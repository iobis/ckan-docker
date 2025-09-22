#!/usr/bin/env python3
"""
CKAN DOI Import Extension (Schema-Aware)

Extension that imports datasets from DOI using your existing scheming schema.
Maps Zenodo metadata to your custom fields including repeating authors and 
contributing organizations.

Test DOI: https://doi.org/10.5281/zenodo.11464531
"""

import ckan.plugins as plugins
import ckan.plugins.toolkit as toolkit
import requests
import re
import json
from datetime import datetime
from urllib.parse import urlparse

class DoiImportPlugin(plugins.SingletonPlugin):
    """CKAN plugin for importing datasets from DOI"""
    
    plugins.implements(plugins.IConfigurer)
    plugins.implements(plugins.IBlueprint)
    plugins.implements(plugins.IActions)
    plugins.implements(plugins.ITemplateHelpers)

    # IConfigurer
    def update_config(self, config_):
        toolkit.add_template_directory(config_, 'templates')
        toolkit.add_public_directory(config_, 'public')
        toolkit.add_resource('public', 'doi_import')

    # ITemplateHelpers
    def get_helpers(self):
        """Provide helper functions for templates"""
        return {
            'doi_import_enabled': lambda: True
        }

    # IBlueprint  
    def get_blueprint(self):
        from flask import Blueprint
        blueprint = Blueprint(self.name, __name__)
        
        # DOI import form
        blueprint.add_url_rule('/dataset/import-doi', 
                             'import_doi_form', 
                             self.import_doi_form, 
                             methods=['GET', 'POST'])
        
        # Dataset creation choice
        blueprint.add_url_rule('/dataset/new-choice', 
                             'dataset_new_choice', 
                             self.dataset_new_choice, 
                             methods=['GET'])
        return blueprint

    # IActions
    def get_actions(self):
        return {
            'doi_fetch_metadata': doi_fetch_metadata,
            'doi_create_dataset': doi_create_dataset
        }

    def dataset_new_choice(self):
        """Show choice between manual dataset creation and DOI import"""
        from flask import render_template
        
        context = {
            'user': toolkit.c.user,
            'auth_user_obj': toolkit.c.userobj
        }
        
        # Check if user is authorized to create datasets
        try:
            toolkit.check_access('package_create', context)
        except toolkit.NotAuthorized:
            toolkit.abort(403, 'Not authorized to create datasets')
        
        return render_template('doi_import/dataset_new_choice.html')

    def import_doi_form(self):
        """Handle the DOI import form"""
        from flask import request, render_template, redirect, url_for, flash
        
        if request.method == 'GET':
            # Show the import form
            context = {
                'user': toolkit.c.user,
                'auth_user_obj': toolkit.c.userobj
            }
            
            # Get user's organizations for dropdown
            try:
                user_orgs = toolkit.get_action('organization_list_for_user')(
                    context, {'id': toolkit.c.userobj.id}
                )
            except (AttributeError, toolkit.NotAuthorized):
                user_orgs = []
            
            # Get contributing organizations
            try:
                groups = toolkit.get_action('group_list')(
                    context, {'all_fields': True}
                )
                contributing_orgs = []
                for group in groups:
                    contributing_orgs.append({
                        'value': group['id'],
                        'label': group['display_name']
                    })
            except:
                contributing_orgs = []
            
            return render_template('doi_import/import_form.html', 
                                 user_orgs=user_orgs,
                                 contributing_orgs=contributing_orgs)
        
        elif request.method == 'POST':
            # Process the form submission
            doi_url = request.form.get('doi_url', '').strip()
            selected_org = request.form.get('owner_org')
            contributing_orgs = request.form.getlist('contributing_organizations')
            
            if not doi_url:
                flash('Please provide a DOI URL', 'error')
                return redirect(url_for('doi_import.import_doi_form'))
            
            try:
                # Step 1: Fetch metadata from DOI
                context = {'user': toolkit.c.user}
                metadata = toolkit.get_action('doi_fetch_metadata')(
                    context, {'doi_url': doi_url}
                )
                
                # Step 2: Create dataset with fetched metadata
                dataset_dict = toolkit.get_action('doi_create_dataset')(
                    context, {
                        'metadata': metadata,
                        'owner_org': selected_org,
                        'contributing_organizations': contributing_orgs
                    }
                )
                
                flash(f'Dataset "{dataset_dict["title"]}" imported successfully!', 'success')
                return redirect(url_for('dataset.read', id=dataset_dict['name']))
                
            except Exception as e:
                flash(f'Error importing dataset: {str(e)}', 'error')
                return redirect(url_for('doi_import.import_doi_form'))


def doi_fetch_metadata(context, data_dict):
    """Fetch metadata from a DOI URL"""
    
    doi_url = data_dict.get('doi_url', '').strip()
    if not doi_url:
        raise toolkit.ValidationError({'doi_url': 'DOI URL is required'})
    
    # Extract DOI from URL
    doi = extract_doi_from_url(doi_url)
    if not doi:
        raise toolkit.ValidationError({'doi_url': 'Invalid DOI URL format'})
    
    # Determine the repository (Zenodo, DataCite, etc.)
    if 'zenodo' in doi_url.lower():
        return fetch_zenodo_metadata(doi)
    else:
        # Try DataCite as fallback for other DOIs
        return fetch_datacite_metadata(doi)


def extract_doi_from_url(url):
    """Extract DOI from various URL formats"""
    # Handle direct DOIs
    if url.startswith('10.'):
        return url
    
    # Handle DOI URLs
    patterns = [
        r'doi\.org/(.+)$',
        r'zenodo\.org/record/(\d+)',
        r'zenodo\.org/doi/(.+)$'
    ]
    
    for pattern in patterns:
        match = re.search(pattern, url)
        if match:
            if 'record' in pattern:
                return f"10.5281/zenodo.{match.group(1)}"
            else:
                return match.group(1)
    
    return None


def fetch_zenodo_metadata(doi):
    """Fetch metadata from Zenodo API"""
    
    # Extract record ID from DOI
    match = re.search(r'zenodo\.(\d+)', doi)
    if not match:
        raise toolkit.ValidationError({'doi': 'Invalid Zenodo DOI format'})
    
    record_id = match.group(1)
    api_url = f"https://zenodo.org/api/records/{record_id}"
    
    try:
        response = requests.get(api_url, timeout=30)
        response.raise_for_status()
        data = response.json()
        
        # Add the record_id to the data for use in mapping
        data['record_id'] = record_id
        
        return map_zenodo_to_schema(data, doi)
        
    except requests.RequestException as e:
        raise toolkit.ValidationError({'doi': f'Failed to fetch Zenodo metadata: {str(e)}'})

def map_zenodo_to_schema(zenodo_data, doi):
    """Map Zenodo metadata to your CKAN schema format"""
    
    metadata = zenodo_data.get('metadata', {})
    files = zenodo_data.get('files', [])
    
    # Basic fields
    mapped_data = {
        'title': metadata.get('title', 'Untitled Dataset'),
        'notes': metadata.get('description', ''),
        'url': f"https://doi.org/{doi}",
        'version': metadata.get('version', '1.0'),
        'license_id': map_zenodo_license(metadata.get('license', {})),
        'tag_string': ','.join([kw for kw in metadata.get('keywords', [])]),
    }
    
    # Map authors to your repeating subfields format - CORRECTED VERSION
    creators = metadata.get('creators', [])
    authors_data = []
    
    for creator in creators:
        # Handle cases where affiliation might be a list
        affiliation = creator.get('affiliation', '')
        if isinstance(affiliation, list):
            affiliation = ', '.join(affiliation)
        
        author_entry = {
            'name': creator.get('name', ''),
            'affiliation': str(affiliation) if affiliation else '',
            'email': creator.get('email', '')  # Usually not available in Zenodo
        }
        authors_data.append(author_entry)
    
    # Set the authors field as a list for scheming to process
    if authors_data:
        mapped_data['authors'] = authors_data
        
    # Debug: Print the authors data structure
    print(f"DEBUG: Authors data structure: {authors_data}")
    
    # Try to determine product type based on resource type
    resource_type = metadata.get('resource_type', {}).get('type', 'dataset')
    mapped_data['product_type'] = map_zenodo_resource_type(resource_type)
    
    # Set update frequency based on publication type
    mapped_data['update_frequency'] = 'never'  # Most DOI datasets are static
    
    # Create resources that link to Zenodo files instead of importing them
    resources = []
    record_id = zenodo_data.get('record_id', '')

    for file_info in files:
        resource = {
            'name': file_info.get('key', file_info.get('filename', 'Download')),
            'url': f"https://zenodo.org/record/{record_id}/files/{file_info.get('key', '')}",
            'format': file_info.get('type', '').upper(),
            'description': f"Download from Zenodo. File size: {file_info.get('size', 0)} bytes"
        }
        resources.append(resource)

    # Add main Zenodo record as a resource
    resources.insert(0, {
        'name': 'Zenodo Record',
        'url': f"https://zenodo.org/record/{record_id}",
        'format': 'HTML',
        'description': 'View this dataset on Zenodo'
    })
    
    mapped_data['resources'] = resources
    
    # Add DOI and source information as extras
    mapped_data['extras'] = [
        {'key': 'doi', 'value': doi},
        {'key': 'source', 'value': 'zenodo'},
        {'key': 'zenodo_record_id', 'value': str(zenodo_data.get('record_id', ''))},
        {'key': 'publication_date', 'value': metadata.get('publication_date', '')},
    ]
    
    return mapped_data


def map_zenodo_license(license_info):
    """Map Zenodo license to CKAN license IDs"""
    license_mapping = {
        'CC-BY-4.0': 'cc-by',
        'CC-BY-SA-4.0': 'cc-by-sa', 
        'CC0-1.0': 'cc-zero',
        'MIT': 'mit-license',
        'Apache-2.0': 'apache2-license',
    }
    
    zenodo_license = license_info.get('id', 'notspecified')
    return license_mapping.get(zenodo_license, 'notspecified')


def map_zenodo_resource_type(resource_type):
    """Map Zenodo resource type to your product_type field"""
    type_mapping = {
        'dataset': ['derived_dataset'],
        'software': ['model'],
        'publication-report': ['report'],
        'publication-article': ['report'],
        'image-figure': ['data_visualization'],
        'image-plot': ['data_visualization'],
    }
    
    return type_mapping.get(resource_type, ['derived_dataset'])

def doi_create_dataset(context, data_dict):
    """Create or update a dataset from DOI metadata"""
    
    metadata = data_dict.get('metadata', {})
    owner_org = data_dict.get('owner_org')
    contributing_orgs = data_dict.get('contributing_organizations', [])
    
    # Extract DOI from the extras
    doi = None
    for extra in metadata.get('extras', []):
        if extra.get('key') == 'doi':
            doi = extra.get('value')
            break
    
    # Add organization and contributing organizations
    if owner_org:
        metadata['owner_org'] = owner_org
    
    if contributing_orgs:
        metadata['contributing_organizations'] = contributing_orgs
    
    # Check if a dataset with this DOI already exists
    if doi:
        try:
            search_context = context.copy()
            search_context['ignore_auth'] = True
            
            search_results = toolkit.get_action('package_search')(
                search_context, 
                {'q': f'extras_doi:"{doi}"', 'rows': 1}
            )
            
            if search_results['count'] > 0:
                # Update existing dataset
                existing_dataset = search_results['results'][0]
                metadata['id'] = existing_dataset['id']
                metadata['name'] = existing_dataset['name']
                
                dataset_dict = toolkit.get_action('package_update')(context, metadata)
                return dataset_dict
                
        except Exception as e:
            print(f"Error searching for existing dataset: {e}")
    
    # Create new dataset
    base_name = re.sub(r'[^\w\s-]', '', metadata.get('title', 'dataset')).lower()
    base_name = re.sub(r'[-\s]+', '-', base_name)[:50]
    metadata['name'] = base_name or 'imported-dataset'
    
    try:
        dataset_dict = toolkit.get_action('package_create')(context, metadata)
        return dataset_dict
    except toolkit.ValidationError as e:
        raise toolkit.ValidationError(f"Failed to create dataset: {e}")

def fetch_datacite_metadata(doi):
    """Fallback: fetch metadata from DataCite API for non-Zenodo DOIs"""
    
    api_url = f"https://api.datacite.org/dois/{doi}"
    
    try:
        response = requests.get(api_url, timeout=30)
        response.raise_for_status()
        data = response.json()
        
        return map_datacite_to_schema(data, doi)
        
    except requests.RequestException as e:
        raise toolkit.ValidationError({'doi': f'Failed to fetch DataCite metadata: {str(e)}'})


def map_datacite_to_schema(datacite_data, doi):
    """Map DataCite metadata to schema (basic implementation)"""
    
    attributes = datacite_data.get('data', {}).get('attributes', {})
    
    mapped_data = {
        'title': attributes.get('title', 'Untitled Dataset'),
        'notes': attributes.get('descriptions', [{}])[0].get('description', ''),
        'url': f"https://doi.org/{doi}",
        'version': attributes.get('version', '1.0'),
        'product_type': ['derived_dataset'],
        'update_frequency': 'never',
        'resources': [],
        'extras': [
            {'key': 'doi', 'value': doi},
            {'key': 'source', 'value': 'datacite'},
        ]
    }
    
    return mapped_data
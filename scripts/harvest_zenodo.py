#!/usr/bin/env python3
"""
OBIS Zenodo Harvest Script using API
"""

import os
import requests
from datetime import datetime

def load_doi_registry():
    registry_file = '/srv/app/ckan/config/zenodo_dois.txt'
    dois = []
    with open(registry_file, 'r') as f:
        for line in f:
            doi = line.strip()
            if doi and not doi.startswith('#'):
                dois.append(doi)
    return dois

def find_dataset_via_api(doi):
    """Search for existing dataset by DOI URL."""
    try:
        base_url = "http://host.docker.internal:5000"  # Changed from localhost
        url = f"{base_url}/api/action/package_search"
        params = {'q': f'url:"{doi}"', 'rows': 1}
        response = requests.get(url, params=params)
        data = response.json()
        
        if data.get('success') and data['result']['count'] > 0:
            return data['result']['results'][0]
        return None
    except Exception as e:
        print(f"    Error: {e}")
        return None

def get_zenodo_last_modified(doi):
    """Get last modified date from Zenodo record."""
    try:
        if 'zenodo' in doi.lower():
            # Extract just the numeric ID
            zenodo_id = doi.split('/')[-1]
            if zenodo_id.startswith('zenodo.'):
                zenodo_id = zenodo_id.replace('zenodo.', '')
            
            url = f"https://zenodo.org/api/records/{zenodo_id}"
            response = requests.get(url, timeout=30)
            response.raise_for_status()
            data = response.json()
            return data.get('updated')
    except Exception as e:
        print(f"    Zenodo error: {e}")
    return None

def should_update_dataset(ckan_modified, zenodo_modified):
    """Check if dataset should be updated based on modification dates."""
    if not zenodo_modified:
        return False
    
    try:
        ckan_dt = datetime.fromisoformat(ckan_modified.replace('Z', '+00:00'))
        zenodo_dt = datetime.fromisoformat(zenodo_modified.replace('Z', '+00:00'))
        return zenodo_dt > ckan_dt
    except:
        return False

def update_dataset_via_api(dataset_id, doi):
    """Update existing dataset with fresh DOI metadata (placeholder)."""
    try:
        # TODO: Implement actual update logic using harvest API
        print(f"    Would update dataset {dataset_id} with fresh DOI data")
        return True
    except Exception as e:
        print(f"    Update error: {e}")
        return False

def import_new_dataset_via_api(doi):
    """Import new dataset using the harvest API endpoint."""
    token = os.getenv('HARVEST_API_TOKEN')
    if not token:
        print("    Error: HARVEST_API_TOKEN not set")
        return False
    
    try:
        headers = {
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json'
        }
        
        data = {'doi_url': doi}
        
        response = requests.post(
            'http://host.docker.internal:5000/api/harvest-doi',  # Changed from localhost
            json=data,
            headers=headers
        )
        
        if response.status_code == 200:
            result = response.json()
            print(f"    ✓ Imported: {result['dataset']['title']}")
            return True
        else:
            try:
                error_msg = response.json().get('error', 'Unknown error')
            except:
                error_msg = f"HTTP {response.status_code}"
            print(f"    ✗ Import failed: {error_msg}")
            return False
            
    except Exception as e:
        print(f"    Import error: {e}")
        return False

def main():
    print("=== Zenodo DOI Harvest ===")
    
    dois = load_doi_registry()
    print(f"Found {len(dois)} DOIs to check\n")
    
    found_count = 0
    imported_count = 0
    updated_count = 0
    
    for doi in dois:
        print(f"Checking: {doi}")
        
        # Find in CKAN
        dataset = find_dataset_via_api(doi)
        if dataset:
            # Existing dataset - check for updates
            print(f"  ✓ Found: {dataset['title']}")
            print(f"    Last modified: {dataset.get('metadata_modified', 'Unknown')}")
            
            # Check if Zenodo has updates
            zenodo_modified = get_zenodo_last_modified(doi)
            if zenodo_modified:
                print(f"    Zenodo updated: {zenodo_modified}")
                if should_update_dataset(dataset.get('metadata_modified'), zenodo_modified):
                    print(f"    → Update needed!")
                    if update_dataset_via_api(dataset['id'], doi):
                        updated_count += 1
                else:
                    print(f"    → No update needed")
            found_count += 1
        else:
            # New dataset - import it
            print(f"  → Not in CKAN, attempting to import...")
            if import_new_dataset_via_api(doi):
                imported_count += 1
        print()
    
    print(f"Summary:")
    print(f"  Found: {found_count}/{len(dois)} datasets in CKAN")
    print(f"  Imported: {imported_count} new datasets")
    print(f"  Updated: {updated_count} datasets")

if __name__ == '__main__':
    main()
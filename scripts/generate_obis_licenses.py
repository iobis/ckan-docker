#!/usr/bin/env python3
"""
Automatic CKAN License Generator for OBIS

This script automatically generates a comprehensive CKAN license configuration
by fetching license data from authoritative sources:
- SPDX License List (https://spdx.org/licenses/)
- Creative Commons API
- Open Definition licenses

Usage:
    python generate_obis_licenses.py [--output obis-licenses.json]
"""

import json
import requests
import argparse
import sys
from typing import Dict, List, Any, Optional
from urllib.parse import urljoin

# Configuration for which licenses to include
INCLUDE_LICENSE_FAMILIES = {
    'Creative Commons': True,
    'Open Data Commons': True,
    'MIT': True,
    'Apache': True,
    'BSD': True,
    'GPL': True,
    'Government': True,
    'SPDX': True
}

# Licenses that are particularly important for research/marine data
PRIORITY_LICENSES = [
    'CC0-1.0',
    'CC-BY-4.0',
    'CC-BY-SA-4.0', 
    'CC-BY-NC-4.0',
    'CC-BY-NC-SA-4.0',
    'CC-BY-ND-4.0',
    'CC-BY-NC-ND-4.0',
    'MIT',
    'Apache-2.0',
    'BSD-3-Clause',
    'PDDL-1.0',
    'ODbL-1.0',
    'ODC-BY-1.0'
]

def fetch_spdx_licenses() -> Dict[str, Dict]:
    """Fetch license data from SPDX license list."""
    print("Fetching SPDX license data...")
    
    try:
        # Get the license list
        response = requests.get('https://spdx.org/licenses/licenses.json', timeout=30)
        response.raise_for_status()
        spdx_data = response.json()
        
        licenses = {}
        for license_info in spdx_data.get('licenses', []):
            license_id = license_info.get('licenseId')
            if not license_id:
                continue
                
            # Determine if it's OSI/OKD compliant
            is_osi_approved = license_info.get('isOsiApproved', False)
            is_deprecated = license_info.get('isDeprecatedLicenseId', False)
            
            if is_deprecated:
                continue
                
            licenses[license_id] = {
                'id': license_id,
                'title': license_info.get('name', license_id),
                'url': license_info.get('reference', ''),
                'is_osi_compliant': is_osi_approved,
                'is_okd_compliant': is_osi_approved,  # Approximate
                'od_conformance': 'approved' if is_osi_approved else 'not reviewed',
                'osd_conformance': 'approved' if is_osi_approved else 'not reviewed',
                'status': 'active',
                'maintainer': license_info.get('licenseId', '').split('-')[0] if '-' in license_info.get('licenseId', '') else '',
                'family': get_license_family(license_id),
                'domain_content': is_content_license(license_id),
                'domain_data': is_data_license(license_id),
                'domain_software': is_software_license(license_id),
                'is_generic': False
            }
            
        print(f"Retrieved {len(licenses)} SPDX licenses")
        return licenses
        
    except Exception as e:
        print(f"Error fetching SPDX licenses: {e}")
        return {}

def fetch_opendefinition_licenses() -> Dict[str, Dict]:
    """Fetch the current Open Definition license list."""
    print("Fetching Open Definition licenses...")
    
    try:
        response = requests.get('https://licenses.opendefinition.org/licenses/groups/ckan.json', timeout=30)
        response.raise_for_status()
        od_licenses = response.json()
        
        licenses = {}
        for license_info in od_licenses:
            license_id = license_info.get('id')
            if not license_id:
                continue
                
            # Add missing fields for CKAN compatibility
            license_info['is_okd_compliant'] = license_info.get('od_conformance') == 'approved'
            license_info['is_osi_compliant'] = license_info.get('osd_conformance') == 'approved'
            
            licenses[license_id] = license_info
            
        print(f"Retrieved {len(licenses)} Open Definition licenses")
        return licenses
        
    except Exception as e:
        print(f"Error fetching Open Definition licenses: {e}")
        return {}

def get_license_family(license_id: str) -> str:
    """Determine the license family from the license ID."""
    license_id_upper = license_id.upper()
    
    if license_id_upper.startswith('CC-') or license_id_upper.startswith('CC0'):
        return 'Creative Commons'
    elif license_id_upper.startswith('MIT'):
        return 'MIT'
    elif license_id_upper.startswith('APACHE'):
        return 'Apache'
    elif license_id_upper.startswith('BSD'):
        return 'BSD'
    elif license_id_upper.startswith('GPL') or license_id_upper.startswith('LGPL'):
        return 'GPL'
    elif license_id_upper.startswith('OD') or license_id_upper.startswith('PDDL'):
        return 'Open Data Commons'
    elif license_id_upper.startswith('OGL'):
        return 'Government'
    else:
        return ''

def is_content_license(license_id: str) -> bool:
    """Check if license is suitable for content."""
    content_patterns = ['CC-', 'CC0', 'GFDL', 'OGL']
    return any(license_id.upper().startswith(pattern) for pattern in content_patterns)

def is_data_license(license_id: str) -> bool:
    """Check if license is suitable for data."""
    data_patterns = ['CC-', 'CC0', 'OD', 'PDDL', 'OGL']
    return any(license_id.upper().startswith(pattern) for pattern in data_patterns)

def is_software_license(license_id: str) -> bool:
    """Check if license is suitable for software."""
    software_patterns = ['MIT', 'APACHE', 'BSD', 'GPL', 'LGPL', 'ISC', 'MPL', 'CC0']
    return any(license_id.upper().startswith(pattern) for pattern in software_patterns)

def merge_license_sources(spdx_licenses: Dict, od_licenses: Dict) -> Dict[str, Dict]:
    """Merge licenses from different sources, prioritizing completeness."""
    print("Merging license sources...")
    
    merged = {}
    
    # Start with Open Definition licenses (they have CKAN-specific fields)
    for license_id, license_data in od_licenses.items():
        merged[license_id] = license_data.copy()
    
    # Add SPDX licenses that aren't already present, focusing on priority ones
    for license_id, license_data in spdx_licenses.items():
        if license_id not in merged:
            # Only include if it's in our priority list or popular license families
            family = get_license_family(license_id)
            if license_id in PRIORITY_LICENSES or family in INCLUDE_LICENSE_FAMILIES:
                merged[license_id] = license_data
        else:
            # Update existing license with better SPDX data
            existing = merged[license_id]
            if not existing.get('url') and license_data.get('url'):
                existing['url'] = license_data['url']
            if not existing.get('title') or len(existing['title']) < len(license_data.get('title', '')):
                existing['title'] = license_data.get('title', existing['title'])
    
    print(f"Merged to {len(merged)} total licenses")
    return merged

def add_obis_specific_licenses(licenses: Dict[str, Dict]) -> Dict[str, Dict]:
    """Add any OBIS-specific or missing research licenses."""
    
    # Ensure we have the essential research licenses
    essential_additions = {
        'CC-BY-NC-4.0': {
            'domain_content': True,
            'domain_data': True,
            'domain_software': False,
            'family': 'Creative Commons',
            'id': 'CC-BY-NC-4.0',
            'is_generic': False,
            'is_okd_compliant': False,
            'is_osi_compliant': False,
            'maintainer': 'Creative Commons',
            'od_conformance': 'rejected',
            'osd_conformance': 'not reviewed',
            'status': 'active',
            'title': 'Creative Commons Attribution-NonCommercial 4.0 International',
            'url': 'https://creativecommons.org/licenses/by-nc/4.0/'
        }
    }
    
    for license_id, license_data in essential_additions.items():
        if license_id not in licenses:
            licenses[license_id] = license_data
            print(f"Added essential license: {license_id}")
    
    return licenses

def generate_ckan_license_list(output_file: str = 'obis-licenses.json'):
    """Generate the complete CKAN license configuration file."""
    print("Generating OBIS CKAN license configuration...")
    
    # Fetch from different sources
    spdx_licenses = fetch_spdx_licenses()
    od_licenses = fetch_opendefinition_licenses()
    
    # Merge sources
    licenses = merge_license_sources(spdx_licenses, od_licenses)
    
    # Add OBIS-specific licenses
    licenses = add_obis_specific_licenses(licenses)
    
    # Convert to list format for CKAN
    license_list = []
    
    # Always include "not specified" first
    if 'notspecified' in licenses:
        license_list.append(licenses['notspecified'])
        del licenses['notspecified']
    else:
        license_list.append({
            'domain_content': False,
            'domain_data': False,
            'domain_software': False,
            'family': '',
            'id': 'notspecified',
            'is_generic': True,
            'is_okd_compliant': False,
            'is_osi_compliant': False,
            'maintainer': '',
            'od_conformance': 'not reviewed',
            'osd_conformance': 'not reviewed',
            'status': 'active',
            'title': 'License Not Specified',
            'url': ''
        })
    
    # Add priority licenses first (in order)
    for license_id in PRIORITY_LICENSES:
        if license_id in licenses:
            license_list.append(licenses[license_id])
            del licenses[license_id]
    
    # Add remaining licenses sorted by family then by ID
    remaining_licenses = sorted(licenses.values(), 
                              key=lambda x: (x.get('family', ''), x.get('id', '')))
    license_list.extend(remaining_licenses)
    
    # Write to file
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(license_list, f, indent=2, ensure_ascii=False)
    
    print(f"Generated {len(license_list)} licenses in {output_file}")
    
    # Print summary
    families = {}
    for lic in license_list:
        family = lic.get('family', 'Other')
        families[family] = families.get(family, 0) + 1
    
    print("\nLicense summary by family:")
    for family, count in sorted(families.items()):
        print(f"  {family}: {count}")

def main():
    parser = argparse.ArgumentParser(description='Generate OBIS CKAN license configuration')
    parser.add_argument('--output', '-o', default='obis-licenses.json',
                       help='Output file path (default: obis-licenses.json)')
    parser.add_argument('--priority-only', action='store_true',
                       help='Only include priority licenses for research data')
    
    args = parser.parse_args()
    
    try:
        generate_ckan_license_list(args.output)
        print(f"\n✅ Successfully generated license file: {args.output}")
        print(f"Add this to your CKAN configuration:")
        print(f"licenses_group_url = file:///path/to/{args.output}")
        
    except Exception as e:
        print(f"❌ Error generating license file: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()

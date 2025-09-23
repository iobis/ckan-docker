# Test the license mapping with the actual Zenodo data

# This is what Zenodo actually returns:
license_info = {'id': 'cc-by-4.0'}

def map_zenodo_license(license_info):
    """Map Zenodo license to CKAN license IDs"""
    print(f"DEBUG: License info received: {license_info}")
    print(f"DEBUG: License info type: {type(license_info)}")
    
    if not license_info:
        print("DEBUG: No license info, returning 'notspecified'")
        return 'notspecified'
    
    # Handle case where license_info is a dict (which it is!)
    license_id = None
    if isinstance(license_info, dict):
        license_id = license_info.get('id') or license_info.get('title') or license_info.get('name')
    elif isinstance(license_info, str):
        license_id = license_info
    
    print(f"DEBUG: Extracted license_id: '{license_id}'")
    
    # License mapping
    license_mapping = {
        'cc-by-4.0': 'cc-by',
        'cc-by-sa-4.0': 'cc-by-sa', 
        'cc0-1.0': 'cc-zero',
        'mit': 'mit-license',
        'apache-2.0': 'apache2-license',
    }
    
    if license_id:
        # Try exact match first
        if license_id in license_mapping:
            result = license_mapping[license_id]
            print(f"DEBUG: Exact match found: '{license_id}' -> '{result}'")
            return result
        
        # Try case-insensitive match
        for zenodo_key, ckan_key in license_mapping.items():
            if license_id.lower() == zenodo_key.lower():
                print(f"DEBUG: Case-insensitive match: '{license_id}' -> '{ckan_key}'")
                return ckan_key
    
    print(f"DEBUG: No mapping found for '{license_id}', returning 'notspecified'")
    return 'notspecified'

# Test with actual Zenodo data
result = map_zenodo_license(license_info)
print(f"\nFINAL RESULT: {result}")

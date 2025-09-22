#!/usr/bin/env python3
"""
Delete All CKAN Groups

This script deletes all groups from your CKAN instance.
Use with caution - this cannot be undone!

Usage: CKAN_TOKEN=your-token python3 delete_all_groups.py
"""

import requests
import json
import os
from urllib.parse import urljoin

# Configuration
CKAN_BASE_URL = "http://localhost:5000"
CKAN_TOKEN = os.getenv('CKAN_TOKEN')

if not CKAN_TOKEN:
    print("Error: Please set the CKAN_TOKEN environment variable")
    print("Usage: CKAN_TOKEN=your-token python3 delete_all_groups.py")
    exit(1)

# Headers for CKAN API requests
HEADERS = {
    'Authorization': CKAN_TOKEN,
    'Content-Type': 'application/json'
}

def get_all_groups():
    """Get all existing CKAN groups"""
    list_url = urljoin(CKAN_BASE_URL, "/api/3/action/group_list")
    try:
        response = requests.get(list_url)
        response.raise_for_status()
        data = response.json()
        if data['success']:
            return data['result']
        else:
            print(f"Error fetching groups: {data}")
            return []
    except requests.RequestException as e:
        print(f"Error fetching CKAN groups: {e}")
        return []

def delete_group(group_name):
    """Delete a single CKAN group"""
    url = urljoin(CKAN_BASE_URL, "/api/3/action/group_delete")
    
    try:
        response = requests.post(url, headers=HEADERS, data=json.dumps({'id': group_name}))
        response.raise_for_status()
        result = response.json()
        
        if result['success']:
            print(f"✓ Deleted group: {group_name}")
            return True
        else:
            print(f"✗ Failed to delete {group_name}: {result.get('error', 'Unknown error')}")
            return False
            
    except requests.RequestException as e:
        print(f"✗ Error deleting group {group_name}: {e}")
        return False

def main():
    """Main deletion function"""
    print("CKAN Groups Deletion Script")
    print("=" * 40)
    print("⚠️  WARNING: This will delete ALL groups from your CKAN instance!")
    print("⚠️  This action cannot be undone!")
    print()
    
    # Get all groups
    groups = get_all_groups()
    if not groups:
        print("No groups found or error fetching groups.")
        return
    
    print(f"Found {len(groups)} groups to delete:")
    for i, group in enumerate(groups[:10], 1):
        print(f"  {i}. {group}")
    if len(groups) > 10:
        print(f"  ... and {len(groups) - 10} more")
    
    print()
    
    # Confirmation
    confirm = input(f"Are you sure you want to delete ALL {len(groups)} groups? (type 'DELETE ALL' to confirm): ")
    
    if confirm != "DELETE ALL":
        print("Deletion cancelled.")
        return
    
    print(f"\nDeleting {len(groups)} groups...")
    
    # Delete each group
    deleted = 0
    failed = 0
    
    for i, group_name in enumerate(groups, 1):
        print(f"[{i}/{len(groups)}] Deleting: {group_name}")
        
        if delete_group(group_name):
            deleted += 1
        else:
            failed += 1
    
    # Summary
    print("\n" + "=" * 40)
    print("Deletion complete!")
    print(f"Deleted: {deleted}")
    print(f"Failed: {failed}")
    print(f"Total: {len(groups)}")
    
    if failed == 0:
        print("\n✅ All groups successfully deleted!")
        print("You can now run the institutions sync script on a clean slate.")
    else:
        print(f"\n⚠️  {failed} groups failed to delete. Check the errors above.")

if __name__ == "__main__":
    main()

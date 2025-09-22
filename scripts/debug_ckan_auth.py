#!/usr/bin/env python3
"""
Debug CKAN Authentication Issues

This script tests your CKAN token and permissions to help diagnose
the 403 FORBIDDEN errors you're getting.
"""

import requests
import json
import os
from urllib.parse import urljoin

# Configuration
CKAN_BASE_URL = "http://localhost:5000"
CKAN_TOKEN = os.getenv('CKAN_TOKEN')

def test_token_format():
    """Test if the token format is correct"""
    print("=== Testing Token Format ===")
    
    if not CKAN_TOKEN:
        print("❌ No CKAN_TOKEN environment variable set!")
        return False
    
    print(f"✓ Token exists: {CKAN_TOKEN[:20]}...{CKAN_TOKEN[-10:]}")
    print(f"✓ Token length: {len(CKAN_TOKEN)} characters")
    
    # Check if it looks like a UUID (CKAN default format)
    if len(CKAN_TOKEN) == 36 and CKAN_TOKEN.count('-') == 4:
        print("✓ Token format looks like UUID")
    else:
        print("⚠️  Token format doesn't look like standard CKAN UUID")
    
    return True

def test_basic_api_access():
    """Test basic API access without authentication"""
    print("\n=== Testing Basic API Access ===")
    
    try:
        response = requests.get(f"{CKAN_BASE_URL}/api/3/action/status_show", timeout=10)
        response.raise_for_status()
        
        data = response.json()
        if data.get('success'):
            print("✓ CKAN API is accessible")
            print(f"✓ CKAN version: {data.get('result', {}).get('ckan_version', 'Unknown')}")
            return True
        else:
            print(f"❌ API returned error: {data}")
            return False
            
    except Exception as e:
        print(f"❌ Cannot reach CKAN API: {e}")
        return False

def test_token_authentication():
    """Test token authentication with user info"""
    print("\n=== Testing Token Authentication ===")
    
    # Determine token format and test both
    token_formats = []
    
    if CKAN_TOKEN.startswith('eyJ'):  # JWT token
        print("Detected JWT token format")
        token_formats = [
            ('Bearer JWT', {'Authorization': f'Bearer {CKAN_TOKEN}', 'Content-Type': 'application/json'}),
            ('Direct JWT', {'Authorization': CKAN_TOKEN, 'Content-Type': 'application/json'})
        ]
    else:  # UUID token
        print("Detected UUID token format")
        token_formats = [
            ('UUID', {'Authorization': CKAN_TOKEN, 'Content-Type': 'application/json'})
        ]
    
    for format_name, headers in token_formats:
        print(f"\nTrying {format_name} format...")
        
        # Test 1: Try organization_list (we know this worked before)
        try:
            response = requests.get(f"{CKAN_BASE_URL}/api/3/action/organization_list", 
                                  headers=headers, 
                                  timeout=10)
            
            print(f"organization_list status: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success'):
                    orgs = data.get('result', [])
                    print(f"✓ {format_name} token works with organization_list!")
                    print(f"✓ Found {len(orgs)} organizations")
                    
                    # Test 2: Try group_list to see if groups work at all
                    response2 = requests.get(f"{CKAN_BASE_URL}/api/3/action/group_list", 
                                           headers=headers, 
                                           timeout=10)
                    
                    print(f"group_list status: {response2.status_code}")
                    if response2.status_code == 200:
                        data2 = response2.json()
                        if data2.get('success'):
                            groups = data2.get('result', [])
                            print(f"✓ Can also list groups: {len(groups)} groups found")
                            
                            # Test 3: Try to create a test group
                            test_group = {
                                'name': 'test-auth-group',
                                'title': 'Test Auth Group'
                            }
                            
                            response3 = requests.post(f"{CKAN_BASE_URL}/api/3/action/group_create",
                                                    headers=headers,
                                                    data=json.dumps(test_group),
                                                    timeout=10)
                            
                            print(f"group_create status: {response3.status_code}")
                            if response3.status_code == 200:
                                data3 = response3.json()
                                if data3.get('success'):
                                    print(f"✓ {format_name} can create groups!")
                                    
                                    # Clean up test group
                                    requests.post(f"{CKAN_BASE_URL}/api/3/action/group_delete",
                                                headers=headers,
                                                data=json.dumps({'id': 'test-auth-group'}))
                                    
                                    return True, {'name': 'token-user', 'sysadmin': True}
                                else:
                                    print(f"❌ Group create failed: {data3}")
                            elif response3.status_code == 403:
                                print(f"❌ 403 FORBIDDEN on group_create - permission issue")
                            elif response3.status_code == 409:
                                print(f"⚠️  409 CONFLICT on group_create - test group already exists")
                                return True, {'name': 'token-user', 'sysadmin': True}
                            else:
                                print(f"❌ Group create unexpected status: {response3.status_code}")
                                print(f"Response: {response3.text}")
                        else:
                            print(f"❌ Group list API error: {data2}")
                    else:
                        print(f"❌ Cannot list groups: {response2.status_code}")
                        
                else:
                    print(f"❌ Organization list API error: {data}")
            elif response.status_code == 403:
                print("❌ 403 FORBIDDEN - Token is invalid or expired")
            elif response.status_code == 401:
                print("❌ 401 UNAUTHORIZED - Token format issue or missing")
            else:
                print(f"❌ Unexpected status: {response.status_code}")
                print(f"Response: {response.text}")
                
        except Exception as e:
            print(f"❌ Error testing {format_name} authentication: {e}")
    
    return False, None

def test_group_permissions(user_info):
    """Test if user has permissions to create groups"""
    print("\n=== Testing Group Permissions ===")
    
    headers = {
        'Authorization': CKAN_TOKEN,
        'Content-Type': 'application/json'
    }
    
    # Test 1: Can we list groups?
    try:
        response = requests.get(f"{CKAN_BASE_URL}/api/3/action/group_list", 
                              headers=headers, 
                              timeout=10)
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                groups = data.get('result', [])
                print(f"✓ Can list groups: {len(groups)} groups found")
            else:
                print(f"❌ Error listing groups: {data}")
                return False
        else:
            print(f"❌ Cannot list groups: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ Error listing groups: {e}")
        return False
    
    # Test 2: Check if user is sysadmin (needed for group creation in some CKAN configs)
    if user_info and user_info.get('sysadmin'):
        print("✓ User is sysadmin - should have group creation permissions")
        return True
    else:
        print("⚠️  User is NOT sysadmin - may not have group creation permissions")
        
        # Test 3: Try to check auth for group creation
        try:
            auth_data = {
                'domain_object': None,
                'user': user_info.get('name') if user_info else 'current'
            }
            
            response = requests.post(f"{CKAN_BASE_URL}/api/3/action/auth_group_create",
                                   headers=headers,
                                   data=json.dumps(auth_data),
                                   timeout=10)
            
            if response.status_code == 200:
                data = response.json()
                if data.get('success') and data.get('result', {}).get('success'):
                    print("✓ User has group creation permissions")
                    return True
                else:
                    print("❌ User does NOT have group creation permissions")
                    print(f"Auth response: {data}")
                    return False
            else:
                print(f"⚠️  Could not check group creation auth: {response.status_code}")
                
        except Exception as e:
            print(f"⚠️  Error checking group creation auth: {e}")
    
    return False

def test_organization_permissions():
    """Test if the issue is specific to groups vs organizations"""
    print("\n=== Testing Organization vs Group Permissions ===")
    
    headers = {
        'Authorization': CKAN_TOKEN,
        'Content-Type': 'application/json'
    }
    
    # Test if we can list organizations (which worked before)
    try:
        response = requests.get(f"{CKAN_BASE_URL}/api/3/action/organization_list", 
                              headers=headers, 
                              timeout=10)
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                orgs = data.get('result', [])
                print(f"✓ Can list organizations: {len(orgs)} organizations found")
                print("✓ Organization permissions work (as expected from your node sync)")
                return True
            else:
                print(f"❌ Error listing organizations: {data}")
        else:
            print(f"❌ Cannot list organizations: {response.status_code}")
            
    except Exception as e:
        print(f"❌ Error testing organizations: {e}")
    
    return False

def provide_solutions():
    """Provide solutions based on test results"""
    print("\n=== Potential Solutions ===")
    
    print("1. **Make user sysadmin:**")
    print("   docker-compose -f docker-compose.dev.yml exec ckan ckan sysadmin add <your-username>")
    
    print("\n2. **Create a new API token:**")
    print("   - Log into CKAN web interface")
    print("   - Go to user profile")
    print("   - Generate new API token")
    
    print("\n3. **Check CKAN permissions config:**")
    print("   - Some CKAN instances restrict group creation to sysadmins only")
    print("   - Check your CKAN configuration files")
    
    print("\n4. **Alternative: Use organization_create instead:**")
    print("   - Since organization creation worked, you might need to use organizations")
    print("   - Groups and organizations have different permission models in CKAN")

def main():
    """Run all authentication tests"""
    print("CKAN Authentication Diagnostic Tool")
    print("=" * 50)
    
    # Test 1: Token format
    if not test_token_format():
        return
    
    # Test 2: Basic API access
    if not test_basic_api_access():
        return
    
    # Test 3: Token authentication
    token_valid, user_info = test_token_authentication()
    if not token_valid:
        provide_solutions()
        return
    
    # Test 4: Group permissions
    has_group_perms = test_group_permissions(user_info)
    
    # Test 5: Organization permissions (for comparison)
    test_organization_permissions()
    
    # Provide solutions
    if not has_group_perms:
        provide_solutions()
    else:
        print("\n✅ All tests passed! The issue might be elsewhere.")

if __name__ == "__main__":
    main()

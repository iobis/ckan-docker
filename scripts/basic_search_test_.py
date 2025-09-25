#!/usr/bin/env python3
"""
Basic test to see if CKAN search works at all
"""

import ckan.plugins.toolkit as toolkit

def test_basic_search():
    """Test very basic CKAN search functionality."""
    try:
        print("Testing basic CKAN search...")
        
        # Try the most basic search possible
        result = toolkit.get_action('package_search')({}, {
            'rows': 1
        })
        
        print(f"Basic search worked! Found {result['count']} total datasets")
        
        if result['count'] > 0:
            pkg = result['results'][0]
            print(f"First dataset: {pkg['title']}")
            print(f"URL field: {pkg.get('url', 'No URL field')}")
            
            # Test search for this specific dataset by name
            result2 = toolkit.get_action('package_search')({}, {
                'q': f'name:{pkg["name"]}',
                'rows': 1
            })
            
            print(f"Search by name found {result2['count']} results")
            
    except Exception as e:
        print(f"Error in basic search: {e}")
        import traceback
        print(traceback.format_exc())

if __name__ == '__main__':
    test_basic_search()

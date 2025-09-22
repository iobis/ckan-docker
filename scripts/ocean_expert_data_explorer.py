#!/usr/bin/env python3
"""
Ocean Expert Data Structure Explorer

This script examines what data Ocean Expert actually provides
so we can create better mapping to CKAN group schema.
"""

import requests
import json
from typing import Dict, List

OCEAN_EXPERT_API_BASE = "https://oceanexpert.org/api/v1"

def explore_ocean_expert_institution(oe_id: int):
    """Fetch and explore a single Ocean Expert institution"""
    print(f"Exploring Ocean Expert institution ID: {oe_id}")
    
    try:
        url = f"{OCEAN_EXPERT_API_BASE}/institute/{oe_id}.json"
        response = requests.get(url, timeout=30)
        response.raise_for_status()
        
        data = response.json()
        
        print(f"✓ Successfully fetched institution {oe_id}")
        print(f"✓ Data type: {type(data)}")
        
        if isinstance(data, dict):
            print(f"\n=== Ocean Expert Institution Data Structure ===")
            for key, value in data.items():
                value_type = type(value).__name__
                if isinstance(value, (str, int, float)):
                    value_preview = str(value)[:100] + "..." if len(str(value)) > 100 else str(value)
                    print(f"  {key} ({value_type}): {value_preview}")
                elif isinstance(value, list):
                    print(f"  {key} ({value_type}): [{len(value)} items]")
                    if value:  # Show first item if exists
                        print(f"    Sample item: {value[0]}")
                elif isinstance(value, dict):
                    print(f"  {key} ({value_type}): {{{len(value)} keys}}")
                    print(f"    Keys: {list(value.keys())}")
                else:
                    print(f"  {key} ({value_type}): {value}")
        else:
            print(f"Unexpected data format: {data}")
        
        return data
        
    except Exception as e:
        print(f"✗ Error fetching Ocean Expert institution {oe_id}: {e}")
        return None

def explore_multiple_institutions(oe_ids: List[int]):
    """Explore multiple institutions to see data patterns"""
    print(f"\n=== Exploring {len(oe_ids)} institutions for patterns ===")
    
    all_keys = set()
    field_stats = {}
    institutions = []
    
    for oe_id in oe_ids:
        print(f"\nFetching institution {oe_id}...")
        data = explore_ocean_expert_institution(oe_id)
        
        if data:
            institutions.append(data)
            
            # Collect all possible keys
            if isinstance(data, dict):
                all_keys.update(data.keys())
                
                # Track which fields have data
                for key, value in data.items():
                    if key not in field_stats:
                        field_stats[key] = {'populated': 0, 'empty': 0, 'sample_values': []}
                    
                    if value and value != 'No name':
                        field_stats[key]['populated'] += 1
                        if len(field_stats[key]['sample_values']) < 3:
                            field_stats[key]['sample_values'].append(str(value)[:50])
                    else:
                        field_stats[key]['empty'] += 1
        
        # Rate limiting
        import time
        time.sleep(1)
    
    # Analyze patterns
    print(f"\n=== DATA QUALITY ANALYSIS ===")
    print(f"Total institutions analyzed: {len(institutions)}")
    print(f"All available fields: {sorted(all_keys)}")
    
    print(f"\n=== FIELD POPULARITY (most useful fields) ===")
    # Sort by how often fields are populated
    sorted_fields = sorted(field_stats.items(), 
                          key=lambda x: x[1]['populated'], 
                          reverse=True)
    
    for field, stats in sorted_fields:
        populated = stats['populated']
        empty = stats['empty']
        total = populated + empty
        percentage = (populated / total * 100) if total > 0 else 0
        
        print(f"  {field}: {populated}/{total} ({percentage:.1f}%) populated")
        
        if stats['sample_values']:
            print(f"    Sample values: {stats['sample_values']}")
    
    return institutions, field_stats

def suggest_ckan_mapping(field_stats):
    """Suggest mapping from Ocean Expert fields to CKAN group fields"""
    print(f"\n=== SUGGESTED CKAN GROUP MAPPING ===")
    
    # CKAN group schema has these main fields:
    ckan_fields = {
        'name': 'URL-friendly identifier (auto-generated from title)',
        'title': 'Display name of the group',
        'description': 'Main description text',
        'image_url': 'Logo or image URL',
        'extras': 'Additional metadata as key-value pairs'
    }
    
    print("CKAN Group Schema:")
    for field, desc in ckan_fields.items():
        print(f"  {field}: {desc}")
    
    print(f"\nRecommended Mapping:")
    
    # Suggest best fields based on popularity and relevance
    suggestions = []
    
    for field, stats in field_stats.items():
        populated_rate = stats['populated'] / (stats['populated'] + stats['empty'])
        
        if populated_rate > 0.5:  # More than 50% populated
            if field.lower() in ['name', 'institution', 'title']:
                suggestions.append(f"  TITLE: Use '{field}' ({populated_rate:.1%} populated)")
            elif field.lower() in ['description', 'about', 'summary']:
                suggestions.append(f"  DESCRIPTION: Use '{field}' ({populated_rate:.1%} populated)")
            elif field.lower() in ['website', 'url', 'homepage']:
                suggestions.append(f"  EXTRAS['website']: Use '{field}' ({populated_rate:.1%} populated)")
            elif field.lower() in ['address', 'location']:
                suggestions.append(f"  DESCRIPTION: Include '{field}' ({populated_rate:.1%} populated)")
            elif field.lower() in ['country', 'nation']:
                suggestions.append(f"  EXTRAS['country']: Use '{field}' ({populated_rate:.1%} populated)")
            elif field.lower() in ['email', 'contact']:
                suggestions.append(f"  EXTRAS['email']: Use '{field}' ({populated_rate:.1%} populated)")
            else:
                suggestions.append(f"  EXTRAS['{field}']: Use '{field}' ({populated_rate:.1%} populated)")
    
    for suggestion in suggestions:
        print(suggestion)

def main():
    """Main function to explore Ocean Expert data"""
    print("Ocean Expert Data Structure Explorer")
    print("=" * 50)
    
    # Test with some known Ocean Expert IDs
    test_ids = [
        6860,   # Intergovernmental Oceanographic Commission of UNESCO
        7489,   # National Institute for Water & Atmospheric Research
        17039,  # Vlaamse Overheid - Instituut voor Natuur- en Bosonderzoek
        11379,  # National Oceanic and Atmospheric Administration, Washington
        19196,  # Fisheries and Oceans Canada
    ]
    
    print("Testing with sample institutions to understand data structure...")
    
    institutions, field_stats = explore_multiple_institutions(test_ids)
    
    if institutions:
        suggest_ckan_mapping(field_stats)
        
        # Save raw data for further analysis
        with open('ocean_expert_sample_data.json', 'w') as f:
            json.dump({
                'institutions': institutions,
                'field_stats': field_stats,
                'test_ids': test_ids
            }, f, indent=2)
        
        print(f"\n✓ Sample data saved to ocean_expert_sample_data.json")
        print(f"✓ Use this data to improve the CKAN mapping in your sync script")
    else:
        print("❌ No data retrieved. Check Ocean Expert API connectivity.")

if __name__ == "__main__":
    main()

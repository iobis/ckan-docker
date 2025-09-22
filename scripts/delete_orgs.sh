#!/bin/bash

orgs_to_delete=("afrobis" "antarctic-obis" "arctic-obis" "caribbean-obis" "esp-obis" "eurobis" "fish-obis" "hab-obis" "indobis" "medobis" "obis-argentina" "obis-australia" "obis-black-sea" "obis-brazil" "obis-cpps" "obis-canada" "obis-china" "obis-colombia" "obis-deep-sea" "obis-ecuador" "obis-isa" "obis-indonesia" "obis-japan" "obis-kenya" "obis-korea" "obis-malaysia" "obis-panama" "obis-secretariat" "obis-senegal" "obis-uk" "obis-usa" "obis-gbif-norway" "obis-seamap" "ocean-tracking-network" "oceans-past-initiative" "pego-obis" "sea-obis" "swp-obis")

for org in "${orgs_to_delete[@]}"; do
    echo "Deleting $org..."
    curl -H "Authorization: $CKAN_TOKEN" -H "Content-Type: application/json" -X POST http://localhost:5000/api/3/action/organization_delete -d "{\"id\": \"$org\"}"
    echo ""
done

echo "Deletion complete!"

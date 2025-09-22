#!/bin/bash
# Create this as: ckan/docker-entrypoint.d/setup-doi-import.sh

set -e

# Install the DOI import extension
echo "Installing DOI import extension..."
pip install -e /srv/app/src_extensions/ckanext-doi-import

echo "DOI import extension installed successfully!"

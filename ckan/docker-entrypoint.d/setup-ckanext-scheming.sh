#!/bin/sh
set -e

: "${CKAN_INI:=/srv/app/ckan.ini}"

case "$CKAN__PLUGINS" in
  *scheming_datasets*)
    echo "Configuring scheming dataset schemas..."
    ckan config-tool "$CKAN_INI" "scheming.dataset_schemas=${CKAN__SCHEMING__DATASET_SCHEMAS}"
    ;;
  *)
    echo "Not configuring scheming_datasets"
    ;;
esac
echo "Done."

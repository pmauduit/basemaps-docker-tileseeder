#!/bin/bash

mkdir -p /tmp/imposm-bootstrap
cd /tmp/imposm-bootstrap

if [ -z "${CUSTOM_PBF_EXTRACT_URL}" ] ; then
  axel -a -n 5 -o extract.pbf http://download.geofabrik.de/europe/france/rhone-alpes-latest.osm.pbf
else
  axel -a -n 5 -o extract.pbf ${CUSTOM_PBF_EXTRACT_URL} ;
fi

PGPASSWORD=osm psql -h database -U osm -l | grep template_postgis
while [ $? -ne 0 ]; do
  echo "$(date) - waiting for postgres ..."
  sleep 60
  PGPASSWORD=osm psql -h database -U osm -l | grep template_postgis
done
echo "creating db osm"
echo "CREATE DATABASE osm ENCODING 'UTF8' TEMPLATE template_postgis;" | PGPASSWORD=osm psql -h database -U osm -d postgres

imposm --read --write --overwrite-cache --optimize --mapping-file /imposm-mapping.py --connection postgis://osm:osm@database/osm -c 4 extract.pbf

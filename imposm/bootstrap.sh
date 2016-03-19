#!/bin/bash

until `nc -z database 5432`; do
  echo "$(date) - waiting for postgres (localhost-only)..."
  sleep 20
done
echo "creating db osm"
echo "CREATE DATABASE osm ENCODING 'UTF8' TEMPLATE template_postgis;" | PGPASSWORD=osm psql -h database -U osm -d postgres
echo "adding postgis extension to db osm"
echo "CREATE EXTENSION postgis;" | PGPASSWORD=osm psql -h database -U osm -d osm

mkdir -p /tmp/imposm-bootstrap
cd /tmp/imposm-bootstrap

if [ -z "${CUSTOM_PBF_EXTRACT_URL}" ] ; then
  wget -O extract.pbf http://download.geofabrik.de/europe/france/rhone-alpes-latest.osm.pbf
else
  wget -O extract.pbf ${CUSTOM_PBF_EXTRACT_URL} ;
fi

imposm --read --write --optimize --mapping-file /imposm-mapping.py --connection postgis://osm:osm@database/osm extract.pbf

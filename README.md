About
======

This is an attempt to provide a docker composition for setting up a
mapserver-based tileserver rendering OSM data given several styles (e.g.
mapfiles) developped by Thomas Bonfort on basemaps
(https://github.com/mapserver/basemaps).

How to use
===========

Before launching the composition, some manual steps are needed, first you will
require the mapserver-bin package (which provides a command to create indexes
on shapefiles).

```
apt-get install mapserver-bin
```

Then you will need to get extra resources for the base map (shorelines, ...):

```
cd mapserver/map/data
make
```

Then:

```
docker-compose up
```
Once the container `imposm` returns, this means that the initial data import finished. It is now possible to consume the WMS webservices available:

```
http://localhost:8280/map/default
http://localhost:8280/map/bing
http://localhost:8280/map/google
http://localhost:8280/map/michelin
```

Seed with tilecloud-chain
===========================

```
docker run --rm -ti --link basemapsdockertileseeder_mapserver_1:mapserver -v ${PWD}/tilecloud_chain/config.yaml:/tilecloud-chain/config.yaml yjacolin/tilecloud-chain -c /tilecloud-chain/config.yaml -l default
```

Customization
=================

By default, a postgresql database will be created and populated with latest OSM
rhone-alpes french region data.

You can override it, by setting up an env variable in your composition:

```yaml
imposm:
  build: ./imposm
  links:
    - database
  environment:
    - CUSTOM_PBF_EXTRACT_URL=http://download.geofabrik.de/europe-latest.osm.pbf

```


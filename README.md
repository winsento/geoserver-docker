# Supported tags and respective `Dockerfile` links #

- `2.6.5`, `2.6` ([2.6/Dockerfile](https://bitbucket.org/ololoteam/geoserver-docker/src/default/2.6))
- `2.7.6`, `2.7` ([2.7/Dockerfile](https://bitbucket.org/ololoteam/geoserver-docker/src/default/2.7))
- `2.8.2`, `2.8`, `latest` ([2.8/Dockerfile](https://bitbucket.org/ololoteam/geoserver-docker/src/default/2.8))
- `2.9-beta`, `2.9` ([2.9/Dockerfile](https://bitbucket.org/ololoteam/geoserver-docker/src/default/2.9))

[![](https://badge.imagelayers.io/winsent/geoserver:latest.svg)](https://imagelayers.io/?images=winsent/geoserver:latest,winsent/geoserver:2.6,winsent%2Fgeoserver:2.7,winsent/geoserver:2.8,winsent/geoserver:2.9)

# What is GeoServer? #
GeoServer is a Java-based software server that allows users to view and edit geospatial data. Using open standards set forth by the [Open Geospatial Consortium (OGC)](http://www.opengeospatial.org/), GeoServer allows for great flexibility in map creation and data sharing.

![GeoServer_200.png](http://static.geoserver.org/images/GeoServer_200.png)

wiki: [wikipedia.org](https://wikipedia.org/wiki/GeoServer) | site: [geoserver.org](http://geoserver.org/) | documentation: [docs.geoserver.org](http://docs.geoserver.org/) | repository: [github.com](https://github.com/geoserver/geoserver)
# Image description #

Is not official GeoServer image based on `Oracle Java` with `JAI 1.1.3`, `ImageIO 1.1`, `GDAL 1.10.1` and extensions:

* ogr
* gdal
* printing
* importer

# How to use this image #
## Start a GeoServer instance ##

```console
$ docker run -d winsent/geoserver

```
You can test it by visiting http://container-ip:8080

## Using a custom GeoServer data directory ##
Make geoserver data directory and run container
```console
$ mkdir ~/geoserver_data
$ docker run -d -p 8080:8080 -v ~/geoserver_data:/opt/geoserver/data_dir winsent/geoserver

```

## License ##
GeoServer licensed under the [GPL](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
# README #
GeoServer 2.7.2 on Oracle Java 7 with JAI 1.1.3, ImageIO 1.1, GDAL 1.9.2 and extentions:

* ogr
* gdal
* printing
* importer

Image size 705 Mb

## Run geoserver ##

Make directory for geoserver data and run container


```
mkdir -p ~/geoserver_data
docker run -d -p 8080:8080 -v ~/geoserver_data:/opt/geoserver/data_dir winsent/geoserver
```
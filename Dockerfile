FROM ubuntu:trusty
MAINTAINER winsent<pipetc@gmail.com>


ENV DEBIAN_FRONTEND noninteractive
ENV GDAL_PATH /usr/local/gdal
ENV GEOSERVER_HOME /opt/geoserver
ENV JAVA_HOME /usr
ENV GDAL_DATA $GDAL_PATH/gdal-data
ENV PATH $GDAL_PATH:$PATH
ENV LD_LIBRARY_PATH $GDAL_PATH

RUN export DEBIAN_FRONTEND=noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl

# Install packages
RUN \
  apt-get -y update --fix-missing && \
  apt-get -y install unzip software-properties-common && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get -y update && \
  apt-get install -y oracle-java7-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer && \
  rm -rf /tmp/* /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Get native JAI and ImageIO
RUN \
    cd $JAVA_HOME && \
    wget http://data.boundlessgeo.com/suite/jai/jai-1_1_3-lib-linux-amd64-jdk.bin && \
    echo "yes" | sh jai-1_1_3-lib-linux-amd64-jdk.bin && \
    rm jai-1_1_3-lib-linux-amd64-jdk.bin

RUN \
    cd $JAVA_HOME && \
    export _POSIX2_VERSION=199209 &&\
    wget http://data.opengeo.org/suite/jai/jai_imageio-1_1-lib-linux-amd64-jdk.bin && \
    echo "yes" | sh jai_imageio-1_1-lib-linux-amd64-jdk.bin && \
    rm jai_imageio-1_1-lib-linux-amd64-jdk.bin

# Install GDAL
RUN wget -c http://demo.geo-solutions.it/share/github/imageio-ext/releases/1.1.X/1.1.12/native/gdal/gdal-data.zip -O ~/gdal-data.zip && \
    unzip ~/gdal-data.zip -d $GDAL_PATH && \
    rm ~/gdal-data.zip

RUN wget -c http://demo.geo-solutions.it/share/github/imageio-ext/releases/1.1.X/1.1.12/native/gdal/linux/gdal192-Ubuntu12-gcc4.6.3-x86_64.tar.gz -O ~/gdal192.tar.gz && \
    tar -zxvf ~/gdal192.tar.gz -C $GDAL_PATH && \
    rm ~/gdal192.tar.gz

#
# GEOSERVER INSTALLATION
#
ENV GEOSERVER_VERSION 2.7.2

# Get GeoServer
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-bin.zip -O ~/geoserver.zip &&\
    unzip ~/geoserver.zip -d /opt && mv -v /opt/geoserver* /opt/geoserver && \
    rm ~/geoserver.zip

# Get OGR plugin
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/extensions/geoserver-$GEOSERVER_VERSION-ogr-plugin.zip -O ~/geoserver-ogr-plugin.zip &&\
    unzip -o ~/geoserver-ogr-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-ogr-plugin.zip
    
# Get GDAL plugin
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/extensions/geoserver-$GEOSERVER_VERSION-gdal-plugin.zip -O ~/geoserver-gdal-plugin.zip &&\
    unzip -o ~/geoserver-gdal-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-gdal-plugin.zip

# Get printing plugin
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/extensions/geoserver-$GEOSERVER_VERSION-printing-plugin.zip -O ~/geoserver-printing-plugin.zip &&\
    unzip ~/geoserver-printing-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-printing-plugin.zip

# Get import plugin
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/$GEOSERVER_VERSION/extensions/geoserver-$GEOSERVER_VERSION-importer-plugin.zip -O ~/geoserver-importer-plugin.zip &&\
    unzip -o ~/geoserver-importer-plugin.zip -d /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm ~/geoserver-importer-plugin.zip

# Expose GeoServer's default port
EXPOSE 8080
CMD ["/opt/geoserver/bin/startup.sh"]

FROM tomcat:9.0-alpine
LABEL maintainer="marie.gradeler@gmail.com"

#download geoserver from sourceforge
RUN wget 'https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/geoserver-2.18.2-war.zip' \
    unzip geoserver-2.18.2-war.zip geoserver.war -d /usr/local/webapp-data


EXPOSE 8080
CMD [ "catalina.sh", "run" ]
FROM postgres:12.5
LABEL maintainer="marie.gradeler@gmail.com"

#install postGIS
RUN apt-get update && apt-get install --no-install-recommends -y postgis postgresql-12-postgis-3

#run init_db.sh
ADD init-user-db.sh /docker-entrypoint-initdb.d/
ADD init-db-postgis.sh /docker-entrypoint-initdb.d/

#clean up
RUN apt-get -y --purge autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*


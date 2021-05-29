FROM postgres:13.3
LABEL maintainer="marie.gradeler@gmail.com"

# Install postGIS
RUN apt-get update && apt-get install --no-install-recommends -y postgis postgresql-13-postgis-3

# Add shell scripts to execute once the database has been created
COPY ./init/* /docker-entrypoint-initdb.d/
RUN ls -la /docker-entrypoint-initdb.d/

#clean up
RUN apt-get -y --purge autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*
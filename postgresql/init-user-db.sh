#!/bin/bash
set -e

#create webadmin role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS webapp_default;
    CREATE USER webadmin;
    ALTER ROLE webadmin WITH PASSWORD 'webadmin';
        GRANT ALL PRIVILEGES ON DATABASE webapp TO webadmin;
        GRANT ALL ON SCHEMA webapp_default TO webadmin WITH GRANT OPTION;
        ALTER DEFAULT PRIVILEGES IN SCHEMA webapp_default GRANT ALL ON TABLES TO webadmin WITH GRANT OPTION;
EOSQL

#create geoserver read-only user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER geoserver;
    ALTER ROLE geoserver WITH PASSWORD 'geoserver';
        GRANT USAGE ON SCHEMA webapp_default TO geoserver;
        ALTER DEFAULT PRIVILEGES IN SCHEMA webapp_default GRANT SELECT ON TABLES TO geoserver;
EOSQL
done
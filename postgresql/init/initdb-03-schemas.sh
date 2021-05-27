#!/bin/bash
set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create userdata schema
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SCHEMA userdata
        AUTHORIZATION namo;

    COMMENT ON SCHEMA userdata
        IS '''userdata'' schema contains the web data like storymap books or users login data.';

    GRANT ALL ON SCHEMA userdata TO admins;

    GRANT USAGE ON SCHEMA userdata TO guests;

    GRANT ALL ON SCHEMA userdata TO webadmins;
EOSQL

# Create geodata schema
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SCHEMA geodata
        AUTHORIZATION admins;

    COMMENT ON SCHEMA geodata
        IS '''geodata'' schema contains the geospatial data to display on the map.';

    GRANT ALL ON SCHEMA geodata TO admins;

    GRANT ALL ON SCHEMA geodata TO geoadmins;

    GRANT USAGE ON SCHEMA geodata TO guests;

    ALTER DEFAULT PRIVILEGES IN SCHEMA geodata
    GRANT ALL ON TABLES TO admins;

    ALTER DEFAULT PRIVILEGES IN SCHEMA geodata
    GRANT ALL ON TABLES TO geoadmins;

    ALTER DEFAULT PRIVILEGES IN SCHEMA geodata
    GRANT SELECT ON TABLES TO guests;
EOSQL
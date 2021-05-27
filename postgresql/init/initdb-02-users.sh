#!/bin/bash
set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create admins role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE admins WITH
        NOLOGIN
        NOSUPERUSER
        INHERIT
        CREATEDB
        CREATEROLE
        NOREPLICATION;
    COMMENT ON ROLE admins IS 'Main admins - all rights to create roles and databases. Be careful.';
EOSQL

# Create webadmins role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE webadmins WITH
        NOLOGIN
        NOSUPERUSER
        INHERIT
        NOCREATEDB
        NOCREATEROLE
        NOREPLICATION;
    COMMENT ON ROLE webadmins IS 'Webadmins have CREATE and USAGE rights on ''userdata'' and ''geodata'' schema.';
EOSQL

# Create geoadmins role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE geoadmins WITH
        NOLOGIN
        NOSUPERUSER
        INHERIT
        NOCREATEDB
        NOCREATEROLE
        NOREPLICATION;
    COMMENT ON ROLE geoadmins IS 'Geoadmins can USAGE and CREATE on ''geodata'' schema';
EOSQL

# Create guests role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE guests WITH
        NOLOGIN
        NOSUPERUSER
        INHERIT
        NOCREATEDB
        NOCREATEROLE
        NOREPLICATION;
    COMMENT ON ROLE guests IS 'Guests can USAGE on every schema. It''s a ''readonly'' role.';
EOSQL

# Create first admin user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE first_admin WITH
        LOGIN
        NOSUPERUSER
        INHERIT
        CREATEDB
        CREATEROLE
        NOREPLICATION
        ENCRYPTED PASSWORD '$FIRST_ADMIN_PASSWORD';
    GRANT admins TO first_admin;
    COMMENT ON ROLE first_admin IS 'Default admin with all rights.';
EOSQL

# Create web connexion
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE webconnexion WITH
        LOGIN
        NOSUPERUSER
        INHERIT
        NOCREATEDB
        NOCREATEROLE
        NOREPLICATION
        ENCRYPTED PASSWORD '$WEBCONNEXION_PASSWORD';
    GRANT geoadmins, webadmins TO webconnexion;
EOSQL
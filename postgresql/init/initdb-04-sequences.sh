#!/bin/bash
set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Login id
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE userdata.login_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE userdata.login_id_seq
        OWNER TO admins;

    GRANT ALL ON SEQUENCE userdata.login_id_seq TO admins;

    GRANT ALL ON SEQUENCE userdata.login_id_seq TO webadmins;
EOSQL

# Collections
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE userdata.collections_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE userdata.collections_id_seq
        OWNER TO admins;

    GRANT ALL ON SEQUENCE userdata.collections_id_seq TO admins;

    GRANT ALL ON SEQUENCE userdata.collections_id_seq TO webadmins;
EOSQL

# Books
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE userdata.books_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE userdata.books_id_seq
        OWNER TO admins;

    GRANT ALL ON SEQUENCE userdata.books_id_seq TO admins;

    GRANT ALL ON SEQUENCE userdata.books_id_seq TO webadmins;
EOSQL

# Chapters
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE userdata.chapters_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE userdata.chapters_id_seq
        OWNER TO namo;

    GRANT ALL ON SEQUENCE userdata.chapters_id_seq TO admins;

    GRANT ALL ON SEQUENCE userdata.chapters_id_seq TO webadmins;
EOSQL

# Paragraphs
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE userdata.paragraphs_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE userdata.paragraphs_id_seq
        OWNER TO namo;

    GRANT ALL ON SEQUENCE userdata.paragraphs_id_seq TO admins;

    GRANT ALL ON SEQUENCE userdata.paragraphs_id_seq TO webadmins;
EOSQL

# Themes
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE geodata.themes_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE geodata.themes_id_seq
        OWNER TO namo;

    GRANT ALL ON SEQUENCE geodata.themes_id_seq TO admins;

    GRANT ALL ON SEQUENCE geodata.themes_id_seq TO geoadmins;
EOSQL

# Server types
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE geodata."serverType_id_seq"
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 2147483647
        CACHE 1;

    ALTER SEQUENCE geodata."serverType_id_seq"
        OWNER TO namo;

    GRANT ALL ON SEQUENCE geodata."serverType_id_seq" TO admins;

    GRANT ALL ON SEQUENCE geodata."serverType_id_seq" TO geoadmins;
EOSQL

# Servers
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE geodata.servers_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 2147483647
        CACHE 1;

    ALTER SEQUENCE geodata.servers_id_seq
        OWNER TO namo;

    GRANT ALL ON SEQUENCE geodata.servers_id_seq TO admins;

    GRANT ALL ON SEQUENCE geodata.servers_id_seq TO geoadmins;
EOSQL

# Layers
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SEQUENCE geodata.layers_id_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE geodata.layers_id_seq
        OWNER TO namo;

    GRANT ALL ON SEQUENCE geodata.layers_id_seq TO admins;

    GRANT ALL ON SEQUENCE geodata.layers_id_seq TO geoadmins;
EOSQL
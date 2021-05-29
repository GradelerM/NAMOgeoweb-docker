#!/bin/bash
set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Users
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE userdata.users
    (
        id bigint NOT NULL DEFAULT nextval('userdata.login_id_seq'::regclass),
        username character varying(255) COLLATE pg_catalog."default" NOT NULL,
        password character varying(255) COLLATE pg_catalog."default" NOT NULL,
        email character varying(255) COLLATE pg_catalog."default" NOT NULL,
        role character varying(255) COLLATE pg_catalog."default" NOT NULL,
        user_enabled boolean NOT NULL,
        motivation character varying(1000) COLLATE pg_catalog."default",
        CONSTRAINT login_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

    ALTER TABLE userdata.users
        OWNER to admins;

    GRANT ALL ON TABLE userdata.users TO admins;

    GRANT ALL ON TABLE userdata.users TO webadmins;

    COMMENT ON TABLE userdata.users
        IS 'Table in which usernames, passwords and mails are stores. EDIT WITH CAUTION.';
EOSQL

# Allow the first admin user to login in NAMO GeoWeb
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    INSERT INTO userdata.users(username, password, email, role, user_enabled, motivation)
	VALUES ('$ADMIN_USERNAME', encode(digest('$ADMIN_PASSWORD', 'sha256'), 'hex'), '$ADMIN_MAIL', 'admin', true, 'First admin');
EOSQL

# Collections
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE userdata.collections
    (
        id bigint NOT NULL DEFAULT nextval('userdata.collections_id_seq'::regclass),
        name character varying(255) COLLATE pg_catalog."default" NOT NULL,
        "position" integer,
        CONSTRAINT id PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

    ALTER TABLE userdata.collections
        OWNER to admins;

    GRANT ALL ON TABLE userdata.collections TO admins;

    GRANT SELECT ON TABLE userdata.collections TO guests;

    GRANT ALL ON TABLE userdata.collections TO webadmins;

    COMMENT ON TABLE userdata.collections
        IS 'This table contains the collections in which the books can be classified.';
EOSQL

# Create the default "Aucune" collection
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    INSERT INTO userdata.collections(name, position)
	VALUES ('Aucune', 0);
EOSQL

# Books
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE userdata.books
    (
        id bigint NOT NULL DEFAULT nextval('userdata.books_id_seq'::regclass),
        title character varying(255) COLLATE pg_catalog."default",
        collection_id integer DEFAULT 1,
        abstract character varying(10000) COLLATE pg_catalog."default",
        author_id integer NOT NULL,
        status character varying(255) COLLATE pg_catalog."default" DEFAULT 'draft'::character varying,
        creation_date date NOT NULL DEFAULT CURRENT_DATE,
        publication_date date,
        legal_notice character varying(255) COLLATE pg_catalog."default",
        CONSTRAINT books_pkey PRIMARY KEY (id),
        CONSTRAINT title UNIQUE (title),
        CONSTRAINT author_id FOREIGN KEY (author_id)
            REFERENCES userdata.users (id) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        CONSTRAINT collection_id FOREIGN KEY (collection_id)
            REFERENCES userdata.collections (id) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

    ALTER TABLE userdata.books
        OWNER to admins;

    GRANT ALL ON TABLE userdata.books TO admins;

    GRANT SELECT ON TABLE userdata.books TO guests;

    GRANT ALL ON TABLE userdata.books TO webadmins;

    COMMENT ON TABLE userdata.books
        IS 'This table contains the books which were created by the users.';
EOSQL

# Chapters
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE userdata.chapters
    (
        id bigint NOT NULL DEFAULT nextval('userdata.chapters_id_seq'::regclass),
        book_id integer NOT NULL,
        introduction boolean NOT NULL DEFAULT false,
        title character varying(80) COLLATE pg_catalog."default",
        "position" integer NOT NULL,
        latitude real NOT NULL DEFAULT '-61.5262'::numeric,
        longitude real NOT NULL DEFAULT 16.1599,
        zoom real NOT NULL DEFAULT 8.5,
        basemap character varying(255) COLLATE pg_catalog."default",
        layers character varying(10000) COLLATE pg_catalog."default",
        CONSTRAINT chapters_pkey PRIMARY KEY (id),
        CONSTRAINT book_id FOREIGN KEY (book_id)
            REFERENCES userdata.books (id) MATCH SIMPLE
            ON UPDATE CASCADE
            ON DELETE CASCADE
            NOT VALID
    )

    TABLESPACE pg_default;

    ALTER TABLE userdata.chapters
        OWNER to namo;

    GRANT ALL ON TABLE userdata.chapters TO admins;

    GRANT SELECT ON TABLE userdata.chapters TO guests;

    GRANT ALL ON TABLE userdata.chapters TO webadmins;

    COMMENT ON TABLE userdata.chapters
        IS 'The books chapters are stored here.';
EOSQL

# Paragraphs
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE userdata.paragraphs
    (
        id bigint NOT NULL DEFAULT nextval('userdata.paragraphs_id_seq'::regclass),
        chapter_id integer NOT NULL,
        type character varying(255) COLLATE pg_catalog."default" NOT NULL,
        content character varying(10000) COLLATE pg_catalog."default",
        url character varying(10000) COLLATE pg_catalog."default",
        "position" integer NOT NULL,
        CONSTRAINT paragraphs_pkey PRIMARY KEY (id),
        CONSTRAINT chapter_id FOREIGN KEY (chapter_id)
            REFERENCES userdata.chapters (id) MATCH SIMPLE
            ON UPDATE CASCADE
            ON DELETE CASCADE
    )

    TABLESPACE pg_default;

    ALTER TABLE userdata.paragraphs
        OWNER to namo;

    GRANT ALL ON TABLE userdata.paragraphs TO admins;

    GRANT SELECT ON TABLE userdata.paragraphs TO guests;

    GRANT ALL ON TABLE userdata.paragraphs TO webadmins;

    COMMENT ON TABLE userdata.paragraphs
        IS 'The paragraphs composing the chapters are stored here.';
EOSQL

# Themes
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE geodata.themes
    (
        id bigint NOT NULL DEFAULT nextval('geodata.themes_id_seq'::regclass),
        theme character varying(255) COLLATE pg_catalog."default" NOT NULL,
        "position" integer,
        CONSTRAINT themes_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

    ALTER TABLE geodata.themes
        OWNER to namo;

    GRANT ALL ON TABLE geodata.themes TO admins;

    GRANT ALL ON TABLE geodata.themes TO geoadmins;

    GRANT SELECT ON TABLE geodata.themes TO guests;

    COMMENT ON TABLE geodata.themes
        IS 'Table to store all the themes created in the application, for displaying the layers.';
EOSQL

# Create the default "Autres" theme
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    INSERT INTO geodata.themes(theme, position)
	VALUES ('Autres', 0);
EOSQL

# Server types
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE geodata."serverType"
    (
        id integer NOT NULL DEFAULT nextval('geodata."serverType_id_seq"'::regclass),
        type character varying(255) COLLATE pg_catalog."default" NOT NULL,
        CONSTRAINT id PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

    ALTER TABLE geodata."serverType"
        OWNER to namo;

    GRANT ALL ON TABLE geodata."serverType" TO admins;

    GRANT ALL ON TABLE geodata."serverType" TO geoadmins;

    GRANT SELECT ON TABLE geodata."serverType" TO guests;

    COMMENT ON TABLE geodata."serverType"
        IS 'All the available server types in OpenLayers, including the "other" option.';
EOSQL

# Add all the supported server types
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    INSERT INTO geodata."serverType"(type)
        VALUES 
            ('other'),
            ('carmentaserver'),
            ('geoserver'),
            ('mapserver'),
            ('qgis');
EOSQL

# Servers
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE geodata.servers
    (
        id integer NOT NULL DEFAULT nextval('geodata.servers_id_seq'::regclass),
        name character varying(255) COLLATE pg_catalog."default" NOT NULL,
        url character varying(255) COLLATE pg_catalog."default" NOT NULL,
        type integer NOT NULL,
        CONSTRAINT servers_pkey PRIMARY KEY (id),
        CONSTRAINT "serverType" FOREIGN KEY (type)
            REFERENCES geodata."serverType" (id) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

    ALTER TABLE geodata.servers
        OWNER to namo;

    GRANT ALL ON TABLE geodata.servers TO admins;

    GRANT ALL ON TABLE geodata.servers TO geoadmins;

    GRANT SELECT ON TABLE geodata.servers TO guests;

    COMMENT ON TABLE geodata.servers
        IS 'Table to store the different server sources we want to add to the application.';

    COMMENT ON CONSTRAINT "serverType" ON geodata.servers
        IS 'Link to one of the available server types.';
EOSQL

# Layers
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE geodata.layers
    (
        id bigint NOT NULL DEFAULT nextval('geodata.layers_id_seq'::regclass),
        server integer NOT NULL,
        name character varying(255) COLLATE pg_catalog."default" NOT NULL,
        title character varying(255) COLLATE pg_catalog."default",
        theme integer NOT NULL,
        opacity real DEFAULT 1,
        "zIndex" integer DEFAULT 1000,
        CONSTRAINT layers_pkey PRIMARY KEY (id),
        CONSTRAINT server FOREIGN KEY (server)
            REFERENCES geodata.servers (id) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE CASCADE,
        CONSTRAINT theme FOREIGN KEY (theme)
            REFERENCES geodata.themes (id) MATCH SIMPLE
            ON UPDATE NO ACTION
            ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

    ALTER TABLE geodata.layers
        OWNER to namo;

    GRANT ALL ON TABLE geodata.layers TO admins;

    GRANT ALL ON TABLE geodata.layers TO geoadmins;

    GRANT SELECT ON TABLE geodata.layers TO guests;

    COMMENT ON TABLE geodata.layers
        IS 'Table to store the layers imported in the application.';

    COMMENT ON CONSTRAINT server ON geodata.layers
        IS 'Referring to the server.';
    COMMENT ON CONSTRAINT theme ON geodata.layers
        IS 'Link to the themes.';
EOSQL

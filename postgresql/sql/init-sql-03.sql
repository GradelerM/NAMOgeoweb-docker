-- ================================================================================================
-- Creating the sequences the tables will use
-- ================================================================================================

-- ================================================================================================
-- userdata sequences
-- ================================================================================================

-- Login id

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


-- Collections

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


-- Books

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


-- Chapters

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


-- Paragraphs

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

-- ================================================================================================
-- geodata sequences
-- ================================================================================================

-- Themes

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


-- Server types

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


-- Servers

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


-- Layers

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

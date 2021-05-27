-- ================================================================================================
-- Defining passwords for groups and roles
-- ================================================================================================

-- setting up passwords for the groups (TO CHANGE BEFORE CREATING THE DATABASE)

DECLARE webadmins_psswd CONSTANT    VARCHAR:= 'webadmins';
DECLARE admins_psswd CONSTANT       VARCHAR:= 'admins';
DECLARE geoadmins_psswd CONSTANT    VARCHAR:= 'geoadmins';
DECLARE guests_psswd CONSTANT       VARCHAR:= 'guests';

-- setting up passwords for the users (TO CHANGE BEFORE CREATING THE DATABASE)

DECLARE first_admin_psswd CONSTANT    VARCHAR:= 'first_admin';
DECLARE webconnexion_psswd CONSTANT   VARCHAR:= 'webconnexion';

-- ================================================================================================
-- Creating roles in the database
-- ================================================================================================

-- webadmins have rights on the userdata schema

CREATE ROLE webadmins WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD webadmins_psswd;

COMMENT ON ROLE webadmins IS 'Webadmins have CREATE and USAGE rights on ''userdata'' and ''geodata'' schema.';

-- admins have all rights on the database, even to create roles
-- for administration inside the database only

CREATE ROLE admins WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD admins_psswd;

COMMENT ON ROLE admins IS 'Main admins - all rights to create roles and databases. Be careful.';

-- geoadmins only have rights on the geodata schema
-- useful role if you want some users to only access these for layer management
-- useful in case your want to add shapefiles in your database (not recommended)

CREATE ROLE geoadmins WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD geoadmins_psswd;

COMMENT ON ROLE geoadmins IS 'Geoadmins can USAGE and CREATE on ''geodata'' schema';

-- guests have a readonly role

CREATE ROLE guests WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD guests_psswd;

COMMENT ON ROLE guests IS 'Guests can USAGE on every schema. It''s a ''readonly'' role.';

-- ================================================================================================
-- Creating users in the database
-- ================================================================================================

-- Creating the first administrator so the database is accessible 
-- and this administrator can create other users

CREATE ROLE first_admin WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD first_admin_psswd;

GRANT admins TO first_admin;

COMMENT ON ROLE first_admin IS 'Default admin with all rights.';

-- Creating the webconnexion so NAMO can access the database

CREATE ROLE webconnexion WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD webconnexion_psswd;

GRANT geoadmins, webadmins TO webconnexion;
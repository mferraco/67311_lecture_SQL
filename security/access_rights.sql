
-- Create users with various levels of access
CREATE USER tmp_commish WITH LOGIN PASSWORD 'notlong' VALID UNTIL '2012-12-31' CONNECTION LIMIT 2;
CREATE USER batman WITH LOGIN PASSWORD 'darkknight' SUPERUSER;
ALTER USER batman NOSUPERUSER;

-- Info on users
\du -- describe users
SELECT * FROM pg_user;
SELECT * FROM pg_shadow; -- only for superusers

-- Create groups
CREATE GROUP police WITH USER gordon, blake, fields;


-- Create a database and change ownership
CREATE DATABASE gcpd_sec OWNER profh CONNECTION LIMIT 3;
ALTER DATABASE gcpd_sec OWNER TO tmp_commish;

-- Info on databases and tables
SELECT * FROM pg_database ORDER BY datname;
SELECT * FROM pg_tables ORDER BY tablename;


-- Change ownership of a table
ALTER TABLE case_summary OWNER TO batman;

-- Info on privileges
\dp -- describe privileges
\dt -- tells you who owns tables in database


-- Change access to specific tables and views
GRANT ALL PRIVILEGES ON cases TO batman;
GRANT SELECT ON case_crimes_view TO PUBLIC;
GRANT SELECT, UPDATE, INSERT ON officers TO police;

REVOKE ALL PRIVILEGES ON cases FROM batman;
REVOKE SELECT ON case_crimes_view FROM PUBLIC;
REVOKE UPDATE, INSERT ON officers FROM police;








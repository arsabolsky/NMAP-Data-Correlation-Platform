-- Create a specific database role for PostgREST to use for anonymous requests.
-- This does NOT modify your existing tables or data; it only adds a permission layer.
CREATE ROLE web_anon NOLOGIN;

-- Grant the new role access to the 'public' schema.
GRANT USAGE ON SCHEMA public TO web_anon;

-- Grant the role permission to SELECT (read) data from all tables and views in the 'public' schema.
GRANT SELECT ON ALL TABLES IN SCHEMA public TO web_anon;

-- Ensure that any future tables created in this schema also grant read access to this role.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO web_anon;

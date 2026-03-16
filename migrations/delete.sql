/*
-------------------------------------------------------------------------------
-- MYSQL VERSION (Commented out)
-------------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0; -- to disable foreign key check
-- 1. Delete from COMPANY (Base table)
DELETE FROM COMPANY;

-- 2. Delete from LOCATION (Depends on COMPANY)
DELETE FROM LOCATION;

-- 3. Delete from EMPLOYEE (Depends on LOCATION)
DELETE FROM EMPLOYEE;

-- 4. Delete from SCAN (Depends on LOCATION)
DELETE FROM SCAN;

SET FOREIGN_KEY_CHECKS=1; -- to re-enable foreign key check
*/

-------------------------------------------------------------------------------
-- POSTGRESQL VERSION
-------------------------------------------------------------------------------

-- CHANGE: PostgreSQL does not use SET FOREIGN_KEY_CHECKS. 
-- Instead, you can set the session_replication_role to 'replica' to bypass triggers/constraints,
-- or simply delete in reverse order of dependency, or use TRUNCATE CASCADE.

-- Option A: Disable constraints temporarily (Requires superuser or specific permissions)
SET session_replication_role = 'replica';

-- 1. Delete from COMPANY (Base table)
DELETE FROM COMPANY;

-- 2. Delete from LOCATION (Depends on COMPANY)
DELETE FROM LOCATION;

-- 3. Delete from EMPLOYEE (Depends on LOCATION)
DELETE FROM EMPLOYEE;

-- 4. Delete from SCAN (Depends on LOCATION)
DELETE FROM SCAN;

-- Re-enable constraints
SET session_replication_role = 'origin';

-- NOTE: In PostgreSQL, a more idiomatic way to wipe all data is:
-- TRUNCATE TABLE COMPANY, LOCATION, EMPLOYEE, SCAN CASCADE;
-- This will clear all tables and reset their dependencies safely.

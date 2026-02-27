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
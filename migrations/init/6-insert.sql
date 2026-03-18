/*
-------------------------------------------------------------------------------
-- MYSQL VERSION (Commented out)
-------------------------------------------------------------------------------
-- 1. Insert into COMPANY
INSERT INTO COMPANY (CID, CompanyName, Admin_Contact)
VALUES
(1, 'Cyberdyne Systems', 'sarah.connor@cyberdyne.io'),
(2, 'Initech', 'bill.lumbergh@initech.com'),
(3, 'Soylent Corp', 'robert.thorn@soylent.org');

-- 2. Insert into LOCATION
INSERT INTO LOCATION (LID, CID, LocationName, Address)
VALUES
(101, 1, 'Main Research Lab', '123 Skynet Ln, Los Angeles, CA'),
(102, 2, 'Regional Office', '4120 Freidrich Ln, Austin, TX'),
(103, 3, 'Processing Plant 4', '55 Food St, New York, NY');

-- 3. Insert into EMPLOYEE
INSERT INTO EMPLOYEE (UID, LID, Username, PasswordHash, Email, PointOfContact, FirstName, LastName)
VALUES
(501, 101, 'kylereese2026', 'da665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e867f7a27ae3', 'kyle@cyberdyne.com', 1, 'Kyle', 'Reese'),
(502, 102, 'petergibbonsoffice', 'b31d86b9877207a23366c3a27744356e9c15a77f0a6d5952136d7d5612143f60', 'peter@initech.com', 0, 'Peter', 'Gibbons'),
(503, 103, 'solrothdetective', '861821084a70b904141663140656006f85d2634e004052309f06e6e2f1e626e2', 'sol@soylent.com', 1, 'Sol', 'Roth');

-- 4. Insert into SCAN
INSERT INTO SCAN (Scan_ID, LID, Date, Time, IP_Address, OS, Open_Ports)
VALUES
(1001, 101, '2026-02-23', '09:00:00', '192.168.1.50', 'Linux Ubuntu 22.04', '{"22": "ssh", "80": "http", "443": "https"}'),
(1002, 102, '2026-02-23', '10:30:00', '10.0.0.15', 'Windows Server 2022', '{"3389": "rdp", "445": "microsoft-ds"}'),
(1003, 101, '2026-02-23', '14:15:00', '192.168.1.55', 'CentOS 7', '{"80": "http", "8080": "http-proxy"}');
*/

-------------------------------------------------------------------------------
-- POSTGRESQL VERSION
-------------------------------------------------------------------------------

-- 1. COMPANY Table: No changes needed.
INSERT INTO COMPANY (CID, CompanyName, Admin_Contact)
VALUES
(1, 'Cyberdyne Systems', 'sarah.connor@cyberdyne.io'),
(2, 'Initech', 'bill.lumbergh@initech.com'),
(3, 'Soylent Corp', 'robert.thorn@soylent.org');

-- Sync the sequence for the CID column
SELECT setval('company_cid_seq', (SELECT MAX(CID) FROM COMPANY));

-- 2. LOCATION Table: No changes needed.
INSERT INTO LOCATION (LID, CID, LocationName, Address)
VALUES
(101, 1, 'Main Research Lab', '123 Skynet Ln, Los Angeles, CA'),
(102, 2, 'Regional Office', '4120 Freidrich Ln, Austin, TX'),
(103, 3, 'Processing Plant 4', '55 Food St, New York, NY');

-- Sync the sequence for the LID column
SELECT setval('location_lid_seq', (SELECT MAX(LID) FROM LOCATION));

-- 3. EMPLOYEE Table:
-- CHANGE: Booleans in PostgreSQL should be TRUE/FALSE literal values.
-- CHANGE: PointOfContact 1 -> TRUE, 0 -> FALSE
INSERT INTO EMPLOYEE (UID, LID, Username, PasswordHash, Email, PointOfContact, FirstName, LastName)
VALUES
(501, 101, 'kylereese2026', 'da665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e867f7a27ae3', 'kyle@cyberdyne.com', TRUE, 'Kyle', 'Reese'),
(502, 102, 'petergibbonsoffice', 'b31d86b9877207a23366c3a27744356e9c15a77f0a6d5952136d7d5612143f60', 'peter@initech.com', FALSE, 'Peter', 'Gibbons'),
(503, 103, 'solrothdetective', '861821084a70b904141663140656006f85d2634e004052309f06e6e2f1e626e2', 'sol@soylent.com', TRUE, 'Sol', 'Roth');

-- Sync the sequence for the UID column
SELECT setval('employee_uid_seq', (SELECT MAX(UID) FROM EMPLOYEE));

-- 4. SCAN Table: No changes needed for values, JSON strings are compatible with JSONB.
INSERT INTO SCAN (Scan_ID, LID, Date, Time, IP_Address, OS, Open_Ports)
VALUES
(1001, 101, '2026-02-23', '09:00:00', '192.168.1.50', 'Linux Ubuntu 22.04', '{"22": "ssh", "80": "http", "443": "https"}'),
(1002, 102, '2026-02-23', '10:30:00', '10.0.0.15', 'Windows Server 2022', '{"3389": "rdp", "445": "microsoft-ds"}'),
(1003, 101, '2026-02-23', '14:15:00', '192.168.1.55', 'CentOS 7', '{"80": "http", "8080": "http-proxy"}');

-- Sync the sequence for the Scan_ID column
SELECT setval('scan_scan_id_seq', (SELECT MAX(Scan_ID) FROM SCAN));

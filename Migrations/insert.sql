
-- 1. Insert into COMPANY (Base table)
INSERT INTO COMPANY (CID, CompanyName, Admin_Contact)
VALUES 
(1, 'Cyberdyne Systems', 'Sarah Connor'),
(2, 'Initech', 'Bill Lumbergh'),
(3, 'Soylent Corp', 'Robert Thorn');

-- 2. Insert into LOCATION (Depends on COMPANY)
INSERT INTO LOCATION (LID, CID, LocationName, Address)
VALUES 
(101, 1, 'Main Research Lab', '123 Skynet Ln, Los Angeles, CA'),
(102, 2, 'Regional Office', '4120 Freidrich Ln, Austin, TX'),
(103, 3, 'Processing Plant 4', '55 Food St, New York, NY');

-- 3. Insert into EMPLOYEE (Depends on LOCATION)
INSERT INTO EMPLOYEE (UID, LID, Username, PasswordHash, Email, PointOfContact, FirstName, LastName)
VALUES 
(501, 101, 'mreese', 'hash_abc123', 'kyle@cyberdyne.com', 1, 'Kyle', 'Reese'),
(502, 102, 'pgibbons', 'hash_def456', 'peter@initech.com', 0, 'Peter', 'Gibbons'),
(503, 103, 'sroth', 'hash_ghi789', 'sol@soylent.com', 1, 'Sol', 'Roth');

-- 4. Insert into SCAN (Depends on LOCATION)
INSERT INTO SCAN (Scan_ID, LID, Date, Time, IP_Address, OS, Open_Ports)
VALUES 
(1001, 101, '2026-02-23', '09:00:00', '192.168.1.50', 'Linux Ubuntu 22.04', '22, 80, 443'),
(1002, 102, '2026-02-23', '10:30:00', '10.0.0.15', 'Windows Server 2022', '3389, 445'),
(1003, 101, '2026-02-23', '14:15:00', '192.168.1.55', 'CentOS 7', '80, 8080');
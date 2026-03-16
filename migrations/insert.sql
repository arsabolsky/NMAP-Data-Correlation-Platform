-- 1. Insert into COMPANY
-- Note: Admin_Contact must be unique and contain '@'
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
-- Rules: Username >= 12 chars, PasswordHash = 64 chars, Names = Alphabetic only
INSERT INTO EMPLOYEE (UID, LID, Username, PasswordHash, Email, PointOfContact, FirstName, LastName)
VALUES
(501, 101, 'kylereese2026', 'da665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e867f7a27ae3', 'kyle@cyberdyne.com', 1, 'Kyle', 'Reese'),
(502, 102, 'petergibbonsoffice', 'b31d86b9877207a23366c3a27744356e9c15a77f0a6d5952136d7d5612143f60', 'peter@initech.com', 0, 'Peter', 'Gibbons'),
(503, 103, 'solrothdetective', '861821084a70b904141663140656006f85d2634e004052309f06e6e2f1e626e2', 'sol@soylent.com', 1, 'Sol', 'Roth');

-- 4. Insert into SCAN
-- Rules: IP_Address must be valid, Scan_ID will start at 1000 automatically
INSERT INTO SCAN (Scan_ID, LID, Date, Time, IP_Address, OS, Open_Ports)
VALUES
(1001, 101, '2026-02-23', '09:00:00', '192.168.1.50', 'Linux Ubuntu 22.04', '{"22": "ssh", "80": "http", "443": "https"}'),
(1002, 102, '2026-02-23', '10:30:00', '10.0.0.15', 'Windows Server 2022', '{"3389": "rdp", "445": "microsoft-ds"}'),
(1003, 101, '2026-02-23', '14:15:00', '192.168.1.55', 'CentOS 7', '{"80": "http", "8080": "http-proxy"}');
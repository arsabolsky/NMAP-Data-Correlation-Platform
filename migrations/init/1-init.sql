/*
-------------------------------------------------------------------------------
-- MYSQL VERSION (Commented out)
-------------------------------------------------------------------------------
CREATE TABLE COMPANY (
    CID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    -- Email (Contains @)
    Admin_Contact VARCHAR(255) NOT NULL CHECK (Admin_Contact LIKE '%@%')
);

CREATE TABLE LOCATION (
    LID SERIAL PRIMARY KEY,
    CID BIGINT UNSIGNED NOT NULL,
    LocationName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL, -- This will be our ISO 20022 PostalAddress
    FOREIGN KEY (CID) REFERENCES COMPANY(CID) ON DELETE CASCADE -- If we delete a location (parent table) it will go through and kill of foreign key references as well such as scans leaving no orphan scans
);

CREATE TABLE EMPLOYEE (
    UID SERIAL PRIMARY KEY,
    LID BIGINT UNSIGNED NOT NULL,
    -- Alphanumeric
    Username VARCHAR(255) NOT NULL UNIQUE CHECK (Username REGEXP '^[a-zA-Z0-9]+$'),
    -- SHA256 hash is always 64 chars
    PasswordHash VARCHAR(64) NOT NULL CHECK (CHAR_LENGTH(PasswordHash) = 64),
    -- Unique Email (Contains @)
    Email VARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%'),
    PointOfContact BOOLEAN NOT NULL DEFAULT FALSE,
    -- Alphabetic chars only
    FirstName VARCHAR(255) NOT NULL CHECK (FirstName REGEXP '^[a-zA-Z]+$'),
    LastName VARCHAR(255) NOT NULL CHECK (LastName REGEXP '^[a-zA-Z]+$'),
    FOREIGN KEY (LID) REFERENCES LOCATION(LID) ON DELETE CASCADE
);

CREATE TABLE SCAN (
    -- Unique numeric, min of 4 digits
    Scan_ID SERIAL PRIMARY KEY,
    LID BIGINT UNSIGNED NOT NULL, 
    Date DATE NOT NULL, -- This will be ISO 860 YYYY-MM-DD
    Time TIME NOT NULL, -- This will be ISO 8601 HH:MM:SS
    -- IPv4 & IPv6 or bust (ALSO HOW COOL IS THIS MYSQL FUCTION!?!?)
    IP_Address VARCHAR(45) NOT NULL CHECK (INET6_ATON(IP_Address) IS NOT NULL),
    OS VARCHAR(255) NOT NULL,
    Open_Ports TEXT NOT NULL, -- Text is used for large string containing a JSON disctionary ex: [8080,80,443,24]
    FOREIGN KEY (LID) REFERENCES LOCATION(LID) ON DELETE CASCADE
) AUTO_INCREMENT = 1000; -- ensures length of 4 digits
*/

-------------------------------------------------------------------------------
-- POSTGRESQL VERSION
-------------------------------------------------------------------------------

-- 1. COMPANY Table:
-- CHANGE: Using BIGSERIAL instead of SERIAL to ensure 64-bit integer support (matching MySQL SERIAL alias).
CREATE TABLE COMPANY (
    CID BIGSERIAL PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Admin_Contact VARCHAR(255) NOT NULL CHECK (Admin_Contact LIKE '%@%')
);

-- 2. LOCATION Table:
-- CHANGE: BIGINT UNSIGNED -> BIGINT. PostgreSQL does not have an UNSIGNED numeric type in core.
-- CHANGE: BIGSERIAL for 64-bit ID.
CREATE TABLE LOCATION (
    LID BIGSERIAL PRIMARY KEY,
    CID BIGINT NOT NULL,
    LocationName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    FOREIGN KEY (CID) REFERENCES COMPANY(CID) ON DELETE CASCADE
);

-- 3. EMPLOYEE Table:
-- CHANGE: REGEXP -> ~ (PostgreSQL uses the ~ operator for POSIX regex matches).
-- CHANGE: BIGINT UNSIGNED -> BIGINT.
-- CHANGE: CHAR_LENGTH -> LENGTH (Though Postgres supports both, LENGTH is idiomatic).
CREATE TABLE EMPLOYEE (
    UID BIGSERIAL PRIMARY KEY,
    LID BIGINT NOT NULL,
    -- Username uses '~' for regex validation
    Username VARCHAR(255) NOT NULL UNIQUE CHECK (Username ~ '^[a-zA-Z0-9]+$'),
    PasswordHash VARCHAR(64) NOT NULL CHECK (LENGTH(PasswordHash) = 64),
    Email VARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%'),
    PointOfContact BOOLEAN NOT NULL DEFAULT FALSE,
    FirstName VARCHAR(255) NOT NULL CHECK (FirstName ~ '^[a-zA-Z]+$'),
    LastName VARCHAR(255) NOT NULL CHECK (LastName ~ '^[a-zA-Z]+$'),
    FOREIGN KEY (LID) REFERENCES LOCATION(LID) ON DELETE CASCADE
);

-- 4. SCAN Table:
-- CHANGE: BIGINT UNSIGNED -> BIGINT.
-- CHANGE: INET6_ATON(IP_Address) IS NOT NULL -> IP_Address::INET IS NOT NULL.
--         PostgreSQL has a native INET type that performs strict IP validation when cast.
-- CHANGE: AUTO_INCREMENT = 1000 -> Sequence restart (see below).
CREATE TABLE SCAN (
    Scan_ID BIGSERIAL PRIMARY KEY,
    LID BIGINT NOT NULL, 
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    -- Validate IP using PostgreSQL's native INET casting
    IP_Address VARCHAR(45) NOT NULL CHECK (IP_Address::INET IS NOT NULL),
    OS VARCHAR(255) NOT NULL,
    Open_Ports JSONB NOT NULL, -- JSONB stores binary JSON for efficient indexing and querying
    FOREIGN KEY (LID) REFERENCES LOCATION(LID) ON DELETE CASCADE
);

-- CHANGE: PostgreSQL manages "SERIAL" via sequences. To start at 1000, we must restart the sequence.
-- The sequence name for BIGSERIAL is automatically generated as [table]_[column]_seq.
ALTER SEQUENCE scan_scan_id_seq RESTART WITH 1000;

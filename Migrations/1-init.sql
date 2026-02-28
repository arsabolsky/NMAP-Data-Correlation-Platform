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
    -- Alphanumeric, min 12 chars
    Username VARCHAR(255) NOT NULL UNIQUE CHECK (Username REGEXP '^[a-zA-Z0-9]{12,}$'),
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
    Scan_ID SERIAL PRIMARY KEY, -- CHECK (Scan_ID >= 1000), -- ensures length of 4 digits
    LID BIGINT UNSIGNED NOT NULL, 
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    IP_Address VARCHAR(45) NOT NULL,
    OS VARCHAR(255) NOT NULL,
    Open_Ports TEXT NOT NULL, -- Text is used for large string data
    FOREIGN KEY (LID) REFERENCES LOCATION(LID) ON DELETE CASCADE
);
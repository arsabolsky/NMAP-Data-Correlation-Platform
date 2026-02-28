CREATE TABLE COMPANY (
    CID SERIAL PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Admin_Contact VARCHAR(255) NOT NULL CHECK (Admin_Contact LIKE '%@%')
);

CREATE TABLE LOCATION (
    LID SERIAL PRIMARY KEY,
    CID BIGINT UNSIGNED NOT NULL,
    LocationName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL, -- This will be our ISO 20022 PostalAddress
    FOREIGN KEY (CID) REFERENCES COMPANY(CID) ON DELETE CASCADE 
    -- I had gemini review this and it suggested adding on delete... 
    -- basically if we delete a location (parent table) it will go through and kill of foreign key references as well such as scans leaving no orphan scans
    -- Super duper smart stuff
);

CREATE TABLE EMPLOYEE (
    UID SERIAL PRIMARY KEY,
    LID BIGINT UNSIGNED NOT NULL,
    Username VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(64) NOT NULL, -- SHA256 hash is always 64 chars
    Email VARCHAR(255) NOT NULL UNIQUE CHECK (Email LIKE '%@%'),
    PointOfContact BOOLEAN NOT NULL DEFAULT FALSE,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FOREIGN KEY (LID) REFERENCES LOCATION(LID)
);

CREATE TABLE SCAN (
    Scan_ID SERIAL PRIMARY KEY, -- CHECK (Scan_ID >= 1000), -- ensures length of 4 digits
    LID BIGINT UNSIGNED NOT NULL, 
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    IP_Address VARCHAR(45) NOT NULL,
    OS VARCHAR(255) NOT NULL,
    Open_Ports TEXT NOT NULL, -- Text is used for large string data
    FOREIGN KEY (LID) REFERENCES LOCATION(LID)
);
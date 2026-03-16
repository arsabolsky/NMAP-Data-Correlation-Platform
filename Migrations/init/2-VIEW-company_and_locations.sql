CREATE VIEW companies_and_locations AS
SELECT c.CompanyName, c.Admin_Contact, l.LID, l.LocationName, l.Address
FROM COMPANY c
JOIN LOCATION l ON c.CID = l.CID
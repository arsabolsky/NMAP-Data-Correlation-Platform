-- PostgreSQL Compatible View
CREATE VIEW employees_and_locations AS
SELECT e.UID, e.FirstName, e.LastName, e.PointOfContact, l.LID, l.LocationName, l.Address
FROM EMPLOYEE e
JOIN LOCATION l ON e.LID = l.LID
CREATE VIEW detailed_scan_report AS
SELECT 
    s.Scan_ID,
    c.CompanyName,
    l.LocationName,
    s.Date,
    s.Time,
    s.IP_Address,
    s.OS,
    s.Open_Ports
FROM SCAN s
JOIN LOCATION l ON s.LID = l.LID
JOIN COMPANY c ON l.CID = c.CID;
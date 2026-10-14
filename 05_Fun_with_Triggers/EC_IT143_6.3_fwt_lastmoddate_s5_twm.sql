/*
EC_IT143_6.3_fwt_lastmoddate_s5_twm.sql
Step 5: Test results to see if they are as expected.
*/
USE EC_IT143_DA;
GO
-- Check the "before" value
SELECT TOP (1)
    CustomerID,
    ContactName,
    LastModifiedDate
FROM dbo.t_w3_schools_customers
ORDER BY CustomerID;
GO
-- Perform an update
UPDATE dbo.t_w3_schools_customers
SET ContactName = ContactName
WHERE CustomerID = (SELECT MIN(CustomerID) FROM dbo.t_w3_schools_customers);
GO
-- Check the "after" value
SELECT TOP (1)
    CustomerID,
    ContactName,
    LastModifiedDate
FROM dbo.t_w3_schools_customers
ORDER BY CustomerID;
GO
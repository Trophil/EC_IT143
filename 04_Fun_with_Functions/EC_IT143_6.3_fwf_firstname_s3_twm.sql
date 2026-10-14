/*
EC_IT143_6.3_fwf_firstname_s3_twm.sql
Step 3: Create an ad hoc SQL query.
*/

USE EC_IT143_DA;
GO

SELECT
    ContactName,
    CASE
        WHEN CHARINDEX(' ', ContactName) > 0
            THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        ELSE ContactName
    END AS first_name
FROM dbo.t_w3_schools_customers
ORDER BY ContactName;
GO
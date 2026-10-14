/*
EC_IT143_6.3_fwf_firstname_s6_twm.sql
Step 6: Compare UDF results to ad hoc query results.
*/

USE EC_IT143_DA;
GO

SELECT
    ContactName,
    CASE
        WHEN CHARINDEX(' ', ContactName) > 0
            THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        ELSE ContactName
    END AS ad_hoc_first_name,
    dbo.udf_get_first_name(ContactName) AS udf_first_name
FROM dbo.t_w3_schools_customers
ORDER BY ContactName;
GO
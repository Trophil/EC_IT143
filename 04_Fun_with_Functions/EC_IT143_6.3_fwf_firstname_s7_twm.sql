/*
EC_IT143_6.3_fwf_firstname_s7_twm.sql
Step 7: Perform a "0 results expected" test.

If the UDF matches the ad hoc query, this query returns 0 rows.
Any row returned is a mismatch and signals a bug.
*/

USE EC_IT143_DA;
GO

WITH comparison AS (
    SELECT
        ContactName,
        CASE
            WHEN CHARINDEX(' ', ContactName) > 0
                THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
            ELSE ContactName
        END AS ad_hoc_first_name,
        dbo.udf_get_first_name(ContactName) AS udf_first_name
    FROM dbo.t_w3_schools_customers
)
SELECT *
FROM comparison
WHERE ad_hoc_first_name <> udf_first_name
   OR (ad_hoc_first_name IS NULL AND udf_first_name IS NOT NULL)
   OR (ad_hoc_first_name IS NOT NULL AND udf_first_name IS NULL);
GO
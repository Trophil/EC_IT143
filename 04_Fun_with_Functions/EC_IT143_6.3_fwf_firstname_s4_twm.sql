/*
EC_IT143_6.3_fwf_firstname_s4_twm.sql
Step 4: Research and test a solution.

Research reference:
https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql
https://learn.microsoft.com/en-us/sql/t-sql/functions/left-transact-sql

Edge case tested: what happens if ContactName has no space?
- CHARINDEX returns 0
- LEFT(ContactName, -1) returns an empty string
*/
USE EC_IT143_DA;
GO

SELECT
    contact_name,
    CASE
        WHEN CHARINDEX(' ', contact_name) > 0
            THEN LEFT(contact_name, CHARINDEX(' ', contact_name) - 1)
        ELSE contact_name
    END AS first_name_result
FROM
(
    SELECT 'John Smith' AS contact_name
    UNION ALL
    SELECT 'Madonna' 
    UNION ALL
    SELECT 'Mary Jane Watson'
) AS test_data;
GO
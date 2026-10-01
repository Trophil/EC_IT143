/*
EC_IT143_W4.2_institutions_s3_twm.sql
Step 3: Create an ad hoc SQL query.

Source table assumed: dbo.t_community2
*/
USE EC_IT143_DA;
GO

SELECT
    institution_state,
    COUNT(*) AS institution_count
FROM dbo.t_community2
WHERE institution_state IS NOT NULL
GROUP BY
    institution_state
ORDER BY
    institution_state;
GO

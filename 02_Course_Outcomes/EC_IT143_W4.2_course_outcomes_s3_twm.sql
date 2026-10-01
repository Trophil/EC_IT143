/*
EC_IT143_W4.2_course_outcomes_s3_twm.sql
Step 3: Create an ad hoc SQL query.

Source table assumed: dbo.t_community1
*/
USE EC_IT143_DA;
GO

SELECT
    TRY_CONVERT(INT, year) AS year,
    SUM(TRY_CONVERT(INT, graduates)) AS total_graduates
FROM dbo.t_community1
WHERE TRY_CONVERT(INT, year) IS NOT NULL
  AND TRY_CONVERT(INT, graduates) IS NOT NULL
GROUP BY
    TRY_CONVERT(INT, year)
ORDER BY
    year;
GO

/*
EC_IT143_W4.2_course_outcomes_s8_twm.sql
Step 8: Call the stored procedure.
*/
USE EC_IT143_DA;
GO

EXEC dbo.usp_course_outcomes_graduates_by_year_load;
GO

SELECT
    year,
    total_graduates
FROM dbo.t_course_outcomes_graduates_by_year
ORDER BY year;
GO

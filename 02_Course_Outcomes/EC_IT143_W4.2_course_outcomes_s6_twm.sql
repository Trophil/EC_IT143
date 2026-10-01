/*
EC_IT143_W4.2_course_outcomes_s6_twm.sql
Step 6: Load the table from the view using an ad hoc SQL script.
*/
USE EC_IT143_DA;
GO

TRUNCATE TABLE dbo.t_course_outcomes_graduates_by_year;
GO

INSERT INTO dbo.t_course_outcomes_graduates_by_year
(
    year,
    total_graduates
)
SELECT
    year,
    total_graduates
FROM dbo.v_course_outcomes_graduates_by_year;
GO

/*
EC_IT143_W4.2_course_outcomes_s5.1_twm.sql
Step 5.1: Turn the view into a table.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_course_outcomes_graduates_by_year;
GO

SELECT
    *
INTO dbo.t_course_outcomes_graduates_by_year
FROM dbo.v_course_outcomes_graduates_by_year;
GO

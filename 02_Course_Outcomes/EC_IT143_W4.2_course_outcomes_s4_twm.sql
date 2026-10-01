/*
EC_IT143_W4.2_course_outcomes_s4_twm.sql
Step 4: Turn the ad hoc SQL query into a view.
*/
USE EC_IT143_DA;
GO

DROP VIEW IF EXISTS dbo.v_course_outcomes_graduates_by_year;
GO

CREATE VIEW dbo.v_course_outcomes_graduates_by_year
AS
    SELECT
        TRY_CONVERT(INT, year) AS year,
        SUM(TRY_CONVERT(INT, graduates)) AS total_graduates
    FROM dbo.t_community1
    WHERE TRY_CONVERT(INT, year) IS NOT NULL
      AND TRY_CONVERT(INT, graduates) IS NOT NULL
    GROUP BY
        TRY_CONVERT(INT, year);
GO

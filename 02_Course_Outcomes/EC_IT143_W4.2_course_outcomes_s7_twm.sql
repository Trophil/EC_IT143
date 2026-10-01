/*
EC_IT143_W4.2_course_outcomes_s7_twm.sql
Step 7: Turn the ad hoc SQL script into a stored procedure.
*/
USE EC_IT143_DA;
GO

CREATE OR ALTER PROCEDURE dbo.usp_course_outcomes_graduates_by_year_load
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.t_course_outcomes_graduates_by_year;

    INSERT INTO dbo.t_course_outcomes_graduates_by_year
    (
        year,
        total_graduates
    )
    SELECT
        year,
        total_graduates
    FROM dbo.v_course_outcomes_graduates_by_year;
END;
GO

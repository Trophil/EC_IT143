/*
EC_IT143_W4.2_course_outcomes_s5.2_twm.sql
Step 5.2: Refine the table architecture.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_course_outcomes_graduates_by_year;
GO

CREATE TABLE dbo.t_course_outcomes_graduates_by_year
(
    year INT NOT NULL
        CONSTRAINT PK_t_course_outcomes_graduates_by_year PRIMARY KEY,
    total_graduates INT NOT NULL
);
GO

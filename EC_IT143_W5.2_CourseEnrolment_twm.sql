/*
====================================================================
EC_IT143_W5.2_CourseEnrolment_twm.sql
Author: Trophily Wamalwa Misiko
Date: October 3, 2026
Course: IT 143
Assignment: 5.2 Final Project - My Communities Analysis - Create Answers
Community: Course Enrolment
Database: EC_IT143_DA
Tables Used: t_w4_community1 (enrolment), t_w4_communit (course names)
====================================================================
Question 1 Author: Hernandez
Question 2 Author: David
Question 3 Author: Trophily Wamalwa Misiko
Question 4 Author: Trophily Wamalwa Misiko
====================================================================
*/

USE [EC_IT143_DA];
GO

-- ================================================================
-- Question 1
-- How many of the enrolled students are available for graduation
-- for the current/most recent year?
-- I need to see enrolment and graduates for the latest year in the
-- data so I can measure completion in that final year.
-- Author: Hernandez
-- NOTE: The most recent year in the data is 2024 (there is no
-- "current" year column, so we use the MAX(year) in the table).
-- ================================================================

SELECT MAX([year]) AS MostRecentYear
FROM [EC_IT143_DA].[dbo].[t_w4_community1];

SELECT
      [course].[course]               AS CourseName
    , [enrolment].[year]              AS Year
    , [enrolment].[enrolment]         AS EnrolledStudents
    , [enrolment].[graduates]         AS AvailableForGraduation
    , CAST([enrolment].[graduates] * 1.0
           / NULLIF([enrolment].[enrolment], 0)
           AS DECIMAL(5,4))           AS GraduationRate
FROM [EC_IT143_DA].[dbo].[t_w4_community1] AS [enrolment]
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
    ON [enrolment].[Course_Id] = [course].[Course_Id]
WHERE [enrolment].[year] = (
        SELECT MAX([year])
        FROM [EC_IT143_DA].[dbo].[t_w4_community1]
      )
  AND [enrolment].[sex] = 'MF'
ORDER BY [enrolment].[graduates] DESC;


-- ================================================================
-- Question 2
-- Which course has the highest number of graduates each year?
-- I need to see course name, year, and graduates so I can identify
-- which programs consistently produce the most graduates.
-- Author: David
-- ================================================================

WITH GraduatesByYear AS (
    SELECT
          [enrolment].[year]                       AS Year
        , [course].[course]                        AS CourseName
        , [enrolment].[graduates]                  AS Graduates
        , ROW_NUMBER() OVER (
              PARTITION BY [enrolment].[year]
              ORDER BY [enrolment].[graduates] DESC
          )                                        AS RankInYear
    FROM [EC_IT143_DA].[dbo].[t_w4_community1] AS [enrolment]
    INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
        ON [enrolment].[Course_Id] = [course].[Course_Id]
    WHERE [enrolment].[sex] = 'MF'
)
SELECT
      Year
    , CourseName                                  AS TopCourseByGraduates
    , Graduates                                   AS GraduatesForTopCourse
FROM GraduatesByYear
WHERE RankInYear = 1
ORDER BY Year ASC;


-- ================================================================
-- Question 3
-- How does female intake compare to total intake across courses
-- over time?
-- I need Course name, year, sex, and intake so we can measure gender
-- balance and target outreach.
-- Author: Trophily Wamalwa Misiko
-- ================================================================

SELECT
      [course].[course]                       AS CourseName
    , [female].[year]                         AS Year
    , [female].[intake]                       AS FemaleIntake
    , [total].[intake]                        AS TotalIntake
    , CAST([female].[intake] * 1.0
           / NULLIF([total].[intake], 0)
           AS DECIMAL(5,4))                   AS FemaleShareOfIntake
FROM [EC_IT143_DA].[dbo].[t_w4_community1] AS [female]
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_community1] AS [total]
    ON  [female].[Course_Id] = [total].[Course_Id]
    AND [female].[year]      = [total].[year]
    AND [female].[sex]       = 'F'
    AND [total].[sex]        = 'MF'
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
    ON [female].[Course_Id] = [course].[Course_Id]
ORDER BY [course].[course], [female].[year];


-- ================================================================
-- Question 4
-- Which courses have consistently had more intake than graduates,
-- and what is the gap per year?
-- I need Course name, year, intake, and graduates to identify
-- retention problems.
-- Author: Trophily Wamalwa Misiko
-- ================================================================

SELECT
      [course].[course]                                AS CourseName
    , [enrolment].[year]                               AS Year
    , [enrolment].[intake]                             AS Intake
    , [enrolment].[graduates]                          AS Graduates
    , ([enrolment].[intake] - [enrolment].[graduates]) AS IntakeMinusGraduates
FROM [EC_IT143_DA].[dbo].[t_w4_community1] AS [enrolment]
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
    ON [enrolment].[Course_Id] = [course].[Course_Id]
WHERE [enrolment].[sex] = 'MF'
  AND [enrolment].[intake] > [enrolment].[graduates]
ORDER BY IntakeMinusGraduates DESC, Year DESC;
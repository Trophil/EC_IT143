/*
====================================================================
EC_IT143_W5.2_Institutions_twm.sql
Author: Trophily Wamalwa Misiko
Date: October 3, 2026
Course: IT 143
Assignment: 5.2 Final Project - My Communities Analysis - Create Answers
Community: Institutions
Database: EC_IT143_DA
Tables Used: t_w4_community2 (institutions), t_w4_communit(course names)
====================================================================
Question 1 Author: Kevin
Question 2 Author: Amina
Question 3 Author: Trophily Wamalwa Misiko
Question 4 Author: Trophily Wamalwa Misiko
-- NOTE: Kevin's and Amina's questions were suggested via the
-- Collaboration Corner discussion board for my Institutions data set.
====================================================================
*/

USE [EC_IT143_DA];
GO

-- ================================================================
-- Question 1
-- Which states have the highest number of institutions offering
-- Information Technology (IT032)?
-- I need institution_state and a count of institution_Id so we can
-- map regional capacity for tech programs.
-- Author: Kevin
-- ================================================================

SELECT
      [institution].[institution_state]        AS State
    , COUNT([institution].[institution_Id])    AS InstitutionCount
FROM [EC_IT143_DA].[dbo].[t_w4_community2] AS [institution]
WHERE [institution].[Course_Id] = 'IT032'
GROUP BY [institution].[institution_state]
ORDER BY InstitutionCount DESC;


-- ================================================================
-- Question 2
-- How many institutions in each state offer each course, and which
-- states have the fewest offerings?
-- I need state, course name, and a count of institutions so we can
-- find access gaps across the country.
-- Author: Amina
-- ================================================================

SELECT
      [institution].[institution_state]        AS State
    , [course].[course]                        AS CourseName
    , COUNT([institution].[institution_Id])    AS InstitutionCount
FROM [EC_IT143_DA].[dbo].[t_w4_community2] AS [institution]
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
    ON [institution].[Course_Id] = [course].[Course_Id]
GROUP BY [institution].[institution_state], [course].[course]
ORDER BY InstitutionCount ASC, State ASC;


-- ================================================================
-- Question 3
-- Which courses are offered across the most states, and which are
-- concentrated in only a few?
-- I need course name and institution_state so we can assess
-- curriculum coverage nationally.
-- Author: Trophily Wamalwa Misiko
-- ================================================================

SELECT
      [course].[course]                                  AS CourseName
    , COUNT(DISTINCT [institution].[institution_state])  AS StatesOffering
    , COUNT([institution].[institution_Id])              AS TotalInstitutions
FROM [EC_IT143_DA].[dbo].[t_w4_community2] AS [institution]
INNER JOIN [EC_IT143_DA].[dbo].[t_w4_communit] AS [course]
    ON [institution].[Course_Id] = [course].[Course_Id]
GROUP BY [course].[course]
ORDER BY StatesOffering DESC, TotalInstitutions DESC;


-- ================================================================
-- Question 4
-- Which states have institutions but no offerings in high-demand
-- courses like Information Technology (IT032) or Natural &
-- Mathematical Sciences (NMS032)?
-- I need institution_state and Course_Id to identify underserved
-- regions for these critical programs.
-- Author: Trophily Wamalwa Misiko
-- ================================================================

SELECT DISTINCT
      [institution].[institution_state]     AS State
FROM [EC_IT143_DA].[dbo].[t_w4_community2] AS [institution]
WHERE NOT EXISTS (
        SELECT 1
        FROM [EC_IT143_DA].[dbo].[t_w4_community2] AS [check]
        WHERE [check].[institution_state] = [institution].[institution_state]
          AND [check].[Course_Id] IN ('IT032', 'NMS032')
      )
ORDER BY State ASC;
/*
============================================================
EC_IT143_6.3_performance_analysis_missing_indexes_twm.sql
Author:   Trophily Wamalwa Misiko
Course:   EC_IT143
Purpose:  Demonstrate how to surface missing index recommendations
          in SQL Server using Actual Execution Plans, then create
          the recommended indexes and measure the improvement in
          estimated subtree cost.

Database: AdventureWorks
Activity: "Execution plans and missing index recommendations:
           your turn" — two different queries on at least two
           different tables.

HOW TO USE:
1. Open in SSMS with the AdventureWorks database selected.
2. Enable "Include Actual Execution Plan" (Ctrl+M).
3. Run Query 1, inspect the plan, note the estimated subtree cost.
4. Right-click the missing index recommendation → Missing Index Details.
5. Create the index, re-run, compare the cost.
6. Repeat with Query 2.
============================================================
*/

USE AdventureWorks;
GO

/* ============================================================
   QUERY 1 — Person.Address (city filter, unindexed)
   ============================================================ */

-- STEP A: The poorly performing query.
-- City is a character field with no index. Filtering on it forces
-- a clustered index scan.
SELECT
    pa.AddressID,
    pa.City,
    pa.StateProvinceID,
    pa.PostalCode
FROM Person.Address AS pa
WHERE pa.City = 'Bothell';
GO

-- At this point, enable Actual Execution Plan (Ctrl+M) and run
-- the query above. In the Execution Plan tab:
--   • Look for the "Missing Index (Impact ...)" green text.
--   • Note the "Estimated Subtree Cost" on the SELECT operator.
--   • Right-click the missing index hint → "Missing Index Details".
--   • Copy the recommended CREATE INDEX statement below.
--   • Name the index following the ix_<table>_<column> convention.

-- STEP B: Create the recommended index.
IF EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'ix_Person_Address_City'
      AND object_id = OBJECT_ID('Person.Address')
)
    DROP INDEX ix_Person_Address_City ON Person.Address;
GO
CREATE NONCLUSTERED INDEX ix_Person_Address_City
    ON Person.Address (City)
    INCLUDE (AddressID, StateProvinceID, PostalCode);
GO

-- STEP C: Re-run the same query to compare execution plans.
-- Re-enable Actual Execution Plan, then run:
SELECT
    pa.AddressID,
    pa.City,
    pa.StateProvinceID,
    pa.PostalCode
FROM Person.Address AS pa
WHERE pa.City = 'Bothell';
GO
-- EXPECTED: The plan now shows an Index Seek (NonClustered)
-- instead of a Clustered Index Scan, and the estimated subtree
-- cost drops noticeably.


/* ============================================================
   QUERY 2 — Production.Product (name filter, unindexed)
   ============================================================ */

-- STEP A: The poorly performing query.
-- Filter on a character field (Name) that has no supporting index.
SELECT
    pp.ProductID,
    pp.Name,
    pp.ProductNumber,
    pp.ListPrice,
    pp.Color
FROM Production.Product AS pp
WHERE pp.Name LIKE 'Road%';
GO

-- With Actual Execution Plan on, look for the missing index
-- recommendation and note the estimated subtree cost.
-- Right-click → Missing Index Details to grab the recommendation.

-- STEP B: Create the recommended index.
IF EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'ix_Production_Product_Name'
      AND object_id = OBJECT_ID('Production.Product')
)
    DROP INDEX ix_Production_Product_Name ON Production.Product;
GO
CREATE NONCLUSTERED INDEX ix_Production_Product_Name
    ON Production.Product (Name)
    INCLUDE (ProductNumber, ListPrice, Color);
GO

-- STEP C: Re-run the same query and compare.
SELECT
    pp.ProductID,
    pp.Name,
    pp.ProductNumber,
    pp.ListPrice,
    pp.Color
FROM Production.Product AS pp
WHERE pp.Name LIKE 'Road%';
GO


/* ============================================================
   OPTIONAL — Inspect existing indexes on the two tables
   ============================================================ */
SELECT
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc,
    i.is_unique
FROM sys.indexes AS i
JOIN sys.tables AS t
    ON i.object_id = t.object_id
WHERE t.name IN ('Address', 'Product')
ORDER BY t.name, i.name;
GO

/* ============================================================
   CLEANUP (optional — uncomment to remove the demo indexes)
   ============================================================ */
-- DROP INDEX ix_Person_Address_City ON Person.Address;
-- DROP INDEX ix_Production_Product_Name ON Production.Product;
-- GO
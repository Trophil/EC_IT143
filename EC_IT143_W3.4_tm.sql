/**********************************************************************************************
    EC_IT143_W3.4_tm.sql
    Author:       Trophily Misiko
    Date:         27-09-2026
    Description:  Answers to eight AdventureWorks questions selected from the W3.3 discussion board.
    Database:     AdventureWorks2022
**********************************************************************************************/

USE AdventureWorks2022;
GO

/* ============================================================================================
   Q1  Business User question—Marginal complexity
   Author: Trophily Misiko
   Question: What are our top ten most expensive products in terms of list price?
   ============================================================================================ */
-- Answer:
SELECT TOP (10)
       ProductID,
       Name,
       ListPrice
FROM   Production.Product
WHERE  ListPrice > 0
ORDER BY ListPrice DESC;
GO


/* ============================================================================================
   Q2  Business User question—Marginal complexity
   Author: King Brandan Mthimunye
   Question: Which ten employees have the most accumulated vacation hours remaining on record?
   ============================================================================================ */
-- Answer:
SELECT TOP (10)
       BusinessEntityID,
       JobTitle,
       VacationHours,
       SickLeaveHours
FROM   HumanResources.Employee
ORDER BY VacationHours DESC;
GO


/* ============================================================================================
   Q3  Business User question—Moderate complexity
   Author: Junior Enama Benyomo
   Question: I want to understand our customer base by region. Which sales territory has
             generated the highest total sales amount from online orders in 2013?
   ============================================================================================ */
-- Answer:
SELECT TOP (1)
       st.Name                AS SalesTerritory,
       st.CountryRegionCode,
       SUM(soh.TotalDue)      AS TotalOnlineSales
FROM   Sales.SalesOrderHeader AS soh
       INNER JOIN Sales.SalesTerritory AS st
           ON soh.TerritoryID = st.TerritoryID
WHERE  soh.OnlineOrderFlag = 1
       AND YEAR(soh.OrderDate) = 2013
GROUP BY st.Name, st.CountryRegionCode
ORDER BY TotalOnlineSales DESC;
GO


/* ============================================================================================
   Q4  Business User question—Moderate complexity
   Author: King Brandan Mthimunye
   Question: Our HR department is auditing regional operations. Can you list all active
             employees currently assigned to the North American sales territory along with
             their job titles?
   ============================================================================================ */
-- Answer:
SELECT e.BusinessEntityID,
       e.JobTitle,
       e.HireDate,
       st.Name AS SalesTerritory,
       st.CountryRegionCode
FROM   HumanResources.Employee AS e
       INNER JOIN Sales.SalesPerson AS sp
           ON e.BusinessEntityID = sp.BusinessEntityID
       INNER JOIN Sales.SalesTerritory AS st
           ON sp.TerritoryID = st.TerritoryID
WHERE  e.CurrentFlag = 1
       AND st.CountryRegionCode IN ('US', 'CA')   -- North America
ORDER BY st.Name, e.JobTitle;
GO


/* ============================================================================================
   Q5  Business User question—Increased complexity
   Author: Junior Enama Benyomo
   Question: Our regional manager for the European market wants to review order patterns
             before the next budgeting cycle. Specifically, she would like to see, for each
             quarter of 2013, the total number of orders and total sales revenue generated
             by customers located in France and Germany.
   ============================================================================================ */
-- Answer:
SELECT DATEPART(QUARTER, soh.OrderDate) AS OrderQuarter,
       COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
       SUM(soh.TotalDue)                AS TotalSalesRevenue
FROM   Sales.SalesOrderHeader AS soh
       INNER JOIN Sales.SalesTerritory AS st
           ON soh.TerritoryID = st.TerritoryID
WHERE  YEAR(soh.OrderDate) = 2013
       AND st.CountryRegionCode IN ('FR', 'DE')
GROUP BY DATEPART(QUARTER, soh.OrderDate)
ORDER BY OrderQuarter;
GO


/* ============================================================================================
   Q6  Business User question—Increased complexity
   Author: King Brandan Mthimunye
   Question: The supply chain team is evaluating vendor reliability and inventory turnover
             for bike components. We need to identify suppliers who experienced shipment
             delays during fiscal year 2012. Could you generate a breakdown showing vendor
             names, total order quantities, average lead time in days, and total purchase
             amounts for all delayed component orders?
   ============================================================================================ */
-- Answer:
WITH DelayedComponentOrders AS
(
    SELECT pod.PurchaseOrderID,
           pod.ProductID,
           pod.OrderQty,
           pod.LineTotal,
           poh.VendorID,
           poh.OrderDate,
           poh.ShipDate,
           DATEDIFF(DAY, poh.OrderDate, poh.ShipDate) AS LeadTimeDays
    FROM   Purchasing.PurchaseOrderDetail AS pod
           INNER JOIN Purchasing.PurchaseOrderHeader AS poh
               ON pod.PurchaseOrderID = poh.PurchaseOrderID
           INNER JOIN Production.Product AS p
               ON pod.ProductID = p.ProductID
           INNER JOIN Production.ProductSubcategory AS ps
               ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    WHERE  YEAR(poh.OrderDate) = 2012
           AND ps.Name = 'Bike Racks'          -- adjust to your preferred component subcategory
           AND poh.ShipDate > poh.DueDate       -- delayed shipment
)
SELECT v.Name                              AS VendorName,
       SUM(dco.OrderQty)                   AS TotalOrderQty,
       AVG(dco.LeadTimeDays)               AS AvgLeadTimeDays,
       SUM(dco.LineTotal)                  AS TotalPurchaseAmount
FROM   DelayedComponentOrders AS dco
       INNER JOIN Purchasing.Vendor AS v
           ON dco.VendorID = v.BusinessEntityID
GROUP BY v.Name
ORDER BY TotalPurchaseAmount DESC;
GO


/* ============================================================================================
   Q7  Metadata question
   Author: Trophily Misiko
   Question: Using the System Information Schema Views, can you list all columns in the
             Production.Product table along with their data types and whether they allow
             null values?
   ============================================================================================ */
-- Answer:
SELECT TABLE_SCHEMA,
       TABLE_NAME,
       COLUMN_NAME,
       DATA_TYPE,
       CHARACTER_MAXIMUM_LENGTH,
       IS_NULLABLE
FROM   INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_SCHEMA = 'Production'
       AND TABLE_NAME = 'Product'
ORDER BY ORDINAL_POSITION;
GO


/* ============================================================================================
   Q8  Metadata question
   Author: King Brandan Mthimunye
   Question: Which system views in the INFORMATION_SCHEMA schema can I query to display
             all columns and their data types for the Sales.SalesOrderHeader table?
   ============================================================================================ */
-- Answer:
SELECT TABLE_SCHEMA,
       TABLE_NAME,
       COLUMN_NAME,
       DATA_TYPE,
       IS_NULLABLE
FROM   INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_SCHEMA = 'Sales'
       AND TABLE_NAME = 'SalesOrderHeader'
ORDER BY ORDINAL_POSITION;
GO

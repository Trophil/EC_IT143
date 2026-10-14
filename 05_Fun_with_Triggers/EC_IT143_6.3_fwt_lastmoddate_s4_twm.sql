/*
EC_IT143_6.3_fwt_lastmoddate_s4_twm.sql
Step 4: Create an after-update trigger.

Trigger name: dbo.trg_customers_set_last_modified_date
Purpose: Set LastModifiedDate = GETDATE() on every row updated.
*/
USE EC_IT143_DA;
GO
DROP TRIGGER IF EXISTS dbo.trg_customers_set_last_modified_date;
GO
CREATE TRIGGER dbo.trg_customers_set_last_modified_date
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.LastModifiedDate = GETDATE()
    FROM dbo.t_w3_schools_customers c
    INNER JOIN inserted i
        ON c.CustomerID = i.CustomerID;
END;
GO
/*
EC_IT143_6.3_fwt_setup_add_columns_twm.sql
Setup: Add LastModifiedDate and LastModifiedBy columns to the table.
These will be populated by triggers, not by default constraints,
because default constraints only fire on INSERT, not UPDATE.
*/
USE EC_IT143_DA;
GO
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.t_w3_schools_customers')
      AND name = 'LastModifiedDate'
)
    ALTER TABLE dbo.t_w3_schools_customers
        ADD LastModifiedDate DATETIME NULL;
GO
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.t_w3_schools_customers')
      AND name = 'LastModifiedBy'
)
    ALTER TABLE dbo.t_w3_schools_customers
        ADD LastModifiedBy NVARCHAR(128) NULL;
GO
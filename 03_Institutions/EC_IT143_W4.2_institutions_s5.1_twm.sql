/*
EC_IT143_W4.2_institutions_s5.1_twm.sql
Step 5.1: Turn the view into a table.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_institutions_by_state;
GO

SELECT
    *
INTO dbo.t_institutions_by_state
FROM dbo.v_institutions_by_state;
GO

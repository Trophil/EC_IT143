/*
EC_IT143_W4.2_institutions_s6_twm.sql
Step 6: Load the table from the view using an ad hoc SQL script.
*/
USE EC_IT143_DA;
GO

TRUNCATE TABLE dbo.t_institutions_by_state;
GO

INSERT INTO dbo.t_institutions_by_state
(
    institution_state,
    institution_count
)
SELECT
    institution_state,
    institution_count
FROM dbo.v_institutions_by_state;
GO

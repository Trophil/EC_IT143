/*
EC_IT143_W4.2_institutions_s8_twm.sql
Step 8: Call the stored procedure.
*/
USE EC_IT143_DA;
GO

EXEC dbo.usp_institutions_by_state_load;
GO

SELECT
    institution_state,
    institution_count
FROM dbo.t_institutions_by_state
ORDER BY institution_state;
GO

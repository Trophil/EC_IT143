/*
EC_IT143_W4.2_hello_world_s8_twm.sql
Step 8: Call the stored procedure.
*/
USE EC_IT143_DA;
GO

EXEC dbo.usp_hello_world_load;
GO

SELECT *
FROM dbo.t_hello_world;
GO

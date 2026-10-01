/*
EC_IT143_W4.2_hello_world_s5.1_twm.sql
Step 5.1: Turn the view into a table.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_hello_world;
GO

SELECT
    *
INTO dbo.t_hello_world
FROM dbo.v_hello_world;
GO

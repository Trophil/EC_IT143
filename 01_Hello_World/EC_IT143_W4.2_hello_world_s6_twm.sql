/*
EC_IT143_W4.2_hello_world_s6_twm.sql
Step 6: Load the table from the view using an ad hoc SQL script.
*/
USE EC_IT143_DA;
GO

TRUNCATE TABLE dbo.t_hello_world;
GO

INSERT INTO dbo.t_hello_world
(
    message_id,
    message
)
SELECT
    1,
    message
FROM dbo.v_hello_world;
GO

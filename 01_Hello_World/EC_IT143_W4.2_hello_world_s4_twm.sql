/*
EC_IT143_W4.2_hello_world_s4_twm.sql
Step 4: Turn the ad hoc SQL query into a view.
*/
USE EC_IT143_DA;
GO

DROP VIEW IF EXISTS dbo.v_hello_world;
GO

CREATE VIEW dbo.v_hello_world
AS
    SELECT
        'Hello World' AS message;
GO

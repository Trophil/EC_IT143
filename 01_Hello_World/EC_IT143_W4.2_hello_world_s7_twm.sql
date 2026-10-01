/*
EC_IT143_W4.2_hello_world_s7_twm.sql
Step 7: Turn the ad hoc SQL script into a stored procedure.
*/
USE EC_IT143_DA;
GO

CREATE OR ALTER PROCEDURE dbo.usp_hello_world_load
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.t_hello_world;

    INSERT INTO dbo.t_hello_world
    (
        message_id,
        message
    )
    SELECT
        1,
        message
    FROM dbo.v_hello_world;
END;
GO

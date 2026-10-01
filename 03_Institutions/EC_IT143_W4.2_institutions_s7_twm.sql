/*
EC_IT143_W4.2_institutions_s7_twm.sql
Step 7: Turn the ad hoc SQL script into a stored procedure.
*/
USE EC_IT143_DA;
GO

CREATE OR ALTER PROCEDURE dbo.usp_institutions_by_state_load
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.t_institutions_by_state;

    INSERT INTO dbo.t_institutions_by_state
    (
        institution_state,
        institution_count
    )
    SELECT
        institution_state,
        institution_count
    FROM dbo.v_institutions_by_state;
END;
GO

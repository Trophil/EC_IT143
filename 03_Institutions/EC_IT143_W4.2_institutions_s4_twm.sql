/*
EC_IT143_W4.2_institutions_s4_twm.sql
Step 4: Turn the ad hoc SQL query into a view.
*/
USE EC_IT143_DA;
GO

DROP VIEW IF EXISTS dbo.v_institutions_by_state;
GO

CREATE VIEW dbo.v_institutions_by_state
AS
    SELECT
        institution_state,
        COUNT(*) AS institution_count
    FROM dbo.t_w4_community2
    WHERE institution_state IS NOT NULL
    GROUP BY
        institution_state;
GO

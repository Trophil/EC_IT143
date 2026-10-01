/*
EC_IT143_W4.2_institutions_s5.2_twm.sql
Step 5.2: Refine the table architecture.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_institutions_by_state;
GO

CREATE TABLE dbo.t_institutions_by_state
(
    institution_state CHAR(2) NOT NULL
        CONSTRAINT PK_t_institutions_by_state PRIMARY KEY,
    institution_count INT NOT NULL
);
GO

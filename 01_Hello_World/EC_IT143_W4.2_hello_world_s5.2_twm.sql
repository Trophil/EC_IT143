/*
EC_IT143_W4.2_hello_world_s5.2_twm.sql
Step 5.2: Refine the table architecture.
*/
USE EC_IT143_DA;
GO

DROP TABLE IF EXISTS dbo.t_hello_world;
GO

CREATE TABLE dbo.t_hello_world
(
    message_id INT NOT NULL
        CONSTRAINT PK_t_hello_world PRIMARY KEY,
    message NVARCHAR(50) NOT NULL
);
GO

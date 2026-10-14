/*
EC_IT143_6.3_fwt_lastmoddate_s3_twm.sql
Step 3: Research and test a solution.

Research reference:
https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
https://learn.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql

Approach: use the inserted pseudo-table inside an AFTER UPDATE trigger
to know which rows changed, then update the base table using a join.
*/
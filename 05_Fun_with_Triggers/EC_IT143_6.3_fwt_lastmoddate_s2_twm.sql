/*
EC_IT143_6.3_fwt_lastmoddate_s2_twm.sql
Step 2: Begin creating an answer.

Where I am: I know a default constraint will only set a value on INSERT,
not on UPDATE. So a default constraint will not solve this problem.

Next logical step: Create an AFTER UPDATE trigger that sets LastModifiedDate
to GETDATE() for every row that was changed.
*/
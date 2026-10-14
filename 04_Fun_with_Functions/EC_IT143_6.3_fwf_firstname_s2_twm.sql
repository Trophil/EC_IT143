/*
EC_IT143_6.3_fwf_firstname_s2_twm.sql
Step 2: Begin creating an answer.

Where I am: I know ContactName contains a first and last name separated by a space.

Next logical step: Find the position of the first space with CHARINDEX,
then take everything to the left of that position with LEFT().

Planned approach:
1. Locate the position of the first space using CHARINDEX(' ', ContactName).
2. Use LEFT(ContactName, position - 1) to return everything before the space.
*/
/*
EC_IT143_6.3_fwf_firstname_s5_twm.sql
Step 5: Create a user-defined scalar function.

Function name: dbo.udf_get_first_name
Purpose: Return the first name from a full contact name.
Input: @full_name NVARCHAR(100)
Output: NVARCHAR(100)
*/
USE EC_IT143_DA;
GO
DROP FUNCTION IF EXISTS dbo.udf_get_first_name;
GO
CREATE FUNCTION dbo.udf_get_first_name
(
    @full_name NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @first_name NVARCHAR(100);

    -- If there is a space, take everything before it.
    -- Otherwise, return the whole string.
    IF CHARINDEX(' ', @full_name) > 0
        SET @first_name = LEFT(@full_name, CHARINDEX(' ', @full_name) - 1);
    ELSE
        SET @first_name = @full_name;

    RETURN @first_name;
END;
GO
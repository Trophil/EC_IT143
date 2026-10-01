EC_IT143_W4.2 — T-SQL Data Manipulation — Answer-Focused Approach

Prepared for the three required script sets:
1. Hello World
2. Course Outcomes (Community 1)
3. Institutions (Community 2)

INITIALS USED
TWM

IMPORTANT
The Community 1 CSV contains an extra header row stored as a data row.
The Community 1 Step 3/4 queries use TRY_CONVERT so that row is excluded.

SOURCE TABLE NAMES ASSUMED
Community 1: dbo.t_community1
Community 2: dbo.t_community2


QUESTIONS
Community 1: How many students graduated each year?
Community 2: How many institutions are in each state?

EXECUTION ORDER
For each folder, execute:
s1, s2, s3, s4, s5.1, s5.2, s6, s7, s8.

Step 5.1 demonstrates SELECT INTO.
Step 5.2 refines/recreates the destination table with a primary key and
appropriate data types.
Step 6 loads the table from the view.
Step 7 encapsulates Step 6 in a stored procedure.
Step 8 executes the stored procedure and displays the final result.

GITHUB
The assignment asks for the three script sets to be uploaded to your
repository with the commit message:
Adding deliverable W4.2


-- SQL Interview Practice
-- Topic: Keys, Joins, and Data Integrity
-- Database platform: SQL Server

-- 1. Create sample tables with primary and foreign keys

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE NOT NULL,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 2. Insert sample data

INSERT INTO Students VALUES
(1, 'Mary'),
(2, 'John'),
(3, 'Grace');

INSERT INTO Courses VALUES
(101, 'Database Systems'),
(102, 'Data Engineering'),
(103, 'Cloud Computing');

INSERT INTO Enrollments VALUES
(1, 101, '2026-01-10'),
(1, 102, '2026-01-12'),
(2, 101, '2026-01-15');

-- 3. INNER JOIN: Show only matching records

SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID;

-- 4. LEFT JOIN: Show all students, even without enrollment

SELECT s.StudentName, e.CourseID
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID;

-- 5. RIGHT JOIN: Show all courses, even without enrollment

SELECT c.CourseName, e.StudentID
FROM Enrollments e
RIGHT JOIN Courses c
    ON e.CourseID = c.CourseID;

-- 6. FULL OUTER JOIN: Show matching and unmatched records

SELECT s.StudentName, e.CourseID
FROM Students s
FULL OUTER JOIN Enrollments e
    ON s.StudentID = e.StudentID;

-- 7. CROSS JOIN: Generate every student-course combination

SELECT s.StudentName, c.CourseName
FROM Students s
CROSS JOIN Courses c;

-- 8. SELF JOIN: Demonstrate employees and their managers

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    ManagerID INT NULL,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees VALUES
(1, 'Alice', NULL),
(2, 'Peter', 1),
(3, 'Susan', 1);

SELECT e.EmployeeName AS Employee,
       m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmployeeID;

-- 9. Data integrity check: Find students without enrollment

SELECT s.StudentID, s.StudentName
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

--Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
CREATE PROCEDURE SP_INSERT_STUDENT
    @StudentID INT,
    @StuName VARCHAR(100),
    @StuEmail VARCHAR(100),
    @StuPhone VARCHAR(15),
    @StuDepartment VARCHAR(50),
    @StuDOB DATE,
    @StuEnrollmentYear INT
AS
BEGIN
    INSERT INTO STUDENT(StudentID, StuName, StuEmail, StuPhone, StuDepartment, StuDateOfBirth, StuEnrollmentYear)
    VALUES (@StudentID, @StuName, @StuEmail, @StuPhone, @StuDepartment, @StuDOB, @StuEnrollmentYear)
END;


EXEC SP_INSERT_STUDENT 10, 'Harsh Parmar', 'harsh@univ.edu', '9876543218', 'CSE', '2005-09-18', 2023;

EXEC SP_INSERT_STUDENT 20, 'Om Patel', 'om@univ.edu', '9876543211', 'IT', '2002-08-22', 2022;

-- 2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)

go
CREATE PROCEDURE PR_INSERT_COURSE
    @CourseID VARCHAR(10),
    @CourseName VARCHAR(100),
    @CourseCredits INT,
    @CourseDept VARCHAR(50),
    @CourseSemester INT
AS
BEGIN
    INSERT INTO COURSE (CourseID, CourseName, CourseCredits, CourseDepartment, CourseSemester)
    VALUES (@CourseID, @CourseName, @CourseCredits, @CourseDept, @CourseSemester)
END;

go 
EXEC pr_INSERT_COURSE 'CS330', 'Computer Networks', 4, 'CSE', 5;
EXEC pr_INSERT_COURSE 'EC120', 'Electronic Circuits', 3, 'ECE', 2;


--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)

go
CREATE PROCEDURE PR_UPDATE_STUDENT
    @StudentID INT,
    @NewEmail VARCHAR(100),
    @NewPhone VARCHAR(15)
AS
BEGIN
    UPDATE STUDENT
    SET StuEmail = @NewEmail,
        StuPhone = @NewPhone
    WHERE StudentID = @StudentID
END

select * from STUDENT

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
go
CREATE PROCEDURE PR_DELETE_STUDENT
AS
BEGIN
    DELETE FROM STUDENT
    WHERE StuName = 'Om Patel'
END

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.

go
CREATE or alter PROCEDURE PR_SELECT_STUDENT_BY_ID
    @StudentID INT
AS
BEGIN
    SELECT *
    FROM STUDENT
    WHERE StudentID = @StudentID;
END;

--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
go
CREATE or alter PROCEDURE PR_FIRST_5_STUDENTS
AS
BEGIN
    SELECT TOP 5 *
    FROM STUDENT
    ORDER BY StuEnrollmentYear;
END;


--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.

go
CREATE OR ALTER  PROCEDURE PR_FACULTY_DESIGNATION
AS 
BEGIN
     SELECT COUNT(FacultyID) AS FACULTY_COUNT,FacultyDesignation
     FROM FACULTY
     GROUP BY FacultyDesignation;
END

--8.	Create a stored procedure that takes department name as input and returns all students in that department.

go
CREATE OR ALTER PROCEDURE PR_DEPARTMENT
 @DEPTNAME VARCHAR(20)
AS 
BEGIN
        
        SELECT  StuName
        FROM STUDENT 
        WHERE  StuDepartment = @DEPTNAME
       
END

--Part – C 
--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.

go
CREATE or alter PROCEDURE SP_COURSE_CREDITS_STATS
AS
BEGIN
    SELECT 
        CourseDepartment,
        MAX(CourseCredits) AS MaxCredits,
        MIN(CourseCredits) AS MinCredits,
        AVG(CourseCredits) AS AvgCredits
    FROM COURSE
    GROUP BY CourseDepartment;
END;


--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.

go
CREATE or alter PROCEDURE SP_STUDENT_COURSES_WITH_GRADES
    @StudentID INT
AS
BEGIN
    SELECT 
        S.StuName,
        C.CourseName,
        E.Grade,
        E.EnrollmentStatus
    FROM ENROLLMENT E
    JOIN COURSE C ON E.CourseID = C.CourseID
    JOIN STUDENT S ON S.StudentID = E.StudentID
    WHERE E.StudentID = @StudentID;
END;
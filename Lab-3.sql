--Part – A 
--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
go
CREATE OR ALTER PROCEDURE PR_FACULTY
@DATE DATE
AS 
BEGIN
	 SELECT FacultyName 
	 FROM FACULTY
	 WHERE FacultyJoiningDate = @DATE

END

EXEC PR_FACULTY "2010-07-15"

--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID OR
--COURSEID returns EnrollmentID, EnrollmentDate, Grade, and Status.
go
create or alter procedure pr_show_details
@stuid int = null,
@courseid varchar(10) = null
as
begin
 	SELECT EnrollmentID,EnrollmentDate,Grade,EnrollmentStatus
	from enrollment
 	where studentID = @stuid or courseid = @courseid
END

exec pr_show_details "2"

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
go
create or alter procedure pr_credits
@min int,
@max int
as 
begin
select *
from course
where CourseCredits between @min and @max
END

exec pr_credits 2,3

-- 4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
go
create or alter procedure pr_enrolledstudent
@coursename varchar(100)
as
begin
select e.StudentID,e.CourseID,CourseName,StuDepartment,EnrollmentDate
from student s join enrollment e
on s.studentID = e.studentID
join course c 
on c.courseid = e.courseid
where CourseName = @coursename
end

exec pr_enrolledstudent "Data Structures"

--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
go
create or alter PROCEDURE PR_FAC
@FACNAME VARCHAR(100)
AS
BEGIN
SELECT CourseID,C.FacultyID,C.Semester,C.Year,C.ClassRoom
FROM COURSE_ASSIGNMENT C JOIN FACULTY F
ON C.FacultyID = F.FacultyID
WHERE FacultyName = @FACNAME
END

EXEC PR_FAC "Dr. Sheth"

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
go
CREATE OR ALTER PROCEDURE PR_COURSEDETAILS
@SEMNUM INT,
@YEAR INT
AS
BEGIN
SELECT CA.FacultyID,F.FacultyName,C.CourseName,CA.Semester,CA.YEAR
FROM COURSE C JOIN COURSE_ASSIGNMENT CA
ON C.COURSEID = CA.COURSEID
JOIN FACULTY F
ON F.FacultyID = CA.FacultyID
WHERE Semester = @SEMNUM AND YEAR = @YEAR
END

EXEC PR_COURSEDETAILS 1,2024

--Part – B 
--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
GO
CREATE OR ALTER PROCEDURE PR_FIRSTLETTER
@LETTER VARCHAR(1)
AS
BEGIN
SELECT *
FROM ENROLLMENT
WHERE EnrollmentStatus LIKE @LETTER+'%'
END

EXEC PR_FIRSTLETTER "A"

--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
go
CREATE OR ALTER PROCEDURE PR_SDNAME
@NAME VARCHAR(50)
AS
BEGIN
	SELECT * FROM STUDENT
	WHERE StuName = @NAME OR StuDepartment = @NAME
END

EXEC PR_SDNAME "Raj Patel"
GO
--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.

CREATE OR ALTER PROCEDURE PR_ENSTATUS
@CID VARCHAR(20)
AS
BEGIN
	 SELECT COUNT(EnrollmentStatus)  FROM ENROLLMENT
	 WHERE CourseID = @CID
	 GROUP BY EnrollmentStatus
END

EXEC PR_ENSTATUS "CS201"


--Part – C   
--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
GO
CREATE PROCEDURE PR_COURSES_ASSIGNED_BY_YEAR
(
    @Year INT
)
AS
BEGIN
    SELECT C.CourseID,
           C.CourseName,
           F.FacultyName,
           CA.ClassRoom
    FROM COURSE_ASSIGNMENT CA
    JOIN COURSE C ON CA.CourseID = C.CourseID
    JOIN FACULTY F ON CA.FacultyID = F.FacultyID
    WHERE CA.Year = @Year;
END;


EXEC PR_COURSES_ASSIGNED_BY_YEAR 2024;

	

--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.

GO
CREATE OR ALTER PROCEDURE PR_ENROLLMENTS_BETWEEN_DATES
(
    @FromDate DATE,
    @ToDate DATE
)
AS
BEGIN
    SELECT S.StudentID,
           S.StuName,
           C.CourseName,
           E.EnrollmentDate,
           E.Grade,
           E.EnrollmentStatus
    FROM ENROLLMENT E
    JOIN STUDENT S ON E.StudentID = S.StudentID
    JOIN COURSE C ON E.CourseID = C.CourseID
    WHERE E.EnrollmentDate BETWEEN @FromDate AND @ToDate;
END;
GO

EXEC PR_ENROLLMENTS_BETWEEN_DATES '2021-07-01','2022-01-05';


--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).

GO
CREATE OR ALTER PROCEDURE PR_FACULTY_CALCULATES
(
	@FACULTYID INT
)
AS
BEGIN
	 SELECT F.FacultyID,
           F.FacultyName,
           SUM(C.CourseCredits) AS TotalTeachingLoad
    FROM FACULTY F
    JOIN COURSE_ASSIGNMENT CA ON F.FacultyID = CA.FacultyID
    JOIN COURSE C ON CA.CourseID = C.CourseID
    WHERE F.FacultyID = @FacultyID
    GROUP BY F.FacultyID, F.FacultyName;
END

EXEC PR_FACULTY_CALCULATES 101;
--Part � A 

--1.	Retrieve all unique departments from the STUDENT table.
SELECT DISTINCT StuDepartment from student

--2.	Insert a new student record into the STUDENT table.
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
Insert into student values(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
update student
set stuemail = 'raj.p@univ.edu'
where stuname = 'Raj Patel'

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
alter table student
add CGPA DECIMAL(3,2)

select * from student

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
Select CourseName
from COURSE
where CourseName like 'data%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
select stuname
from student
where stuname like '%Shah%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
Select UPPER(Facultyname)
from Faculty

--8.	Find all faculty who joined after 2015. (FACULTY table)
Select *
from Faculty
where Year(FacultyJoiningDate) > '2015'

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
Select sqrt(CourseCredits)
from course
Where CourseName = 'Database Management Systems'

--10.	Find the Current Date using SQL Server in-built function.
select getdate() as CurrentDate

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
Select top 3 *
from student
ORDER BY stuEnrollmentYear

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
SELECT *
from student
where stuEnrollmentYear = 2022

--13.	Find the number of courses offered by each department. (COURSE table)
Select CourseDepartment,count(CourseName)
from Course
GROUP BY CourseDepartment

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
Select CourseID,count(enrollmentdate)
from enrollment
GROUP BY CourseID
having count(enrollmentdate)>2

--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
Select s.stuname, e.enrollmentStatus
From student s join enrollment e
on s.studentID = e.studentID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
Select s.stuname, c.CourseName
From student s join enrollment e
on s.studentID = e.studentID
join Course c
on  c.CourseID = e.CourseID

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT)
go
Create View ActiveEnrollments
AS
Select s.stuname, c.CourseName
From student s join enrollment e
on s.studentID = e.studentID
join Course c
on  c.CourseID = e.CourseID

select * from ActiveEnrollments

--18.	Retrieve the students name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
Select stuname
from  student
where studentID not in(Select studentID
                        From enrollment)

--19.	Display course name having second highest credit. (COURSE table)
Select CourseName , CourseCredits
from Course
where CourseCredits in(Select top 1 CourseCredits
                        From Course
                        ORDER BY CourseCredits)

--Part – B 
--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)

SELECT C.CourseID,CourseName,COUNT(StudentID)
FROM COURSE C
JOIN ENROLLMENT
ON C.CourseID=ENROLLMENT.CourseID
GROUP BY C.CourseID,CourseName

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)

SELECT 
    EnrollmentStatus,
    COUNT(*) AS TotalEnrollments
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(*) > 2

--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)

SELECT COURSENAME,CourseCredits
FROM COURSE_ASSIGNMENT
JOIN COURSE
ON COURSE.COURSEID=COURSE_ASSIGNMENT.CourseID
JOIN FACULTY
ON COURSE_ASSIGNMENT.FACULTYID=FACULTY.FACULTYID
WHERE FacultyName='Dr. Sheth'
ORDER BY CourseCredits

--Part – C 
--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)
--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)

SELECT STUName
FROM STUDENT
WHERE StudentID IN (
    SELECT StudentID 
    FROM ENROLLMENT 
    WHERE CourseID = 'CS101'
)
AND StudentID IN (
    SELECT StudentID 
    FROM ENROLLMENT 
    WHERE CourseID = 'CS201'
)

--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)
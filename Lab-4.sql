-- Part-A 
-- 1. Write a scalar function to print "Welcome to DBMS Lab". 

create or alter function fn_welcome()
returns varchar(20)
as
begin
 return 'Welcome To Dbms'
end

select dbo.fn_welcome()

-- 2. Write a scalar function to calculate simple interest.  

create or alter function fn_intrest(@p int,@n int,@r int)
returns Float
as
begin
return (@p * @n * @r)/100
end

select dbo.fn_intrest(1000,1,5)

-- 3. Function to Get Difference in Days Between Two Given Dates 

create or alter function fn_diffdays(@d1 date,@d2 date)
returns int
as
begin
 declare @diff int

 set @diff = DATEDIFF(day, @d1, @d2)
return @diff
end

select dbo.fn_diffdays('2025-01-01','2025-02-01')

-- 4. Write a scalar function which returns the sum of Credits for two given CourseIDs. 

CREATE OR ALTER Function FN_SUMCREDIT(@C1 VARCHAR(10),@C2 VARCHAR(10))
returns INT
AS 
    BEGIN 
    declare @SUM INT
    SELECT @SUM = SUM(CourseCredits)
    FROM COURSE
    WHERE COURSEID IN (@C1,@C2)

return @SUM
END

SELECT DBO.FN_SUMCREDIT('CS301','EC101')

-- 5. Write a function to check whether the given number is ODD or EVEN. 

CREATE OR ALTER FUNCTION FN_ODDEVEN(@N INT)
returns VARCHAR(10)
AS
BEGIN
    declare @MSG VARCHAR(10)
    IF @N%2 = 0
        SET @MSG = 'EVEN'
    ELSE
        SET @MSG = 'ODD'
    return @MSG
END

SELECT DBO.FN_ODDEVEN(443)

-- 6. Write a function to print number from 1 to N. (Using while loop) 

CREATE OR ALTER FUNCTION FN_PRINT(@N INT)
returns VARCHAR(30)
AS
BEGIN
    declare @ANS VARCHAR(30)
    declare @I INT
    SET @I = 1
    SET @ANS = ''

    WHILE (@I<=@N)
        BEGIN
        SET @ANS = @ANS + CAST(@I AS VARCHAR) + ' '
        SET @I = @I + 1
        END
    return @ANS
END

SELECT DBO.FN_PRINT(10)

-- 7. Write a scalar function to calculate factorial of total credits for a given CourseID. 

CREATE OR ALTER FUNCTION FN_FACOFCOURSE(@COURSEID VARCHAR(10))
returns INT
AS
BEGIN 
    declare @CourseCredits INT
    SELECT @CourseCredits = CourseCredits
    FROM COURSE
    WHERE COURSEID = @COURSEID

    declare @FAC INT
    declare @I INT
    SET @I = 1
    SET @FAC = 1
    
        WHILE (@CourseCredits>=@I)
        BEGIN
        SET @FAC = @FAC * @I
        SET @I = @I + 1
        END
    return @FAC
END

SELECT DBO.FN_FACOFCOURSE('CS101')

-- 8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case 
-- statement)

CREATE OR ALTER FUNCTION FN_ENROLLYEAR(@YEAR INT)
returns VARCHAR(10)
AS
BEGIN
    declare @ANS VARCHAR(10)

    SET @ANS = Case
    WHEN @YEAR < YEAR(GETDATE()) THEN 'PAST'
    WHEN @YEAR = YEAR(GETDATE()) THEN 'PRESENT'
    ELSE 'FUTURE'
    END
return @ANS
END

SELECT DBO.FN_ENROLLYEAR(2025)

-- 9. Write a table-valued function that returns details of students whose names start with a given letter. 

CREATE OR ALTER FUNCTION FN_NAMESTARTS(@L CHAR)

-- 10. Write a table-valued function that returns unique department names from the STUDENT table. 

-- Part-B 

-- 11. Write a scalar function that calculates age in years given a DateOfBirth. 
-- 12. Write a scalar function to check whether given number is palindrome or not. 
-- 13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department. 
-- 14. Write a table-valued function that returns all courses taught by faculty with a specific designation. 

-- Part - C 

-- 15. Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits 
-- from all active enrollments).
-- 16. Write a scalar function that accepts two dates (joining date range) and returns the count of faculty who 
-- joined in that period. 
CREATE TABLE Location ( Location_ID INT PRIMARY KEY , City NVARCHAR(50));

CREATE TABLE Department 
           ( Department_ID INT PRIMARY KEY, Name NVARCHAR(50) , Location_ID INT FOREIGN KEY REFERENCES Location(Location_ID));

CREATE TABLE Job 
            (Job_ID INT PRIMARY KEY , Designation NVARCHAR(50));

CREATE TABLE Employee_Details
            (Employee_ID INT PRIMARY KEY ,First_Name NVARCHAR(50), Last_name NVARCHAR(50), Middle_name NVARCHAR(50), 
			  Job_ID INT FOREIGN KEY REFERENCES Job(Job_ID), Hiredate DATE, Salary INT , Comm INT NULL , 
			  Department_ID INT FOREIGN KEY REFERENCES Department(Department_ID));


INSERT INTO Location VALUES 
            ( 122 ,'New York'),
			(123,'Dallas'),
			(124,'Chicago'),
			(167,'Boston');

INSERT INTO Department VALUES
            (10, 'Accounting', 122),
			(20, 'Sales', 124),
			(30, 'Research', 123),
			(40, 'Operations', 167);

INSERT INTO Job VALUES
           (667, 'Clerk'),
           (668, 'Staff'),
           (669, 'Analyst'),
           (670, 'Sales Person'),
           (671, 'Manager'),
           (672, 'President');

INSERT INTO Employee_Details VALUES
             (7369, 'John', 'Smith', 'Q',  667, '17-Dec-84', 800, Null ,20),
             (7499,  'Kevin', 'Allen', 'J', 670, '20-Feb-85', 1600, 300 ,30),
             (755, 'Jean', 'Doyle', 'K', 671, '04-Apr-85', 2850, Null, 30),
             (756,  'Lynn', 'Dennis', 'S', 671, '15-May-85', 2750 ,Null ,30),
             (757,  'Leslie',  'Baker', 'D', 671, '10-Jun-85', 2200, Null, 40),
             (7521,  'Cynthia', 'Wark', 'D' ,670, '22-Feb-85', 1250, 50, 30);



SELECT * FROM Employee_Details;

SELECT * FROM Department;

SELECT * FROM Job;

SELECT * FROM Location;

SELECT First_Name, Last_name, Salary, Comm
      FROM Employee_Details;

SELECT Employee_ID AS "ID of the Employee", Last_name AS "Name of the Employee", 
Department_ID AS "Dep_id" FROM Employee_Details;

SELECT First_Name, Last_name, Middle_name, (Salary*12) AS Annual_Salary
FROM Employee_Details;

SELECT * FROM Employee_Details
WHERE Last_name = 'Smith';

SELECT * FROM Employee_Details
WHERE Department_ID = 20;

SELECT * FROM Employee_Details
WHERE Salary BETWEEN 2000 AND 3000;

SELECT * FROM  Employee_Details
WHERE Department_ID IN (10,20);

SELECT * FROM  Employee_Details
WHERE Department_ID NOT IN (10,30);

SELECT * FROM Employee_Details
WHERE First_Name LIKE 'L%';


SELECT * FROM Employee_Details
WHERE First_Name LIKE 'L%' AND Last_name LIKE '%e';

SELECT * 
FROM Employee_Details
WHERE LEN(First_Name) = 4 AND First_Name LIKE 'J%';


SELECT * 
FROM Employee_Details
WHERE Department_ID = 30 
AND Salary > 2500;

SELECT * 
FROM Employee_Details
WHERE Comm IS NULL;

SELECT Employee_ID, Last_Name
FROM Employee_Details
ORDER BY Employee_ID ASC;

SELECT Employee_ID, First_Name, Last_Name
FROM Employee_Details
ORDER BY Salary DESC;

SELECT *
FROM Employee_Details
ORDER BY Last_Name ASC;

SELECT *
FROM Employee_Details
ORDER BY Last_Name ASC, Department_ID DESC;

SELECT Department_ID,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM Employee_Details
GROUP BY Department_ID;

SELECT Job_ID,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary,
       AVG(Salary) AS Avg_Salary
FROM Employee_Details
GROUP BY Job_ID;

SELECT MONTH(Hiredate) AS Join_Month, COUNT(*) AS Number_of_Employees
FROM Employee_Details
GROUP BY MONTH(Hiredate)
ORDER BY Join_Month ASC;

SELECT YEAR(Hiredate) AS Join_Year, MONTH(Hiredate) AS Join_Month, COUNT(*) AS Number_of_Employees
FROM Employee_Details
GROUP BY YEAR(Hiredate), MONTH(Hiredate)
ORDER BY Join_Year ASC, Join_Month ASC;

SELECT Department_ID
FROM Employee_Details
GROUP BY Department_ID
HAVING COUNT(*) >= 4;

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE MONTH(Hiredate) = 2;

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE MONTH(Hiredate) IN (5, 6);

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE YEAR(Hiredate) = 1985;

SELECT MONTH(Hiredate) AS Join_Month, COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE YEAR(Hiredate) = 1985
GROUP BY MONTH(Hiredate)
ORDER BY Join_Month ASC;

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE MONTH(Hiredate) = 4 AND YEAR(Hiredate) = 1985;

SELECT Department_ID
FROM Employee_Details
WHERE MONTH(Hiredate) = 4 AND YEAR(Hiredate) = 1985
GROUP BY Department_ID
HAVING COUNT(*) >= 3;


SELECT E.Employee_ID, E.First_Name, E.Last_Name, D.Name AS Department_Name
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID;

SELECT E.Employee_ID, E.First_Name, E.Last_Name, J.Designation
FROM Employee_Details E
JOIN Job J ON E.Job_ID = J.Job_ID;

SELECT E.Employee_ID, E.First_Name, E.Last_name, D.Name AS Department_name, L.City AS City
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
JOIN Location L ON D.Location_ID = L.Location_ID;

SELECT D.Name AS Department_Name, COUNT(E.Employee_ID) AS Number_of_Employees
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
GROUP BY D.Name;


SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
WHERE D.Name = 'Sales';

SELECT D.Name AS Department_Name
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
GROUP BY D.Name
HAVING COUNT(E.Employee_ID) >= 3
ORDER BY D.Name ASC;

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
JOIN Location L ON D.Location_ID = L.Location_ID
WHERE L.City = 'Dallas';

SELECT E.Employee_ID, E.First_Name, E.Last_Name
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
WHERE D.Name IN ('Sales', 'Operations');


SELECT E.Employee_ID, E.First_Name, E.Last_Name, E.Salary,
       CASE 
           WHEN E.Salary < 2000 THEN 'Low'
           WHEN E.Salary BETWEEN 2000 AND 4000 THEN 'Medium'
           WHEN E.Salary > 4000 THEN 'High'
       END AS Salary_Grade
FROM Employee_Details E;

SELECT 
       CASE 
           WHEN Salary < 2000 THEN 'Low'
           WHEN Salary BETWEEN 2000 AND 4000 THEN 'Medium'
           WHEN Salary > 4000 THEN 'High'
       END AS Salary_Grade,
       COUNT(*) AS Number_of_Employees
FROM Employee_Details
GROUP BY 
       CASE 
           WHEN Salary < 2000 THEN 'Low'
           WHEN Salary BETWEEN 2000 AND 4000 THEN 'Medium'
           WHEN Salary > 4000 THEN 'High'
       END;


SELECT 
       CASE 
           WHEN Salary < 2000 THEN 'Low'
           WHEN Salary BETWEEN 2000 AND 4000 THEN 'Medium'
           WHEN Salary > 4000 THEN 'High'
       END AS Salary_Grade,
       COUNT(*) AS Number_of_Employees
FROM Employee_Details
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY 
       CASE 
           WHEN Salary < 2000 THEN 'Low'
           WHEN Salary BETWEEN 2000 AND 4000 THEN 'Medium'
           WHEN Salary > 4000 THEN 'High'
       END;


SELECT *
FROM Employee_Details
WHERE Salary = (SELECT MAX(Salary) FROM Employee_Details);

SELECT E.*
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
WHERE D.Name = 'Sales';

SELECT E.*
FROM Employee_Details E
JOIN Job J ON E.Job_ID = J.Job_ID
WHERE J.Designation = 'Clerk';

SELECT E.*
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
JOIN Location L ON D.Location_ID = L.Location_ID
WHERE L.City = 'Boston';

SELECT COUNT(*) AS Number_of_Employees
FROM Employee_Details E
JOIN Department D ON E.Department_ID = D.Department_ID
WHERE D.Name = 'Sales';

UPDATE Employee_Details
SET Salary = Salary * 1.10
WHERE Job_ID = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');

SELECT *
FROM Employee_Details
WHERE Salary = (SELECT DISTINCT Salary FROM Employee_Details ORDER BY Salary DESC OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY);

SELECT *
FROM Employee_Details
WHERE Salary > (SELECT MAX(Salary) FROM Employee_Details WHERE Department_ID = 30);

SELECT D.*
FROM Department D
LEFT JOIN Employee_Details E ON D.Department_ID = E.Department_ID
WHERE E.Employee_ID IS NULL;

SELECT E.*
FROM Employee_Details E
JOIN (
    SELECT Department_ID, AVG(Salary) AS Average_Salary
    FROM Employee_Details
    GROUP BY Department_ID
) AS DeptAvg ON E.Department_ID = DeptAvg.Department_ID
WHERE E.Salary > DeptAvg.Average_Salary;

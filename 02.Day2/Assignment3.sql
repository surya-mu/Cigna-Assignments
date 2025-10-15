CREATE TABLE Dept ( 
Deptno NUMBER(2) PRIMARY KEY,
Dname VARCHAR(10),
Loc VARCHAR(10)
);


CREATE TABLE Emps (
EmpNo NUMBER(3) PRIMARY KEY,
Ename VARCHAR(10),
JobName VARCHAR(10),
Sal NUMBER(10),
Deptno NUMBER(2), 
CONSTRAINT fk_dept FOREIGN KEY(Deptno) REFERENCES Dept(Deptno)
);

DESC Dept;
DESC Emps;

INSERT INTO Dept VALUES (10,'Sales','Bengaluru');
INSERT INTO Dept VALUES (20,'Accounting','Chennai');
INSERT INTO Dept VALUES (30,'IT','Dallas');
INSERT INTO Dept VALUES (40,'Marketing','Cochin');


INSERT INTO Emps VALUES (779,'Surya','Executive',50000,10);
INSERT INTO Emps VALUES (789,'Paavan','Associate',30000,10);
INSERT INTO Emps VALUES (777,'Zubair','Associate',30000,10);
INSERT INTO Emps VALUES (710,'Aman','Developer',30000,10);
INSERT INTO Emps VALUES (801,'Abdul','Junior',35000,30);
INSERT INTO Emps VALUES (802,'Nischith','Senior',65000,30);
INSERT INTO Emps VALUES (919, 'Fayaz','Auditor',40000,20);
INSERT INTO Emps VALUES (921,'Ekachit','Chief',70000,20);
INSERT INTO Emps VALUES (988,'Varun','Intern',20000,NULL);



SELECT * FROM Dept;
SELECT * FROM Emps;

-- 1)  Display employee names along with their department names.

SELECT e.Ename,d.Dname
FROM Emps e 
INNER JOIN Dept d ON e.Deptno = d.Deptno;

-- 2) List all employees with their job titles and the location of their department.

SELECT e.Ename,e.JobName,d.loc
FROM Emps e 
INNER JOIN Dept d ON e.Deptno = d.Deptno

-- 3)  Display employees who work in the SALES department.

SELECT e.Ename,d.Dname
FROM Emps e 
INNER JOIN Dept d ON e.Deptno = d.Deptno
WHERE d.Dname = 'Sales';

-- 4) List all employees along with their department name and location, including departments that have no employees.
SELECT e.Ename,d.Dname,d.Loc
FROM Emps e
RIGHT JOIN Dept d ON e.Deptno = d.Deptno;

-- 5)  Display all departments and employees, even if some employees are not assigned to any department
SELECT e.Ename, d.Dname
FROM Emps e 
LEFT JOIN Dept d ON e.Deptno = d.Deptno;

-- 6)Show each department name and  total salary paid to its employees.
SELECT d.Dname, SUM(e.Sal) AS Total_Salary
FROM Emps e 
INNER JOIN Dept d ON e.Deptno = d.Deptno
GROUP BY d.Dname

-- 7) Find departments that have more than 3 employees.  Display dname and no. of employees.
SELECT d.Dname, COUNT(*) AS Employee_Count
FROM Emps e
INNER JOIN Dept d ON e.Deptno = d.Deptno
GROUP BY d.Dname
HAVING COUNT(*) > 3;

--8) Display employees who work in the same location as the ACCOUNTING department.
SELECT e.Ename,d.Loc
FROM Emps e
INNER JOIN Dept d ON e.Deptno = d.Deptno
WHERE d.Loc = (SELECT Loc from Dept WHERE Dname='Accounting');

--9)   For each department, display the employee who has the highest salary
SELECT e.Ename,d.Dname,e.Sal AS Highest_Salary from Emps e INNER JOIN Dept d ON e.Deptno = d.Deptno 
WHERE Sal IN (SELECT MAX(e.Sal) AS Highest_Salary
FROM Emps e
INNER JOIN Dept d ON e.Deptno = d.Deptno
GROUP BY d.Dname); 

-- 10) List employees whose salary is greater than the average salary of their department
SELECT e.Ename,e.Sal,e.Deptno
FROM Emps e
WHERE e.Sal > (SELECT AVG(Sal) FROM Emps where Deptno = e.Deptno)

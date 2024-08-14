CREATE DATABASE CompanyDB;
USE CompanyDB;

Create table Employees (
	EmployeeID INT auto_increment PRIMARY key,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE

);
INSERT INTO Employees (FirstName, LastName, Department, Salary, HireDate)
VALUES 
('Babar', 'Azam', 'IT', 60000, '2015-01-15'),
('Shaan', 'Masood', 'HR', 55000, '2018-03-22'),
('Shadab', 'Khan', 'Marketing', 50000, '2019-07-11');

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
INSERT INTO Departments (DepartmentName)
VALUES 
('IT'),
('HR'),
('Marketing');

/*Basic Data Retrival*/
select * FROM Employees;

select firstName, LastName, Department FROM Employees;

Select * from Employees Where Salary > 55000;

/*Updating Records*/
SET SQL_SAFE_UPDATES = 0;
update Employees set salary = 65000 where EmployeeID = 1;
Update Employees Set Department = 'Seniotr Manager' Where HireDate <= date_sub(curdate(),interval 5 year);

DELETE FROM Employees WHERE EmployeeID = 3;
DELETE FROM Employees WHERE Salary < 50000;

SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.Department = d.DepartmentName
WHERE d.DepartmentName = 'IT';
SELECT 
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary,
    AVG(Salary) AS AverageSalary
FROM Employees;

SELECT COUNT(*) AS TotalEmployees FROM Employees;

SELECT Department, SUM(Salary) AS TotalSalaryExpenditure
FROM Employees
GROUP BY Department;
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department;


/*Procedures*/
DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Department VARCHAR(50),
    IN p_Salary DECIMAL(10, 2),
    IN p_HireDate DATE
)
BEGIN
    INSERT INTO Employees (FirstName, LastName, Department, Salary, HireDate)
    VALUES (p_FirstName, p_LastName, p_Department, p_Salary, p_HireDate);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateEmployeeSalary(
    IN p_EmployeeID INT,
    IN p_NewSalary DECIMAL(10, 2)
)
BEGIN
    UPDATE Employees
    SET Salary = p_NewSalary
    WHERE EmployeeID = p_EmployeeID;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE DeleteLeftEmployees(
    IN p_EmployeeID INT
)
BEGIN
    DELETE FROM Employees WHERE EmployeeID = p_EmployeeID;
END //
DELIMITER ;
ALTER TABLE Employees ADD COLUMN LastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DELIMITER //
CREATE TRIGGER UpdateLastModified
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    SET NEW.LastModified = CURRENT_TIMESTAMP;
END //
DELIMITER ;


CREATE TABLE EmployeeDeletions (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER LogEmployeeDeletion
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeDeletions (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
    VALUES (OLD.EmployeeID, OLD.FirstName, OLD.LastName, OLD.Department, OLD.Salary, OLD.HireDate);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER PreventDepartmentDeletion
BEFORE DELETE ON Departments
FOR EACH ROW
BEGIN
    DECLARE employeeCount INT;
    
    SELECT COUNT(*) INTO employeeCount
    FROM Employees
    WHERE Department = OLD.DepartmentName;
    
    IF employeeCount > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete department with assigned employees.';
    END IF;
END //
DELIMITER ;


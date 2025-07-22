
-- Tabla DEPARTMENTS
CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMERIC(4,0) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30),
    MANAGER_ID NUMERIC(6,0),
    LOCATION_ID NUMERIC(4,0)
);

-- Inserción de datos en DEPARTMENTS
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 202, 1700),
(40, 'Human Resources', 203, 1500),
(50, 'Shipping', 204, 1500);

-- Tabla Countries
CREATE TABLE Countries (
    COUNTRY_ID VARCHAR(2) PRIMARY KEY,
    COUNTRY_NAME VARCHAR(50),
    REGION_ID INT
);

-- Inserción de datos en Countries
INSERT INTO Countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES
('CA', 'Canada', 2),
('DE', 'Germany', 1),
('UK', 'United Kingdom', 1),
('US', 'United States of America', 2);

-- Tabla Locations
CREATE TABLE Locations (
    LOCATION_ID INT PRIMARY KEY,
    CITY VARCHAR(50),
    STATE_PROVINCE VARCHAR(50)
);

-- Inserción de datos en Locations
INSERT INTO Locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES
(1800, 'Toronto', 'Ontario'),
(2500, 'Oxford', 'Oxford'),
(1400, 'Southlake', 'Texas'),
(1500, 'South San Francisco', 'California'),
(1700, 'Seattle', 'Washington');

-- Tabla Employees
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    SALARY INT,
    job_id VARCHAR(10),
    HIRE_DATE DATE,
    DEPARTMENT_ID NUMERIC(4,0),
    COMMISSION_PCT NUMERIC(3,2)
);

-- Inserción de datos en Employees
INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY, job_id, HIRE_DATE, DEPARTMENT_ID, COMMISSION_PCT) VALUES
(10, 'John', 'Doe', 4000, 'IT_PROG', '2022-01-15', 10, NULL),
(20, 'Jane', 'Jones', 3000, 'SA_MAN', '2021-03-20', 20, NULL),
(30, 'Sylvia', 'Smith', 5000, 'IT_PROG', '2023-05-10', 10, NULL),
(40, 'Hai', 'Nguyen', 6000, 'MK_MAN', '2020-07-01', 20, NULL),
(50, 'Alice', 'Brown', 4500, 'MK_REP', '2023-11-01', 20, NULL),
(148, 'Gerald', 'Grant', 7000, 'SA_REP', '2007-05-24', 50, NULL);


-- Lección 1.1
SELECT *
FROM employees;

SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 'SA_REP';

-- Lección 1.2
SELECT department_name
FROM departments;

-- Lección 1.3
SELECT last_name
FROM employees;

SELECT salary
FROM employees
WHERE last_name LIKE 'Smith';

SELECT *
FROM countries;

SELECT country_id, country_name, region_id
FROM countries;

SELECT location_id, city, state_province
FROM locations;

SELECT last_name, salary,
salary + 300
FROM employees;

SELECT last_name, salary,
12 * salary + 100
FROM employees;

SELECT last_name, salary,
12 * (salary + 100)
FROM employees;

SELECT last_name, job_id, salary, commission_pct,
salary * commission_pct
FROM employees;

SELECT last_name AS name,
commission_pct AS comm
FROM employees;

SELECT last_name "Name",
salary * 12 "Annual Salary"
FROM employees;
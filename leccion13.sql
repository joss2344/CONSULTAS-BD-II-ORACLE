-- Lección 12.1: Sentencias INSERT

CREATE TABLE copy_employees AS SELECT * FROM employees;
CREATE TABLE copy_departments AS SELECT * FROM departments;

INSERT INTO copy_departments
(department_id, department_name, manager_id, location_id)
VALUES (200,'Human Resources', 205, 1500);

INSERT INTO copy_departments
VALUES (210,'Estate Management', 102, 1700);

INSERT INTO copy_employees
(ID, first_name, last_name, job_id, hire_date, salary)
VALUES
(302,'Grigorz','Polanski', 'IT_PROG', '2017-06-15', 4200);

INSERT INTO copy_employees
(ID, first_name, last_name, email, job_id, hire_date, salary)
VALUES
(302,'Grigorz','Polanski', 'gpolanski@example.com', 'IT_PROG', '2017-06-15', 4200);

INSERT INTO copy_employees
(ID, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(304,'Test',CURRENT_USER, 't_user@example.com', NOW(), 'ST_CLERK',2500);

SELECT first_name, TO_CHAR(hire_date,'Month, DD, YYYY')
FROM employees
WHERE ID = 101;

INSERT INTO copy_employees
(ID, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(301,'Katie','Hernandez', 'khernandez@example.com', TO_DATE('July 8, 2017', 'Month DD, YYYY'), 'MK_REP',4200);

INSERT INTO copy_employees
(ID, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(303,'Angelina','Wright', 'awright@example.com', TO_DATE('July 10, 2017 17:20', 'Month DD, YYYY HH24:MI'), 'MK_REP', 3600);

SELECT first_name, last_name,
TO_CHAR(hire_date, 'DD-Mon-YYYY HH24:MI') As "Date and Time"
FROM copy_employees
WHERE ID = 303;

CREATE TABLE sales_reps (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    commission_pct NUMERIC(3,2)
);

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT ID, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

-- Lección 12.2: Actualización de Valores de Columna y Supresión de Filas

ALTER TABLE copy_employees ADD COLUMN phone_number VARCHAR(20);
UPDATE copy_employees
SET phone_number = '123456'
WHERE ID = 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE ID >= 303;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE ID = 100)
WHERE ID = 101;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE ID = 205),
job_id = (SELECT job_id
FROM copy_employees
WHERE ID = 205)
WHERE ID = 206;

UPDATE copy_employees
SET salary = (SELECT salary
FROM employees
WHERE ID = 205)
WHERE ID = 202;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30);

UPDATE copy_employees e
SET department_name = (SELECT d.department_name
FROM departments d
WHERE e.department_id =
d.department_id);

DELETE FROM copy_employees
WHERE ID = 303;

DELETE FROM copy_employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Shipping');

DELETE FROM copy_employees e
WHERE e.manager_id IN
(SELECT d.manager_id
FROM employees d
GROUP BY d.manager_id
HAVING count(d.department_id) < 2);

-- Lección 12.3: Valores DEFAULT, MERGE e Inserciones en Varias Tablas

CREATE TABLE my_employees (
    hire_date DATE DEFAULT CURRENT_DATE,
    first_name VARCHAR(15),
    last_name VARCHAR(15)
);

INSERT INTO my_employees
(hire_date, first_name, last_name)
VALUES
(DEFAULT, 'Angelina','Wright');

INSERT INTO my_employees
(first_name, last_name)
VALUES
('Angelina','Wright');

UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';

CREATE TABLE copy_emp (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(50),
    department_id NUMERIC(4,0)
);

INSERT INTO copy_emp (employee_id, last_name, department_id) VALUES
(100, 'Smith', 40),
(103, 'Chang', 30),
(142, 'OldName', 50);

INSERT INTO copy_emp AS c (employee_id, last_name, department_id)
SELECT e.ID, e.last_name, e.department_id
FROM employees e
WHERE e.ID IN (100, 103, 142)
ON CONFLICT (employee_id) DO UPDATE SET
    last_name = EXCLUDED.last_name,
    department_id = EXCLUDED.department_id;

CREATE TABLE my_employees_multi (
    hire_date DATE,
    first_name VARCHAR(15),
    last_name VARCHAR(15)
);

CREATE TABLE copy_my_employees (
    hire_date DATE,
    first_name VARCHAR(15),
    last_name VARCHAR(15)
);

INSERT INTO my_employees_multi (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name FROM employees;

INSERT INTO copy_my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name FROM employees;

CREATE TABLE calls (
    caller_id INT,
    call_timestamp TIMESTAMP,
    call_duration INT,
    call_format VARCHAR(10),
    recipient_caller INT
);

CREATE TABLE all_calls (
    caller_id INT,
    call_timestamp TIMESTAMP,
    call_duration INT,
    call_format VARCHAR(10)
);

CREATE TABLE police_record_calls (
    caller_id INT,
    call_timestamp TIMESTAMP,
    recipient_caller INT
);

CREATE TABLE short_calls (
    caller_id INT,
    call_timestamp TIMESTAMP,
    call_duration INT
);

CREATE TABLE long_calls (
    caller_id INT,
    call_timestamp TIMESTAMP,
    call_duration INT
);

INSERT INTO calls (caller_id, call_timestamp, call_duration, call_format, recipient_caller) VALUES
(1, '2023-07-26 10:00:00', 60, 'tlk', 10),
(2, '2023-07-26 10:05:00', 30, 'txt', 20),
(3, '2023-07-26 10:10:00', 120, 'pic', 30),
(4, '2023-07-26 10:15:00', 45, 'tlk', 40),
(5, '2023-07-26 10:20:00', 70, 'txt', 50),
(6, '2023-07-26 10:25:00', 20, 'tlk', 60);

INSERT INTO all_calls (caller_id, call_timestamp, call_duration, call_format)
SELECT caller_id, call_timestamp, call_duration, call_format
FROM calls
WHERE call_format IN ('tlk','txt','pic')
AND date_trunc('day', call_timestamp) = date_trunc('day', NOW());

INSERT INTO police_record_calls (caller_id, call_timestamp, recipient_caller)
SELECT caller_id, call_timestamp, recipient_caller
FROM calls
WHERE call_format IN ('tlk','txt')
AND date_trunc('day', call_timestamp) = date_trunc('day', NOW());

INSERT INTO short_calls (caller_id, call_timestamp, call_duration)
SELECT caller_id, call_timestamp, call_duration
FROM calls
WHERE call_duration < 50 AND call_format = 'tlk'
AND date_trunc('day', call_timestamp) = date_trunc('day', NOW());

INSERT INTO long_calls (caller_id, call_timestamp, call_duration)
SELECT caller_id, call_timestamp, call_duration
FROM calls
WHERE call_duration >= 50 AND call_format = 'tlk'
AND date_trunc('day', call_timestamp) = date_trunc('day', NOW());

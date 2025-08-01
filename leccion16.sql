-- DDL y DML para establecer el entorno de la Lección 16.x
-- Este script crea y puebla las tablas necesarias para todos los ejemplos.

-- *** MUY IMPORTANTE: EJECUTAR ESTA SECCIÓN COMPLETA PRIMERO ***
-- Eliminar tablas, secuencias e índices existentes para asegurar una recreación limpia.
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS DEPARTMENTS CASCADE;
DROP TABLE IF EXISTS Locations CASCADE;
DROP TABLE IF EXISTS Countries CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS job_grades CASCADE;
DROP TABLE IF EXISTS job_history CASCADE;
DROP TABLE IF EXISTS DUAL;
DROP TABLE IF EXISTS wf_countries CASCADE;
DROP TABLE IF EXISTS wf_spoken_languages CASCADE;
DROP TABLE IF EXISTS runners CASCADE; -- Nueva tabla para secuencias
DROP SEQUENCE IF EXISTS runner_id_seq;
DROP SEQUENCE IF EXISTS departments_seq;
DROP SEQUENCE IF EXISTS employees_seq;
DROP INDEX IF EXISTS wf_cont_reg_id_idx;
DROP INDEX IF EXISTS emps_name_idx;
DROP INDEX IF EXISTS upper_last_name_idx;
DROP INDEX IF EXISTS emp_hire_year_idx;


-- Creación de la Tabla Countries
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

-- Creación de la Tabla DEPARTMENTS
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
(50, 'Shipping', 124, 1500),
(60, 'IT', 103, 1400),
(80, 'Sales', 149, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120, 'Treasury', 206, 1700),
(190, 'Contracting', NULL, 1700);

-- Creación de la Tabla Locations
CREATE TABLE Locations (
    LOCATION_ID INT PRIMARY KEY,
    CITY VARCHAR(50),
    STATE_PROVINCE VARCHAR(50),
    COUNTRY_ID VARCHAR(2)
);

-- Agrega la restricción de clave foránea para country_id en Locations
ALTER TABLE Locations
ADD CONSTRAINT fk_location_country
FOREIGN KEY (country_id)
REFERENCES Countries (COUNTRY_ID);

-- Inserción de datos en Locations
INSERT INTO Locations (LOCATION_ID, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1800, 'Toronto', 'Ontario', 'CA'),
(2500, 'Oxford', 'Oxford', 'UK'),
(1400, 'Southlake', 'Texas', 'US'),
(1500, 'South San Francisco', 'California', 'US'),
(1700, 'Seattle', 'Washington', 'US');

-- Creación de la Tabla jobs
CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35),
    min_salary INT,
    max_salary INT
);

-- Inserción de datos en jobs
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('IT_PROG', 'Programmer', 4000, 10000),
('MK_MAN', 'Marketing Manager', 9000, 15000),
('MK_REP', 'Marketing Representative', 4000, 9000),
('HR_REP', 'Human Resources Representative', 4000, 9000),
('PR_REP', 'Public Relations Representative', 4500, 10000),
('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
('AC_MGR', 'Accounting Manager', 8000, 16000),
('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000);


-- Creación de la Tabla job_grades
CREATE TABLE job_grades (
    grade_level VARCHAR(3) PRIMARY KEY,
    lowest_sal INT,
    highest_sal INT
);

-- Inserción de datos en job_grades
INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 24999),
('F', 25000, 40000);

-- Creación de la Tabla Employees
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    SALARY INT,
    job_id VARCHAR(10),
    HIRE_DATE DATE,
    DEPARTMENT_ID NUMERIC(4,0),
    COMMISSION_PCT NUMERIC(3,2),
    MANAGER_ID NUMERIC(6,0),
    EMAIL VARCHAR(50)
);

-- Agrega la restricción de clave foránea para department_id en Employees
ALTER TABLE Employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES DEPARTMENTS (DEPARTMENT_ID)
ON DELETE NO ACTION;

-- Agrega la restricción de clave foránea para job_id en Employees
ALTER TABLE Employees
ADD CONSTRAINT fk_employee_job
FOREIGN KEY (job_id)
REFERENCES jobs (job_id)
ON DELETE NO ACTION;

-- Inserción de datos en Employees (ajustados para Lecciones 16.x)
INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY, job_id, HIRE_DATE, DEPARTMENT_ID, COMMISSION_PCT, MANAGER_ID, EMAIL) VALUES
(1, 'Natacha', 'Hansen', 12000, 'AD_VP', '1998-09-07', 90, NULL, 100, 'NHANSEN@example.com'),
(10, 'John', 'Doe', 4000, 'IT_PROG', '2022-01-15', 10, NULL, 100, 'JDOE@example.com'),
(20, 'Jane', 'Jones', 3000, 'SA_MAN', '2021-03-20', 20, NULL, 100, 'JJONES@example.com'),
(30, 'Sylvia', 'Smith', 5000, 'IT_PROG', '2023-05-10', 10, NULL, 100, 'SSMITH@example.com'),
(100, 'Steven', 'King', 24000, 'AD_PRES', '1987-06-17', 90, NULL, NULL, 'SKING@example.com'),
(101, 'Neena', 'Kochhar', 17000, 'AD_VP', '1989-09-21', 90, NULL, 100, 'NKOCHHAR@example.com'),
(102, 'Lex', 'De Haan', 17000, 'AD_VP', '1993-01-13', 90, NULL, 100, 'LDEHAAN@example.com'),
(103, 'Alexander', 'Whalen', 4400, 'AD_ASST', '1987-09-17', 10, NULL, 100, 'AWHALEN@example.com'),
(104, 'Bruce', 'Higgins', 12000, 'AC_MGR', '1994-06-07', 110, NULL, 100, 'BHIGGINS@example.com'),
(105, 'Diana', 'Gietz', 8300, 'AC_ACCOUNT', '1994-06-07', 110, NULL, 104, 'DGIETZ@example.com'),
(145, 'John', 'Zlotkey', 10500, 'SA_MAN', '2000-01-29', 80, 0.20, 100, 'JZLOTKEY@example.com'),
(170, 'Jack', 'Davies', 3100, 'ST_CLERK', '1997-01-29', 50, NULL, 100, 'JDAVIES@example.com'),
(171, 'Sarah', 'Ernst', 3400, 'IT_PROG', '1991-05-21', 60, NULL, 100, 'SERNST@example.com'), -- Para ejemplo UPPER(last_name)
(173, 'Joshua', 'Rajs', 3500, 'ST_CLERK', '1995-10-17', 50, NULL, 100, 'JRAJS@example.com');


-- Creación de la Tabla job_history
CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id NUMERIC(4,0),
    PRIMARY KEY (employee_id, start_date)
);

-- Agrega FK a employees y departments
ALTER TABLE job_history
ADD CONSTRAINT fk_jh_employee
FOREIGN KEY (employee_id)
REFERENCES Employees (ID)
ON DELETE CASCADE;

ALTER TABLE job_history
ADD CONSTRAINT fk_jh_department
FOREIGN KEY (department_id)
REFERENCES DEPARTMENTS (DEPARTMENT_ID)
ON DELETE CASCADE;

ALTER TABLE job_history
ADD CONSTRAINT fk_jh_job
FOREIGN KEY (job_id)
REFERENCES jobs (job_id)
ON DELETE CASCADE;

-- Inserción de datos en job_history para ejemplos
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES
(101, '1998-01-01', '2000-12-31', 'AD_VP', 90),
(102, '1993-01-13', '1998-07-24', 'IT_PROG', 60);


-- Creación de la Tabla DUAL (para simular la tabla DUAL de Oracle)
CREATE TABLE DUAL (
    DUMMY VARCHAR(1)
);

-- Inserción de datos en DUAL
INSERT INTO DUAL (DUMMY) VALUES ('X');

-- Creación de la Tabla wf_countries
CREATE TABLE wf_countries (
    country_name VARCHAR(100) PRIMARY KEY,
    airports INT,
    internet_extension VARCHAR(10),
    location VARCHAR(50),
    date_of_independence DATE,
    life_expect_at_birth NUMERIC(5,2),
    area NUMERIC(10,2),
    region_id INT,
    population NUMERIC(15,0)
);

-- Inserción de datos en wf_countries
INSERT INTO wf_countries (country_name, airports, internet_extension, location, date_of_independence, life_expect_at_birth, area, region_id, population) VALUES
('Canada', 7, NULL, 'North America', '1867-07-01', 82.00, 9984670.00, 2, 38000000),
('Germany', 10, '.de', 'Europe', '1990-10-03', 81.00, 357022.00, 1, 83000000),
('United Kingdom', 20, '.uk', 'Europe', NULL, 81.00, 243610.00, 1, 67000000),
('United States of America', 100, '.us', 'North America', '1776-07-04', 79.00, 9833520.00, 2, 331000000),
('France', 50, '.fr', 'Europe', NULL, 82.00, 551695.00, 1, 65000000),
('Italy', 30, '.it', 'Europe', NULL, 83.00, 301340.00, 1, 59000000);


-- Creación de la Tabla wf_spoken_languages
CREATE TABLE wf_spoken_languages (
    country_id VARCHAR(2),
    language_id INT,
    PRIMARY KEY (country_id, language_id)
);

-- Inserción de datos en wf_spoken_languages
INSERT INTO wf_spoken_languages (country_id, language_id) VALUES
('US', 1), ('US', 2),
('CA', 1), ('CA', 2),
('UK', 1),
('DE', 3),
('JP', 4),
('ZA', 1), ('ZA', 5), ('ZA', 6),
('ZM', 1), ('ZM', 7),
('ZW', 1), ('ZW', 8);


-- Creación de la tabla runners
CREATE TABLE runners (
    runner_id NUMERIC(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);


-- *** FIN DE LA SECCIÓN DDL/DML ***


-- Lección 16: Creación de Secuencias e Índices

-- Creación de Secuencias
CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

-- Repetido en el material, pero se mantiene para la transcripción.
CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

CREATE SEQUENCE departments_seq
INCREMENT BY 1
START WITH 1
NO CYCLE;

-- Insertar un nuevo departamento usando la secuencia
-- Nota: Asegúrate de que DEPARTMENT_ID 1 no exista si START WITH 1.
INSERT INTO departments (department_id, department_name, location_id)
VALUES (nextval('departments_seq'), 'Support', 2500);

CREATE SEQUENCE employees_seq
INCREMENT BY 1
START WITH 1
NO CYCLE;

-- Insertar un nuevo empleado usando secuencias
-- Nota: job_id 101 no es un job_id válido en la tabla 'jobs'.
-- Se ha cambiado a 'IT_PROG' para que la FK sea válida.
-- department_id también usa nextval('departments_seq'), lo que podría crear un nuevo departamento cada vez.
-- Se asume un department_id fijo (10) para el ejemplo.
INSERT INTO employees (
    id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id, -- Corregido de id_job a job_id
    salary,
    department_id
)
VALUES (
    nextval('employees_seq'),
    'Juan',
    'Perez',
    'juan.perez@example.com',
    CURRENT_DATE,
    'IT_PROG', -- Asumiendo un job_id válido
    50000,
    10 -- Asumiendo un department_id fijo y existente
);

-- Insertar datos en la tabla runners usando la secuencia
INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');

SELECT runner_id, first_name, last_name
FROM runners;

-- Repetido en el material.
INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

-- Alterar una secuencia
ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 999999
NO CYCLE;


-- Creación de Índices

-- Crear un índice en una sola columna
CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

-- Crear un índice compuesto
CREATE INDEX emps_name_idx
ON employees(first_name, last_name);

-- Consultar el diccionario de datos para información de índices (PostgreSQL)
SELECT
    idx.relname AS index_name,
    a.attname AS column_name,
    (array_position(idx_cls.indkey, a.attnum)) AS column_position,
    idx_cls.indisunique AS uniqueness
FROM
    pg_class t
JOIN
    pg_namespace n ON n.oid = t.relnamespace
JOIN
    pg_index idx_cls ON t.oid = idx_cls.indrelid
JOIN
    pg_class idx ON idx.oid = idx_cls.indexrelid
JOIN
    pg_attribute a ON a.attrelid = t.oid AND a.attnum = ANY(idx_cls.indkey)
WHERE
    t.relkind = 'r' -- 'r' for regular table
    AND idx.relkind = 'i' -- 'i' for index
    AND t.relname = 'employees'
ORDER BY
    index_name, column_position;

-- Crear un índice basado en una función (UPPER)
CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

-- Consulta para probar el índice de función
SELECT *
FROM employees
WHERE UPPER(last_name) = 'KING';

-- Repetido en el material.
CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

-- Consulta para probar el índice de función con LIKE
SELECT *
FROM employees
WHERE UPPER(last_name) LIKE 'KIN%';

-- Consulta para ordenar por UPPER(last_name)
SELECT *
FROM employees
WHERE UPPER (last_name) IS NOT NULL
ORDER BY UPPER (last_name);

-- Consulta para filtrar por año de contratación
SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '1987'; -- TO_CHAR es compatible, pero EXTRACT es común en PG

-- Crear un índice en una expresión de fecha (EXTRACT YEAR)
CREATE INDEX emp_hire_year_idx
ON employees (EXTRACT(YEAR FROM hire_date));

-- Eliminar índices
DROP INDEX upper_last_name_idx;
DROP INDEX emps_name_idx;
DROP INDEX emp_hire_year_idx;

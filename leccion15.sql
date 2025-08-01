CREATE VIEW view_employees AS
SELECT id, first_name, last_name, email
FROM employees
WHERE id BETWEEN 10 AND 30;

SELECT * FROM view_employees;

CREATE OR REPLACE VIEW view_euro_countries AS
SELECT country_name, region_id, population, internet_extension
FROM wf_countries
WHERE country_name LIKE '%Europe%';

SELECT * FROM view_euro_countries
ORDER BY country_name;

CREATE OR REPLACE VIEW view_euro_countries AS
SELECT airports AS "ID", country_name AS "Country", area AS "Area"
FROM wf_countries
WHERE country_name LIKE '%canada%';

CREATE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, email
FROM copy_employees
WHERE department_id = 50;

SELECT * FROM view_dept50;

CREATE OR REPLACE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50
WITH CHECK OPTION;

DROP VIEW IF EXISTS view_dept50;

CREATE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name
FROM copy_employees
WHERE department_id = 50;

UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 20;

CREATE OR REPLACE VIEW view_dept50 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM employees
WHERE department_id = 50
WITH CHECK OPTION;

SELECT e.last_name, e.salary, e.department_id, d.maxsal
FROM employees e,
(SELECT department_id, max(salary) maxsal
 FROM employees
 GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary = d.maxsal;

SELECT last_name, hire_date
FROM employees
ORDER BY hire_date ASC
LIMIT 5;

SELECT last_name, hire_date
FROM employees
ORDER BY hire_date ASC
LIMIT 5;

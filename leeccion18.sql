CREATE VIEW HQ_EMP AS SELECT * FROM emp;

SELECT first_name, last_name FROM employees WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');

SELECT first_name, last_name FROM employees WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');

SELECT last_name, REGEXP_REPLACE(last_name, '^H(a|e|i|o|u)','**') AS "Name changed" FROM employees;

SELECT country_name, REGEXP_COUNT(country_name, '(ab)') AS "Count of 'ab'" FROM wf_countries WHERE REGEXP_COUNT(country_name, '(ab)')>0;

ALTER TABLE employees ADD CONSTRAINT email_addr_chk CHECK(REGEXP_LIKE(email,'@'));

CREATE TABLE my_contacts (first_name VARCHAR(15), last_name VARCHAR(15), email VARCHAR(30) CHECK(REGEXP_LIKE(email, '.+@.+\..+')));

ALTER TABLE copy_departments ADD COLUMN manager_id INT;

UPDATE copy_departments SET manager_id = 101 WHERE department_id = 60;

INSERT INTO copy_departments(department_id, department_name, manager_id) VALUES(130, 'Estate Management', 102);

UPDATE copy_departments SET department_id = 140;

BEGIN;

INSERT INTO copy_departments (department_id, department_name, manager_id) VALUES (131, 'New Department', 103);

SAVEPOINT my_savepoint_1;

INSERT INTO copy_departments (department_id, department_name, manager_id) VALUES (132, 'Another Department', 104);

ROLLBACK TO SAVEPOINT my_savepoint_1;

INSERT INTO copy_departments (department_id, department_name, manager_id) VALUES (133, 'Corrected Department', 105);

COMMIT;

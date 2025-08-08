CREATE TABLE emp
AS select * FROM employees;

CREATE TABLE dept
AS select * FROM departments;

ALTER TABLE emp
ADD CONSTRAINT fk_emp_dept 
FOREIGN KEY (dept_id)
REFERENCES dept(deptid)
ON DELETE CASCADE; 

SELECT COUNT(*) AS "Num employees"
FROM emp;

DELETE FROM dept
WHERE department_id = 10;

SELECT * FROM emp;

INSERT INTO emp
(first_name, last_name, email,
hire_date,
id_job, salary, commission_pct, manager_id, department_id)
VALUES
('Kaare', 'Hansen', 'KHANSEN',
NOW(),
'Manager', 6500, null, 100, 10);

CREATE INDEX emp_indx ON emp(id DESC,
UPPER(SUBSTR(first_name, 1, 1) || ' ' || last_name));
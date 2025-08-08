SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jobs';

ALTER TABLE jobs
ADD COLUMN min_salary NUMERIC(8, 2),
ADD COLUMN max_salary NUMERIC(8, 2);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (222, 'New Job', 100, 200);

SELECT last_name, department_name
FROM employees CROSS JOIN departments;

SELECT id, last_name, department_name
FROM employees NATURAL JOIN departments;

SELECT e.id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

SELECT id, last_name, department_name
FROM employees JOIN departments
USING (department_id);

SELECT e.id, e.last_name, d.department_id,
d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT id, first_name, last_name
FROM employees
WHERE (department_id, manager_id) IN (SELECT department_id, manager_id
                                       FROM employees
                                       WHERE id = 50);

SELECT
    e.id,
    e.first_name,
    e.salary,
    e.department_id
FROM
    employees e
WHERE
    e.salary BETWEEN (SELECT j.min_salary
                      FROM jobs j
                      WHERE j.job_title = 'Manager')
    AND (SELECT j2.max_salary
         FROM jobs j2
         WHERE j2.job_title = 'Manager')
AND
    e.department_id IN (SELECT d.department_id
                        FROM departments d
                        WHERE d.manager_id = 100);

SELECT
    e.id,
    e.first_name,
    e.department_id,
    e.manager_id AS employee_manager_id
FROM
    employees e
WHERE
    e.manager_id = (SELECT d.manager_id
                    FROM departments d
                    WHERE d.department_id = e.department_id);

INSERT INTO employees (id, first_name)
VALUES (100, 'Gustavo');

INSERT INTO employees
VALUES (101, 'Alice', 'Smith', 10000);

DELETE FROM EMPLOYEES
WHERE id = 102;



SELECT
    id,
    first_name,
    last_name,
    salary
FROM
    employees
ORDER BY
    salary DESC
LIMIT 5;

CREATE SEQUENCE order_id_seq
    AS INTEGER
    INCREMENT BY 1
    START WITH 1000
    MAXVALUE 999999
    MINVALUE 1000
    NO CYCLE
    CACHE 50;

SELECT nextval('order_id_seq');

CREATE TABLE customer_orders (
    order_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE DEFAULT CURRENT_DATE
);1
DROP SEQUENCE order_id_seq;

CREATE INDEX idx_employees_last_name
ON employees (last_name);

CREATE UNIQUE INDEX idx_employees_email_unique
ON employees (email);

CREATE INDEX idx_employees_dept_salary
ON employees (department_id, salary DESC);

DROP INDEX idx_employees_dept_salary;

CREATE ROLE administrador_db LOGIN PASSWORD '123456!' CREATEDB CREATEROLE;


GRANT INSERT (nombre, apellido, correo_electronico),
      UPDATE (nombre, apellido, correo_electronico)
ON empleados
TO gerentes_ventas;


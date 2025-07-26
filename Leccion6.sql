-- 6.1
SELECT first_name, last_name, e.job_id, job_title
FROM employees e
NATURAL JOIN jobs
WHERE department_id > 80;

SELECT department_name, city
FROM departments
NATURAL JOIN locations;

SELECT last_name, department_name
FROM employees
CROSS JOIN departments;

-- 6.2
SELECT first_name, last_name, department_id, department_name
FROM employees
JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees
JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

SELECT last_name, job_title
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id);

SELECT last_name, job_title
FROM employees e
JOIN jobs j ON (e.job_id = j.job_id)
WHERE last_name LIKE 'H%';

SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees
JOIN job_grades ON (salary BETWEEN lowest_sal AND highest_sal);

SELECT last_name, department_name AS "Department", city
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id);

-- 6.3
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT last_name, e.job_id AS "Job", jh.job_id AS "Old job", end_date
FROM employees e
LEFT OUTER JOIN job_history jh ON (e.ID = jh.employee_id);

-- 6.4
SELECT worker.last_name AS "Employee", worker.manager_id, manager.last_name AS "Manager name"
FROM employees worker
JOIN employees manager ON (worker.manager_id = manager.ID);

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, job_id, manager_id, 1 AS level
    FROM employees
    WHERE ID = 100
    UNION ALL
    SELECT e.ID, e.last_name, e.job_id, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT employee_id, last_name, job_id, manager_id
FROM employee_hierarchy;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'King'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT eh.last_name || ' reports to ' || COALESCE(m.last_name, 'No one') AS "Walk Top Down"
FROM employee_hierarchy eh
LEFT JOIN employees m ON eh.manager_id = m.ID
ORDER BY eh.level, eh.last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'King'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT level, eh.last_name || ' reports to ' || COALESCE(m.last_name, 'No one') AS "Walk Top Down"
FROM employee_hierarchy eh
LEFT JOIN employees m ON eh.manager_id = m.ID
ORDER BY eh.level, eh.last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'King'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT LPAD(last_name, LENGTH(last_name) + (level * 2) - 2, '_') AS "Org Chart"
FROM employee_hierarchy
ORDER BY level, last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'King'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT LPAD(last_name, LENGTH(last_name) + (level * 2) - 2, '_') AS "Org_Chart"
FROM employee_hierarchy
ORDER BY level, last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'Grant'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.ID = eh.manager_id
)
SELECT LPAD(last_name, LENGTH(last_name) + (level * 2) - 2, '_') AS ORG_CHART
FROM employee_hierarchy
ORDER BY level DESC, last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'Kochhar'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
    WHERE e.last_name != 'Higgins'
)
SELECT last_name
FROM employee_hierarchy
ORDER BY level, last_name;

WITH RECURSIVE employee_hierarchy AS (
    SELECT ID AS employee_id, last_name, manager_id, 1 AS level
    FROM employees
    WHERE last_name = 'Kochhar'
    UNION ALL
    SELECT e.ID, e.last_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
    WHERE e.last_name != 'Higgins'
)
SELECT last_name
FROM employee_hierarchy
ORDER BY level, last_name;

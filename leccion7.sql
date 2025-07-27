-- Lección 7.1: Unión Igualitaria y Producto Cartesiano 
SELECT e.last_name, e.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.last_name, e.job_id, j.job_title
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
AND e.department_id = 80;

SELECT e.last_name, d.department_name
FROM employees e, departments d;

SELECT e.last_name, e.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.department_id = 80;

SELECT e.last_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-- Lección 7.2: Uniones No Igualitarias y Uniones Externas

SELECT e.last_name, e.salary, jg.grade_level, jg.lowest_sal,
jg.highest_sal
FROM employees e, job_grades jg
WHERE e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e RIGHT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

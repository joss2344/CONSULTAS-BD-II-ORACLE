-- Lección 3.1: Comparaciones Lógicas y Reglas de Prioridad

-- Operador AND: department_id > 50 AND salary > 12000
SELECT last_name, department_id, salary
FROM employees
WHERE department_id > 50 AND salary > 12000;

-- Operador AND: hire_date > '01-Jan-1998' AND job_id LIKE 'SA%'
-- Nota: PostgreSQL requiere formato de fecha 'YYYY-MM-DD' para literales de fecha sin CAST explícito.
SELECT last_name, hire_date, job_id
FROM employees
WHERE hire_date > '1998-01-01' AND job_id LIKE 'SA%';

-- Operador OR: location_id = 2500 OR manager_id=124
SELECT department_name, manager_id, location_id
FROM departments
WHERE location_id = 2500 OR manager_id=124;

-- Operador NOT: location_id NOT IN (1700,1800)
SELECT department_name, location_id
FROM departments
WHERE location_id NOT IN (1700,1800);

-- Reglas de Prioridad: AND antes que OR
SELECT last_name||' '||salary*1.05 AS "Employee Raise", department_id, first_name
FROM employees
WHERE department_id IN(50,80) AND first_name LIKE 'C%'
OR last_name LIKE '%s%';

-- Reglas de Prioridad: OR antes que AND (ejemplo con orden invertido)
SELECT last_name||' '||salary*1.05 AS "Employee Raise",
department_id,
first_name
FROM employees
WHERE department_id IN(50,80)
OR first_name LIKE 'C%'
AND last_name LIKE '%s%';

-- Reglas de Prioridad: Uso de paréntesis para forzar el orden (OR antes que AND)
SELECT last_name||' '||salary*1.05 AS "Employee Raise",
department_id,
first_name
FROM employees
WHERE (department_id IN(50,80) OR first_name LIKE 'C%')
AND last_name LIKE '%s%';


-- Lección 3.2: Ordenación de Filas

-- Ordena los empleados por hire_date en orden ascendente (por defecto)
SELECT last_name, hire_date
FROM employees
ORDER BY hire_date;

-- Ordena los empleados por hire_date en orden descendente
SELECT last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

-- Ordena los empleados por un alias de columna ("Date Started")
SELECT last_name, hire_date AS "Date Started"
FROM employees
ORDER BY "Date Started";

-- Ordena los empleados por last_name, aunque last_name no está en SELECT
SELECT ID, first_name
FROM employees
WHERE ID < 105
ORDER BY last_name;

-- Ordena los empleados por department_id (ascendente) y luego por last_name (ascendente)
SELECT department_id, last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id,
last_name;

-- Ordena los empleados por department_id (descendente) y luego por last_name (ascendente)
SELECT department_id,
last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id DESC,
last_name;
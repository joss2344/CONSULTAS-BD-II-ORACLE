
-- Lección 2.1: Columnas, Caracteres y Filas
-- Muestra la estructura de la tabla DEPARTMENTS.
-- Nota: DESCRIBE (o DESC) es un meta-comando de psql, no SQL estándar.
-- DESCRIBE departments;

-- Concatena el ID del departamento y el nombre del departamento.
SELECT department_id || department_name
FROM departments;

-- Concatena el ID del departamento, un espacio y el nombre del departamento.
SELECT department_id ||' '||department_name
FROM departments;

-- Concatena el ID del departamento, un espacio y el nombre del departamento,
-- usando un alias de columna para la salida.
SELECT department_id ||' '||
department_name AS " Department Info "
FROM departments;

-- Concatena el nombre y apellido del empleado, usando un alias de columna.
SELECT first_name ||' '||
last_name AS "Employee Name"
FROM employees;

-- Concatena el apellido del empleado con literales para formar una frase sobre el salario mensual.
SELECT last_name || ' has a monthly
salary of ' || salary || '
dollars.' AS Pay
FROM employees;

-- Concatena el apellido del empleado con literales y un cálculo para formar una frase sobre el salario anual.
SELECT last_name ||' has a '|| 1 ||' year salary of '||
salary*12 || ' dollars.' AS Pay
FROM employees;

-- Selecciona todos los IDs de departamento, incluyendo duplicados.
SELECT department_id
FROM employees;

-- Selecciona IDs de departamento únicos (elimina duplicados).
SELECT DISTINCT department_id
FROM employees;


-- Lección 2.2: Limitación de Filas Seleccionadas
-- Consulta para mostrar todos los empleados (contexto para WHERE)
SELECT ID, first_name, last_name
FROM employees;

-- Limita las filas donde el ID del empleado es 101
SELECT ID, first_name, last_name
FROM employees
WHERE ID = 101;

-- Limita las filas donde el department_id es 90
SELECT ID, last_name, department_id
FROM employees
WHERE department_id = 90;

-- Limita las filas donde el last_name es 'Taylor'
-- Nota: las cadenas de caracteres deben ir entre comillas simples y son sensibles a mayúsculas/minúsculas.
SELECT first_name, last_name
FROM employees
WHERE last_name = 'Taylor';

-- Limita las filas donde el salary es menor o igual a 3000
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;


-- Lección 2.3: Operadores de Comparación
-- Selecciona empleados con salario entre 9000 y 11000 (inclusive)
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 9000 AND 11000;

-- Selecciona ubicaciones donde el country_id está en la lista ('UK', 'CA')
SELECT city, state_province, country_id
FROM locations
WHERE country_id IN('UK', 'CA');

-- Selecciona apellidos que tienen una 'o' como segundo carácter
SELECT last_name
FROM employees
WHERE last_name LIKE '_o%';

-- Selecciona job_id que contienen el patrón '_R' usando un carácter de escape '\'
SELECT last_name, job_id
FROM employees
WHERE job_id LIKE '%\_R%' ESCAPE '\';

-- Selecciona job_id que contienen una 'R' en cualquier posición después del segundo carácter
SELECT last_name, job_id
FROM employees
WHERE job_id LIKE '%_R%';

-- Selecciona empleados cuyo manager_id es NULL (ej. el presidente de la compañía)
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

-- Selecciona empleados cuyo commission_pct NO es NULL
SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- Leccion 9.1: Uso de las clausulas GROUP BY y HAVING

-- Cual es el salario promedio de todos los empleados?
SELECT AVG(salary) FROM employees;

-- Cual es el salario promedio en cada departamento especifico?
SELECT AVG(salary) FROM employees WHERE department_id = 10;
SELECT AVG(salary) FROM employees WHERE department_id = 20;
SELECT AVG(salary) FROM employees WHERE department_id = 50;

-- Como obtener el salario promedio por departamento?
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- Cual es el salario maximo por departamento?
SELECT MAX(salary)
FROM employees
GROUP BY department_id;

-- Mostrando el departamento junto con el salario maximo
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- Cuantos paises hay en cada region
SELECT COUNT(country_name), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

-- Cuantos paises hay en cada region? (usando COUNT(*))
SELECT COUNT(*), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

-- Cual es el salario maximo por departamento, excluyendo a 'King'?
SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;

-- Cual es la poblacion promedio por region? (redondeada)
SELECT region_id, ROUND(AVG(population)) AS population
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

-- Cuantos idiomas se hablan en cada pais?
SELECT country_id, COUNT(language_id) AS "Number of languages"
FROM wf_spoken_languages
GROUP BY country_id;

-- Como agrupar por mas de una columna? (departamento y puesto)
SELECT department_id, job_id, COUNT(*)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id;

-- Como obtener el promedio de salarios por departamento y luego el maximo de esos promedios?
SELECT MAX(avg_salary)
FROM (
    SELECT AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS department_avg_salaries;

-- Ejemplo de error: no se pueden usar funciones de agregacion en WHERE
-- SELECT department_id, MAX(salary) FROM employees WHERE COUNT(*) > 1 GROUP BY department_id;
-- ERROR: aggregate functions are not allowed in WHERE clause

-- Como filtrar grupos con mas de un empleado
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1
ORDER BY department_id;
ORDER BY department_id;
lacion media por region con MIN(population) > 300000
-- Como mostrar la poblacion promedio por region, solo si la poblacion minima es mayor a 300,000?
SELECT region_id, ROUND(AVG(population))ion))
FROM wf_countries
GROUP BY region_idGROUP BY region_id
HAVING MIN(population) > 300000
ORDER BY region_id;d;

-- Leccion 9.2: Operaciones ROLLUP, CUBE y GROUPING SETS
o de las Operaciones Rollup y Cube, y Grouping Sets
-- Como obtener subtotales por departamento y puesto usando ROLLUP?
SELECT department_id, job_id, SUM(salary)otales (department_id, job_id)
FROM employeesSELECT department_id, job_id, SUM(salary)
WHERE department_id < 50FROM employees
GROUP BY ROLLUP (department_id, job_id);
GROUP BY ROLLUP (department_id, job_id);
-- Comparacion: agrupando solo por departamento y puesto (sin subtotales)
-- GROUP BY sin ROLLUP para comparacion
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;
GROUP BY department_id, job_id;
-- Como obtener todas las combinaciones posibles de departamento y puesto usando CUBE?
-- CUBE para tabulacion cruzada (department_id, job_id)
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE (department_id, job_id);
GROUP BY CUBE (department_id, job_id);
-- Como agrupar por diferentes combinaciones de columnas en una sola consulta?
SELECT department_id, job_id, manager_id, SUM(salary)nes en una sola consulta
SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
GROUP BY GROUPING SETS
    ((job_id, manager_id), (department_id, job_id), (department_id, manager_id));GROUP BY GROUPING SETS

-- Como identificar las filas que son subtotales usando la funcion GROUPING?
SELECT department_id, job_id, SUM(salary),
       GROUPING(department_id) AS "Dept sub total", identificar filas agregadas (con CUBE)
       GROUPING(job_id) AS "Job sub total"job_id, SUM(salary),
FROM employees
WHERE department_id < 50total"
GROUP BY CUBE (department_id, job_id);FROM employees

-- Leccion 9.3: Operadores SET

-- UNION: muestra todos los valores unicos de ambas tablas
SELECT a_id FROM A: Uso de los Operadores SET
UNION
SELECT b_id FROM B;ambas tablas, eliminando duplicados
SELECT a_id FROM A
-- UNION ALL: muestra todos los valores, incluyendo duplicadosUNION
SELECT a_id FROM A
UNION ALL
SELECT b_id FROM B;icados

-- INTERSECT: muestra solo los valores que estan en ambas tablas ALL
SELECT a_id FROM A
INTERSECT
SELECT b_id FROM B;

-- EXCEPT: muestra los valores que estan en la primera tabla pero no en la segunda
SELECT a_id FROM A
EXCEPT -- Equivalente a MINUS en Oracle
SELECT b_id FROM B; tabla pero no en la segunda

-- Ejemplo: unir empleados y su historial de cargos, igualando tipos de datos Equivalente a MINUS en Oracle
SELECT hire_date, ID AS employee_id, job_id
FROM employees
UNION
SELECT NULL::DATE AS hire_date, employee_id, job_idTE para que coincida el tipo de dato de hire_date
FROM job_history;b_id

-- Como ordenar el resultado de una operacion SET?UNION
SELECT hire_date, ID AS employee_id, job_id
FROM employees
UNION
SELECT NULL::DATE AS hire_date, employee_id, job_id Operaciones SET (solo al final de la ultima sentencia SELECT)
FROM job_historyT hire_date, ID AS employee_id, job_id
ORDER BY employee_id;

-- Ejemplo con mas columnas: empleados y su historial, mostrando fechas y departamentoSELECT NULL::DATE AS hire_date, employee_id, job_id
SELECT hire_date, ID AS employee_id, NULL::DATE AS start_date,
       NULL::DATE AS end_date, job_id, department_id

-- ORDER BY con mas columnas coincidentes (añadiendo start_date, end_date, department_id)
SELECT NULL::DATE AS hire_date, employee_id, start_date, end_date,start_date,
       job_id, department_idE AS end_date, job_id, department_id
FROM job_history
ORDER BY employee_id;UNION

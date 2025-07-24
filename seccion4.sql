-- Lección 4.1: Manipulación de Mayúsculas/Minúsculas y de Caracteres

-- Ejecuta una sentencia SELECT con un cálculo usando DUAL.
SELECT (319/29) + 12
FROM DUAL;

-- Convierte caracteres alfabéticos a minúscula.
SELECT last_name
FROM employees
WHERE LOWER(last_name) = 'abel';

-- Convierte caracteres alfabéticos a mayúscula.
SELECT last_name
FROM employees
WHERE UPPER(last_name) = 'ABEL';

-- Convierte la primera letra de cada palabra a mayúscula.
SELECT last_name
FROM employees
WHERE INITCAP(last_name) = 'Abel';

-- CONCAT: Une dos valores.
SELECT CONCAT('Hello', 'World')
FROM DUAL;

SELECT CONCAT(first_name, last_name)
FROM employees;

-- SUBSTR: Extrae una subcadena.
SELECT SUBSTR('HelloWorld',1,5)
FROM DUAL;

SELECT SUBSTR('HelloWorld', 6)
FROM DUAL;

SELECT SUBSTR(last_name,1,3)
FROM employees;

-- LENGTH: Muestra la longitud de una cadena.
SELECT LENGTH('HelloWorld')
FROM DUAL;

SELECT LENGTH(last_name)
FROM employees;

-- INSTR (STRPOS en PostgreSQL): Encuentra la posición numérica de los caracteres especificados.
SELECT STRPOS('HelloWorld', 'W')
FROM DUAL;

SELECT last_name, STRPOS(last_name, 'a')
FROM employees;

-- LPAD: Rellena la parte izquierda de una cadena.
SELECT LPAD('HelloWorld',15, '-')
FROM DUAL;

SELECT LPAD(last_name, 10,'*')
FROM employees;

-- RPAD: Rellena la parte derecha de una cadena.
SELECT RPAD('HelloWorld',15, '-')
FROM DUAL;

SELECT RPAD(last_name, 10,'*')
FROM employees;

-- TRIM: Elimina caracteres especificados del principio, final o ambos.
SELECT TRIM(LEADING 'a' FROM 'abcba')
FROM DUAL;

SELECT TRIM(TRAILING 'a' FROM 'abcba')
FROM DUAL;

SELECT TRIM(BOTH 'a' FROM 'abcba')
FROM DUAL;

-- REPLACE: Sustituye una secuencia de caracteres por otra.
SELECT REPLACE('JACK and JUE','J','BL')
FROM DUAL;

-- REPLACE con dos argumentos (elimina la subcadena en PostgreSQL).
SELECT REPLACE('JACK and JUE','J','') -- En Oracle, REPLACE('JACK and JUE','J') eliminaría 'J'.
FROM DUAL;

SELECT REPLACE(last_name,'a','*')
FROM employees;

-- Uso de Alias de Columna con Funciones.
SELECT LOWER(last_name)||
LOWER(SUBSTR(first_name,1,1))
AS "User Name"
FROM employees;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id= 10; -- Originalmente :enter_dept_id

SELECT *
FROM employees
WHERE last_name = 'King'; -- Originalmente :l_name


-- Lección 4.2: Funciones Numéricas
-- MOD: Encuentra el resto de una división.
SELECT country_name, MOD(airports,2)
AS "Mod Demo"
FROM wf_countries;

-- ROUND (para números): Redondea números a un número especificado de posiciones decimales.
-- Ejemplos de uso (puedes probar con valores literales o columnas numéricas):
SELECT ROUND(45.926), ROUND(45.926, 0), ROUND(45.926, 2), ROUND(45.926, -1) FROM DUAL;

-- TRUNC (para números): Trunca un número a un número especificado de posiciones decimales.
-- Ejemplos de uso:
SELECT TRUNC(45.926, 2), TRUNC(45.926, 0), TRUNC(45.926) FROM DUAL;


-- Lección 4.3: Funciones de Fecha
-- SYSDATE (NOW() en PostgreSQL): Devuelve la fecha y hora actuales del servidor.
SELECT NOW() AS SYSDATE_PG
FROM DUAL;

-- Suma días a una fecha.
SELECT last_name, hire_date + INTERVAL '60 days' AS hire_date_plus_60
FROM employees;

-- Muestra el número de semanas desde que se contrató al empleado.
-- (SYSDATE - hire_date)/7 en Oracle. En PostgreSQL, se puede usar EXTRACT o AGE.
SELECT last_name, EXTRACT(EPOCH FROM (NOW() - hire_date)) / (7 * 24 * 60 * 60) AS weeks_since_hire
FROM employees;

-- Busca el número de días que el empleado mantuvo un trabajo, luego lo divide entre 365 para mostrar en años.
-- Requiere la tabla job_history.
SELECT employee_id, (end_date - start_date) / 365.0 AS "Tenure in last job"
FROM job_history;

-- MONTHS_BETWEEN: Número de meses entre dos fechas.
-- Equivalente en PostgreSQL: cálculo basado en AGE().
SELECT last_name, hire_date
FROM employees
WHERE (EXTRACT(YEAR FROM AGE(NOW(), hire_date)) * 12 + EXTRACT(MONTH FROM AGE(NOW(), hire_date))) > 240;

-- ADD_MONTHS: Agrega meses de calendario a una fecha.
SELECT (NOW() + INTERVAL '12 months')::date AS "Next Year"
FROM DUAL;

SELECT (NOW() + ((5 - EXTRACT(DOW FROM NOW()) + 7) % 7) * INTERVAL '1 day')::date AS "Next Friday"
FROM dual;

-- LAST_DAY: Último día del mes.
SELECT (date_trunc('month', NOW()) + INTERVAL '1 month' - INTERVAL '1 day')::date AS "End of the Month"
FROM DUAL;

-- ROUND (para fechas): Redondea fecha a la unidad especificada.
SELECT hire_date,
       CASE
           WHEN EXTRACT(DAY FROM hire_date) >= 16 THEN (date_trunc('month', hire_date) + INTERVAL '1 month')::date
           ELSE date_trunc('month', hire_date)::date
       END AS "Rounded to Month"
FROM employees
WHERE department_id = 50;

SELECT hire_date,
       CASE
           WHEN EXTRACT(MONTH FROM hire_date) >= 7 THEN (date_trunc('year', hire_date) + INTERVAL '1 year')::date
           ELSE date_trunc('year', hire_date)::date
       END AS "Rounded to Year"
FROM employees
WHERE department_id = 50;

-- TRUNC (para fechas): Trunca una fecha a la unidad especificada.
SELECT hire_date,
       date_trunc('month', hire_date)::date AS "Truncated to Month",
       date_trunc('year', hire_date)::date AS "Truncated to Year"
FROM employees
WHERE department_id = 50;

-- Consulta con varias funciones de fecha combinadas.
SELECT ID AS employee_id, hire_date,
       (EXTRACT(YEAR FROM AGE(NOW(), hire_date)) * 12 + EXTRACT(MONTH FROM AGE(NOW(), hire_date))) AS TENURE,
       (hire_date + INTERVAL '6 months')::date AS REVIEW,
       (hire_date + ((5 - EXTRACT(DOW FROM hire_date) + 7) % 7) * INTERVAL '1 day')::date AS "Next Friday Hire", -- Usando 'FRIDAY' (5)
       (date_trunc('month', hire_date) + INTERVAL '1 month' - INTERVAL '1 day')::date AS "Last Day of Hire Month"
FROM employees
WHERE (EXTRACT(YEAR FROM AGE(NOW(), hire_date)) * 12 + EXTRACT(MONTH FROM AGE(NOW(), hire_date))) > 36;

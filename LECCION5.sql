SELECT TO_CHAR(hire_date, 'Month dd, YYYY')
FROM employees;
SELECT TO_CHAR(hire_date, 'fmMonth dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth ddth, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay ddthsp Mon, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay, ddthsp "of" Month, Year')
FROM employees;

SELECT TO_CHAR(NOW(), 'hh:mm')
FROM dual;

SELECT TO_CHAR(NOW(), 'hh:mm pm')
FROM dual;

SELECT TO_CHAR(NOW(), 'hh:mm:ss pm')
FROM dual;

SELECT TO_CHAR(salary, '$99,999') AS "Salary"
FROM employees;

SELECT TO_NUMBER('5,320', '9,999') AS "Number"
FROM dual;

-- SELECT last_name, TO_NUMBER(bonus, '9999') AS "Bonus"
-- FROM employees
-- WHERE department_id = 80;

SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY') AS "Convert"
FROM DUAL;

SELECT TO_DATE('Sep 07, 1965', 'fxMon dd, YYYY') AS "Date"
FROM dual;

SELECT TO_DATE('July312004', 'fxMonthDDYYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('June 19, 1990','fxMonth dd, YYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('27-Oct-95','DD-Mon-YY') AS "Date"
FROM dual;

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');

SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'FRIDAY'), 'fmDay, Month ddth, YYYY') AS "Next Evaluation"
FROM employees
WHERE employee_id = 100;

SELECT TO_CHAR((e.hire_date + INTERVAL '6 months')::date + INTERVAL '1 day' * ((5 - EXTRACT(DOW FROM (e.hire_date + INTERVAL '6 months')) + 7) % 7), 'FMDay, FMMonth DD, YYYY') AS "Next Evaluation"
FROM employees e
WHERE e.ID = 100;

-- SELECT country_name, NVL(internet_extension, 'None') AS "Internet extn"
-- FROM wf_countries
-- WHERE location = 'Southern Africa'
-- ORDER BY internet_extension DESC;
-- NVL en Oracle es COALESCE en PostgreSQL

SELECT country_name, COALESCE(internet_extension, 'None') AS "Internet extn"
FROM wf_countries
WHERE location = 'Southern Africa'
ORDER BY internet_extension DESC NULLS LAST;

SELECT last_name, NVL(commission_pct, 0)
FROM employees
WHERE department_id IN(80,90);

SELECT NVL(date_of_independence, 'No date')
FROM wf_countries;

SELECT country_name,COALESCE(internet_extension, 'None') AS "Internet extn"
FROM wf_countries
WHERE location = 'Southern Africa'
ORDER BY internet_extension DESC NULLS LAST;

SELECT COALESCE(TO_CHAR(date_of_independence, 'YYYY-MM-DD'), 'No date') AS "Date of Independence"
FROM wf_countries;


SELECT last_name, 
CASE department_id WHEN 90 
THEN 'Management' WHEN 80 
THEN 'Sales' WHEN 60 
THEN 'It' 
ELSE 'Other dept.' 
END AS "Department" 
FROM employees;

SELECT last_name, 
CASE department_id 
WHEN 90 THEN 'Management' 
WHEN 80 THEN 'Sales' 
WHEN 60 THEN 'It' 
ELSE 'Other dept.' 
END AS "Department" 
FROM employees;

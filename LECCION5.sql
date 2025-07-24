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

SELECT TO_CHAR(salary,
'$99,999') AS "Salary"
FROM employees;

SELECT TO_NUMBER('5,320', '9,999')
AS "Number"
FROM dual;

-- SELECT last_name, TO_NUMBER(bonus,
-- '9999')
-- AS "Bonus"
-- FROM employees
-- WHERE department_id = 80;


SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY')
AS "Convert"
FROM DUAL;


SELECT TO_DATE('Sep 07, 1965', 'fxMon dd, YYYY') AS "Date"
FROM dual;

SELECT TO_DATE('July312004', 'fxMonthDDYYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('June 19, 1990','fxMonth dd, YYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('27-Oct-95','DD-Mon-YY')
AS "Date"
FROM dual;

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');

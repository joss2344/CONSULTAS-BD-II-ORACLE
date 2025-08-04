-- Lección 17.1: Control del Acceso de los Usuarios

-- CREATE USER scott IDENTIFIED BY ur35scott;
-- CREATE USER scott_king IDENTIFIED BY password_sk;
-- CREATE USER jennifer_cho IDENTIFIED BY password_jc;
-- CREATE USER jason_tsang IDENTIFIED BY password_jt;
-- ALTER USER scott IDENTIFIED BY imscott35;

-- GRANT CONNECT, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO scott;
-- GRANT CREATE ON DATABASE your_database_name TO scott;
-- GRANT CREATE ON SCHEMA public TO scott;
-- GRANT USAGE ON SCHEMA public TO scott;

-- GRANT SELECT ON clients TO PUBLIC;
-- GRANT UPDATE(first_name, last_name) ON clients TO jennifer_cho;
-- GRANT UPDATE(first_name, last_name) ON clients TO manager;

-- SELECT * FROM scott_king.clients;

-- CREATE SYNONYM clients_syn FOR scott_king.clients;
-- SELECT * FROM clients_syn;

-- GRANT SELECT, INSERT ON clients TO scott_king WITH GRANT OPTION;
-- GRANT SELECT ON jason_tsang.clients TO PUBLIC;

SELECT rolname, rolsuper, rolcreaterole, rolcreatedb, rolcanlogin
FROM pg_roles
WHERE rolname = CURRENT_USER;

SELECT grantor, grantee, table_schema, table_name, privilege_type, is_grantable
FROM information_schema.role_table_grants
WHERE grantor = CURRENT_USER;

SELECT grantor, grantee, table_schema, table_name, privilege_type, is_grantable
FROM information_schema.role_table_grants
WHERE grantee = CURRENT_USER;

SELECT grantor, grantee, table_schema, table_name, column_name, privilege_type, is_grantable
FROM information_schema.column_privileges
WHERE grantor = CURRENT_USER;

SELECT grantor, grantee, table_schema, table_name, column_name, privilege_type, is_grantable
FROM information_schema.column_privileges
WHERE grantee = CURRENT_USER;

-- Lección 17.2: Creación y Revocación de Privilegios de Objeto

-- CREATE ROLE manager;
-- GRANT CREATE TABLE, CREATE VIEW TO manager;
-- GRANT manager TO jennifer_cho;
-- REVOKE SELECT, INSERT ON clients FROM scott_king;
-- REVOKE REFERENCES ON your_table FROM your_user CASCADE CONSTRAINTS;

-- Lección 17.3: Expresiones Regulares

SELECT first_name, last_name
FROM employees
WHERE first_name ~ '^Ste(v|ph)en$';

SELECT last_name, REGEXP_REPLACE(last_name, '^H(a|e|i|o|u)', '**') AS "Name changed"
FROM employees;

SELECT country_name, REGEXP_COUNT(country_name, '(ab)') AS "Count of 'ab'"
FROM wf_countries
WHERE REGEXP_COUNT(country_name, '(ab)') > 0;

ALTER TABLE employees
ADD CONSTRAINT email_addr_chk
CHECK(email ~ '@');

CREATE TABLE my_contacts (
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    email VARCHAR(30) CHECK(email ~ '.+@.+\..+')
);

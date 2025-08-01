-- ejemplo 1: create table basica (sin restricciones)
create table clients (
    client_number numeric(4),
    first_name varchar(14),
    last_name varchar(13)
);

-- ejemplo 2: create table con primary key en linea
drop table if exists clients;
create table clients (
    client_number numeric(4) constraint clients_client_num_pk primary key,
    first_name varchar(14),
    last_name varchar(13)
);

-- ejemplo 3: create table con primary key en linea (repetido)
drop table if exists clients;
create table clients (
    client_number numeric(4) constraint clients_client_num_pk primary key,
    first_name varchar(14),
    last_name varchar(13)
);

-- ejemplo 4: create table con primary key, not null y unique en linea
drop table if exists clients;
create table clients (
    client_number numeric(4) constraint clients_client_num_pk primary key,
    last_name varchar(13) constraint clients_last_name_nn not null,
    email varchar(80) constraint clients_email_uk unique
);

-- ejemplo 5: create table con primary key y not null (sin nombre de restriccion para not null)
drop table if exists clients;
create table clients (
    client_number numeric(4) constraint clients_client_num_pk primary key,
    last_name varchar(13) not null,
    email varchar(80)
);

-- ejemplo 6: create table con primary key y not null (repetido)
drop table if exists clients;
create table clients (
    client_number numeric(4) constraint clients_client_num_pk primary key,
    last_name varchar(13) not null,
    email varchar(80)
);

-- ejemplo 7: create table con unique en multiples columnas (en linea y fuera de linea)
drop table if exists clients;
create table clients (
    client_number numeric(6),
    first_name varchar(20),
    last_name varchar(20),
    phone varchar(20),
    email varchar(10) not null,
    constraint clients_phone_email_uk unique (email, phone)
);

-- ejemplo 8: create table con primary key y unique en multiples columnas (fuera de linea)
drop table if exists clients;
create table clients (
    client_number numeric(6),
    first_name varchar(20),
    last_name varchar(20),
    phone varchar(20),
    email varchar(10) not null,
    constraint clients_client_num_pk primary key (client_number),
    constraint phone_email_uk unique (email, phone),
    constraint email_unique_constraint unique (email)
);

-- ejemplo 9: create table con primary key fuera de linea
drop table if exists clients;
create table clients (
    client_number numeric(4),
    first_name varchar(14),
    last_name varchar(13),
    constraint clients_client_num_pk primary key (client_number)
);

-- ejemplo 10: create table con primary key fuera de linea (repetido)
drop table if exists clients;
create table clients (
    client_number numeric(4),
    first_name varchar(14),
    last_name varchar(13),
    constraint clients_client_num_pk primary key (client_number)
);

-- ejemplo de create table copy_job_history con primary key
create table copy_job_history (
    employee_id numeric(6,0),
    start_date date,
    job_id varchar(10),
    department_id numeric(4,0),
    constraint copy_jhist_id_st_date_pk primary key (employee_id, start_date)
);

-- ejemplo de create table copy_employees con primary key y foreign key en linea
create table copy_employees (
    employee_id numeric(6,0) constraint copy_emp_pk primary key,
    first_name varchar(20),
    last_name varchar(25),
    department_id numeric(4,0) constraint c_emps_dept_id_fk references departments(department_id),
    email varchar(25)
);

-- ejemplo de create table copy_employees (repetido)
drop table if exists copy_employees;
create table copy_employees (
    employee_id numeric(6,0) constraint copy_emp_pk primary key,
    first_name varchar(20),
    last_name varchar(25),
    department_id numeric(4,0) constraint c_emps_dept_id_fk references departments(department_id),
    email varchar(25)
);

-- ejemplo de create table copy_employees con foreign key fuera de linea
drop table if exists copy_employees;
create table copy_employees (
    employee_id numeric(6,0) constraint copy_emp_pk primary key,
    first_name varchar(20),
    last_name varchar(25),
    department_id numeric(4,0),
    email varchar(25),
    constraint c_emps_dept_id_fk foreign key (department_id) references departments(department_id)
);

-- ejemplo de create table copy_employees con foreign key y on delete cascade
drop table if exists copy_employees;
create table copy_employees (
    employee_id numeric(6,0) constraint copy_emp_pk primary key,
    first_name varchar(20),
    last_name varchar(25),
    department_id numeric(4,0),
    email varchar(25),
    constraint cdept_dept_id_fk foreign key (department_id) references copy_departments(department_id) on delete cascade
);

-- ejemplo de create table copy_job_history con primary key y check
drop table if exists copy_job_history;
create table copy_job_history (
    employee_id numeric(6,0),
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id numeric(4,0),
    constraint cjhist_emp_id_st_date_pk primary key (employee_id, start_date),
    constraint cjhist_end_ck check (end_date > start_date)
);

-- ejemplo de alter table add constraint foreign key
alter table employees
add constraint emp_dept_fk foreign key (department_id)
references departments (department_id) on delete cascade;

-- ejemplo de alter table alter column set not null
alter table clients alter column last_name set not null;

-- ejemplo de alter table alter column set not null
alter table employees alter column email set not null;

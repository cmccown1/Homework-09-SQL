 
 --------------------------------
 -- THIS IS THE SCHEMA SECTION  -
 --------------------------------

 -- need to add SERIAL to "id" columns; the ERD tool didn't like SERIAL
 -- need to add CASCADE to DROP statements to keep from potentially violating key constraints as you drop tables

DROP TABLE IF EXISTS "departments" CASCADE;
DROP TABLE IF EXISTS "dept_emp" CASCADE;
DROP TABLE IF EXISTS "dept_manager" CASCADE;
DROP TABLE IF EXISTS "employees" CASCADE;
DROP TABLE IF EXISTS "salaries" CASCADE;
DROP TABLE IF EXISTS "titles" CASCADE;

CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "id" serial  NOT NULL,
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "id" serial   NOT NULL,
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


 --------------------------------
 -- THIS IS THE IMPORT SECTION  -
 --------------------------------

 -- populate tables from csv
 
 -- I had to move the table to a C:\Temp\data folder to overcome what were probably permission issues
 -- I wanted to figure out how to import tables without relying on the GUI import tool

COPY departments(dept_no,dept_name)
FROM 'C:\Temp\data\departments.csv' DELIMITER ',' CSV HEADER;

-- I had to manage the order of the import to keep from violating key constraints!
-- I'd started to import in alpha order, but dept_emp needed employees to be populated first.
COPY employees(emp_no,birth_date,first_name,last_name,gender,hire_date) 
FROM 'C:\Temp\data\employees.csv' DELIMITER ',' CSV HEADER;

COPY dept_emp(emp_no,dept_no,from_date,to_date) 
FROM 'C:\Temp\data\dept_emp.csv' DELIMITER ',' CSV HEADER;

COPY dept_manager(dept_no,emp_no,from_date,to_date) 
FROM 'C:\Temp\data\dept_manager.csv' DELIMITER ',' CSV HEADER;

COPY salaries(emp_no,salary,from_date,to_date) 
FROM 'C:\Temp\data\salaries.csv' DELIMITER ',' CSV HEADER;

COPY titles(emp_no,title,from_date,to_date) 
FROM 'C:\Temp\data\titles.csv' DELIMITER ',' CSV HEADER;
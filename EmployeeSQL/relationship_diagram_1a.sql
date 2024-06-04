employees
--
emp_no int pk 
emp_title_id string fk >- titles.title_id
birth_date date
first_name varchar(50)
last_name varchar(50)
sex varchar(2)
hire_date date

departments
--
dept_no string pk FK >- dept_manager.dept_no
dept_name varchar(50)

dept_emp
--
emp_no int pk FK >- employees.emp_no
dept_no string FK >- departments.dept_no

dept_manager
--
dept_no string pk
emp_no int FK - employees.emp_no

salaries
--
emp_no int pk FK - employees.emp_no
salary int

titles
--
title_id string pk
title varchar(50)


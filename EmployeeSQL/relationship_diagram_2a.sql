employees
--
emp_no INT PK
emp_title_id VARCHAR(10) FK >- titles.title_id
birth_date DATE
first_name VARCHAR(50)
last_name VARCHAR(50)
sex CHAR(1)
hire_date DATE

titles
--
title_id VARCHAR(10) PK
title VARCHAR(50)

salaries
--
emp_no INT PK FK >- employees.emp_no
salary INT

departments
--
dept_no VARCHAR(10) PK
dept_name VARCHAR(50)

dept_manager
--
dept_no VARCHAR(10) PK FK >- departments.dept_no
emp_no INT PK FK >- employees.emp_no

dept_emp
--
emp_no INT PK FK >- employees.emp_no
dept_no VARCHAR(10) PK FK >- departments.dept_no


DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;


CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

CREATE TABLE departments (
    dept_no VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


CREATE TABLE salaries (
    emp_no INT,
    salary INT NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


CREATE TABLE dept_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);




-- ##########################################################################################
-- # 1.) List the employee number, last name, first name, sex, and salary of each employee. #
-- ##########################################################################################
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
LEFT JOIN salaries AS s ON (e.emp_no = s.emp_no);

-- ###############################################################################################
-- # 2.) List the first name, last name, and hire date for the employees who were hired in 1986. #
-- ###############################################################################################
SELECT e.first_name, e.last_name, e.hire_date
FROM employees AS e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986;

-- #######################################################################################
-- # 3.) List the manager of each department along with their                            #
-- #     department number, department name, employee number, last name, and first name. #
-- #######################################################################################
SELECT dm.dept_no, dp.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
LEFT JOIN departments AS dp ON (dm.dept_no = dp.dept_no)
LEFT JOIN employees AS e ON (dm.emp_no = e.emp_no);

-- ###############################################################################
-- # 4.) List the department number for each employee along with that employee’s #
-- #     employee number, last name, first name, and department name.            #
-- ###############################################################################
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS de
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no);

-- ############################################################
-- # 5.) List first name, last name, and sex of each employee #
-- #     whose first name is Hercules                         #
-- #     and whose last name begins with the letter B.        #
-- ############################################################
SELECT e.first_name, e.last_name, e.sex
FROM employees AS e
WHERE (e.first_name = 'Hercules') AND (e.last_name LIKE 'B%');

-- ###################################################################
-- # 6.) List each employee in the Sales department,                 #
-- #     including their employee number, last name, and first name. #
-- ###################################################################
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Sales'
	LIMIT 1
);

-- ####################################################################################
-- # 7.) List each employee in the Sales and Development departments,                 #
-- #     including their employee number, last name, first name, and department name. #
-- ####################################################################################
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no IN (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name in ('Sales','Development')
);

-- ######################################################################################
-- # 8.) List the frequency counts, in descending order, of all the employee last names #
-- #     (that is, how many employees share each last name).                            #
-- ######################################################################################
SELECT e.last_name, COUNT(*) AS total_count
FROM employees AS e
GROUP BY e.last_name
ORDER BY total_count DESC;

	







-- NOTES



SELECT DISTINCT e.last_name
FROM employees AS e
ORDER BY e.last_name DESC;

SELECT COUNT(*) AS total_count
FROM employees AS e
WHERE e.last_name ='Sadowsky';




-- NOTES


--
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = 'd007';
-- 52245
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = 'd005';
-- 85707
--
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Sales'
	LIMIT 1
);
-- 52245
--
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Development'
	LIMIT 1
);
-- 85707
--
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Sales'
	LIMIT 1
)
UNION
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Development'
	LIMIT 1
);
-- 52245
-- 85707
--
--
SELECT COUNT(*) AS total_count
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no IN (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name in ('Sales','Development')
);
-- 137952
--
--
--
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no IN (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name in ('Sales','Development')
);
--
--
--
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Sales'
	LIMIT 1
)
UNION
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS de
LEFT JOIN employees AS e ON (de.emp_no = e.emp_no)
LEFT JOIN departments AS dp ON (de.dept_no = dp.dept_no)
WHERE de.dept_no = (
	SELECT dp.dept_no
	FROM departments AS dp	
	WHERE dp.dept_name = 'Development'
	LIMIT 1
);
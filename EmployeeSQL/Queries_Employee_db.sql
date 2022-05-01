-- ### Data Analysis

-- Once you have a complete database, perform these steps:

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT  e.emp_no,
        e.last_name,
        e.first_name,
        e.sex,
        s.salary
FROM employees as e
    LEFT JOIN saleries as s
    ON (e.emp_no = s.emp_no)
ORDER BY e.last_name;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name,hire_date 
FROM employees
WHERE hire_date 
BETWEEN '1986-01-01' 
AND '1986-12-31'
ORDER BY last_name;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT	dm.dept_no,
		d.dept_name,
		dm.emp_no,
		e.last_name,
		e.first_name
FROM	dept_manager AS dm
	INNER JOIN departments AS d
	ON (dm.dept_no = d.dept_no)
	INNER JOIN employees AS e
	ON (dm.emp_no = e.emp_no)
ORDER BY d.dept_name;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_NO)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
ORDER BY e.last_name;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT	First_name,
		last_name,
		sex
FROM employees
WHERE first_name ='Hercules'
AND last_name LIKE 'B%'
ORDER BY last_name;

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT	e.emp_no,
		e.last_name,
		e.first_name,
		d.dept_name
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY e.last_name;

-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.

SELECT last_name,
COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name)
DESC;


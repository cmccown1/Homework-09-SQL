-- 1 List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s
	ON e.emp_no = s.emp_no
ORDER BY s.salary DESC;
	
-- 2 List employees who were hired in 1986.
SELECT *
FROM employees
WHERE DATE_PART('year',hire_date)=1986
ORDER BY hire_date;

-- 3 List the manager of each department with the following information: department number, 
-- department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no,d.dept_name,dm.emp_no,e.last_name,e.first_name,dm.from_date,dm.to_date
FROM dept_manager AS dm
	JOIN departments AS d ON dm.dept_no = d.dept_no
	JOIN employees AS e ON dm.emp_no = e.emp_no
ORDER BY dm.dept_no,dm.from_date;

-- 4 List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e
	JOIN dept_emp AS de ON e.emp_no = de.emp_no
	JOIN departments AS d ON de.dept_no = d.dept_no
ORDER BY e.last_name,e.first_name

-- 5 List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules'
	AND last_name like 'B%'
	
-- 6 List all employees in the Sales department, including 
-- their employee number, last name, first name, and department name.
SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e
	JOIN dept_emp AS de ON e.emp_no = de.emp_no
	JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name,e.first_name

-- 7 List all employees in the Sales and Development departments, including 
-- their employee number, last name, first name, and department name.
SELECT e.emp_no,e.last_name,e.first_name,d.dept_name
FROM employees AS e
	JOIN dept_emp AS de ON e.emp_no = de.emp_no
	JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name in ('Sales','Development')
ORDER BY d.dept_name,e.last_name,e.first_name

-- 8 In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
SELECT last_name, COUNT(DISTINCT first_name) AS "Count"
FROM employees
GROUP BY last_name
ORDER BY "Count" DESC
-- Every last name is associated with between 133 and 210 employees. Quite the family business!

SELECT *
FROM employees
WHERE last_name = 'Foolsday'
-- April Foolsday. Hmmmm...

--- Bonus
SELECT t.title,ROUND(AVG(s.salary),2)
FROM titles AS t
	JOIN salaries AS s on t.emp_no = s.emp_no
GROUP BY t.title




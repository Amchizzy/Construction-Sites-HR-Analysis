--average monthly salaries
SELECT  pay_month, ROUND(AVG(salary),2) AS average_salary
FROM df_employee
GROUP BY pay_month
ORDER BY pay_month;

SELECT top 10 * FROM df_employee;

--gender distribution monthly and gap trend
SELECT pay_month, gender, COUNT(gender) AS gender_count
FROM df_employee
GROUP BY pay_month, gender
ORDER BY pay_month, gender;

--total salary across the states
SELECT 	ROUND(SUM(salary),0) AS total_salary
FROM df_employee

--salary distribution across the states
SELECT  company_state,
		ROUND(SUM(salary),0) AS total_salary,
		ROUND(AVG(salary),0) AS average_salary,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY company_state
ORDER BY total_salary DESC;

SELECT top 10 * FROM df_employee;

--what is the salary distribution of the total salaries paid across the function groups
SELECT  function_group, 
		ROUND(AVG(salary),2) AS average_salary,
		ROUND(SUM(salary),2) AS total_salary,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY function_group
ORDER BY average_salary DESC;

--what is the salary distribution of the total salaries paid across the states
SELECT  company_state, 
		ROUND(AVG(salary),2) AS average_salary,
		ROUND(SUM(salary),2) AS total_salary,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY company_state
ORDER BY average_salary DESC;


--how standardised is the pay policy per function group across the states
SELECT  company_state, function_group, 
		ROUND(AVG(salary),2) AS average_salary,
		ROUND(MIN(salary),2) AS min_salary,
		ROUND(MAX(salary),2) AS max_salary,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY function_group, company_state 
ORDER BY function_group, company_state;

--salary distribution by function group
SELECT  function_group,
		ROUND(SUM(salary),2) AS total_salary,
		ROUND(SUM(salary) * 100 / SUM(SUM(salary)) OVER (),2) AS salary_percentage,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY function_group
ORDER BY total_salary DESC;

--average salaries by function group
SELECT  function_group, 
	    ROUND(AVG(salary),2) AS average_salary,
		COUNT(id) AS employee_count
FROM df_employee
GROUP BY function_group
ORDER BY average_salary DESC;

--employee distribution by company city
SELECT company_city, 
	   COUNT(employee_id) AS employee_count,
	   COUNT(employee_id) * 100 / SUM(COUNT(employee_id)) OVER () AS percentage
FROM df_employee
WHERE pay_month = (SELECT MAX(pay_month) FROM df_employee)
GROUP BY company_city
ORDER BY employee_count DESC

SELECT top 10 * FROM df_employee;

--checking how many unique construction sites are available
SELECT DISTINCT company_name FROM df_employee;

--checking if a company is working on different construction site categories and the salary distribution
SELECT company_name AS construction_site, 
	   const_site_category, 
	   ROUND(SUM(salary),2) as total_salary,
	   COUNT(id) AS employee_count
FROM df_employee
GROUP BY company_name, const_site_category
ORDER BY total_salary DESC;

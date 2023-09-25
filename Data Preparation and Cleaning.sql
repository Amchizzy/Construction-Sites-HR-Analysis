--creating a temporary table and joining all the tables together
--it has been observed that salaries table is just suitable to be the primary table

SELECT *
INTO empdata_sets
FROM salaries AS s
LEFT JOIN companies AS c
ON c.company_name = s.comp_name
LEFT JOIN employees AS e
ON e.employee_name_emp = s.employee_name
LEFT JOIN functions AS f
ON s.func_code =f.function_code

--observing the new data set
SELECT top 10 * FROM empdata_sets

--selecting the relevant columns into another temp table  as a dataset for further analysis
--creating a primary key for this new table by concatenating the 'date' and 'employee_id' columns
--converting the date column into the date format because it is currently in a datetime format
SELECT CONCAT(employee_id, CAST(date AS date)) AS id,
	CAST(date AS date) as month_year,
	employee_id,
	employee_name,
	age,
	GEN_M_F,
	function_group,
	salary,
	comp_code,
	company_name,
	company_city,
	company_state,
	company_type,
	const_site_category
INTO df_employee
FROM empdata_sets

--renaming the 'GEN_M_F' column to 'gender' to make it more readable
sp_rename 'df_employee.GEN_M_F','gender','COLUMN'

SELECT top 10 * FROM df_employee

--trimming off all unnecessary spaces from all text columns
--Rounding up the salary column to 2 decimal places.
UPDATE df_employee
SET id =TRIM(id),
	employee_name = TRIM(employee_name),
	function_group = TRIM(function_group),
	company_name = TRIM(company_name),
	company_city = TRIM(company_city),
	company_type = TRIM(company_type),
	const_site_category = TRIM(const_site_category),
	salary = ROUND(salary,2)

--checking for null values
SELECT * FROM df_employee
WHERE id IS NULL
	 OR month_year IS NULL
	 OR	employee_id IS NULL
	 OR	employee_name IS NULL
	 OR	age IS NULL
	 OR	gender IS NULL
	 OR	function_group IS NULL
	 OR	salary IS NULL
	 OR	comp_code IS NULL
	 OR	company_name IS NULL
	 OR	company_city IS NULL
	 OR	company_state IS NULL
	 OR	company_type IS NULL
	 OR	const_site_category IS NULL

--checking for empty cells
SELECT * FROM df_employee
WHERE id = ' '
	 OR month_year = ' '
	 OR	employee_id = ' '
	 OR	employee_name = ' '
	 OR	age = ' '
	 OR	gender = ' '
	 OR	function_group = ' '
	 OR	salary = ' '
	 OR	comp_code = ' '
	 OR	company_name = ' '
	 OR	company_city = ' '
	 OR	company_state = ' '
	 OR	company_type = ' '
	 OR	const_site_category = ' '


SELECT top 10 * FROM df_employee

SELECT COUNT (*) AS count_null_id
FROM df_employee
WHERE id IS NULL

SELECT COUNT (*) AS count_null_month_year
FROM df_employee
WHERE month_year IS NULL

SELECT COUNT (*) AS count_null_employee_id
FROM df_employee
WHERE employee_id IS NULL

SELECT COUNT (*) AS count_null_employee_name
FROM df_employee
WHERE employee_name IS NULL

SELECT COUNT (*) AS count_null_age
FROM df_employee
WHERE age IS NULL

SELECT COUNT (*) AS count_null_gender
FROM df_employee
WHERE gender IS NULL

SELECT COUNT (*) AS count_null_function_group
FROM df_employee
WHERE function_group IS NULL

SELECT COUNT (*) AS count_null_function_group
FROM df_employee
WHERE function_group IS NULL

SELECT COUNT (*) AS count_null_salary
FROM df_employee
WHERE salary IS NULL

SELECT COUNT (*) AS count_null_comp_code
FROM df_employee
WHERE comp_code IS NULL

SELECT COUNT (*) AS count_null_company_name
FROM df_employee
WHERE company_name IS NULL

SELECT COUNT (*) AS company_state
FROM df_employee
WHERE company_state IS NULL

SELECT COUNT (*) AS count_null_company_type
FROM df_employee
WHERE company_type IS NULL

SELECT COUNT (*) AS count_null_const_site_category
FROM df_employee
WHERE const_site_category IS NULL

--these are the columns with the null values
SELECT COUNT (*) AS count_null_age
FROM df_employee
WHERE age IS NULL

SELECT COUNT (*) AS count_null_gender
FROM df_employee
WHERE gender IS NULL

SELECT COUNT (*) AS count_null_salary
FROM df_employee
WHERE salary IS NULL

SELECT COUNT (*) AS count_null_const_site_category
FROM df_employee
WHERE const_site_category IS NULL

SELECT top 10 * FROM df_employee

--deleting the rows with null values
DELETE FROM df_employee
WHERE gender IS NULL
OR age IS NULL
OR salary IS NULL
OR const_site_category IS NULL;

--checking how many records are left
SELECT COUNT (*) FROM df_employee;

SELECT top 10 * FROM df_employee;

--adding a pay month column
ALTER TABLE df_employee
ADD pay_month AS CONCAT(LEFT(month_year, 5),RIGHT(month_year,2));

SELECT top 10 * FROM df_employee;

--CORRECTING WRONG SPELLINGS
--changing "F" to "Female" and "M" to "Male" in the gender column
UPDATE df_employee
SET gender = CASE gender 
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE gender
			 END;

--correcting "Construction Sites" to "Construction Site"
UPDATE df_employee
SET company_type = CASE company_type
				WHEN 'Construction Sites' THEN 'Construction Site'
				ELSE company_type
			 END

--correcting 'Commerciall' to 'Commercial'
UPDATE df_employee
SET const_site_category = CASE const_site_category
				WHEN 'Commerciall' THEN 'Commercial'
				ELSE const_site_category
			 END
--correcting 'Goianiaa' to 'Goiania'
UPDATE df_employee
SET company_city = 'Goiania'
WHERE company_city = 'Goianiaa'

--correcting 'GOIAS' to 'Goias'
UPDATE df_employee
SET company_state = 'Goias'
WHERE company_state = 'GOIAS'

--confirming the changes
SELECT DISTINCT company_type
FROM df_employee

SELECT DISTINCT const_site_category
FROM df_employee

SELECT top 10 * FROM df_employee

--checking for duplicate values
SELECT DISTINCT id, COUNT(id) as duplicates
FROM df_employee
GROUP BY id
HAVING COUNT(id) > 1
--there are 175 records  with duplicates

--removing the duplicates
--creating a CTE with the ROWNUMBER WINDOW function
WITH tempcte AS
	(SELECT *, 
		ROW_NUMBER() 
		OVER(
		PARTITION BY id ORDER BY id
		) AS row_num
	FROM df_employee)
DELETE
FROM tempcte
WHERE row_num > 1



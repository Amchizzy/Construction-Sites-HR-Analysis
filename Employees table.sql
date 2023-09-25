--Observing the employees table
SELECT TOP 10 * FROM employees;

--Checking how may records are available
SELECT COUNT(*) AS Record_count FROM employees;
--There are 1156 records

--Checking how many company codes the 1156 employees have
SELECT DISTINCT comp_code_emp FROM employees;
SELECT COUNT(DISTINCT comp_code_emp) AS Code_count FROM employees;
--There are 10 unique company codes

--Checking how many employees are there
SELECT COUNT(DISTINCT employee_code_emp) FROM employees;

--Checking the range of ages 
SELECT DISTINCT age 
FROM employees
ORDER BY age;
--the youngest employee is 18 and the oldest is 42

--Checking the age distribution 
SELECT age, COUNT(*) AS count_of_age
FROM employees
GROUP BY age
ORDER BY age;

--Observing the employees table
SELECT TOP 10 * FROM employees;

--Checking the gender distribution 
SELECT GEN_M_F, COUNT(*) AS count_of_gender
FROM employees
GROUP BY GEN_M_F;
--293 Females and 863 Males
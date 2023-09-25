--Observing the salaries table
SELECT TOP 10 * FROM salaries;

--checking the number of available records
SELECT COUNT(*) FROM salaries;

--checking the average salary per function
SELECT func, ROUND(AVG(salary),2) as Average_salaries
FROM salaries
GROUP BY func
ORDER BY Average_salaries DESC;

--checking the earliest and latest salary data collected
SELECT MAX(date) AS latest FROM salaries;
SELECT MIN(date) AS earliest FROM salaries;

SELECT * from salaries where employee_name = 'Dalton Brooks'
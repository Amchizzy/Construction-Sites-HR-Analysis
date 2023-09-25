

--Observing the functions table
SELECT TOP 10 * FROM functions;

--checking how many records available
SELECT COUNT(DISTINCT function_code) FROM functions;

SELECT COUNT(DISTINCT [function]) FROM functions;

--checking how many functions are available and how they're distributed
SELECT [function], COUNT(*)  AS count_of_age
FROM functions
GROUP BY [function];
--this returned an error because 'function' is a keyword in sql, 
--so I had to use the square brackets

--checking how many function groups are available and how they're distributed
SELECT function_group, COUNT(*)  AS count_of_groups
FROM functions
GROUP BY function_group;

-- Observing the companies table
SELECT TOP 10 * FROM companies;

--Checking how many records are available
SELECT COUNT(*) AS Record_count FROM companies;

--Checking how many cities the 25 companies are scattered across
SELECT DISTINCT company_city FROM companies;
--there are 3 cities: Anapolis, Brasilia and Goiania

--Checking how many states the 25 companies are scattered across
SELECT DISTINCT company_state FROM companies;
--there are 3 states: Distrito Federal, GOIAS and Tocantins

--Checking how many different company types there are 
SELECT DISTINCT company_type FROM companies;
--We can observe that this column needs cleaning with the "construction site" spelt in different ways

SELECT TOP 10 * FROM companies;

--Checking how many different company categories there are 
SELECT DISTINCT const_site_category FROM companies;
--some cleaning to be done in this column as well
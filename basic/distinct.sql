-- Select the company name that have the Québec and their citys are unique

SELECT DISTINCT
company_name,
(city) AS unique_cities
FROM suppliers
WHERE region = 'Québec';
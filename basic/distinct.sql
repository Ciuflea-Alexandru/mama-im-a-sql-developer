SELECT DISTINCT
company_name,
(city) AS unique_cities
FROM suppliers
WHERE region = 'Québec';
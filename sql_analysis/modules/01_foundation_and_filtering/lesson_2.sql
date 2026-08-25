/*
Imagine you are working with the products table in your Northwind database, 
and the marketing team wants a clean inventory report.
*/

SELECT
LOWER(product_name) AS lower_name,
CASE WHEN unit_price > 50.00 THEN 'Premium'
WHEN unit_price BETWEEN 20.00 AND 50.00 THEN 'Mid-Range'
ELSE 'Budget' END AS price_category
FROM products
ORDER BY unit_price DESC;

/*
Now, let's say the HR department wants a report of all employees.
*/

SELECT
first_name || ' ' || last_name AS full_name,
UPPER(title) AS upper_title,
INITCAP(city) AS capitalized_city
FROM employees
ORDER BY last_name ASC;
/*
Create the dimension tables.
*/

DROP TABLE IF EXISTS dim_customers;

CREATE TABLE dim_customers AS
SELECT 
    customer_id,
    company_name,
    contact_name,
    city,
    country
FROM 
    customers;

SELECT * FROM dim_customers LIMIT 5;

DROP TABLE IF EXISTS dim_products;

CREATE TABLE dim_products AS
SELECT 
p.product_id,
p.product_name,
c.category_name,
p.unit_price AS current_unit_price,
p.discontinued
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id;

SELECT * FROM dim_products LIMIT 5;

DROP TABLE IF EXISTS dim_employees;

CREATE TABLE dim_employees AS
SELECT
employee_id,
first_name || ' ' || last_name AS employee_name,
title,
city,
country
FROM employees;

SELECT * FROM dim_employees LIMIT 5;

DROP TABLE IF EXISTS dim_suppliers;

CREATE TABLE dim_suppliers AS
SELECT 
supplier_id,
company_name AS supplier_name,
city,
country
FROM suppliers;

SELECT * FROM dim_suppliers LIMIT 5;

DROP TABLE IF EXISTS dim_shippers;

CREATE TABLE dim_shippers AS
SELECT 
shipper_id,
company_name AS shipper_name
FROM shippers;

SELECT * FROM dim_shippers LIMIT 5;

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date AS
SELECT DISTINCT date_key,
EXTRACT(YEAR FROM date_key) AS year,
EXTRACT(MONTH FROM date_key) AS month,
EXTRACT(QUARTER FROM date_key) AS quarter,
TO_CHAR(date_key, 'Day') AS day_of_week
FROM (
    SELECT order_date AS date_key FROM orders WHERE order_date IS NOT NULL
    UNION
    SELECT required_date AS date_key FROM orders WHERE required_date IS NOT NULL
    UNION
    SELECT shipped_date AS date_key FROM orders WHERE shipped_date IS NOT NULL
) all_dates
ORDER BY date_key;

SELECT * FROM dim_date LIMIT 5;

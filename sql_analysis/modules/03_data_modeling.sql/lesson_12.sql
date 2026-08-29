-- CREATE DATABASE northwind_olap;


-- To populate the database with the Northwind dataset, you can use the following command in your terminal
-- psql -U your_username -d northwind_analytics -f path/to/northwind.sql

/*
Create a fact table for sales data by joining the orders, order_details and products tables. 
The fact_sales table will contain the often used numeric measures and dimension keys.
*/

DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT 
o.order_id,
o.customer_id,
o.employee_id,
od.product_id,
o.ship_via AS shipper_id,
p.supplier_id,
o.order_date AS order_date_key,
o.required_date AS required_date_key,
o.shipped_date AS shipped_date_key,
od.unit_price,
od.quantity,
od.discount,
(od.unit_price * od.quantity) AS line_total
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;

SELECT * FROM fact_sales LIMIT 10;


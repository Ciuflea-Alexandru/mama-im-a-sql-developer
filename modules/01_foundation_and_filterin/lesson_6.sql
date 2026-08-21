/*
The management team at Northwind wants to know how many products belong to each
category name, rather than just looking at a raw category_id number. 
They also want to see the average price of products in each of those categories.
*/

SELECT
c.category_name,
COUNT(p.product_id) AS total_products,
ROUND(AVG(p.unit_price):: numeric, 2) AS average_price
FROM categories c
JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_products DESC;
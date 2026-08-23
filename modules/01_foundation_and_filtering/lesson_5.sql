/*
Management wants a complete list of all product categories in Northwind, paired with their respective products. 
However, they want to ensure that even if a category currently has zero products, it still shows up on the report.
*/

SELECT
category_name,
product_name
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
ORDER BY category_name ASC;
/*
The purchasing department wants to find out which suppliers provide us with the most expensive products, 
but they only want to look at suppliers who offer a solid variety of items.
*/

SELECT
s.company_name,
c.category_name,
COUNT(p.product_id) AS total_products,
MAX(p.unit_price) AS max_unit_price
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY s.company_name, c.category_name
HAVING COUNt(p.product_id) > 2
ORDER BY MAX(p.unit_price) DESC;hmm
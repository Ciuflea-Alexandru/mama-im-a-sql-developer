/*
The sales team wants to see a list of products alongside their human-readable category names, 
but they only want items where there are units currently in stock.
*/

SELECT
p.product_name,
c.category_name,
p.unit_price
FROM products p
INNER JOIN categories c ON  p.category_id = c.category_id
WHERE p.units_in_stock > 0
ORDER BY category_name ASC, product_name ASC;
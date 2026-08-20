/*
Show me product stock levels grouped by their category ID, 
but only categories where the total product count is greater than 5.
*/

SELECT
category_id,
COUNT(*) AS product_count,
ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5
ORDER BY product_count DESC;
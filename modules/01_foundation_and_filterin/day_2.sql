SELECT
LOWER(product_name) AS lower_name,
CASE WHEN unit_price > 50.00 THEN 'Premium'
WHEN unit_price BETWEEN 20.00 AND 50.00 THEN 'Mid-Range'
ELSE 'Budget' END AS price_category
FROM products
ORDER BY unit_price DESC;
-- calculate the average price and the statistical variance of prices for every product category

SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.unit_price)::numeric, 2) AS avg_unit_price,
    ROUND(VARIANCE(p.unit_price)::numeric, 2) AS price_variance
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY price_variance DESC;
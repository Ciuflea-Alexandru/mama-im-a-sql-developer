-- calculate a scaled price

SELECT 
    product_id, 
    unit_price,
    ROUND(POWER(unit_price, 1.1)::numeric, 2) AS Scaled_Price
FROM products
ORDER BY Scaled_Price DESC;
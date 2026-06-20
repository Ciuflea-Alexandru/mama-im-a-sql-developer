-- display the entire result set as a single window.

SELECT 
    product_name, 
    unit_price,
    AVG(unit_price) OVER () AS avg_price_all
FROM products;
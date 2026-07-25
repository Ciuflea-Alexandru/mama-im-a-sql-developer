-- split the products into 4 equal price buckets

SELECT 
    product_name,
    unit_price,
    NTILE(4) OVER (ORDER BY unit_price ASC) AS price_quartile
FROM products;
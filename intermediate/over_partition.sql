-- divide the data into buckets (partitions) and performs calculations independently within those buckets

SELECT 
    category_id,
    product_name,
    unit_price,
    AVG(unit_price) OVER (PARTITION BY category_id) AS avg_price_in_category
FROM products;
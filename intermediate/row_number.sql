-- Finding the top 3 most expensive products within each product category.

WITH RankedProducts AS (
    SELECT 
        p.product_name,
        c.category_name,
        p.unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY p.category_id 
            ORDER BY p.unit_price DESC
        ) as price_rank
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
)
SELECT 
    category_name,
    product_name,
    unit_price
FROM RankedProducts
WHERE price_rank <= 3
ORDER BY category_name, price_rank;
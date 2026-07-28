WITH RankedProducts AS (
    SELECT 
        c.category_name,
        p.product_name,
        p.unit_price,
        -- Assign a unique rank to products within each category based on price
        ROW_NUMBER() OVER (
            PARTITION BY c.category_name 
            ORDER BY p.unit_price DESC
        ) AS price_rank
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
)
SELECT 
    category_name,
    product_name,
    unit_price,
    price_rank
FROM RankedProducts
-- Filter to keep only the top 3 most expensive products per category
WHERE price_rank <= 3
ORDER BY category_name, price_rank;
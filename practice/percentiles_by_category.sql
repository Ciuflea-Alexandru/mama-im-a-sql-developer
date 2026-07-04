SELECT 
    category_id,
    -- 25th percentile (bottom quarter)
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY unit_price) AS p25_price,
    -- 50th percentile (median)
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY unit_price) AS median_price,
    -- 75th percentile (top quarter)
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY unit_price) AS p75_price
FROM products
GROUP BY category_id;
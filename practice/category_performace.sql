WITH CategoryStats AS (
    -- 1. Calculate base metrics per category
    SELECT 
        c.category_name,
        p.product_name,
        od.unit_price * od.quantity AS line_total,
        -- Window function to get total sales in category
        SUM(od.unit_price * od.quantity) OVER (PARTITION BY c.category_name) AS total_category_sales
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_details od ON p.product_id = od.product_id
)
SELECT 
    category_name,
    -- Aggregate the stats
    COUNT(product_name) AS unique_products,
    ROUND(AVG(line_total)::numeric, 2) AS avg_line_item_value,
    -- Use PERCENTILE_CONT to find the median line item value
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY line_total) AS median_line_item_value,
    MAX(total_category_sales) AS total_sales_volume
FROM CategoryStats
GROUP BY category_name
ORDER BY total_sales_volume DESC;
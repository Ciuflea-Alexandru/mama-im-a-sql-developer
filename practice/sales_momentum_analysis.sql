WITH OrderTrends AS (
    SELECT 
        o.order_id,
        o.order_date,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS order_value
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_id, o.order_date
),
GrowthCalculation AS (
    SELECT 
        order_date,
        order_value,
        LAG(order_value) OVER (ORDER BY order_date) AS prev_order_value
    FROM OrderTrends
)
SELECT 
    order_date,
    order_value,
    -- Cast to numeric to ensure ROUND works properly
    ROUND(((order_value - prev_order_value) / NULLIF(prev_order_value, 0))::numeric * 100, 2) AS pct_change
FROM GrowthCalculation
ORDER BY order_date DESC;
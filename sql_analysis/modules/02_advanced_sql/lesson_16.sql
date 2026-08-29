/*
Find the difference between quaterly revenues
*/

WITH quaterly_revenue AS (
    -- Step 1: Get total revenue grouped by quarter
    SELECT 
    DATE_TRUNC('quarter', o.order_date) AS order_quarter,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY order_quarter
)
-- Step 2: Use LAG() and LEAD() to pull the previous and next quarter's revenue into the same row
SELECT 
order_quarter,
ROUND(total_revenue::numeric, 2) AS current_revenue,
ROUND(LAG(total_revenue, 1) OVER (ORDER BY order_quarter)::numeric, 2) AS prev_quarter_revenue,
ROUND((total_revenue - LAG(total_revenue, 1) OVER (ORDER BY order_quarter))::numeric, 2) AS last_quarter_diff,
ROUND(LEAD(total_revenue, 1) OVER (ORDER BY order_quarter)::numeric, 2) AS next_quarter_revenue,
ROUND((total_revenue - LEAD(total_revenue, 1) OVER (ORDER BY order_quarter))::numeric, 2) AS next_quarter_diff
FROM quaterly_revenue;
WITH date_range AS (
    -- Dynamically find the lifetime start and end dates of your order history
    SELECT 
        MIN(order_date)::date AS min_date,
        MAX(order_date)::date AS max_date
    FROM orders
),
calendar AS (
    -- Generate a continuous row for every single calendar day between the first and last order
    SELECT generate_series(min_date, max_date, '1 day'::interval)::date AS report_date
    FROM date_range
),
actual_sales AS (
    -- Aggregate actual revenue per day from your transactional tables
    SELECT 
        o.order_date::date AS order_date,
        SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS daily_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date::date
)
SELECT 
    c.report_date,
    -- COALESCE ensures days with zero activity show 0.00 instead of disappearing or showing NULL
    COALESCE(a.daily_revenue, 0.00) AS daily_revenue
FROM calendar c
LEFT JOIN actual_sales a ON c.report_date = a.order_date
ORDER BY c.report_date;
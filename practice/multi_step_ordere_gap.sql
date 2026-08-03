WITH CustomerOrders AS (
    SELECT 
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS order_total
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id, o.order_id, o.order_date
)
SELECT 
    customer_id,
    order_date,
    order_total,
    -- Look 1 row backward (default behavior)
    LAG(order_total, 1, 0.00) OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS prev_order_total,
    -- Look 1 row forward
    LEAD(order_total, 1, 0.00) OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS next_order_total
FROM CustomerOrders
ORDER BY customer_id, order_date;
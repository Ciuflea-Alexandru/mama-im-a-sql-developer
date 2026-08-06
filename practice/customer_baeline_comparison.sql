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
    -- Pinpoint the customer's absolute first order amount ever
    FIRST_VALUE(order_total) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_order_amount,
    -- Calculate growth from their initial baseline purchase
    (order_total - FIRST_VALUE(order_total) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ))::numeric(10, 2) AS growth_from_first_order
FROM CustomerOrders
ORDER BY customer_id, order_date;
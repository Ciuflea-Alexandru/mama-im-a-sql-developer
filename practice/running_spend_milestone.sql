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
    -- Running total that accumulates per customer over time
    SUM(order_total) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )::numeric(10, 2) AS running_total_spend,
    -- Assign a chronological order number for each customer's purchases
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY order_date, order_id
    ) AS customer_purchase_seq
FROM CustomerOrders
ORDER BY customer_id, order_date;
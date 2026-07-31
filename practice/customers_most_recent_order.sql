SELECT 
    c.customer_id,
    c.company_name,
    latest_order.order_id,
    latest_order.order_date,
    latest_order.order_total
FROM customers c
-- LATERAL allows this subquery to execute once per customer, accessing c.customer_id
LEFT JOIN LATERAL (
    SELECT 
        o.order_id,
        o.order_date,
        SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS order_total
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    WHERE o.customer_id = c.customer_id
    GROUP BY o.order_id, o.order_date
    ORDER BY o.order_date DESC, o.order_id DESC
    LIMIT 1
) latest_order ON true;
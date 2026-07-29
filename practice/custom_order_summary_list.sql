SELECT 
    c.company_name,
    COUNT(o.order_id) AS total_orders,
    -- Compress multiple order IDs into a single comma-separated list, ordered chronologically
    STRING_AGG(CAST(o.order_id AS VARCHAR), ', ' ORDER BY o.order_date) AS order_id_history,
    SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY total_spend DESC;
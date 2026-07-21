SELECT 
    c.company_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_items_bought,
    -- PostgreSQL specific: FILTER clause for conditional aggregation
    SUM(od.quantity) FILTER (WHERE od.discount > 0) AS discounted_items_count,
    SUM(od.quantity) FILTER (WHERE od.discount = 0) AS full_price_items_count,
    -- Calculate total spend with precision casting
    SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY total_spend DESC;
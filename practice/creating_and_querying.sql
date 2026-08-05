CREATE OR REPLACE VIEW v_customer_lifetime_value AS
SELECT 
    c.customer_id,
    c.company_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(od.unit_price * od.quantity * (1 - od.discount)), 0)::numeric(10, 2) AS total_lifetime_spend
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.company_name;
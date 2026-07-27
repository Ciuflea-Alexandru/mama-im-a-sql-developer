SELECT 
    c.company_name,
    -- Dynamically pivot categories into columns using conditional aggregation
    SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE cat.category_name = 'Beverages')::numeric(10, 2) AS beverages_spend,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE cat.category_name = 'Condiments')::numeric(10, 2) AS condiments_spend,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE cat.category_name = 'Confections')::numeric(10, 2) AS confections_spend,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) FILTER (WHERE cat.category_name = 'Dairy Products')::numeric(10, 2) AS dairy_spend,
    -- Total spend across all categories for comparison
    SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY c.company_name
ORDER BY total_spend DESC;
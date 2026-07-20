SELECT 
    o.order_id,
    o.order_date,
    -- COALESCE returns the first non-null value (use 0 if discount is null)
    SUM(od.unit_price * od.quantity * (1 - COALESCE(od.discount, 0)))::numeric(10, 2) AS net_order_value,
    CASE 
        WHEN od.unit_price IS NULL THEN 'Missing Price'
        WHEN od.quantity IS NULL THEN 'Missing Quantity'
        ELSE 'Data OK'
    END AS data_quality_check
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id, o.order_date, od.unit_price, od.quantity
ORDER BY net_order_value DESC;
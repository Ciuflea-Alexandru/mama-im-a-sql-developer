-- calculate the running total of sales per customer

SELECT 
    o.customer_id,
    o.order_date,
    o.order_id,
    -- Calculate line item total
    (od.unit_price * od.quantity * (1 - od.discount)) AS line_total,
    -- Running total per customer
    SUM(od.unit_price * od.quantity * (1 - od.discount)) OVER (
        PARTITION BY o.customer_id 
        ORDER BY o.order_date
    ) AS running_total_per_customer
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
ORDER BY o.customer_id, o.order_date;
WITH OrderTotals AS (
    SELECT 
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS order_amount
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id, o.order_id, o.order_date
)
SELECT 
    customer_id,
    order_date,
    order_amount,
    -- Calculate the moving average of the current order and the 2 immediately preceding orders for that customer
    AVG(order_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date, order_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )::numeric(10, 2) AS trailing_3_order_avg
FROM OrderTotals
ORDER BY customer_id, order_date;
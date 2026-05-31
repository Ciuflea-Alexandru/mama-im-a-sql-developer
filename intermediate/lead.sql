-- Look up the next order date of each customer

SELECT 
    customer_id,
    order_date,
    LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order
FROM orders;
-- look at a customer's orders and see the freight cost of their previous order alongside the current one

SELECT 
    customer_id, 
    order_date, 
    freight AS current_order_freight,
    LAG(freight, 1, 0) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_order_freight
FROM orders
ORDER BY customer_id, order_date;
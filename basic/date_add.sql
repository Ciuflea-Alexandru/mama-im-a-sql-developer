-- see what the shipping deadline would be if it were 7 days after the order date

SELECT 
    order_id, 
    order_date, 
    (order_date + INTERVAL '7 days') AS shipping_deadline
FROM orders;
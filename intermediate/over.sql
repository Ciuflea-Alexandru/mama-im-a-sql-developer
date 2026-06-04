-- Show the running total of the quantity of products partitioned for every order

SELECT 
    order_id, 
    product_id, 
    quantity,
    SUM(quantity) OVER (PARTITION BY order_id ORDER BY product_id) AS running_total_per_order
FROM order_details
ORDER BY order_id, product_id;
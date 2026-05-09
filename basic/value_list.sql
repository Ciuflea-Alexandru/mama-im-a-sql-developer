-- Show the orders who have one of the following order_ids: 10250, 10500, 10750, 11000

SELECT *
FROM orders
WHERE order_id IN (10250, 10500, 10750, 11000)
ORDER BY order_id;
-- Count the total orders for 1996

SELECT COUNT(*) AS total_orders
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1996;
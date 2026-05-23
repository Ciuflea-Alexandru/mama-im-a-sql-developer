-- Select the month number and count the number of orders for each month

SELECT
  EXTRACT(MONTH FROM order_date) AS month_number,
  COUNT(*) AS number_of_orders
FROM orders
GROUP BY month_number
ORDER BY month_number;
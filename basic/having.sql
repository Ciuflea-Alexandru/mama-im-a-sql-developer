-- Show all the customers that have placed more than 10 orders

SELECT
  customer_id
FROM orders
GROUP BY
  customer_id
HAVING COUNT(*) > 10;
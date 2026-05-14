-- Display the customer id for everyone who had more than 10 orders

SELECT
  customer_id
FROM orders
GROUP BY
  customer_id
HAVING COUNT(*) > 10;
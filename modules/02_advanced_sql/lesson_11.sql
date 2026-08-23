/*
Management wants to know the average number of orders placed per customer, but they want to calculate it in two steps:

First, find out how many orders each individual customer has placed.

Second, take that list of totals and calculate the overall average of those numbers.
*/

SELECT
AVG(total_orders) AS average_orders_per_customer
FROM(
    SELECT
    c.company_name,
    COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.company_name
    )
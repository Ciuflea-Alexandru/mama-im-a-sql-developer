/*
The marketing team wants a list of the most loyal customers. Specifically, they want the
Company Name of any customer who has placed more than 15 orders, along with their total order count.

Instead of trying to group, filter, and join all in one massive block, we will use a CTE to first 
calculate the order counts, and then join that clean, summarized data to our customers table.
*/


WITH order_counts AS (
    SELECT
    customer_id,
    COUNT(order_id) AS total_orders
    FROM orders o
    GROUP BY customer_id
)
SELECT
c.company_name,
oc.total_orders
FROM customers c
JOIN order_counts oc ON c.customer_id = oc.customer_id
WHERE total_orders > 15
ORDER BY oc.total_orders DESC;
/*
The management team wants to identify our Top-Tier Customers based on their order history. 
*/

WITH customer_order_totals AS (
    SELECT
    o.customer_id,
    SUM(od.quantity * od.unit_price) AS total_spending
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.customer_id
),
top_tier_customers AS (
    SELECT
    *
    FROM customer_order_totals
    WHERE total_spending > 10000
)
SELECT
c.customer_id,
c.company_name,
ttc.total_spending
FROM customers c
JOIN top_tier_customers ttc ON c.customer_id = ttc.customer_id
ORDER BY ttc.total_spending DESC;
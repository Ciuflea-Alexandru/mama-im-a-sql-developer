/*
Management wants to understand how ROW_NUMBER() behaves differently 
by assigning a unique, sequential integer to every single row regardless of ties.
*/

SELECT
category_id,
product_name,
unit_price,
ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS row_number,
RANK() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS item_rank,
DENSE_RANK() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS dense_rank
FROM products;


/*
Management wants to find the most recent order placed by each customer.
*/

WITH ranked_orders AS (
    SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS row_number
    FROM orders
)
SELECT
customer_id,
order_id,
order_date
FROM ranked_orders
WHERE row_number = 1;
/*
Truncate order dates down to the first day of their respective month
*/
SELECT
DATE_TRUNC('month', order_date) AS order_month,
SUM(freight) AS total_freight
FROM orders
GROUP BY order_date
ORDER BY order_month;

/*
Truncate order dates to see how revenue changes quarter over month
*/

SELECT
DATE_TRUNC('quarter', o.order_date) AS order_quarter,
ROUND(CAST(SUM(od.unit_price * od.quantity * (1 - od.discount)) AS NUMERIC), 2) AS quarterly_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY 1
ORDER BY order_quarter;

/* 
Find all orders placed in the last 30 days relative to a specific reference date,
or dynamically filtering using current timestamps
*/
SELECT order_id, order_date
FROM orders
WHERE order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL '1 year';

/*
TO_CHAR() converts a timestamp into a formatted string template
*/

SELECT 
TO_CHAR(order_date, 'YYYY-MM') AS year_month,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;
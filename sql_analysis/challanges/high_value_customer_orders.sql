/*
The sales operations team wants to identify our highest-value
 individual orders so they can send a VIP customer service survey.
*/

SELECT
c.company_name,
o.order_id,
SUM(od.unit_price * od.quantity) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.company_name, o.order_id
HAVING SUM(od.unit_price * od.quantity) > 1000
ORDER BY SUM(od.unit_price * od.quantity) DESC;
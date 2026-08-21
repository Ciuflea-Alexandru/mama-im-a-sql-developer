/*
The sales team wants a detailed line-item report of orders. 
Specifically, they want to see the Order ID, the Product Name, and the Quantity ordered for each line item.
*/

SELECT
o.order_id,
p.product_name,
od.quantity
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
LIMIT 10;
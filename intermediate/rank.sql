-- rank orders by the total amount (quantity multiplied by unit price)

SELECT 
order_id, 
product_id,
(quantity * unit_price) AS line_total,
RANK() OVER (ORDER BY (quantity * unit_price) DESC) AS revenue_rank
FROM order_details
ORDER BY revenue_rank;
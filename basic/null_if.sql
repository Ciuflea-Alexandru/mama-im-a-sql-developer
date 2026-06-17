-- calculate the revenue and effectively handle a scenario where we want to avoid dividing by zero if a quantity is somehow recorded as 0

SELECT 
order_id, 
product_id, 
unit_price, 
quantity,
unit_price / NULLIF(quantity, 0) AS price_per_unit
FROM order_details
LIMIT 10;
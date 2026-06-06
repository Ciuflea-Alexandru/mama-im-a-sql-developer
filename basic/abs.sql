-- find the absolute diffrence between the unit price and the fixed target price

SELECT 
    order_id, 
    product_id, 
    unit_price,
    ABS(unit_price - 20.00) AS price_diffrence
FROM order_details
ORDER BY price_diffrence DESC;
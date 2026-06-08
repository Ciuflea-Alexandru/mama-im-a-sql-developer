-- calculate the square root of the unit price

SELECT 
order_id, 
product_id, 
unit_price, 
SQRT(unit_price) AS unit_square_root
FROM order_details
ORDER BY 
    unit_square_root DESC;
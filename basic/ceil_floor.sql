-- calculate a total but force the results to round up and down

SELECT 
    order_id, 
    unit_price, 
    quantity,
    (unit_price * quantity) AS exact_total,
    CEIL(unit_price * quantity) AS rounded_up_total,
    FLOOR(unit_price * quantity) AS rounded_down_total
FROM order_details
LIMIT 10;
-- substract the total nu,ber of days between two dates

SELECT 
    order_id, 
    shipped_date - order_date AS days_to_ship
FROM orders
WHERE shipped_date IS NOT NULL;
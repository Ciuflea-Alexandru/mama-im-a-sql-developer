-- calculate the average quantity sold, looking at the current order and the two orders immediately preceding it, ordered by the order date

SELECT 
    order_id,
    order_date,
    quantity,
    AVG(quantity) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_quantity
FROM order_details
JOIN orders USING (order_id)
ORDER BY order_date;
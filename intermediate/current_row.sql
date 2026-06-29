-- display total that never resets from the beginning of time until the current ro

SELECT 
    order_date,
    quantity,
    SUM(quantity) OVER (
        ORDER BY order_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_quantity
FROM order_details
JOIN orders USING (order_id);
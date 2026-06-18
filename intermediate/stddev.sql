-- calculate the average and the standard deviation of the quantity of items per order

SELECT 
    product_id,
    AVG(quantity) AS average_quantity,
    STDDEV(quantity) AS stddev_quantity,
    COUNT(*) AS total_order_count
FROM 
    order_details
GROUP BY 
    product_id
HAVING 
    COUNT(*) > 5
ORDER BY 
    stddev_quantity DESC;
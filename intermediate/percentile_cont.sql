-- find the median the 50th percentile of order amounts to identify high-value orders

SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY unit_price) AS median_price
FROM order_details;
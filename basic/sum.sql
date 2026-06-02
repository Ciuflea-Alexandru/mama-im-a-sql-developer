-- find the total revenue for each region

SELECT region, SUM(revenue) AS total_revenue
FROM sales
GROUP BY region;
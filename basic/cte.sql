-- Show the total sales per employee using a common table expression

WITH EmployeeSales AS (
    -- This CTE calculates total sales per employee
    SELECT 
        o.employee_id, 
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.employee_id
)
-- Main query joins the CTE with the Employees table
SELECT 
    e.first_name, 
    e.last_name, 
    ROUND(es.total_revenue::numeric, 2) AS total_revenue
FROM employees e
JOIN EmployeeSales es ON e.employee_id = es.employee_id
ORDER BY total_revenue DESC;
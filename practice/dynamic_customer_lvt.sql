WITH CustomerSpend AS (
    SELECT 
        c.customer_id,
        c.company_name,
        COALESCE(SUM(od.unit_price * od.quantity * (1 - od.discount)), 0)::numeric(10, 2) AS total_lifetime_spend,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_details od ON o.order_id = od.order_id
    GROUP BY c.customer_id, c.company_name
)
SELECT 
    company_name,
    total_orders,
    total_lifetime_spend,
    -- Segment customers into business tiers using a CASE statement
    CASE 
        WHEN total_lifetime_spend >= 5000 THEN 'Platinum'
        WHEN total_lifetime_spend >= 2000 THEN 'Gold'
        WHEN total_lifetime_spend > 0 THEN 'Silver'
        ELSE 'Inactive'
    END AS customer_tier,
    -- Rank customers globally within their tier using NTILE to split them into 4 groups
    NTILE(4) OVER (ORDER BY total_lifetime_spend DESC) as spend_quartile
FROM CustomerSpend
ORDER BY total_lifetime_spend DESC;
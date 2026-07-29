SELECT 
    c.customer_id,
    c.company_name,
    c.contact_name,
    c.country
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);
SELECT 
    customer_id,
    LEFT(customer_id, 2) AS region_code,
    RIGHT(customer_id, 3) AS unique_identifier,
    LEFT(customer_id, 2) || '-' || RIGHT(customer_id, 3) AS formated_id
FROM customers;
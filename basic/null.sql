-- Show the id of the customers, their company and region that have one but not a fax

SELECT
customer_id,
company_name,
region
FROM customers
WHERE region IS NOT NULL AND fax IS NULL
-- Select the customer_id and company name of all customers which name starts with La

SELECT
  customer_id,
  company_name
FROM customers
WHERE company_name LIKE 'La%';
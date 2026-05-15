-- Select the contact and company name with the phone of all customers and suppliers tagged respectively

SELECT contact_name, company_name, phone, 'customer' AS Relationship
FROM customers
UNION
SELECT contact_name, company_name, phone, 'supplier' AS Relationship
FROM suppliers;

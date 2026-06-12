-- clean un the contract name of customers

SELECT 
    contact_name, 
    TRIM(contact_name) AS cleaned_name
FROM customers;
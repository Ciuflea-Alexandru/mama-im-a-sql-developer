-- see a list of phone numbers with the dashes removed

SELECT 
    phone AS original_phone,
    REPLACE(phone, '-', '') AS cleaned_phone
FROM customers;
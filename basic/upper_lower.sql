-- Show the customers contact name in upper case and contanct title in lower case between square brackets

SELECT
  CONCAT(UPPER(contact_name), ' ', '[', LOWER(contact_title), ']') AS new_name_format
FROM customers
ORDER BY contact_name DESC;
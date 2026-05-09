-- Show both the first name and the last name of all employees in one collumn

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
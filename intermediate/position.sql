-- in the name of the employee find the space and extract everything before that space

SELECT 
    first_name,
    last_name,
    POSITION(' ' IN first_name || ' ' || last_name) AS space_index,
    LEFT(first_name || ' ' || last_name, POSITION(' ' IN first_name || ' ' || last_name) - 1) AS extracted_first_name
FROM employees;
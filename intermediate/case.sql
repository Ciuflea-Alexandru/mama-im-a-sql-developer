-- Disaply all the emplyees with their full country names

select
first_name,
last_name,
CASE
WHEN country = 'USA' THEN 'United States' 
ELSE 'United Kingdom' 
END AS country
from employees
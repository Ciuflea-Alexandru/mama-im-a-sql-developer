/*
The sales team wants to see a ranked list of the most expensive products within each category.
Instead of collapsing the table down to just the category average, they want to see every individual 
product alongside a ranking number indicating which ones cost the most in their respective categories.
*/


SELECT
category_id,
product_name,
unit_price,
RANK() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS price_rank
FROM products;

/*
The human resources or management team wants to look at employee seniority within 
their respective reporting structures or hire dates. Let's look at the employees table.
*/

SELECT
employee_id,
first_name,
last_name,
hire_date,
RANK() OVER (ORDER BY hire_date ASC) AS employee_rank
FROM employees;
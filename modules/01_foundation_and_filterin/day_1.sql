/*
Can you pull a list of all orders shipped to 'France' where 
the freight cost was greater than $50.00, and sort them by the 
highest freight cost first? Show me only the top 5 results.
*/

SELECT *
FROM orders
WHERE ship_country = 'France' AND freight > 50
ORDER BY freight DESC
LIMIT 5;
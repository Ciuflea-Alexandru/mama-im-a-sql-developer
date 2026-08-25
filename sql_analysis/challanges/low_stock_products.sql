/*
The inventory management team wants to know which suppliers we need to contact to restock items. 
They want a report showing products that are running low.
*/

SELECT
s.company_name,
p.product_name,
p.units_in_stock,
p.unit_price
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.units_in_stock < 10 AND p.discontinued = 0
ORDER BY p.units_in_stock ASC;
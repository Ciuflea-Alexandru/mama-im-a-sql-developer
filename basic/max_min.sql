-- Get the two orders with the bigest and samllest quantity

(SELECT order_id, quantity, 'MAX' as type
 FROM order_details
 ORDER BY quantity DESC
 LIMIT 1)

UNION ALL

(SELECT order_id, quantity, 'MIN' as type
 FROM order_details
 ORDER BY quantity ASC
 LIMIT 1);
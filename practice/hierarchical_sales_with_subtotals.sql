SELECT 
    COALESCE(o.ship_country, 'Grand Total') AS ship_country,
    COALESCE(o.ship_city, 'Country Subtotal') AS ship_city,
    SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10, 2) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY ROLLUP (o.ship_country, o.ship_city)
ORDER BY o.ship_country NULLS LAST, o.ship_city NULLS LAST;
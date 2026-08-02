SELECT 
    c.customer_id,
    c.company_name,
    json_agg(
        jsonb_build_object(
            'order_id', o.order_id,
            'order_date', o.order_date,
            'ship_country', o.ship_country
        )
    ) AS orders_json
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name;
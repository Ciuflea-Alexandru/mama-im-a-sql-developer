SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM products
WHERE to_tsvector('english', product_name) @@ to_tsquery('english', 'Chef | Mix & !Dried');
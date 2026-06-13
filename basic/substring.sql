-- extract the first three characters of a product name

SELECT 
    product_name, 
    SUBSTRING(product_name FROM 1 FOR 3) AS product_code
FROM products;
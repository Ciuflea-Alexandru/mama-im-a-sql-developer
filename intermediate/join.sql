-- Show for every product its name, category and description

SELECT
  p.product_name,
  c.category_name,
  c.description
FROM products AS p
JOIN categories AS c ON p.category_id = c.category_id
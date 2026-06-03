-- Select the product id of the products with the bigest quantity ordered

SELECT
product_id,
quantity
FROM order_details
WHERE quantity = (
    SELECT max(quantity)
    FROM order_details
  )
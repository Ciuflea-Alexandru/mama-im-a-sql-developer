-- Display every customer and order them after the lenght of their company name alphabetically

SELECT company_name
FROM customers
order by
  LENGTH(company_name),
  company_name;
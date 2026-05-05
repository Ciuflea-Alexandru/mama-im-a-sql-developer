-- Show for every city name the disctrict and address

SELECT
  c.city,
  a.district,
  a.address
FROM city AS c
JOIN address AS a ON c.city_id = a.city_id;
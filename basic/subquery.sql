-- Select the films that have the highest rental rate

SELECT
film_id,
title,
rental_rate
FROM film
WHERE rental_rate = (
    SELECT max(rental_rate)
    FROM film
  )
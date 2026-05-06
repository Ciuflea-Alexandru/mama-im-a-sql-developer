-- Count how many movies were released in 2006

SELECT COUNT(*) AS total_movies
FROM film
WHERE YEAR(release_year) = 2006;
-- Show all columns for actors who have one of the following patient_ids: 1,45,534,879,1000

SELECT *
FROM actor
WHERE actor_id IN (1, 25, 50, 100, 200)
ORDER BY actor_id;
/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */
SELECT f.title
FROM film_actor fa1
JOIN film_actor fa2 USING (actor_id)
JOIN film f ON f.film_id = fa2.film_id
JOIN film f1 ON f1.film_id = fa1.film_id
WHERE f1.title = 'AMERICAN CIRCUS' 
GROUP BY f.title
HAVING COUNT(actor_id) >= 2
ORDER BY f.title;

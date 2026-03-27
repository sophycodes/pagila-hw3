/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
SELECT name, title, "total rentals"
FROM (
    SELECT
        cat.name,
        f.title,
        COUNT(r.rental_id) AS "total rentals",
        ROW_NUMBER() OVER (PARTITION BY cat.category_id ORDER BY COUNT(r.rental_id) DESC, f.title DESC) AS rn
    FROM category cat
    JOIN film_category fc USING (category_id)
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    GROUP BY cat.category_id, cat.name, f.film_id, f.title
) sub
WHERE rn <= 5
ORDER BY name, "total rentals" DESC, title;

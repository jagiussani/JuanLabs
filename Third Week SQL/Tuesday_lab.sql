###################################################################################
################################ Lab | JOIN 2 TABLES  #################################
###################################################################################
USE sakila;

#1. Which actor has appeared in the most films?
SELECT actor.first_name, actor.last_name, film_actor.actor_id, COUNT(film_actor.film_id) FROM actor INNER JOIN film_actor
USING (actor_id)
GROUP BY actor_id
ORDER BY COUNT(film_actor.film_id) DESC
LIMIT 1;

#2. Most active customer (the customer that has rented the most number of films)
SELECT * FROM customer
ORDER BY first_name;
# Checking how table looks like and what "active" means. 0 = not active. 1 = active
SELECT * FROM rental
ORDER BY customer_id;
# Both rental & costumer tables shares the column costumer_id. 
SELECT customer.first_name, customer.last_name, COUNT(rental.customer_id) FROM customer INNER JOIN rental
USING (customer_id)
GROUP BY customer_id
ORDER BY COUNT(rental.customer_id) DESC
LIMIT 1;

#3. List number of films per category.
SELECT category.name, COUNT(film_category.film_id) FROM category INNER JOIN film_category
USING (category_id)
GROUP BY category_id
ORDER BY category.name; 

#4. Display the first and last names, as well as the address, of each staff member.
SELECT staff.first_name, staff.last_name, address.address FROM address INNER JOIN staff
USING (address_id);

#5. Get films titles where the film language is either English or italian, and whose titles starts with letter "M", 
#   sorted by title descending.
SELECT DISTINCT film.title, `language`.`name`  FROM `language` INNER JOIN film
USING (language_id)
WHERE film.title LIKE 'M%'
AND
`language`.`name` BETWEEN  "English" AND "Italian"
ORDER BY film.title DESC;

#6. Display the total amount rung up by each staff member in August of 2005.
SELECT DISTINCT staff.first_name, staff.last_name, SUM(payment.amount) FROM payment INNER JOIN staff
USING (staff_id)
WHERE payment.payment_date LIKE "2005-08%"
GROUP BY staff.first_name, staff.last_name
ORDER BY staff.first_name;

#7. List each film and the number of actors who are listed for that film.
SELECT film.title,COUNT(film_actor.actor_id) FROM film INNER JOIN film_actor
USING (film_id)
GROUP BY film.title
ORDER BY COUNT(film_actor.actor_id) DESC
LIMIT 10;

#8. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#   List the customers alphabetically by last name.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as total_paid_by_customer FROM customer INNER JOIN payment
USING (customer_id)
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.last_name
LIMIT 10;

#9. Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) FROM actor LEFT JOIN film_actor
USING (actor_id)
WHERE actor.actor_id = 0; 

#10. Get the addresses that have NO customers, and ends with the letter "e"
SELECT address.address FROM address LEFT JOIN customer
USING (address_id)
WHERE address.address LIKE '%e'
GROUP BY address.address
HAVING COUNT(customer.customer_id) = 0;

# Optional 
# what is the most rented film?

SELECT DISTINCT film.title, SUM(film.rental_rate) FROM film INNER JOIN inventory 
ON film.film_id = inventory.film_id
INNER JOIN rental
ON rental.rental_id = inventory.inventory_id
GROUP BY film.title
HAVING SUM(film.rental_rate)
ORDER BY SUM(film.rental_rate) DESC;

# THERE ARE MANY MOVIES WITH THE SAME RENTAL RATE, OR COUNT OF INVENTORY ID
# NOT ABLE TO ACHIEVE THE RESULT 

###################################################################################
################################ Lab | SQL Subqueries  #################################
###################################################################################
USE sakila;

#1.  List all films whose length is longer than the average of all the films.
SELECT title
FROM film
WHERE length > (SELECT AVG(LENGTH)
					FROM FILM); 

#2. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id IN ( SELECT film_id
				FROM film
                WHERE title = "Hunchback Impossible"); 
                
#3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN ( SELECT actor_id
					FROM film_actor
                    WHERE film_id IN ( SELECT film_id
										FROM film
                                        WHERE title = "Alone Trip"));
                                        
#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN ( SELECT film_id
					FROM film_category
                    WHERE category_id IN ( SELECT category_id
											FROM category
                                            WHERE name = "Family"));

#5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN ( SELECT address_id
						FROM address
                        WHERE city_id IN ( SELECT city_id
											FROM city
                                            WHERE country_id IN ( SELECT country_id
																	FROM country
                                                                    WHERE country = "Canada")));
                                                                    
# WITH JOINS
SELECT first_name, last_name, email FROM customer INNER JOIN address
USING (address_id)
INNER JOIN city
USING (city_id)
INNER JOIN country
USING (country_id)
WHERE country = "Canada";


##############
## Optional ##
##############
#6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
# 	First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

# ACTOR ID OF THE MOST PROLIFIC ACTOR
SELECT actor_id, COUNT(film_id)
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

# What is the name of the most prolific actor? 
SELECT first_name, last_name FROM actor
WHERE actor_id = 107;

# Result 
SELECT title
FROM film
WHERE film_id IN ( SELECT film_id
					FROM film_actor
                    WHERE actor_id = ( SELECT actor_id
										FROM film_actor
										GROUP BY actor_id
										ORDER BY COUNT(film_id) DESC
										LIMIT 1)); 

#7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
# ie the customer that has made the largest sum of payments

SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				FROM inventory
                WHERE inventory_id IN (SELECT inventory_id
										FROM rental
                                        WHERE customer_id = (SELECT customer_id
															FROM payment
															GROUP BY customer_id
															ORDER BY sum(amount) DESC
															LIMIT 1))); 

# MOST PROFITABLE CUSTOMER (ID)
SELECT customer_id, sum(amount)
FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
LIMIT 1;
# 526

# 8. Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).
SELECT first_name, last_name, avg(amount) FROM payment INNER JOIN customer
USING (customer_id)
WHERE payment > avg(amount)
GROUP BY customer_id; 
# did not work


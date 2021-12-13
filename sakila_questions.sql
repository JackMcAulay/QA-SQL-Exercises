USE sakila;

#Select all Actors from the table.
SELECT * FROM actor;

#Find the actor with the first name “John”.
SELECT * FROM actor WHERE first_name = 'John';

#Find all actors with the surname “Neeson”.
SELECT * FROM actor WHERE last_name = 'Neeson';

#Find all actors with Id numbers divisible by 10
SELECT * FROM actor WHERE actor_id%10 = 0;

#What is the description of the movie with ID of 100? 
SELECT film_id, description FROM film WHERE film_id = 100;

#Find every movie with a rating of “R”. 
SELECT * FROM film WHERE rating = 'R';

#Find every movie except those with a rating of “R”. 
SELECT * FROM film WHERE rating != 'R';

#Find the 10 shortest movies.
SELECT * FROM film ORDER BY length ASC LIMIT 10; 

#Now return only the movie titles. 
SELECT title FROM film ORDER BY length ASC LIMIT 10; 

#Find all movies with Deleted Scenes.
SELECT * FROM film WHERE special_features LIKE '%Behind the Scenes%';

#Which last names are not repeated?
SELECT last_name FROM actor GROUP BY last_name HAVING count(*) < 2;

#Which last names appear more than once?
SELECT last_name FROM actor GROUP BY last_name HAVING count(*) > 1;

#Which actor has appeared in the most films? 
SELECT * FROM actor WHERE actor_id = (
SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(*) DESC LIMIT 1
);

#Is ‘Academy Dinosaur’ available for rent from Store 1? 
SELECT return_date FROM rental r JOIN inventory i ON
i.inventory_id = r.inventory_id WHERE i.film_id=1 and r.return_date IS NOT NULL
ORDER BY return_date LIMIT 1;  

#When is ‘Academy Dinosaur’ due? 
SELECT * FROM rental WHERE inventory_id IN (
SELECT inventory_id FROM inventory WHERE film_id = (
SELECT film_id FROM film WHERE title = 'Academy Dinosaur')
);

#What is that average running time of all the films in the database? 
SELECT AVG(length) FROM film;

#What is the average running time of films by category? 
SELECT category.name, AVG(length)
FROM film JOIN film_category USING (film_id) JOIN category USING (category_id)
GROUP BY category.name ORDER BY avg(length) desc;

#How many movies have Robots in them? 
SELECT * FROM film WHERE film_id IN (
SELECT film_id FROM film_text WHERE description LIKE '%Robot%'
);

#Find the movie(s) with the longest runtime.
SELECT * FROM film ORDER BY length DESC LIMIT 15; 

#Count how many movies were released in 2010. 
SELECT release_year, count(*) FROM film WHERE release_year = 2010;

#Find the titles of all horror movies. 
SELECT title FROM film WHERE film_id IN (
SELECT film_id FROM film_category WHERE category_id in(
SELECT category_id FROM category WHERE name = 'Horror')
);

#Return the full name of the staff member – in a column named full_name – with the ID of 1. 
SELECT concat(first_name, ' ', last_name) FROM staff WHERE staff_id = 1;

#Retrieve all movies that Fred Costner has appeared in. 
SELECT * FROM film WHERE film_id IN (
SELECT film_id FROM film_actor WHERE actor_id IN (
SELECT actor_id FROM actor WHERE first_name = 'FRED' AND last_name = 'COSTNER')
);

#Find out which location has the most copies of BUCKET BROTHERHOOD. 
SELECT store_id, count(*)
FROM store JOIN inventory USING (store_id) JOIN film USING (film_id)
WHERE film.title = 'BUCKET BROTHERHOOD' GROUP BY store.store_id ORDER BY count(*) DESC LIMIT 1;

#How many distinct countries are there? 
SELECT count(*) FROM country; 

#What are the names of all the languages in the database (sorted alphabetically)?
SELECT * FROM language ORDER BY name ASC; 

#Return the full names (first and last) of actors with “son” in their last name, ordered by their first name. 
SELECT concat(first_name, ' ', last_name) FROM actor WHERE last_name LIKE '%SON' ORDER BY first_name ASC;

#Create a list of categories and the number of films for each category. 
SELECT category.name, count(*)
FROM film JOIN film_category USING (film_id) JOIN category USING (category_id)
GROUP BY category.name ORDER BY count(*) desc;

#Create a list of actors and the number of movies by each actor. 
SELECT concat(actor.first_name, ' ', actor.last_name), count(*)
FROM actor JOIN film_actor USING (actor_id) JOIN film USING (film_id)
GROUP BY actor.first_name ORDER BY count(*) desc;

#Which actor/actress has appeared in the most movies? 
SELECT concat(actor.first_name, ' ', actor.last_name), count(*)
FROM actor JOIN film_actor USING (actor_id) JOIN film USING (film_id)
GROUP BY actor.first_name ORDER BY count(*) desc LIMIT 1;
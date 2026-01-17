/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

SELECT
	first_name
	,last_name
	,email
	,store_id
FROM staff;


/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 
SELECT
	*
FROM inventory;


SELECT
	store_id
	,count(store_id) as inventory_num_per_store
FROM inventory
group by store_id;



/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

SELECT 
	store_id
	,count(active) as active_customers_per_store
FROM customer
WHERE active = 1
GROUP BY store_id;




/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/


SELECT 
	count(DISTINCT email)
FROM customer;



/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/


SELECT
	i.store_id AS which_store
	,count(DISTINCT title) AS count_of_unique_titles
	,count(DISTINCT category_id) AS count_of_unique_categories
FROM film f
join inventory i
	ON f.film_id = i.film_id
join film_category fc
	ON f.film_id = fc.film_id        
  AND fc.category_id IS NOT NULL
group by which_store;


/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/


SELECT
	min(replacement_cost) as min_rep_cost
	,max(replacement_cost) as max_rep_cost
	,round(avg(replacement_cost), 2) as avg_rep_cost
FROM film;



/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/
SELECT
	MAX(amount) as maximum_processed_payment
	,ROUND(AVG(amount), 2) as average_payment_value
FROM payment;


/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

SELECT 
	c.customer_id as customer_id
	,count(r.rental_id) as number_of_rentals
FROM customer c
LEFT JOIN rental r
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY number_of_rentals desc;


-- ADDITIONAL BONUS "QUEST"
/*
 "Now, we need to see the same data (customer ID and rental count),
 but this time only for customers who have rented more than 30 times. 
 Additionally, please include their first name and last name with email so we can reach out to them with a reward."
 */ 

SELECT 
	c.customer_id as customer_id
	,c.first_name as customer_name
	,c.last_name as customer_lastname
	,c.email
	,count(r.rental_id) as number_of_rentals
FROM customer c
LEFT JOIN rental r
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING number_of_rentals > 30
ORDER BY number_of_rentals desc;

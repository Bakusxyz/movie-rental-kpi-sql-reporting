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


-- PROJECT NEXT STEPS

/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

SELECT
	store_id
	,first_name
	,last_name
	,ad.address
	,ad.district
	,ci.city
	,co.country 
FROM staff
LEFT JOIN address ad
	ON staff.address_id = ad.address_id
LEFT JOIN city ci
	ON ad.city_id = ci.city_id
LEFT JOIN country co
	ON ci.country_id = co.country_id;



/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/


SELECT
	store.store_id 
	,i.inventory_id
	,f.title
	,f.rating
	,f.rental_rate
	,f.replacement_cost 
FROM store
LEFT JOIN inventory i
	ON store.store_id = i.store_id
LEFT JOIN film f
	ON i.film_id = f.film_id;



/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/


SELECT
	store.store_id as which_store
	,f.rating
	,count(i.inventory_id) as num_of_specific_items
FROM store
LEFT JOIN inventory i
	ON store.store_id = i.store_id
LEFT JOIN film f
	ON i.film_id = f.film_id
GROUP BY store.store_id, f.rating;


/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 


SELECT
	store.store_id as which_store
	,c.name as category
	,count(f.film_id) as num_of_specific_items
	,round(avg(f.replacement_cost), 2) as average_replacement_cost_usd
	,round(sum(f.replacement_cost),2) as total_replacement_cost_per_store_and_category_in_usd
FROM store
LEFT JOIN inventory i
	ON store.store_id = i.store_id
LEFT JOIN film f
	ON i.film_id = f.film_id
LEFT JOIN film_category fc
	ON f.film_id = fc.film_id 
LEFT JOIN category c
	ON fc.category_id = c.category_id
GROUP BY store.store_id, c.name;



/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/


SELECT
	'Customer' as Type
	,c.first_name
	,c.last_name
	,c.store_id
	,c.active
	,a.address
	,a.district 
	,ci.city
	,co.country
FROM customer c
LEFT JOIN address a
	ON c.address_id = a.address_id
LEFT JOIN city ci
	ON a.city_id = ci.city_id
LEFT JOIN country co
	ON ci.country_id = co.country_id;


/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/


SELECT
	'Customer' as Type
	,c.first_name
	,c.last_name
	,count(p.rental_id) as amount_of_rentals
	,sum(p.amount) as sum_of_payments
FROM customer c
LEFT JOIN payment p
	ON c.customer_id = p.customer_id
group by 1,2,3
ORDER BY sum_of_payments desc;

 
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/
SELECT
	'Advisor' as Type
	,first_name
	,last_name
	,'-' as company
FROM advisor
UNION
SELECT
	'Investor' as Type
	,first_name
	,last_name
	,company_name 
FROM investor

/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

-- NEED TO BE DONE!





use sakila;
-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over (order by length) as 'rank'
from film
where length is not null and length > 0;

-- 2. Rank films by length within the rating category
select title, length, rating, RANK() OVER (partition by rating order by length asc) as 'rank'
from film
where length is not null and length > 0;

-- 3. Count films for each category
select c.name as category, count(f.film_id) as film_count
from category c
left join film_category fc on c.category_id =  fc.category_id
right join film f on fc.film_id = f.film_id
group by c.category_id, c.name;

-- 4. Actor with the most film appearances
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as film_count
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_count desc
limit 1;

-- 5. Most active customer
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as rental_count
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc
limit 1;
-- Most active customer , full list, not only one (limit 1)
select c.customer_id, concat(c.first_name, ' ', c.last_name) as 'Customer Name', count(r.rental_id) 'Number of rentals'
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by count(r.rental_id) desc;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood)
select f.title, count(r.rental_id) as rental_count
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id




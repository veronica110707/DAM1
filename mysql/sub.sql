select title, length 
from film
where length > (
select avg(length)
from film
);

select first_name, last_name 
from actor
where actor_id in (
select actor_id
from film_actor
where film_id=1
);

select first_name, last_name
from customer
where exists (
select 1
from rental
where rental.customer_id = customer.customer_id
);

select title
from film
where not exists (
select 1
from inventory
join rental using (inventory_id)
where inventory.film_id = film.film_id
);

select title, count(inventory_id) as copias
from film
join inventory using (film_id)
group by title
having count(inventory_id) > (
select avg();

select customer_id, first_name, last_name
from customer
where exists (
select 1
from payment
where payment.customer_id = customer.customer_id
)
and not exists (
select 1
from rental
where rental.customer_id = customer.customer_id and rental_date >= date_sub(curdate(), interval 6 month)
);

select name as categoria, title, length
from category
join film_category using (category_id)
join film using (film_id)
where length > 90;

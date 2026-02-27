-- Consulta 1: Clientes con al menos un alquiler
select customer_id,concat(customer.first_name,' ',customer.last_name) as nombre_completo,count(rental_id) as cantidad_alquileres
from customer
inner join rental using(customer_id)
where store_id=1
group by customer_id
order by cantidad_alquileres desc;

-- Consulta 2: Todos los clientes y sus alquileres
select customer_id,concat(customer.first_name,' ',customer.last_name) as nombre_completo,count(rental_id) as cantidad_alquileres
from customer
left join rental using (customer_id)
where store_id=1
group by customer_id
order by customer_id;

-- Consulta 3: Actores y sus películas
select actor_id,concat(actor.first_name,' ',actor.last_name) as nombre_actor,title as titulo_pelicula
from film
join film_actor using (film_id)
left join actor using (actor_id)
group by actor_id,title
order by actor_id;

-- Consulta 4: Categorías y películas
select category_id, category.name as categoria, title as pelicula
from category
left join film_category using (category_id)
left join film using (film_id)
order by category_id;

-- Consulta 5: Películas y sus actores
select film_id,title,actor_id,concat(actor.first_name,' ',actor.last_name) as nombre_actor
from film
left join film_actor using (film_id)
left join actor using (actor_id)
order by film_id;
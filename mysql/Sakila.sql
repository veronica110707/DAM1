-- 1) Cinco actores con más películas
select first_name,last_name,count(film_id) as num_films
from actor
join film_actor on actor.actor_id = film_actor.actor_id
-- film_actor fa using(actor_id)
-- film_actor fa on a.actor_id =fa.actor_id
group by actor.actor_id
order by num_films desc limit 5;



-- 2.1) País con más clientes
select count(customer_id) as num_customers,country as country
from customer 
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
group by country
order by num_customers desc limit 1;

-- 2.2) País con más de 40 clientes
select count(customer_id) as num_customers,country as country
from customer 
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
group by country
having num_customers>40
order by num_customers desc;

-- 3) Tres películas con mayores ingresos por alquiler
select film.film_id,sum(amount) as income
from film 
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by film.film_id
order by income desc limit 3;

-- 4.1) Cliente que más ha gastado
select concat(first_name," ",last_name) as full_name,sum(amount) as income
from customer c
join payment p using(customer_id)
group by customer_id
order by income desc limit 1;

-- 4.2) Cliente que más ha gastado
select concat(first_name," ",last_name) as full_name,sum(amount) as income
from customer c
where customer_id = (
					select customer_id
					from payment
					group by customer_id
					having sum(amount) >= (
									select sum(amount)
									from payment
									group by customer_id
									order by sum(amount) desc limit 1));
                                    



-- 5) Ingreso promedio por alquiler en cada tienda
select store_id,round(avg(amount),2) as average_income
from store
join inventory using(store_id)
join rental using(inventory_id)
join payment using(rental_id)
group by store_id
order by average_income desc;

-- 6) Ventas totales por categoría ordenadas
select distinct category.name,sum(amount) as income
from category 
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
join payment using(rental_id)
group by category_id
order by income desc;

-- 7) Actores con al menos diez películas de categorías distintas
select distinct first_name,last_name,count(category.name) as num_category
from category
join film_category using(category_id)
join film using(film_id)
join film_actor using(film_id)
join actor using(actor_id)
group by actor_id
having count(category.name) >=10
order by num_category asc;

select name
from category;

-- 8) Tiendas con más stock disponible
select 


-- 9) Películas que nunca han sido alquiladas
-- 10) Diez películas con mayor diferencia entre coste de reposición y tarifa de alquiler
-- 11) Películas con más de tres actores y duración menor a 90 minutos
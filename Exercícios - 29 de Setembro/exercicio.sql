-- Clientes e Endereços:
-- Listar o nome completo dos clientes e o endereço onde moram.
-- Tabelas: customer e address.
-- Condição de Join: customer.address_id = address.address_id.
SELECT
  customer.first_name || ' ' || customer.last_name AS full_name,
  address.address
FROM customer
JOIN address
  ON customer.address_id = address.address_id;



-- Filmes e Categorias
-- Exibir o título do filme e o nome de sua categoria
-- Tabelas: film, film_category e category.
SELECT
  film.title,
  category.name AS category_name
FROM film
JOIN film_category
  ON film.film_id = film_category.film_id
JOIN category
  ON film_category.category_id = category.category_id;


-- Pagamentos de Clientes
-- Mostrar o nome completo do cliente e o valor (amount) e a data
-- (payment_date) de cada pagamento que ele fez
-- Tabelas: customer e payment.
SELECT
  customer.first_name || ' ' || customer.last_name AS full_name,
  payment.amount,
  payment.payment_date
FROM customer
JOIN payment
  ON customer.customer_id = payment.customer_id;


-- Atores e Filmes
-- Listar o nome completo de todos os atores e o título de cada
-- filme em que atuaram.
-- Tabelas: actor, film_actor e film.
SELECT
  actor.first_name || ' ' || actor.last_name AS actor_name,
  film.title
FROM actor
JOIN film_actor
  ON actor.actor_id = film_actor.actor_id
JOIN film
  ON film_actor.film_id = film.film_id;


-- Funcionários e Lojas
-- Listar o nome completo dos funcionários e o endereço da loja em
-- que trabalham
-- Tabelas: staff, store e address.
SELECT
  staff.first_name || ' ' || staff.last_name AS staff_name,
  address.address
FROM staff
JOIN store
  ON staff.store_id = store.store_id
JOIN address
  ON store.address_id = address.address_id;
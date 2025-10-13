-- Exercícios - JOINS

-- 1- Listar o título dos filmes que pertencem apenas a 
-- categoria 'Horror' e que têm um custo de substituição
-- (replacement_cost) acima de $20.00.
SELECT title
FROM film
WHERE category = 'Horror'
AND replacement_cost > 20.00;



-- 2- Exibir o nome completo do cliente e a soma total de 
-- todos os pagamentos que ele fez. Ordene pelo valor 
-- total decrescente.
SELECT 
    first_name || ' ' || last_name AS nome_completo,
    SUM(amount) AS total_pagamentos
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name
ORDER BY total_pagamentos DESC;



-- 3- Para cada aluguel (rental), mostre o nome do cliente, 
-- o título do filme alugado e o nome do funcionário (staff) 
-- que processou o aluguel. 
-- Tabelas: customer, rental, inventory, film e staff.
SELECT 
    customer.first_name || ' ' || customer.last_name AS nome_cliente,
    film.title AS titulo_filme,
    staff.first_name || ' ' || staff.last_name AS nome_funcionario
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN staff ON rental.staff_id = staff.staff_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;



-- 4- Listar o título de cada filme e a quantidade de atores 
-- que participaram dele. Ordene pela quantidade de atores 
-- (do filme com mais para o com menos).
SELECT 
    film.title AS titulo_filme,
    COUNT(film_actor.actor_id) AS quantidade_atores
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id, film.title
ORDER BY quantidade_atores DESC;



-- 5- Exibir o nome da cidade e a quantidade de lojas 
-- localizadas nela
SELECT 
    city.city AS nome_cidade,
    COUNT(store.store_id) AS quantidade_lojas
FROM city
JOIN address ON city.city_id = address.city_id
JOIN store ON address.address_id = store.address_id
GROUP BY city.city
ORDER BY quantidade_lojas DESC;



-- Exercícios - VIEWS

-- 6- Crie uma View chamada membros_vip baseada na tabela 
-- customer que inclua apenas o nome completo 
-- (first_name e last_name), o email e o ID do cliente.
-- Oculte a coluna create_date e o address_id para simplificar
-- a visão para equipes de marketing.
CREATE VIEW membros_vip AS
SELECT 
    customer.customer_id,
    customer.first_name || ' ' || customer.last_name AS nome_completo,
    customer.email
FROM customer;
SELECT * FROM membros_vip;



-- 7- Modifique a View membros_vip para incluir a cidade do
-- cliente. Use CREATE OR REPLACE VIEW para fazer a 
-- alteração.
CREATE OR REPLACE VIEW membros_vip AS
SELECT 
    customer.customer_id,
    customer.first_name || ' ' || customer.last_name AS nome_completo,
    customer.email,
    city.city AS nome_cidade
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
SELECT * FROM membros_vip;



-- 8- Crie uma View chamada inventario_filmes_loja que 
-- mostre o título do filme, o nome da loja e a quantidade 
-- (COUNT) de cópias de cada filme disponível em cada loja.
-- A View deve combinar as tabelas film, inventory e
-- store.
CREATE VIEW inventario_filmes_loja AS
SELECT 
    film.title AS titulo_filme,
    store.store_id AS id_loja,
    COUNT(inventory.inventory_id) AS quantidade_copias
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY film.title, store.store_id
ORDER BY film.title, store.store_id;
SELECT * FROM inventario_filmes_loja;
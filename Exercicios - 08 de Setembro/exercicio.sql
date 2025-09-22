-- 1. Liste os filmes cujo rating é "PG" OU "PG-13"
SELECT title, rating FROM film 
WHERE rating IN ('PG', 'PG-13');

-- 2. Liste os filmes cujo rating são diferentes de "R", "NC-17"
SELECT title, rating FROM film 
WHERE rating NOT IN ('R', 'NC-17');

-- 3. Mostre os filmes cujo replacement_cost esteja entre 10 e 20
SELECT title, replacement_cost 
FROM film 
WHERE replacement_cost 
BETWEEN 10 AND 20;

-- 4. Encontre todos os filmes cujo título começa com a letra A
SELECT title 
FROM film
WHERE title ILIKE 'A%';

-- 5. Encontre todos os filmes cujo título contém a palavra "love"
SELECT title 
FROM film
WHERE title ILIKE '%love%';

-- 6. Conte quantos filmes possuem duração entre 90 e 120 minutos
SELECT COUNT(title) FROM film
WHERE length 
BETWEEN 90 AND 120;

-- 7. Calcule a média do "rental_rate" dos filmes com classificação PG-13
SELECT AVG(rental_rate) FROM film
WHERE rating = 'PG-13';

-- 8. Calcule a soma dos "replacement_cost" de todos os filmes classificados como R
SELECT SUM(replacement_cost) FROM film 
WHERE rating = 'R';

-- 9. Mostre a média da duração dos filmes cujo título contém a palavra "super"
SELECT AVG(length) FROM film
WHERE title ILIKE '%super%';

-- 10. Liste a média da duração dos filmes cujo "rating" seja "PG" ou "R"
SELECT AVG(length) FROM film
WHERE rating In ('PG', 'R');

-- Questionário Link: https://forms.gle/G97RCkZi5xquQJ2f6
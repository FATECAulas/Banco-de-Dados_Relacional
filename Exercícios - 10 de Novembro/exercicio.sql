-- Exercícios - Case/When
-- 1- Classificar a duração dos filmes
-- Crie uma consulta que liste o título do filme e classifique sua duração
-- (length) em categorias:
-- "Curta": se a duração for menor ou igual a 60 minutos.
-- "Média": se a duração for maior que 60 minutos e menor ou igual
-- a 120 minutos.
-- "Longa": se a duração for maior que 120 minutos.
SELECT
  film_id,
  title,
  length,
  CASE
    WHEN length <= 60 THEN 'Curta'
    WHEN length > 60 AND length <= 120 THEN 'Média'
    WHEN length > 120 THEN 'Longa'
    ELSE 'Desconhecido'
  END AS categoria_duracao
FROM film
ORDER BY title;



-- 2- Listar o status de devolução dos filmes (Tabela rental)
-- Crie uma consulta que liste o ID do aluguel (rental_id), a data
-- do aluguel (rental_date) e exiba o Status da devolução com
-- base na coluna return_date:
-- "Devolvido": se return_date não for NULL.
-- "Pendente": se return_date for NULL.
SELECT
  rental_id,
  rental_date,
  return_date,
  CASE
    WHEN return_date IS NOT NULL THEN 'Devolvido'
    ELSE 'Pendente'
  END AS status_devolucao
FROM rental
ORDER BY rental_date DESC;



-- 3- Classificar os pagamentos por categoria (Tabela payment)
-- Crie uma consulta que liste o ID do pagamento (payment_id), o
-- valor (amount) e categorize o valor pago:
-- "Baixo": se amount for menor que 2.00.
-- "Normal": se amount for entre 2.00 (inclusive) e 4.99 (inclusive).
-- "Alto": se amount for maior ou igual a 5.00.
SELECT
  payment_id,
  amount,
  CASE
    WHEN amount < 2.00 THEN 'Baixo'
    WHEN amount >= 2.00 AND amount <= 4.99 THEN 'Normal'
    WHEN amount >= 5.00 THEN 'Alto'
    ELSE 'Desconhecido'
  END AS categoria_valor
FROM payment
ORDER BY amount;



-- 4- Classificar os clientes por atividade (Tabelas customer e
-- rental)
-- Classifique o cliente com base no número total de aluguéis .
-- Dica: podemos utilizar o COUNT em conjunto com CASE/WHEN
-- "Ocasional": se tiver até 15 aluguéis.
-- "Regular": se tiver de 16 a 30 aluguéis.
-- "VIP": se tiver mais de 30 aluguéis.
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name AS cliente,
  COUNT(r.rental_id) AS total_alugueis,
  CASE
    WHEN COUNT(r.rental_id) <= 15 THEN 'Ocasional'
    WHEN COUNT(r.rental_id) BETWEEN 16 AND 30 THEN 'Regular'
    WHEN COUNT(r.rental_id) > 30 THEN 'VIP'
    ELSE 'Desconhecido'
  END AS nivel_atividade
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alugueis DESC;



-- 5- Status de estoque (tabelas film e inventory)
-- Liste cada filme e mostre uma coluna status_estoque:
-- "Esgotado" se não houver cópias disponíveis em inventory, ou
-- seja, se COUNT = 0
-- "Disponível" caso contrário
SELECT
  f.film_id,
  f.title,
  COUNT(i.inventory_id) AS copias_no_estoque,
  CASE
    WHEN COUNT(i.inventory_id) = 0 THEN 'Esgotado'
    ELSE 'Disponível'
  END AS status_estoque
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;



-- 6 - Categoria de gastos do cliente
-- Para cada cliente (customer_id), calcule o total gasto em payment
-- e crie uma coluna nivel_cliente.
-- Dica: Utilize a função SUM()
-- "Bronze" se total < 50
-- "Prata" se total entre 50 e 100
-- "Ouro" se total > 100
SELECT
  p.customer_id,
  COALESCE(SUM(p.amount), 0) AS total_gasto,
  CASE
    WHEN COALESCE(SUM(p.amount), 0) < 50 THEN 'Bronze'
    WHEN COALESCE(SUM(p.amount), 0) BETWEEN 50 AND 100 THEN 'Prata'
    WHEN COALESCE(SUM(p.amount), 0) > 100 THEN 'Ouro'
    ELSE 'Desconhecido'
  END AS nivel_cliente
FROM payment p
GROUP BY p.customer_id
ORDER BY total_gasto DESC;
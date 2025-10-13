-- Exercícios - JOINS

-- 1- Listar o título dos filmes que pertencem apenas a 
-- categoria 'Horror' e que têm um custo de substituição
-- (replacement_cost) acima de $20.00.

-- 2- Exibir o nome completo do cliente e a soma total de 
-- todos os pagamentos que ele fez. Ordene pelo valor 
-- total decrescente.

-- 3- Para cada aluguel (rental), mostre o nome do cliente, 
-- o título do filme alugado e o nome do funcionário (staff) 
-- que processou o aluguel. 
-- Tabelas: customer, rental, inventory, film e staff.

-- 4- Listar o título de cada filme e a quantidade de atores 
-- que participaram dele. Ordene pela quantidade de atores 
-- (do filme com mais para o com menos).

-- 5- Exibir o nome da cidade e a quantidade de lojas 
-- localizadas nela



-- Exercícios - VIEWS

-- 6- Crie uma View chamada membros_vip baseada na tabela 
-- customer que inclua apenas o nome completo 
-- (first_name e last_name), o email e o ID do cliente.
-- Oculte a coluna create_date e o address_id para simplificar
-- a visão para equipes de marketing.

-- 7- Modifique a View membros_vip para incluir a cidade do
-- cliente. Use CREATE OR REPLACE VIEW para fazer a 
-- alteração.

-- 8- Crie uma View chamada inventario_filmes_loja que 
-- mostre o título do filme, o nome da loja e a quantidade 
-- (COUNT) de cópias de cada filme disponível em cada loja.
-- A View deve combinar as tabelas film, inventory e
-- store.
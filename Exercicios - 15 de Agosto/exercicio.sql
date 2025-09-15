-- Exercício 1: Tabela customers (clientes)
-- Crie uma tabela chamada customers com as seguintes colunas:
-- id: Chave primária de número inteiro que é gerada
-- automaticamente (SERIAL).
-- name: Nome do cliente, tipo VARCHAR com até 100 caracteres,
-- que não pode ser nulo (NOT NULL).
-- email: Endereço de e-mail do cliente, tipo VARCHAR com até 150
-- caracteres, que não pode ser nulo e deve ser único (UNIQUE).
-- created_at: Data de registro do cliente, tipo DATE, com valor
-- padrão sendo a data e hora atuais (NOW()).
-- updated_at: tipo DATE, com valor padrão sendo a data e hora
-- atuais (NOW()).
CREATE TABLE IF NOT exists customers(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


-- Exercício 2: Tabela products (produtos)
-- Crie uma tabela chamada products com as seguintes
-- especificações:
-- id: Chave primária de número inteiro (SERIAL).
-- name: Nome do produto, tipo VARCHAR com até 100
-- caracteres, que não pode ser nulo.
-- cost: Preço do produto, tipo NUMERIC com precisão de 10
-- e escala de 2.
-- quantity: Quantidade em estoque, tipo INTEGER, que não
-- pode ser nulo.
-- created_at: Data de registro do cliente, tipo DATE, com
-- valor padrão sendo a data e hora atuais (NOW()).
-- updated_at: tipo DATE, com valor padrão sendo a data e
-- hora atuais (NOW()).
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cost NUMERIC(10, 2),
    quantity INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


-- Exercício 3: Tabela orders (pedidos)
-- Crie uma tabela chamada orders que se relacione com as tabelas
-- customers e products:
-- id: Chave primária de número inteiro (SERIAL)
-- customer_id: Chave estrangeira que referencia a coluna id da
-- tabela customers
-- product_id: Chave estrangeira que referencia a coluna id da tabela
-- products
-- quantity: Quantidade do produto, tipo INTEGER, que deve ser
-- maior que 0 (CHECK).
-- created_at: Data de registro do cliente, tipo DATE, com valor
-- padrão sendo a data e hora atuais (NOW()).
CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    customer_id integer REFERENCES customers (id),
    product_id integer REFERENCES products (id),
    quantity INTEGER CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT NOW()
);
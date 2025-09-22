-- Exercício 4: funcionários e departamentos
-- Crie duas tabelas para simular um sistema de gerenciamento defuncionários. 
-- Tabelas departments e employees
-- Tabela departments:
-- id: Chave primária de número inteiro (SERIAL).
-- name: Nome do departamento, tipo VARCHAR com até 50 caracteres,
-- que deve ser único e não nulo.
-- Tabela employees:
-- id: Chave primária de número inteiro (SERIAL).
-- name: Nome do funcionário, tipo VARCHAR com até 100 caracteres, não nulo.
-- salary: Salário do funcionário, tipo NUMERIC com precisão de 10 
-- e escala de 2, que deve ser maior ou igual a 0 (CHECK).
-- department_id: Chave estrangeira que referencia a coluna
-- department_id da tabela departments.
-- Se um departamento for excluído, o valor desta coluna deve
-- ser definido como nulo (ON DELETE SET NULL).
-- Adicione índice na coluna de chave estrangeira
-- Adicione pelo menos 5 registros em cada tabela
-- Faça as associações entre os registros
-- Remova os registros da tabela departments e observe o resultado 
-- na tabela employees
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO departments (name) VALUES
('Desenvolvimento'),
('MARKETING'),
('Desing'),
('Segurança'),
('RH');

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) CHECK (salary >= 0),
    department_id integer REFERENCES departments (id) 
    ON DELETE SET NULL
);

INSERT INTO employees (name) VALUES
('Desenvolvimento'),
('MARKETING'),
('Desing'),
('Segurança'),
('RH');


-- Exercício 5: Tabela de alunos
-- Crie uma tabela chamada students (alunos)
-- id: Chave primária.
-- name: Varchar
-- birth_date: Date
-- created_at: Timestamp.
CREATE TABLE students(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    birth_date
    created_at
);



-- Exercício 6: Tabela de cursos (com restrição CHECK)
-- Crie uma tabela chamada courses com as seguintes colunas:
-- id: Chave primária de número inteiro (SERIAL).
-- name: Nome do curso, tipo VARCHAR com até 60 caracteres, não nulo.
-- status: Status do curso, tipo VARCHAR com até 20 caracteres, com uma
-- restrição CHECK que só permite os valores 'published','draft' ou'inactive'.
-- created_at: Data de publicação, tipo DATE.
CREATE TABLE courses(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60)NOT NULL,
    status VARCHAR(20) CHECK
    created_at
);



-- Exercício 7: Tabela com chave primária composta
-- Crie uma tabela chamada registrations (matrículas) para registrar a
-- matrícula de alunos em cursos. Esta tabela não precisa de uma chave
-- primária serial.
-- student_id: Número inteiro.
-- course_id: Número inteiro
-- created_at: Data da matrícula.
-- Defina uma chave primária composta que combine as colunas
-- student_id e course_id.
-- Após criar cada tabela, use \dt no psql para listar todas as tabelas e \d
-- nome_tabela para inspecionar a estrutura da tabela recém-criada.
-- Tente inserir alguns dados de teste em cada tabela para ver se as
-- restrições (NOT NULL, UNIQUE, CHECK, etc.) funcionam conforme o
-- esperado
CREATE TABLE courses(
    id SERIAL PRIMARY KEY,
    name VARCHAR(60)NOT NULL,
    status VARCHAR(20) CHECK
    created_at
);
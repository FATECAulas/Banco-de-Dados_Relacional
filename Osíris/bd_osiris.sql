CREATE TABLE USUARIO(
    id SERIAL PRIMARY KEY,
    Email VARCHAR(70) NOT NULL,
    Senha VARCHAR(300) NOT NULL,
    Telefone VARCHAR(70) NOT NULL,
    Tipo VARCHAR(20) CHECK (Tipo IN ('Aluno','Coordenador','Professor', 'Empreendedor')) NOT NULL
);

INSERT INTO USUARIO (Email, Senha, Telefone, Tipo)
SELECT
    'usuario' || i || '@exemplo.com' AS Email,
    'senha123' AS Senha,  
    '+55' || (1000000000 + (i % 900000000)) AS Telefone,
    CASE (i % 4)
        WHEN 0 THEN 'Aluno'
        WHEN 1 THEN 'Coordenador'
        WHEN 2 THEN 'Professor'
        WHEN 3 THEN 'Empreendedor'
    END AS Tipo
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE SEMESTRE(
    id SERIAL PRIMARY KEY,
    Descricao CHAR(1) NOT NULL
);

INSERT INTO SEMESTRE (Descricao)
SELECT 
    CAST(((i - 1) % 8 + 1) AS CHAR(1)) AS Descricao
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE STATUS_PROJETO(
    id SERIAL PRIMARY KEY,
    Descricao VARCHAR(70) NOT NULL
);

INSERT INTO STATUS_PROJETO (Descricao)
SELECT
    CASE (i % 4)
        WHEN 1 THEN 'Em Planejamento'
        WHEN 2 THEN 'Em Andamento'
        WHEN 3 THEN 'Concluído'
        WHEN 0 THEN 'Cancelado'
    END AS Descricao
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE GRUPO(
    id SERIAL PRIMARY KEY,
    SEMESTRE_id integer REFERENCES SEMESTRE (id),
    Nome VARCHAR(70) NOT NULL
);

INSERT INTO GRUPO (SEMESTRE_id, Nome)
SELECT
    ((i - 1) % 8 + 1) AS SEMESTRE_id,
    CASE (i % 10)
        WHEN 0 THEN 'Equipe Inovação ' || i
        WHEN 1 THEN 'Grupo Águia ' || i
        WHEN 2 THEN 'Time Orion ' || i
        WHEN 3 THEN 'Projeto Fênix ' || i
        WHEN 4 THEN 'Equipe Delta ' || i
        WHEN 5 THEN 'Grupo Lambda ' || i
        WHEN 6 THEN 'Time Aurora ' || i
        WHEN 7 THEN 'Projeto Solaris ' || i
        WHEN 8 THEN 'Equipe Titan ' || i
        WHEN 9 THEN 'Grupo Apex ' || i
    END AS Nome
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE ALUNO(
    id SERIAL PRIMARY KEY,
    USUARIO_id integer REFERENCES USUARIO (id),
    GRUPO_id integer REFERENCES GRUPO (id),
    RA CHAR(13) NOT NULL,
    Nome VARCHAR(70) NOT NULL
);

INSERT INTO ALUNO (USUARIO_id, GRUPO_id, RA, Nome)
SELECT
    ((i - 1) % 1000 + 1) AS USUARIO_id, 
    ((i - 1) % 1000 + 1) AS GRUPO_id,  
    LPAD(CAST((1000000000000 + i) AS TEXT), 13, '0') AS RA,
    CASE (i % 20)
        WHEN 0 THEN 'Lucas Almeida'
        WHEN 1 THEN 'Mariana Oliveira'
        WHEN 2 THEN 'Pedro Santos'
        WHEN 3 THEN 'Ana Clara Souza'
        WHEN 4 THEN 'Rafael Lima'
        WHEN 5 THEN 'Beatriz Costa'
        WHEN 6 THEN 'João Pedro Ribeiro'
        WHEN 7 THEN 'Larissa Fernandes'
        WHEN 8 THEN 'Gabriel Martins'
        WHEN 9 THEN 'Isabela Rocha'
        WHEN 10 THEN 'Matheus Nogueira'
        WHEN 11 THEN 'Camila Carvalho'
        WHEN 12 THEN 'Felipe Moreira'
        WHEN 13 THEN 'Sofia Monteiro'
        WHEN 14 THEN 'Thiago Freitas'
        WHEN 15 THEN 'Luiza Mendes'
        WHEN 16 THEN 'Bruno Azevedo'
        WHEN 17 THEN 'Carolina Duarte'
        WHEN 18 THEN 'Enzo Gonçalves'
        WHEN 19 THEN 'Giovana Pires'
    END || ' ' || i AS Nome
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE HISTORICO_ALUNO(
    id SERIAL PRIMARY KEY,
    ALUNO_id integer REFERENCES ALUNO (id),
    GRUPO_id integer REFERENCES GRUPO (id)
);

INSERT INTO HISTORICO_ALUNO (ALUNO_id, GRUPO_id)
SELECT
    ((i - 1) % 1000 + 1) AS ALUNO_id,  
    ((i - 1) % 1000 + 1) AS GRUPO_id   
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE DOCENTE(
    id SERIAL PRIMARY KEY,
    USUARIO_id integer REFERENCES USUARIO (id),
    Nome VARCHAR(70) NOT NULL,
    Papel VARCHAR(70) NOT NULL
);

INSERT INTO DOCENTE (USUARIO_id, Nome, Papel)
SELECT
    ((i - 1) % 1000 + 1) AS USUARIO_id,  
    CASE (i % 20)
        WHEN 0 THEN 'André Pereira'
        WHEN 1 THEN 'Fernanda Souza'
        WHEN 2 THEN 'Ricardo Santos'
        WHEN 3 THEN 'Juliana Carvalho'
        WHEN 4 THEN 'Paulo Almeida'
        WHEN 5 THEN 'Vanessa Ribeiro'
        WHEN 6 THEN 'Felipe Oliveira'
        WHEN 7 THEN 'Tatiane Castro'
        WHEN 8 THEN 'Bruno Costa'
        WHEN 9 THEN 'Camila Freitas'
        WHEN 10 THEN 'Leonardo Rocha'
        WHEN 11 THEN 'Renata Martins'
        WHEN 12 THEN 'Rogério Lima'
        WHEN 13 THEN 'Bianca Mendes'
        WHEN 14 THEN 'Diego Moreira'
        WHEN 15 THEN 'Marina Duarte'
        WHEN 16 THEN 'Eduardo Nogueira'
        WHEN 17 THEN 'Carla Monteiro'
        WHEN 18 THEN 'Gustavo Azevedo'
        WHEN 19 THEN 'Priscila Teixeira'
    END || ' ' || i AS Nome,
    CASE (i % 5)
        WHEN 0 THEN 'Professor Orientador'
        WHEN 1 THEN 'Coordenador de Curso'
        WHEN 2 THEN 'Avaliador'
        WHEN 3 THEN 'Supervisor de Estágio'
        WHEN 4 THEN 'Docente Convidado'
    END AS Papel
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE STATUS_AVALIACAO(
    id SERIAL PRIMARY KEY,
    Descricao VARCHAR(70) NOT NULL
);

INSERT INTO STATUS_AVALIACAO (Descricao)
SELECT
    CASE (i % 4)
        WHEN 0 THEN 'Pendente'
        WHEN 1 THEN 'Em Análise'
        WHEN 2 THEN 'Aprovado'
        WHEN 3 THEN 'Reprovado'
    END || ' ' || i AS Descricao
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE EMPREENDEDOR(
    id SERIAL PRIMARY KEY,
    USUARIO_id integer REFERENCES USUARIO (id),
    Nome VARCHAR(70) NOT NULL,
    Setor VARCHAR(70) NOT NULL,
    CNPJ CHAR(14) NOT NULL
);

INSERT INTO EMPREENDEDOR (USUARIO_id, Nome, Setor, CNPJ)
SELECT
    ((i - 1) % 1000 + 1) AS USUARIO_id, 
    CASE (i % 20)
        WHEN 0 THEN 'Lucas Almeida'
        WHEN 1 THEN 'Mariana Oliveira'
        WHEN 2 THEN 'Pedro Santos'
        WHEN 3 THEN 'Ana Clara Souza'
        WHEN 4 THEN 'Rafael Lima'
        WHEN 5 THEN 'Beatriz Costa'
        WHEN 6 THEN 'João Pedro Ribeiro'
        WHEN 7 THEN 'Larissa Fernandes'
        WHEN 8 THEN 'Gabriel Martins'
        WHEN 9 THEN 'Isabela Rocha'
        WHEN 10 THEN 'Matheus Nogueira'
        WHEN 11 THEN 'Camila Carvalho'
        WHEN 12 THEN 'Felipe Moreira'
        WHEN 13 THEN 'Sofia Monteiro'
        WHEN 14 THEN 'Thiago Freitas'
        WHEN 15 THEN 'Luiza Mendes'
        WHEN 16 THEN 'Bruno Azevedo'
        WHEN 17 THEN 'Carolina Duarte'
        WHEN 18 THEN 'Enzo Gonçalves'
        WHEN 19 THEN 'Giovana Pires'
    END || ' ' || i AS Nome,
    CASE (i % 10)
        WHEN 0 THEN 'Tecnologia'
        WHEN 1 THEN 'Educação'
        WHEN 2 THEN 'Saúde'
        WHEN 3 THEN 'Alimentação'
        WHEN 4 THEN 'Comércio'
        WHEN 5 THEN 'Logística'
        WHEN 6 THEN 'Consultoria'
        WHEN 7 THEN 'Engenharia'
        WHEN 8 THEN 'Marketing'
        WHEN 9 THEN 'Entretenimento'
    END AS Setor,
    LPAD((10000000000000 + i)::TEXT, 14, '0') AS CNPJ  
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE DEMANDA(
    id SERIAL PRIMARY KEY,
    STATUS_AVALIACAO_id integer REFERENCES STATUS_AVALIACAO (id),
    EMPREENDEDOR_id integer REFERENCES EMPREENDEDOR (id),
    Titulo VARCHAR(70) NOT NULL,
    Descricao VARCHAR(70) NOT NULL,
    Data_Envio DATE NOT NULL,
    Publico_Alvo VARCHAR(70) NOT NULL
);

INSERT INTO DEMANDA (STATUS_AVALIACAO_id, EMPREENDEDOR_id, Titulo, Descricao, Data_Envio, Publico_Alvo)
SELECT
    ((i - 1) % 1000 + 1) AS STATUS_AVALIACAO_id,
    ((i - 1) % 1000 + 1) AS EMPREENDEDOR_id,
    CASE (i % 10)
        WHEN 0 THEN 'Demanda de Software ' || i
        WHEN 1 THEN 'Projeto Educacional ' || i
        WHEN 2 THEN 'Aplicativo Mobile ' || i
        WHEN 3 THEN 'Serviço de Consultoria ' || i
        WHEN 4 THEN 'Ferramenta de Marketing ' || i
        WHEN 5 THEN 'Plataforma Online ' || i
        WHEN 6 THEN 'Sistema de Automação ' || i
        WHEN 7 THEN 'Projeto IoT ' || i
        WHEN 8 THEN 'Análise de Dados ' || i
        WHEN 9 THEN 'Serviço de Atendimento ' || i
    END AS Titulo,
    CASE (i % 10)
        WHEN 0 THEN 'Desenvolver software customizado para empresa'
        WHEN 1 THEN 'Criar projeto educacional inovador'
        WHEN 2 THEN 'Desenvolver aplicativo para dispositivos móveis'
        WHEN 3 THEN 'Oferecer serviços de consultoria empresarial'
        WHEN 4 THEN 'Ferramenta de marketing digital para vendas'
        WHEN 5 THEN 'Plataforma online para gestão de processos'
        WHEN 6 THEN 'Automatizar processos internos do cliente'
        WHEN 7 THEN 'Projeto IoT para monitoramento remoto'
        WHEN 8 THEN 'Realizar análise de dados estratégicos'
        WHEN 9 THEN 'Serviço de atendimento ao cliente aprimorado'
    END AS Descricao,
    make_date(2025, ((i % 12) + 1), ((i % 28) + 1)) AS Data_Envio,
    CASE (i % 5)
        WHEN 0 THEN 'Estudantes'
        WHEN 1 THEN 'Empresas'
        WHEN 2 THEN 'Profissionais'
        WHEN 3 THEN 'Público Geral'
        WHEN 4 THEN 'Startups'
    END AS Publico_Alvo
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE PAREAMENTO(
    id SERIAL PRIMARY KEY,
    STATUS_PROJETO_id integer REFERENCES STATUS_PROJETO (id),
    GRUPO_id integer REFERENCES GRUPO (id),
    DEMANDA_id integer REFERENCES DEMANDA (id),
    Data DATE NOT NULL
);

INSERT INTO PAREAMENTO (STATUS_PROJETO_id, GRUPO_id, DEMANDA_id, Data)
SELECT
    ((i - 1) % 1000 + 1) AS STATUS_PROJETO_id,
    ((i - 1) % 1000 + 1) AS GRUPO_id,
    ((i - 1) % 1000 + 1) AS DEMANDA_id,
    make_date(2025, ((i % 12) + 1), ((i % 28) + 1)) AS Data
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE PROJETO(
    id SERIAL PRIMARY KEY,
    DOCENTE_id integer REFERENCES DOCENTE (id),
    PAREAMENTO_id integer REFERENCES PAREAMENTO (id),
    STATUS_PROJETO_id integer REFERENCES STATUS_PROJETO (id),
    GRUPO_id integer REFERENCES GRUPO (id),
    DEMANDA_id integer REFERENCES DEMANDA (id),
    Titulo VARCHAR(70) NOT NULL,
    Descricao VARCHAR(70) NOT NULL,
    Prazo VARCHAR(70) NOT NULL,
    Tipo VARCHAR(70) NOT NULL
);

INSERT INTO PROJETO (DOCENTE_id, PAREAMENTO_id, STATUS_PROJETO_id, GRUPO_id, DEMANDA_id, Titulo, Descricao, Prazo, Tipo)
SELECT
    ((i - 1) % 1000 + 1) AS DOCENTE_id,
    ((i - 1) % 1000 + 1) AS PAREAMENTO_id,
    ((i - 1) % 1000 + 1) AS STATUS_PROJETO_id,
    ((i - 1) % 1000 + 1) AS GRUPO_id,
    ((i - 1) % 1000 + 1) AS DEMANDA_id,
    CASE (i % 10)
        WHEN 0 THEN 'Sistema de Controle ' || i
        WHEN 1 THEN 'Aplicativo Educacional ' || i
        WHEN 2 THEN 'Plataforma Online ' || i
        WHEN 3 THEN 'Ferramenta de Gestão ' || i
        WHEN 4 THEN 'Sistema de Relatórios ' || i
        WHEN 5 THEN 'Aplicativo de Marketplace ' || i
        WHEN 6 THEN 'Sistema de Automação ' || i
        WHEN 7 THEN 'Projeto de IoT ' || i
        WHEN 8 THEN 'Ferramenta de Análise ' || i
        WHEN 9 THEN 'Plataforma de Aprendizagem ' || i
    END AS Titulo,
    CASE (i % 10)
        WHEN 0 THEN 'Desenvolver sistema completo para gerenciamento acadêmico'
        WHEN 1 THEN 'Criar aplicativo para auxiliar estudantes e professores'
        WHEN 2 THEN 'Plataforma web para integração de dados'
        WHEN 3 THEN 'Ferramenta de gestão de projetos e tarefas'
        WHEN 4 THEN 'Sistema para geração de relatórios automáticos'
        WHEN 5 THEN 'Aplicativo para conectar compradores e vendedores'
        WHEN 6 THEN 'Automatizar processos internos do setor'
        WHEN 7 THEN 'Projeto IoT para monitoramento remoto'
        WHEN 8 THEN 'Ferramenta para análise de dados estratégicos'
        WHEN 9 THEN 'Plataforma de aprendizagem interativa'
    END AS Descricao,
    '2025-12-' || LPAD(((i % 28) + 1)::text, 2, '0') AS Prazo, 
    CASE (i % 5)
        WHEN 0 THEN 'Acadêmico'
        WHEN 1 THEN 'Empresarial'
        WHEN 2 THEN 'Pesquisa'
        WHEN 3 THEN 'Extensão'
        WHEN 4 THEN 'Inovação'
    END AS Tipo
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE ENTREGA(
    id SERIAL PRIMARY KEY,
    PROJETO_id integer REFERENCES PROJETO (id),
    Titulo VARCHAR(70) NOT NULL,
    Descricao VARCHAR(70) NOT NULL,
    Entrega DATE NOT NULL,
    Link VARCHAR(300) NOT NULL
);

INSERT INTO ENTREGA (PROJETO_id, Titulo, Descricao, Entrega, Link)
SELECT
    ((i - 1) % 1000 + 1) AS PROJETO_id,
    CASE (i % 10)
        WHEN 0 THEN 'Entrega Inicial ' || i
        WHEN 1 THEN 'Documento Técnico ' || i
        WHEN 2 THEN 'Protótipo Funcional ' || i
        WHEN 3 THEN 'Relatório Intermediário ' || i
        WHEN 4 THEN 'Apresentação Final ' || i
        WHEN 5 THEN 'Código Fonte ' || i
        WHEN 6 THEN 'Manual do Usuário ' || i
        WHEN 7 THEN 'Demonstração Online ' || i
        WHEN 8 THEN 'Teste de Qualidade ' || i
        WHEN 9 THEN 'Versão Beta ' || i
    END AS Titulo,
    CASE (i % 10)
        WHEN 0 THEN 'Primeira entrega do projeto para avaliação inicial'
        WHEN 1 THEN 'Documento detalhando requisitos e especificações'
        WHEN 2 THEN 'Protótipo funcional implementado'
        WHEN 3 THEN 'Relatório do progresso do projeto'
        WHEN 4 THEN 'Apresentação final para banca'
        WHEN 5 THEN 'Código-fonte completo do projeto'
        WHEN 6 THEN 'Manual do usuário e instruções de uso'
        WHEN 7 THEN 'Demonstração online do projeto'
        WHEN 8 THEN 'Testes de qualidade realizados'
        WHEN 9 THEN 'Versão beta para avaliação interna'
    END AS Descricao,
    make_date(2025, ((i % 12) + 1), ((i % 28) + 1)) AS Entrega,
    'https://linkfalso.com/entrega/' || i AS Link
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE COORDENADOR(
    id SERIAL PRIMARY KEY,
    USUARIO_id integer REFERENCES USUARIO (id),
    Nome VARCHAR(70) NOT NULL
);

INSERT INTO COORDENADOR (USUARIO_id, Nome)
SELECT
    ((i - 1) % 1000 + 1) AS USUARIO_id,  
    CASE (i % 20)
        WHEN 0 THEN 'André Pereira'
        WHEN 1 THEN 'Fernanda Souza'
        WHEN 2 THEN 'Ricardo Santos'
        WHEN 3 THEN 'Juliana Carvalho'
        WHEN 4 THEN 'Paulo Almeida'
        WHEN 5 THEN 'Vanessa Ribeiro'
        WHEN 6 THEN 'Felipe Oliveira'
        WHEN 7 THEN 'Tatiane Castro'
        WHEN 8 THEN 'Bruno Costa'
        WHEN 9 THEN 'Camila Freitas'
        WHEN 10 THEN 'Leonardo Rocha'
        WHEN 11 THEN 'Renata Martins'
        WHEN 12 THEN 'Rogério Lima'
        WHEN 13 THEN 'Bianca Mendes'
        WHEN 14 THEN 'Diego Moreira'
        WHEN 15 THEN 'Marina Duarte'
        WHEN 16 THEN 'Eduardo Nogueira'
        WHEN 17 THEN 'Carla Monteiro'
        WHEN 18 THEN 'Gustavo Azevedo'
        WHEN 19 THEN 'Priscila Teixeira'
    END || ' ' || i AS Nome
FROM generate_series(1, 1000) AS s(i);

-------------------------------------------------------------------------------------------------

CREATE TABLE DIFICULDADE(
    id SERIAL PRIMARY KEY,
    Descricao VARCHAR(20) CHECK (Descricao IN ('Básico','Intermediário','Difícil')) NOT NULL
);

INSERT INTO DIFICULDADE (Descricao)
SELECT
  CASE (i % 3)
    WHEN 0 THEN 'Básico'
    WHEN 1 THEN 'Intermediário'
    WHEN 2 THEN 'Difícil'
  END AS Descricao
FROM generate_series(1, 1000) AS s(i);


-------------------------------------------------------------------------------------------------

CREATE TABLE AVALIACAO_DEMANDA(
    id SERIAL PRIMARY KEY,
    DEMANDA_id integer REFERENCES DEMANDA (id),
    COORDENADOR_id integer REFERENCES COORDENADOR (id),
    DIFICULDADE_id integer REFERENCES DIFICULDADE (id)
);

INSERT INTO AVALIACAO_DEMANDA (DEMANDA_id, COORDENADOR_id, DIFICULDADE_id)
SELECT
    ((i - 1) % 1000 + 1) AS DEMANDA_id,      
    ((i - 1) % 1000 + 1) AS COORDENADOR_id,  
    ((i - 1) % 3 + 1) AS DIFICULDADE_id       
FROM generate_series(1, 1000) AS s(i);

-----------------------------------------VIEWS----------------------------------------------------
-- Alunos por grupo e semestre
CREATE OR REPLACE VIEW alunos_por_grupo_semestre_392521024 AS
SELECT
  aluno.id                   AS aluno_id,
  aluno.nome                 AS nome_aluno,
  aluno.ra                   AS ra,
  usuario.id                 AS usuario_id,
  usuario.email              AS usuario_email,
  grupo.id                   AS grupo_id,
  grupo.nome                 AS grupo_nome,
  semestre.id                AS semestre_id,
  semestre.descricao         AS semestre_descricao
FROM aluno 
LEFT JOIN usuario   ON aluno.usuario_id = usuario.id
LEFT JOIN grupo     ON aluno.grupo_id = grupo.id
LEFT JOIN semestre  ON g.semestre_id = semestre.id;

SELECT * FROM alunos_por_grupo_semestre_392521024 WHERE semestre_descricao = '1' ORDER BY grupo_id, nome_aluno;


-- Projetos detalhado (status, docente, grupo, demanda, pareamento)
CREATE OR REPLACE VIEW vw_projetos_detalhado AS
SELECT
  p.id                      AS projeto_id,
  p.titulo                  AS titulo,
  p.descricao               AS descricao,
  p.tipo                    AS tipo,
  p.prazo                   AS prazo,
  sp.id                     AS status_projeto_id,
  sp.descricao              AS status_projeto_descricao,
  doc.id                    AS docente_id,
  doc.nome                  AS docente_nome,
  g.id                      AS grupo_id,
  g.nome                    AS grupo_nome,
  d.id                      AS demanda_id,
  d.titulo                  AS demanda_titulo,
  par.id                    AS pareamento_id,
  par.data                  AS pareamento_data
FROM projeto p
LEFT JOIN status_projeto sp ON p.status_projeto_id = sp.id
LEFT JOIN docente doc      ON p.docente_id         = doc.id
LEFT JOIN grupo g          ON p.grupo_id           = g.id
LEFT JOIN demanda d        ON p.demanda_id         = d.id
LEFT JOIN pareamento par   ON p.pareamento_id      = par.id;

SELECT projeto_id, titulo, status_projeto_descricao, docente_nome, grupo_nome 
FROM vw_projetos_detalhado 
WHERE status_projeto_descricao = 'Em Andamento';

-- Entregas com info do projeto e docente
CREATE OR REPLACE VIEW vw_entregas_com_projeto AS
SELECT
  e.id AS entrega_id,
  e.titulo AS entrega_titulo,
  e.descricao AS entrega_descricao,
  e.entrega AS entrega_data,
  e.link AS entrega_link,
  p.id AS projeto_id,
  p.titulo AS projeto_titulo,
  sp.id AS status_projeto_id,
  sp.descricao AS status_projeto,
  dp.id AS docente_id,
  dp.nome AS docente_nome
FROM entrega e
LEFT JOIN projeto p ON e.projeto_id = p.id
LEFT JOIN status_projeto sp ON p.status_projeto_id = sp.id
LEFT JOIN docente dp ON p.docente_id = dp.id;

SELECT * FROM vw_entregas_com_projeto WHERE entrega_data >= CURRENT_DATE ORDER BY entrega_data;
-- Exercício - Projeto Interdisciplinar
-- Definir pelo menos 3 roles
-- administrador: acesso total
-- aplicação web: não deve excluir informações ou remover tabelas
-- extração de relatórios: realiza apenas consultas
-- Criptografar pelo menos as informações de uma coluna

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE ROLE administrador LOGIN PASSWORD 'SENHA_ADMIN';
CREATE ROLE aplicacao_web LOGIN PASSWORD 'SENHA_APP';
CREATE ROLE extracao_relatorios LOGIN PASSWORD 'SENHA_REL';

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM PUBLIC;

GRANT ALL ON SCHEMA public TO administrador;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administrador;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO administrador;


-- Aplicação web: ler/inserir/atualizar (sem DELETE)
GRANT USAGE ON SCHEMA public TO aplicacao_web;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO aplicacao_web;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO aplicacao_web;

-- Extração de relatórios: somente SELECT
GRANT USAGE ON SCHEMA public TO extracao_relatorios;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO extracao_relatorios;



ALTER TABLE usuario ADD COLUMN telefone_enc BYTEA;

-- Substitua 'CHAVE_SECRETA' por uma chave segura e não deixe hardcoded em produção
UPDATE usuario
SET telefone_enc = pgp_sym_encrypt(telefone::text, 'CHAVE_SECRETA')
WHERE telefone IS NOT NULL;

-- Exemplo de leitura (a chave é necessária)
SELECT id, email, pgp_sym_decrypt(telefone_enc, 'CHAVE_SECRETA')::text AS telefone
FROM usuario
WHERE id = 1;


CREATE OR REPLACE VIEW relatorio_entregas_por_dia AS
SELECT entrega, COUNT(*) AS quantidade_entregas, array_agg(entrega_id) AS entregas_ids
FROM entregas_com_projeto_392521024
GROUP BY entrega
ORDER BY entrega;

CREATE OR REPLACE VIEW relatorio_mensal_projetos AS
SELECT
  date_trunc('month', make_date(2025, ((id % 12)+1), 1))::date AS mes_inicio,
  COUNT(*) AS total_projetos,
  AVG(LENGTH(descricao))::numeric(10,2) AS media_tamanho_descricao
FROM projeto
GROUP BY mes_inicio
ORDER BY mes_inicio;
CREATE OR REPLACE VIEW relatorio_exportavel_projetos AS
SELECT
  p.id AS projeto_id,
  p.titulo,
  p.tipo,
  p.prazo,
  gp.nome AS grupo_nome,
  d.titulo AS demanda_titulo,
  s.descricao AS status_projeto_descricao
FROM projeto p
LEFT JOIN grupo gp ON p.grupo_id = gp.id
LEFT JOIN demanda d ON p.demanda_id = d.id
LEFT JOIN status_projeto s ON p.status_projeto_id = s.id;
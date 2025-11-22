CREATE OR REPLACE FUNCTION validar_e_logar_demanda()
RETURNS TRIGGER AS $$
DECLARE
    v_operacao VARCHAR(10);
    v_registro_id INTEGER;
    v_titulo_demanda VARCHAR(70);
    v_status_id INTEGER;
    v_mensagem_log TEXT;
BEGIN
    v_operacao := TG_OP;

    IF v_operacao = 'INSERT' OR v_operacao = 'UPDATE' THEN
        v_registro_id := NEW.id;
        v_titulo_demanda := NEW.Titulo;
        v_status_id := NEW.STATUS_AVALIACAO_id;
    ELSIF v_operacao = 'DELETE' THEN
        v_registro_id := OLD.id;
        v_titulo_demanda := OLD.Titulo;
        v_status_id := OLD.STATUS_AVALIACAO_id;
    END IF;

    IF v_operacao = 'INSERT' OR v_operacao = 'UPDATE' THEN
        IF v_status_id <> 1 AND v_titulo_demanda ILIKE '%Teste%' THEN
            RAISE EXCEPTION 'ERRO DE VALIDAÇÃO: Demanda "%" (ID: %) não pode ter status diferente de Pendente se o título contiver a palavra "Teste".', v_titulo_demanda, v_registro_id;
        END IF;
    END IF;
    
    v_mensagem_log := FORMAT('AUDITORIA - Operação: %s na tabela %s (ID: %s). Usuário: %s. Data/Hora: %s.',
        v_operacao,
        TG_TABLE_NAME,
        v_registro_id,
        CURRENT_USER,
        NOW()
    );
    
    IF v_operacao = 'INSERT' THEN
        v_mensagem_log := v_mensagem_log || FORMAT(' Novo Título: "%s". Novo Status ID: %s.', NEW.Titulo, NEW.STATUS_AVALIACAO_id);
    ELSIF v_operacao = 'UPDATE' THEN
        v_mensagem_log := v_mensagem_log || FORMAT(' Título Antigo: "%s", Novo Título: "%s". Status Antigo ID: %s, Novo Status ID: %s.', OLD.Titulo, NEW.Titulo, OLD.STATUS_AVALIACAO_id, NEW.STATUS_AVALIACAO_id);
    ELSIF v_operacao = 'DELETE' THEN
        v_mensagem_log := v_mensagem_log || FORMAT(' Título Deletado: "%s". Status ID Deletado: %s.', OLD.Titulo, OLD.STATUS_AVALIACAO_id);
    END IF;

    RAISE NOTICE '%', v_mensagem_log;

    IF v_operacao = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_validacao_e_log_demanda
BEFORE INSERT OR UPDATE OR DELETE ON DEMANDA
FOR EACH ROW
EXECUTE FUNCTION validar_e_logar_demanda();

-- Exemplos de Teste (Para demonstrar o funcionamento)

INSERT INTO DEMANDA (STATUS_AVALIACAO_id, EMPREENDEDOR_id, Titulo, Descricao, Data_Envio, Publico_Alvo)
VALUES (1, 1, 'Projeto Teste de Inovação', 'Descrição do projeto', CURRENT_DATE, 'Público Geral');
-- Resultado: Operação permitida. Mensagem de log (RAISE NOTICE) será exibida.

UPDATE DEMANDA SET STATUS_AVALIACAO_id = 2, Titulo = 'Projeto Teste de Validação' WHERE id = 1;
-- Resultado: Operação BLOQUEADA. A exceção (RAISE EXCEPTION) será lançada.
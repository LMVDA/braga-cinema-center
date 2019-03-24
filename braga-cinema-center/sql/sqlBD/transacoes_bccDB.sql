USE bccDB;

-- ----------------------------------------ADICIONAR CLIENTE----------------------------------------------------
-- Definição da transação.
-- Adicionar cliente.
-- Início da transação.
START TRANSACTION;
-- 1ª Operação
INSERT INTO cliente
    (username, password, telefone, dataNascimento, email, nome)
    
    VALUES
    ('lucia17', 'lucia153', '+0351253193212', '1944-03-21', 'luciaabreu@gmail.com', 'Lúcia Abreu');


-- ----------------------------------------ADICIONAR FILME----------------------------------------------------
-- Definição da transação.
-- Adicionar filme.
-- Início da transação.
START TRANSACTION;
-- 1ª Operação
INSERT INTO filme
    (titulo, duracao, dataEstreia, dataFim, idadeMinima, idSala)
    
    VALUES 
    ('Casa Blanca', 127, '2016-07-15', '2016-09-17', 16, 1);
    

-- ----------------------------------------ADICIONAR SALA----------------------------------------------------
-- Definição da transação.
-- Adicionar Sala.
-- Início do procedure.
-- Versão com auto inc

DROP PROCEDURE IF EXISTS spAdicionarSala;
DELIMITER $$
CREATE PROCEDURE spAdicionarSala
    (IN tipoSala CHAR, nSala VARCHAR(45))
BEGIN
    DECLARE a INT;
    DECLARE idS INT;
    DECLARE cap INT;

    -- Declaraçãoo de um handler para tratamento de erros.
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;

    -- Início da transação.
    START TRANSACTION;
    
    -- 1ª Operação 
    INSERT INTO Sala
        (tipoSala, nomeSala)
        VALUES(tipoSala, nSala);
        
    SELECT idSala, capacidade INTO idS, cap
    FROM Sala
        WHERE nomeSala = nSala;
        
    -- Inserir lugares
    SET a = 1;
    WHILE a <= cap DO
        INSERT INTO lugar
            (lugar, idSala)
            VALUES(a, idS);
        SET a = a+1;
    END WHILE;
    
    -- Verificação da ocorrência de um erro.
    IF ErroTransacao THEN
        -- Desfazer as operações realizadas.
        ROLLBACK;
    ELSE
        -- Confirmar as operações realizadas.
        COMMIT;
    END IF;
END $$


CALL spAdicionarSala('B', 'Quentin Tarantino');



-- ----------------------------------------ADICIONAR Bilhete----------------------------------------------------
-- ADICIONA BILHETE
-- Início da transação.
START TRANSACTION;
-- 1ª Operação
    INSERT INTO bilhete
        (lugar, dataSessao, idCliente, idSessao)

        VALUES('12', '2015-09-25', 3, 4);
        
        
        
-- ----------------------------------------ADICIONAR Horário ----------------------------------------------------
-- ADICIONA HORARIO
-- Início da transação.
START TRANSACTION;
-- 1ª Operação
    INSERT INTO horario
        (hora)

        VALUES('09:17:00');
        
        
-- ----------------------------------------ADICIONAR Sessão ----------------------------------------------------
-- ADICIONA SESSAO
-- Início da transação.
START TRANSACTION;
-- 1ª Operação
    INSERT INTO sessao
        (precoBase, idHorario, idFilme)

        VALUES(5.00 ,7, 2);
        
        
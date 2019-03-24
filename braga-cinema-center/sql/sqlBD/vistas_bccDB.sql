

-- --------------------------------------------------
-- --------------------------------------------------
-- Cria uma vista para o Cliente --------------------
-- --------------------------------------------------
-- --------------------------------------------------


DROP VIEW IF EXISTS vwClientes;
CREATE VIEW vwClientes AS
    SELECT  titulo      AS 'Titulo', 
            duracao     AS 'Duração',
            idadeMinima AS 'Idade Mínima', 
            hora        AS 'Hora de Inicio', 
            count(*)    AS 'NrLugares',
            precoTotal  AS 'Preço Total'
    FROM Bilhete
    JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao 
    JOIN Horario on Sessao.idHorario = Horario.idHorario
    JOIN Filme ON Sessao.idFilme = Filme.idFilme
    INNER JOIN Sala ON Filme.idSala = Sala.idSala
    INNER JOIN lugar ON Sala.idSala = lugar.idSala

    GROUP BY titulo;
    
-- TESTE
SELECT * FROM vwClientes;




-- --------------------------------------------------
-- --------------------------------------------------
-- Cria uma vista para o Funcionário ----------------
-- --------------------------------------------------
-- --------------------------------------------------

DROP VIEW IF EXISTS vwFuncionarios;
CREATE VIEW vwFuncionarios AS
    SELECT DISTINCT nomeSala  AS 'Nome da Sala', 
            tipoSala      AS 'Tipo da Sala', 
            capacidade    AS 'Capacidade', 
            titulo        AS 'Filme',
            idadeMinima   AS 'Idade Mínima',
            duracao       AS 'Duração'
    FROM Filme
    LEFT JOIN Sala
        ON Filme.idSala = Sala.idSala;
    
SELECT * FROM vwFuncionarios;


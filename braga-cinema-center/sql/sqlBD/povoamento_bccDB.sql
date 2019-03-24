-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 2017/2018
--
-- Caso de Estudo: "Sétima Arte: gestão de sessões de cinema" 


-- Base de dados de trabalho
USE `bccDB`;

-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
	(username, password, nome, telefone, dataNascimento, email)
	VALUES 
		('joaoS', 'joao1234', 'João Martins Silva', '+0351258843219', '1997-03-11' , 'joaomsilva@gmail.com'),
		('mariaS', 'maria1234', 'Maria Santos', '+0351253193219', '1983-07-21' , 'mariasantos@gmail.com'),
		('pauloR', 'pablo1234', 'Paulo Rodrigues', '+0351258741596', '1989-05-05', 'pablorodriguez@hotmail.com'),
		('penelopeL', 'penelope1234', 'Penelope Silva', '+0351914785965', '1945-02-17', 'penelopelopez@gmail.com'),
        ('andreC', 'andre1234', 'Andre  Carvalho', '+0351243222111', '1990-07-23', 'andre@gmail.com');
-- SELECT * FROM Cliente;



-- Povoamento da tabela "Horario"
INSERT INTO Horario
        (hora)
        VALUES 
        ('09:00:00'),
        ('11:30:00'),
        ('13:00:00'),
        ('16:00:00'),
        ('18:30:00'),
        ('21:00:00'),
        ('23:30:00');
-- SELECT * FROM Sessao;



-- Povoamento da tabela "Sala"
INSERT INTO Sala
        (nomeSala, tipoSala)
        VALUES 
                ('Martin Scorsese', 'B'),
                ('Steven Spielberg', 'S'),
                ('Woody Allen', 'P');
-- SELECT * FROM Sala;



-- Povoamento da tabela "Filme"
INSERT INTO Filme
        (titulo, duracao, dataEstreia, dataFim, idadeMinima, idSala)
        VALUES 
                ('The House By The Sea', 127, '2016-07-15', '2016-09-17', 16, 1),
                ('The Order Of Things', 117, '2017-03-17',  '2017-08-11', 12, 2),
                ('The Phantom Thread', 117, '2017-08-07',  '2017-09-21', 12, 3);
-- SELECT * FROM Filme;



-- Povoamento da tabela "Sessao"
INSERT INTO Sessao
        (precoBase, idHorario, idFilme)
        VALUES 
        (3.50, 1, 1),
        (5.50, 3, 1),
        (6.50, 5, 1),
        (7.00, 7, 1),
        (5.50, 2, 2),
        (5.50, 4, 2),
        (6.50, 6, 2),
        (3.50, 1, 3),
        (5.50, 3, 3),
        (6.50, 5, 3),
        (7.00, 7, 3);

-- SELECT * FROM Sessao;



-- Povoamento da tabela "Bilhete"
INSERT INTO Bilhete
    (lugar, dataSessao, idCliente, idSessao)
    VALUES 
        ('12', '2016-07-15', 3, 1),
        ('1', '2015-04-30', 2, 5),
        ('7', '2014-10-27', 1, 7),
        ('9', '2015-09-10', 5, 3);
-- SELECT * FROM Bilhete;



-- Povoamento da tabela "Lugar"
INSERT INTO Lugar
	(lugar, idSala) 
	VALUES 
	(1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1),
    (11, 1),
    (12, 1),
    (13, 1),
    (14, 1),
    (15, 1),
    (1, 2),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2),
    (8, 2),
    (9, 2),
    (10, 2),
    (11, 2),
    (12, 2),
    (13, 2),
    (14, 2),
    (15, 2),
    (16, 2),
    (17, 2),
    (18, 2),
    (19, 2),
    (20, 2),
    (1, 3),
    (2, 3),
    (3, 3),
    (4, 3),
    (5, 3),
    (6, 3),
    (7, 3),
    (8, 3),
    (9, 3),
    (10, 3),
    (11, 3),
    (12, 3),
    (13, 3),
    (14, 3),
    (15, 3),
    (16, 3),
    (17, 3),
    (18, 3),
    (19, 3),
    (20, 3),
    (21, 3),
    (22, 3),
    (23, 3),
    (24, 3),
    (25, 3);
-- SELECT * FROM Lugar;


-- <fim>
--


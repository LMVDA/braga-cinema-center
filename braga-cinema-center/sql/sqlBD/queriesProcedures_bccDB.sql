----------------------------------------------------------------------------------------
-- QUERY 1: Obter o número de lugares reservados para uma dada sessao
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE nrLugaresReservadosSessao(IN idSessao INT)
BEGIN
	SELECT COUNT(*) AS NrLugaresReservados
	FROM Bilhete
	WHERE Bilhete.idSessao = idSessao;
END $$

CALL nrLugaresReservadosSessao(1);


----------------------------------------------------------------------------------------
-- QUERY 2: Obter o número total de bilhetes vendidos
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE nrBilhetesVendidos()
BEGIN
	SELECT COUNT(*) AS NrBilhetesVendidos
	FROM Bilhete;
END $$

CALL nrBilhetesVendidos();


----------------------------------------------------------------------------------------
-- QUERY 3: Número de lugares reservados para um determinado dia de uma sessao
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE nrLugaresReservadosEmData(IN dataSessao DATE)
BEGIN
	SELECT COUNT(*) AS NrBilhetesReservados
	FROM Bilhete
	WHERE Bilhete.dataSessao = dataSessao;
END $$

CALL nrLugaresReservadosEmData('2016-07-15');



----------------------------------------------------------------------------------------
-- QUERY 4: Obter as reservas/compras de um cliente
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE reservasCliente(IN usern VARCHAR(10))
BEGIN
	SELECT Bilhete.dataSessao, Horario.hora, Filme.titulo, Lugar.lugar, Bilhete.precoTotal
	FROM Cliente 
    JOIN Bilhete ON Bilhete.idCliente = Cliente.idCliente
	JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao
    JOIN Horario ON Sessao.idHorario = Horario.idHorario
	JOIN Filme ON Sessao.idFilme = Filme.idFilme 
	JOIN Sala ON Filme.idSala = Sala.idSala
	JOIN lugar ON Sala.idSala = lugar.idSala
	WHERE Lugar.lugar = Bilhete.lugar AND Cliente.username = usern;
END $$

CALL reservasCliente('joaoS');

----------------------------------------------------------------------------------------
-- QUERY 5: Obter os lugares disponívels de uma sessao
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE lugaresDisponiveisSessao(IN idSess INT)
BEGIN
	SELECT Bilhete.dataSessao, Horario.hora, Filme.titulo, Sala.nomeSala, Lugar.lugar
	FROM Bilhete
	JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao 
	JOIN Horario on Sessao.idHorario = Horario.idHorario
	JOIN Filme ON Sessao.idFilme = Filme.idFilme
	JOIN Sala ON Filme.idSala = Sala.idSala
	JOIN lugar ON Sala.idSala = lugar.idSala
	WHERE Bilhete.idSessao = idSess AND Bilhete.lugar <> Lugar.lugar;
END $$

CALL lugaresDisponiveisSessao(1);


----------------------------------------------------------------------------------------
-- QUERY 6: Obter Top 10 das sessoes com mais clientes
----------------------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE top10SessoesComMaisClientesEntreDatas(IN data1 DATE, IN data2 DATE)
BEGIN
	SELECT Filme.titulo, Sessao.idSessao, COUNT(*) AS NrClientes
	FROM Bilhete
	JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao
	JOIN Filme ON Sessao.idFilme = Filme.idFilme
	WHERE Bilhete.dataSessao BETWEEN data1 AND data2
	GROUP BY Bilhete.idSessao
	ORDER BY COUNT(*) DESC
	LIMIT 10;
END $$

CALL top10SessoesComMaisClientesEntreDatas('2000-04-01', '2017-10-31');
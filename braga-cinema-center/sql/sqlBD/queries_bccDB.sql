---------------------------------------------------------------------------------------------------------------
-- Dada uma Sessao, quais os lugares livres na Sala?
---------------------------------------------------------------------------------------------------------------
SELECT Bilhete.dataSessao, Horario.hora, Filme.titulo, Sala.nomeSala, Lugar.lugar
FROM Bilhete
JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao 
JOIN Horario on Sessao.idHorario = Horario.idHorario
JOIN Filme ON Sessao.idFilme = Filme.idFilme
JOIN Sala ON Filme.idSala = Sala.idSala
JOIN lugar ON Sala.idSala = lugar.idSala
WHERE Bilhete.idSessao = 1 AND Bilhete.lugar <> Lugar.lugar;

---------------------------------------------------------------------------------------------------------------
-- Bilhetes de um utilizador
---------------------------------------------------------------------------------------------------------------
SELECT *
FROM Bilhete
JOIN Cliente ON Cliente.idCliente = Bilhete.idCliente 
WHERE Cliente.username = 'joaoS';

---------------------------------------------------------------------------------------------------------------
-- Número de bilhetes de um utilizador
---------------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM Bilhete
JOIN Cliente ON Cliente.idCliente = Bilhete.idCliente 
WHERE Cliente.username = 'joaoS';

---------------------------------------------------------------------------------------------------------------
-- Saber o número de filmes
---------------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM Filme;

---------------------------------------------------------------------------------------------------------------
-- Saber o número de sessões
---------------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM Sessao;

---------------------------------------------------------------------------------------------------------------
-- Saber quantos filmes projeta uma sala
---------------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM Filme
WHERE idSala = 1;

---------------------------------------------------------------------------------------------------------------
-- Quantos bilhetes vendidos existem para uma sessão
---------------------------------------------------------------------------------------------------------------
SELECT COUNT(*)
FROM Bilhete
WHERE idSessao = 1;

---------------------------------------------------------------------------------------------------------------
-- Qual o total (em €) de bilhetes vendidos para um determinado Filme
---------------------------------------------------------------------------------------------------------------
SELECT SUM(Bilhete.precoTotal)
FROM Bilhete
JOIN Sessao ON Sessao.idSessao = Bilhete.idSessao
JOIN Filme ON Filme.idFilme = Sessao.idFilme
WHERE Filme.titulo = 'The House By The Sea';

---------------------------------------------------------------------------------------------------------------
-- Tipo de sala que projeta um determinado filme
---------------------------------------------------------------------------------------------------------------
SELECT Sala.tipoSala
FROM Bilhete
JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao
JOIN Filme ON Sessao.idFilme = Filme.idFilme
JOIN Sala ON Filme.idSala = Sala.idSala
WHERE Filme.idFilme = 1;

---------------------------------------------------------------------------------------------------------------
-- Durante um intervalo, qual o top 10 de filmes com o menor número de bilhetes vendidos
---------------------------------------------------------------------------------------------------------------
SELECT Filme.titulo, Filme.idFilme, COUNT(*)
FROM Bilhete
JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao
JOIN Filme ON Sessao.idFilme = Filme.idFilme
WHERE Bilhete.dataSessao BETWEEN '2010-04-01' AND '2017-10-31'
GROUP BY Bilhete.idSessao
ORDER BY COUNT(*)
LIMIT 10;

---------------------------------------------------------------------------------------------------------------
-- Filmes de uma sala
---------------------------------------------------------------------------------------------------------------
SELECT Filme.titulo, Filme.duracao, Filme.idadeMinima, Filme.dataEstreia
FROM Sala
JOIN Filme ON Filme.idSala = Sala.idSala
WHERE Sala.idSala = 1;

---------------------------------------------------------------------------------------------------------------
-- Filmes de um cliente
---------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Filme.titulo
FROM Cliente
JOIN Bilhete ON Cliente.idCliente = Bilhete.idCliente
JOIN Sessao ON Bilhete.idSessao = Sessao.idSessao
JOIN Filme ON Filme.idFilme = Sessao.idFilme
WHERE Cliente.username = 'joaoS';

---------------------------------------------------------------------------------------------------------------
-- Nomes dos clientes de umm determinado filme
---------------------------------------------------------------------------------------------------------------
SELECT Cliente.nome
FROM Cliente
JOIN Bilhete ON Cliente.idCliente = Bilhete.idCliente
JOIN Sessao ON Sessao.idSessao = Bilhete.idSessao 
JOIN Filme ON Filme.idFilme = Sessao.idFilme
WHERE Filme.idFilme = 1;




----------------------------------------------------------------------------------------------------------------------------
-- TRIGGER que garante que o número de telefone é válido (os primeiros digitos são +0351(Portugal)
-- TRIGGER que garante que o número de telefone tem 14 digitos
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_Cliente_BI
	BEFORE INSERT ON Cliente
	FOR EACH ROW  
BEGIN 
	
	IF (NEW.telefone NOT LIKE "+0351%") THEN
		SIGNAL SQLSTATE '45000';
	END IF;
    
    IF (CHAR_LENGTH(NEW.telefone) <> 14) THEN
		SIGNAL SQLSTATE '45000';
	END IF;
END $$


----------------------------------------------------------------------------------------------------------------------------
-- TRIGGER que garante que o tipo de sala é B (Basic), S (Silver) ou P (Platinum)
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_Sala_BI
	BEFORE INSERT ON Sala
	FOR EACH ROW  
BEGIN 
	
	IF (NEW.tipoSala <> 'B' AND NEW.tipoSala <> 'S' AND NEW.tipoSala <> 'P') THEN
		SIGNAL SQLSTATE '45000';
	END IF;

END $$


----------------------------------------------------------------------------------------------------------------------------
-- TRIGEER que garante que o número de lugar é inferior à capacidade da sala
-- TRIGGER que garante que o número de lugares de uma sala não excede a sua capacidade
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_lugar_BI
	BEFORE INSERT ON lugar
	FOR EACH ROW  
BEGIN 
	DECLARE nrLugaresExistentes INT;
	DECLARE capacidade INT;

	SET capacidade = (SELECT capacidade
					 FROM Sala
					 WHERE idSala = NEW.idSala);

-- VALIDACAO: número de lugar é inferior à capacidade da sala
	IF (NEW.lugar > capacidade) THEN
		SIGNAL SQLSTATE '45000';
	END IF;

	SET nrLugaresExistentes = (SELECT COUNT(*)
							   FROM lugar
						 	   WHERE idSala = NEW.idSala);

-- VALIDACAO: número de lugares de uma sala não excede a sua capacidade 
	IF nrLugaresExistentes >= capacidade THEN
		SIGNAL SQLSTATE '45000';
	END IF;	

END $$


----------------------------------------------------------------------------------------------------------------------------
-- TRIGGER que permite calcular o atributo derivado: desconto de um bilhete
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_Bilhete_Desconto_BI
	BEFORE INSERT ON Bilhete
	FOR EACH ROW  
BEGIN 
	DECLARE idade INT;
	DECLARE membro BOOLEAN;

	SET idade = (SELECT calculaIdade(dataNascimento)
				 FROM Cliente
				 WHERE idCliente = NEW.idCliente);

	SET membro =   (SELECT membroPremium
					FROM Cliente
					WHERE idCliente = NEW.idCliente);

	IF (idade < 25 ) THEN
		SET NEW.desconto = 0.15;
	ELSEIF (idade > 65) THEN
		SET NEW.desconto = 0.25;
	ELSE 
		SET NEW.desconto = 0;
	END IF;

	IF (membro=1) THEN
		SET NEW.desconto = 0.30;
	END IF;

END $$


----------------------------------------------------------------------------------------------------------------------------
-- FUNCTION que dada uma data de nascimento calcula a idade
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION calculaIdade(dataNascimento DATE) RETURNS INT
BEGIN
	DECLARE idade INT;
    
	SET idade = TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE());
	
	RETURN idade;
END $$


----------------------------------------------------------------------------------------------------------------------------
-- TRIGGER que permite calcular o atributo derivado: precoTotal de um Bilhete
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_Bilhete_PrecoTotal_BI
	BEFORE INSERT ON Bilhete
	FOR EACH ROW
BEGIN 
	DECLARE precoB FLOAT;
	DECLARE precoComIVA FLOAT;
	DECLARE precoComDesconto FLOAT;

	SET precoB = (SELECT `precoBase`
				  FROM Sessao
				  WHERE idSessao = NEW.idSessao); 

	SET precoComIVA = precoB * (1 + NEW.IVA);

	SET precoComDesconto = precoComIVA * (1 - NEW.desconto);

	SET NEW.`precoTotal` = ROUND(precoComDesconto,2);

END $$

---------------------------------------------------------------------------------------------------------------
-- FUNCTION que dado uma data de uma sessao, e uma sessao (idSessao) dá quantos bilhetes estão vendidos/reservados
---------------------------------------------------------------------------------------------------------------
DELIMITER $$

CREATE FUNCTION nrBilhetesSessaoVendidos(idSessao INT, dataSessao DATE) RETURNS INT
BEGIN
	DECLARE nrBilhetes INT;
    
	SET nrBilhetes = (SELECT COUNT(*)
					  FROM Bilhete
					  WHERE Bilhete.idSessao = idSessao AND Bilhete.dataSessao = dataSessao);
	
	RETURN nrBilhetes;
END $$

----------------------------------------------------------------------------------------------------------------------------
-- TRIGGER que garante que o número de bilhetes comprados/reservados não excede a capacidade máxima da sala
----------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER TR_Bilhete_BI
	BEFORE INSERT ON Bilhete
	FOR EACH ROW  
BEGIN 
	DECLARE nrBilhetes INT;
	DECLARE nrBilhetesMax INT;

	SET nrBilhetes = nrBilhetesSessaoVendidos(NEW.idSessao, NEW.dataSessao);

	SET nrBilhetesMax = (SELECT Sala.capacidade
						 FROM Sessao
						 JOIN Filme ON Sessao.idFilme = Filme.idFilme
						 JOIN Sala ON Filme.idSala = Sala.idSala
						 WHERE Sessao.idSessao = NEW.idSessao);

	IF nrBilhetes >= nrBilhetesMax THEN
		SIGNAL SQLSTATE '45000';
	END IF;
END $$



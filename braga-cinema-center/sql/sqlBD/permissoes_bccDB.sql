-- Cliente

DROP USER IF EXISTS 'cliente'@'localhost:3306';
CREATE USER 'cliente'@'localhost:3306';
SET PASSWORD FOR 'cliente'@'localhost:3306' = PASSWORD('clien1234');

GRANT SELECT, INSERT, UPDATE ON bccDB.Cliente TO 'cliente'@'localhost:3306';
GRANT SELECT, INSERT ON bccDB.Bilhete TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.Sessao TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.Filme TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.Sala TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.Lugar TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.Horario TO 'cliente'@'localhost:3306';
GRANT SELECT ON bccDB.vwClientes TO 'cliente'@'localhost:3306';
    
SHOW GRANTS FOR 'cliente'@'localhost';


-- Funcionário

DROP USER IF EXISTS 'funcionario'@'localhost:3306';
CREATE USER 'funcionario'@'localhost:3306';
SET PASSWORD FOR 'funcionario'@'localhost:3306' = PASSWORD('func1234');

GRANT SELECT ON bccDB.Bilhete TO 'funcionario'@'localhost:3306';
GRANT SELECT, INSERT, UPDATE, DELETE ON bccDB.Sessao TO 'funcionario'@'localhost:3306';
GRANT SELECT, INSERT, UPDATE, DELETE ON bccDB.Filme TO 'funcionario'@'localhost:3306';
GRANT SELECT, INSERT, UPDATE, DELETE ON bccDB.Sala TO 'funcionario'@'localhost:3306';
GRANT SELECT, INSERT, UPDATE, DELETE ON bccDB.Lugar TO 'funcionario'@'localhost:3306';
GRANT SELECT, INSERT, UPDATE, DELETE ON bccDB.Horario TO 'funcionario'@'localhost:3306';
GRANT SELECT ON bccDB.vwFuncionarios TO 'funcionario'@'localhost:3306';
  
SHOW GRANTS FOR 'funcionario'@'localhost:3306';


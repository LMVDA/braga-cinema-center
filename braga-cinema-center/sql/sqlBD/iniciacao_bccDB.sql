-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bccDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bccDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bccDB` DEFAULT CHARACTER SET utf8 ;
USE `bccDB` ;

-- -----------------------------------------------------
-- Table `bccDB`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(10) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(75) NOT NULL,
  `telefone` VARCHAR(14) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `dataRegisto` DATETIME NOT NULL DEFAULT NOW(),
  `membroPremium` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Horario` (
  `idHorario` INT NOT NULL AUTO_INCREMENT,
  `hora` TIME NOT NULL,
  PRIMARY KEY (`idHorario`),
  UNIQUE INDEX `idHorario_UNIQUE` (`idHorario` ASC),
  UNIQUE INDEX `horaInicio_UNIQUE` (`hora` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Sala` (
  `idSala` INT NOT NULL AUTO_INCREMENT,
  `nomeSala` VARCHAR(45) NOT NULL,
  `tipoSala` CHAR NOT NULL,
  `capacidade` INT AS (CASE WHEN tipoSala = 'B' THEN 15 WHEN tipoSala = 'S' THEN 20 ELSE 25 END) STORED NOT NULL,
  PRIMARY KEY (`idSala`),
  UNIQUE INDEX `idFilme_UNIQUE` (`idSala` ASC),
  UNIQUE INDEX `nomeSala_UNIQUE` (`nomeSala` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Filme` (
  `idFilme` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(75) NOT NULL,
  `duracao` INT NOT NULL,
  `dataEstreia` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  `idadeMinima` INT NOT NULL,
  `idSala` INT NOT NULL,
  UNIQUE INDEX `idFilme_UNIQUE` (`idFilme` ASC),
  PRIMARY KEY (`idFilme`),
  INDEX `fk_Filme_Sala1_idx` (`idSala` ASC),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC),
  CONSTRAINT `fk_Filme_Sala1`
    FOREIGN KEY (`idSala`)
    REFERENCES `bccDB`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Sessao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Sessao` (
  `idSessao` INT NOT NULL AUTO_INCREMENT,
  `precoBase` FLOAT NOT NULL,
  `idHorario` INT NOT NULL,
  `idFilme` INT NOT NULL,
  PRIMARY KEY (`idSessao`),
  UNIQUE INDEX `idSessao_UNIQUE` (`idHorario` ASC, `idFilme` ASC),
  INDEX `fk_Sessao_Horario1_idx` (`idHorario` ASC),
  INDEX `fk_Sessao_Filme1_idx` (`idFilme` ASC),
  CONSTRAINT `fk_Sessao_Horario1`
    FOREIGN KEY (`idHorario`)
    REFERENCES `bccDB`.`Horario` (`idHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sessao_Filme1`
    FOREIGN KEY (`idFilme`)
    REFERENCES `bccDB`.`Filme` (`idFilme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Bilhete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Bilhete` (
  `idBilhete` INT NOT NULL AUTO_INCREMENT,
  `IVA` FLOAT NOT NULL DEFAULT 0.13,
  `dataCompra` DATETIME NOT NULL DEFAULT NOW(),
  `dataSessao` DATE NOT NULL,
  `tipoBilhete` VARCHAR(1) AS (CASE WHEN desconto > 0 THEN 'P' ELSE 'N' END) NOT NULL,
  `desconto` FLOAT NOT NULL,
  `precoTotal` FLOAT NOT NULL,
  `lugar` INT NOT NULL,
  `idSessao` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idBilhete`),
  UNIQUE INDEX `idBilhete_UNIQUE` (`idSessao` ASC, `lugar` ASC, `dataSessao` ASC),
  INDEX `fk_Bilhete_Sessao1_idx` (`idSessao` ASC),
  INDEX `fk_Bilhete_Cliente1_idx` (`idCliente` ASC),
  CONSTRAINT `fk_Bilhete_Sessao1`
    FOREIGN KEY (`idSessao`)
    REFERENCES `bccDB`.`Sessao` (`idSessao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilhete_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `bccDB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bccDB`.`Lugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bccDB`.`Lugar` (
  `lugar` INT NOT NULL,
  `idSala` INT NOT NULL,
  PRIMARY KEY (`lugar`, `idSala`),
  INDEX `fk_lugar_Sala1_idx` (`idSala` ASC),
  CONSTRAINT `fk_lugar_Sala1`
    FOREIGN KEY (`idSala`)
    REFERENCES `bccDB`.`Sala` (`idSala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
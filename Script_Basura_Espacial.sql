-- MySQL Workbench Synchronization
-- Generated: 2021-05-29 20:47
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Gowther

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `BASURA_ESPACIAL` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Basura_espacial` (
  `id_Num` INT(11) NOT NULL,
  `Peso` REAL NULL,
  `Diámetro` REAL NULL,
  `Velocidad` REAL NULL,
  `Tamaño` REAL NULL,
  `O_radio` REAL NOT NULL,
  `O_Delta` REAL NOT NULL,
  `Nave` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_Num`),
  INDEX `fk_Basura_espacial_Orbita1_idx` (`O_radio` ASC, `O_Delta` ASC) VISIBLE,
  INDEX `fk_Basura_espacial_Nave1_idx` (`Nave` ASC) VISIBLE,
  CONSTRAINT `fk_Basura_espacial_Orbita1`
    FOREIGN KEY (`O_radio` , `O_Delta`)
    REFERENCES `BASURA_ESPACIAL`.`Orbita` (`radio` , `Delta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Basura_espacial_Nave1`
    FOREIGN KEY (`Nave`)
    REFERENCES `BASURA_ESPACIAL`.`Nave` (`Matrícula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Fragmenta` (
  `ID_origen` INT(11) NOT NULL,
  `ID_producido` INT(11) NOT NULL,
  `F_Origen` DATETIME NOT NULL,
  PRIMARY KEY (`ID_producido`),
  INDEX `fk_Fragmenta_Basura_espacial1_idx` (`ID_producido` ASC) VISIBLE,
  CONSTRAINT `fk_Fragmenta_Basura_espacial`
    FOREIGN KEY (`ID_origen`)
    REFERENCES `BASURA_ESPACIAL`.`Basura_espacial` (`id_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fragmenta_Basura_espacial1`
    FOREIGN KEY (`ID_producido`)
    REFERENCES `BASURA_ESPACIAL`.`Basura_espacial` (`id_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Orbita` (
  `radio` REAL NOT NULL,
  `Delta` REAL NOT NULL,
  `Altura` REAL NULL,
  `Excentricidad` REAL NULL,
  `Forma` VARCHAR(8) NULL DEFAULT NULL,
  `Geoestacionaria` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`radio`, `Delta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Agencia_espacial` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Cant_per` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Publica` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  CONSTRAINT `fk_Pública_Agencia_espacial1`
    FOREIGN KEY (`Nombre`)
    REFERENCES `BASURA_ESPACIAL`.`Agencia_espacial` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Empresa` (
  `Nombre` VARCHAR(45) NOT NULL,
  `CIF` VARCHAR(25) NOT NULL,
  `Capital` REAL NOT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Nave` (
  `Matrícula` VARCHAR(30) NOT NULL,
  `F_lanzamiento` DATETIME NOT NULL,
  `Misión` VARCHAR(10) NOT NULL,
  `Agencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Matrícula`, `Agencia`),
  INDEX `fk_Nave_Agencia_espacial1_idx` (`Agencia` ASC) VISIBLE,
  CONSTRAINT `fk_Nave_Agencia_espacial1`
    FOREIGN KEY (`Agencia`)
    REFERENCES `BASURA_ESPACIAL`.`Agencia_espacial` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Componente` (
  `Código` INT(11) NOT NULL,
  `Tipo` VARCHAR(30) NULL DEFAULT NULL,
  `Peso` REAL NULL,
  `Diametro` REAL NULL,
  `Nave` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Código`),
  INDEX `fk_Componente_Nave1_idx` (`Nave` ASC) VISIBLE,
  CONSTRAINT `fk_Componente_Nave1`
    FOREIGN KEY (`Nave`)
    REFERENCES `BASURA_ESPACIAL`.`Nave` (`Matrícula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Tripulantes` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Nave` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_Tripulantes_Nave1_idx` (`Nave` ASC) VISIBLE,
  CONSTRAINT `fk_Tripulantes_Nave1`
    FOREIGN KEY (`Nave`)
    REFERENCES `BASURA_ESPACIAL`.`Nave` (`Matrícula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Privada` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Publica_N` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`, `Publica_N`),
  INDEX `fk_Privada_Publica1_idx` (`Publica_N` ASC) VISIBLE,
  CONSTRAINT `fk_Privada_Agencia_espacial1`
    FOREIGN KEY (`Nombre`)
    REFERENCES `BASURA_ESPACIAL`.`Agencia_espacial` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Privada_Publica1`
    FOREIGN KEY (`Publica_N`)
    REFERENCES `BASURA_ESPACIAL`.`Publica` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`Financia` (
  `P_Nombre` VARCHAR(45) NOT NULL,
  `E_Nombre` VARCHAR(45) NOT NULL,
  `Participacion` REAL NOT NULL,
  INDEX `fk_Privada_has_Empresa_Empresa1_idx` (`E_Nombre` ASC) VISIBLE,
  INDEX `fk_Privada_has_Empresa_Privada1_idx` (`P_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Privada_has_Empresa_Privada1`
    FOREIGN KEY (`P_Nombre`)
    REFERENCES `BASURA_ESPACIAL`.`Privada` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Privada_has_Empresa_Empresa1`
    FOREIGN KEY (`E_Nombre`)
    REFERENCES `BASURA_ESPACIAL`.`Empresa` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `BASURA_ESPACIAL`.`O_actual` (
  `F_inicial` DATETIME NOT NULL,
  `F_final` DATETIME NULL DEFAULT NULL,
  `Nave` VARCHAR(30) NOT NULL,
  `O_radio` REAL NOT NULL,
  `O_Delta` REAL NOT NULL,
  PRIMARY KEY (`F_inicial`, `O_radio`, `O_Delta`),
  INDEX `fk_O_actual_Nave1_idx` (`Nave` ASC) VISIBLE,
  INDEX `fk_O_actual_Orbita1_idx` (`O_radio` ASC, `O_Delta` ASC) VISIBLE,
  CONSTRAINT `fk_O_actual_Nave1`
    FOREIGN KEY (`Nave`)
    REFERENCES `BASURA_ESPACIAL`.`Nave` (`Matrícula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_O_actual_Orbita1`
    FOREIGN KEY (`O_radio` , `O_Delta`)
    REFERENCES `BASURA_ESPACIAL`.`Orbita` (`radio` , `Delta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

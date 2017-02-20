CREATE TABLE `mru_mrp_samp`.`game_konta` (
  `UID` INT NOT NULL AUTO_INCREMENT,
  `Nick` VARCHAR(25) NOT NULL,
  `Pass` VARCHAR(129) NULL,
  `PassPos` SMALLINT NULL,
  `Online` TINYINT NULL DEFAULT 0,
  `Level` SMALLINT NULL DEFAULT 1,
  `Respekt` INT NULL DEFAULT 0,
  `KP` TINYINT NULL DEFAULT 0,
  `Wiek` TINYINT NULL DEFAULT 21,
  `Rasa` TINYINT NULL DEFAULT 0,
  `Skin` SMALLINT NULL DEFAULT '264',
  `Spawn` TINYINT NULL DEFAULT 0,
  `BitUstawienia` BINARY(32) NULL DEFAULT 0,
  `MrucznikCoins` INT NULL DEFAULT 0,
  `Hajs` INT NULL DEFAULT 1000,
  `Bank` INT NULL DEFAULT 0,
  `Warn` TINYINT NULL DEFAULT 0,
  `AJ` INT NULL DEFAULT 0,
  `Frakcja` INT NULL DEFAULT 0,
  `Organizacja` INT NULL DEFAULT 0,
  `Ranga` TINYINT NULL DEFAULT 0,
  `Praca` TINYINT NULL DEFAULT 0,
  `Admin` INT NULL DEFAULT 0,
  `WantedLevel` TINYINT NULL DEFAULT 0,
  `Health` FLOAT NULL DEFAULT 100.0,
  `Armor` FLOAT NULL DEFAULT 0.0,
  `X` FLOAT NULL DEFAULT 0.0,
  `Y` FLOAT NULL DEFAULT 0.0,
  `Z` FLOAT NULL DEFAULT 0.0,
  `A` FLOAT NULL DEFAULT 0.0,
  `Interior` INT NULL DEFAULT 0,
  `VirtualWorld` INT NULL DEFAULT 0,
  PRIMARY KEY (`UID`),
  UNIQUE INDEX `Nick_UNIQUE` (`Nick` ASC),
  UNIQUE INDEX `UID_UNIQUE` (`UID` ASC));
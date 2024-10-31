-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerId` INT NOT NULL,
  `FirstName` VARCHAR(15) NOT NULL,
  `LastName` VARCHAR(15) NOT NULL,
  `ContactNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeId` INT NOT NULL,
  `Salary` FLOAT NOT NULL,
  `Role` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(15) NOT NULL,
  `LastName` VARCHAR(15) NULL,
  PRIMARY KEY (`EmployeeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `TableNumber` TINYINT NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Customer_idx` (`CustomerId` ASC) VISIBLE,
  CONSTRAINT `Customer`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `ItemId` INT NOT NULL,
  `ItemType` VARCHAR(20) NOT NULL,
  `ItemName` VARCHAR(20) NOT NULL,
  `Cuisine` VARCHAR(20) NOT NULL,
  `Price` FLOAT NOT NULL,
  PRIMARY KEY (`ItemId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderId` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `OrderedItem` INT NOT NULL,
  `Quantity` TINYINT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `Customer_idx` (`CustomerId` ASC) VISIBLE,
  INDEX `Item_idx` (`OrderedItem` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Item`
    FOREIGN KEY (`OrderedItem`)
    REFERENCES `LittleLemonDB`.`Menu` (`ItemId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deliveries` (
  `DeliveryId` INT NOT NULL,
  `OrderId` INT NOT NULL,
  `DeliveryStatus` VARCHAR(10) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`DeliveryId`),
  INDEX `Order_idx` (`OrderId` ASC) VISIBLE,
  CONSTRAINT `Order`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

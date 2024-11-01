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
  `CustomerId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(15) NOT NULL,
  `LastName` VARCHAR(15) NOT NULL,
  `ContactNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeId` INT NOT NULL AUTO_INCREMENT,
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
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `CustomerId` INT NOT NULL,
  `TableNumber` TINYINT NOT NULL,
  `Date` DATETIME NULL,
  `EmployeeId` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Customer_idx` (`CustomerId` ASC) VISIBLE,
  INDEX `Employee_idx` (`EmployeeId` ASC) VISIBLE,
  CONSTRAINT `Customer`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Employee`
    FOREIGN KEY (`EmployeeId`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemsId` INT NOT NULL AUTO_INCREMENT,
  `Course` VARCHAR(45) NULL,
  `Starter` VARCHAR(45) NULL,
  `Dessert` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `MenuName` VARCHAR(20) NOT NULL,
  `Cuisine` VARCHAR(20) NOT NULL,
  `ItemsID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `Items_idx` (`ItemsID` ASC) VISIBLE,
  CONSTRAINT `Items`
    FOREIGN KEY (`ItemsID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderId` INT NOT NULL AUTO_INCREMENT,
  `CustomerId` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `OrderedMenu` INT NOT NULL,
  `Quantity` TINYINT NULL,
  `TotalCost` FLOAT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `Customer_idx` (`CustomerId` ASC) VISIBLE,
  INDEX `MenuID_idx` (`OrderedMenu` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`OrderedMenu`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deliveries` (
  `DeliveryId` INT NOT NULL AUTO_INCREMENT,
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

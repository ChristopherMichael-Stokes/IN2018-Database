-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BAPERS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BAPERS` ;

-- -----------------------------------------------------
-- Schema BAPERS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BAPERS` DEFAULT CHARACTER SET utf8 ;
USE `BAPERS` ;

-- -----------------------------------------------------
-- Table `BAPERS`.`User_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`User_Type` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`User_Type` (
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Staff` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Staff` (
  `staff_id` VARCHAR(15) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `passphrase` VARCHAR(128) NOT NULL,
  `fk_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_User_User_Type1_idx` (`fk_type` ASC),
  UNIQUE INDEX `username_UNIQUE` (`staff_id` ASC),
  CONSTRAINT `fk_User_User_Type1`
    FOREIGN KEY (`fk_type`)
    REFERENCES `BAPERS`.`User_Type` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Payment_Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Payment_Info` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Payment_Info` (
  `payment_id` INT NOT NULL,
  `amount_paid` INT NOT NULL,
  `payment_type` VARCHAR(10) NOT NULL,
  `date_paid` DATE NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Discount_Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Discount_Plan` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Discount_Plan` (
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Customer_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Customer_Account` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Customer_Account` (
  `account_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `account_holder_name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(10) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `house_phone` VARCHAR(11) NOT NULL,
  `mobile_phone` VARCHAR(11) NULL,
  `fk_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`account_number`),
  INDEX `fk_Customer_Account_Discount_Plan1_idx` (`fk_type` ASC),
  CONSTRAINT `fk_Customer_Account_Discount_Plan1`
    FOREIGN KEY (`fk_type`)
    REFERENCES `BAPERS`.`Discount_Plan` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Job` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Job` (
  `job_id` INT NOT NULL,
  `amount_due` INT NOT NULL,
  `deadline` DATETIME NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `urgent` TINYINT(1) NOT NULL,
  `fk_payment_id` INT NOT NULL,
  `fk_account_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`job_id`, `fk_payment_id`, `fk_account_number`),
  INDEX `fk_Job_Payment_Info1_idx` (`fk_payment_id` ASC),
  INDEX `fk_Job_Customer_Account1_idx` (`fk_account_number` ASC),
  CONSTRAINT `fk_Job_Payment_Info1`
    FOREIGN KEY (`fk_payment_id`)
    REFERENCES `BAPERS`.`Payment_Info` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Job_Customer_Account1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Customer_Account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Card_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Card_Details` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Card_Details` (
  `last_digits` VARCHAR(4) NOT NULL,
  `expiry_date` DATE NOT NULL,
  `fk_payment_id` INT NOT NULL,
  `card_type` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`last_digits`, `expiry_date`, `fk_payment_id`),
  INDEX `fk_Card_Details_Payment1_idx` (`fk_payment_id` ASC),
  CONSTRAINT `fk_Card_Details_Payment1`
    FOREIGN KEY (`fk_payment_id`)
    REFERENCES `BAPERS`.`Payment_Info` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Address` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Address` (
  `address_line1` VARCHAR(45) NOT NULL,
  `address_line2` VARCHAR(45) NULL,
  `postcode` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(25) NOT NULL,
  `fk_account_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_line1`, `city`, `postcode`, `fk_account_number`),
  INDEX `fk_Address_Customer_Account1_idx` (`fk_account_number` ASC),
  CONSTRAINT `fk_Address_Customer_Account1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Customer_Account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Task` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Task` (
  `task_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `shelf_slot` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `duration` TIME NOT NULL,
  PRIMARY KEY (`task_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Tasks` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Tasks` (
  `fk_job_id` INT NOT NULL,
  `fk_payment_id` INT NOT NULL,
  `fk_account_number` VARCHAR(45) NOT NULL,
  `fk_task_id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `discount` INT NOT NULL,
  `fk_staff_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`fk_job_id`, `fk_payment_id`, `fk_account_number`, `fk_task_id`),
  INDEX `fk_Job_has_Task_Task1_idx` (`fk_task_id` ASC),
  INDEX `fk_Job_has_Task_Job1_idx` (`fk_job_id` ASC, `fk_payment_id` ASC, `fk_account_number` ASC),
  INDEX `fk_Tasks_Staff1_idx` (`fk_staff_id` ASC),
  CONSTRAINT `fk_Job_has_Task_Job1`
    FOREIGN KEY (`fk_job_id` , `fk_payment_id` , `fk_account_number`)
    REFERENCES `BAPERS`.`Job` (`job_id` , `fk_payment_id` , `fk_account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Job_has_Task_Task1`
    FOREIGN KEY (`fk_task_id`)
    REFERENCES `BAPERS`.`Task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_Staff1`
    FOREIGN KEY (`fk_staff_id`)
    REFERENCES `BAPERS`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `BAPERS`.`User_Type`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`User_Type` (`type`) VALUES ('office manager');
INSERT INTO `BAPERS`.`User_Type` (`type`) VALUES ('shift manager');
INSERT INTO `BAPERS`.`User_Type` (`type`) VALUES ('receptionist');
INSERT INTO `BAPERS`.`User_Type` (`type`) VALUES ('technician');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Discount_Plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('fixed');
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('variable');
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('flexible');
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('none');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Customer_Account`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`, `fk_type`) VALUES ('acc0001', NULL, 'City University', 'prof', 'david', 'rhind', '02070408000', NULL, 'fixed');
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`, `fk_type`) VALUES ('acc0002', NULL, 'AirVia Ltd', 'mr', 'boris', 'berezovsky', '02073218523', NULL, 'flexible');
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`, `fk_type`) VALUES ('acc0003', NULL, 'InfoPharma Ltd', 'mr', 'alex', 'wright', '02073218001', NULL, 'variable');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Address` (`address_line1`, `address_line2`, `postcode`, `city`, `country`, `fk_account_number`) VALUES ('Northhampton Square', NULL, 'ec1v 0hb', 'london', 'england', 'acc0001');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Task`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (1, 'use of large copy camera', 'copy room', 'cr25', 1900, '02:00:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (2, 'black and white film processing', 'development area', 'dr12', 4950, '01:00:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (3, 'bag up', 'packing departments', 'pr10', 600, '30:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (4, 'colour film processing', 'development area', 'dr25', 8000, '01:30:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (5, 'colour transparency processing', 'development area', 'dr100', 11030, '03:00:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (6, 'use of small copy camera', 'copy room', 'cr16', 830, '01:15:00');
INSERT INTO `BAPERS`.`Task` (`task_id`, `description`, `location`, `shelf_slot`, `price`, `duration`) VALUES (7, 'mount transparencies', 'finishing room', 'fr5', 5550, '45:00');

COMMIT;


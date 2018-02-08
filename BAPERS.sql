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
-- Table `BAPERS`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`User` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`User` (
  `user_id` INT NOT NULL,
  `username` VARCHAR(15) NOT NULL,
  `passphrase` VARCHAR(45) NOT NULL,
  `fk_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`user_id`, `fk_type`),
  INDEX `fk_User_User_Type1_idx` (`fk_type` ASC),
  CONSTRAINT `fk_User_User_Type1`
    FOREIGN KEY (`fk_type`)
    REFERENCES `BAPERS`.`User_Type` (`type`)
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
  PRIMARY KEY (`address_line1`, `city`, `postcode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Customer_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Customer_Account` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Customer_Account` (
  `customer_id` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `house_phone` VARCHAR(11) NOT NULL,
  `mobile_phone` VARCHAR(11) NOT NULL,
  `valued` TINYINT(1) NOT NULL,
  `fk_address_line1` VARCHAR(45) NOT NULL,
  `fk_city` VARCHAR(45) NOT NULL,
  `fk_postcode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`customer_id`, `email`, `fk_address_line1`, `fk_city`, `fk_postcode`),
  INDEX `fk_Customer_Account_Address1_idx` (`fk_address_line1` ASC, `fk_city` ASC, `fk_postcode` ASC),
  CONSTRAINT `fk_Customer_Account_Address1`
    FOREIGN KEY (`fk_address_line1` , `fk_city` , `fk_postcode`)
    REFERENCES `BAPERS`.`Address` (`address_line1` , `city` , `postcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Job` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Job` (
  `job_id` INT NOT NULL,
  `fk_customer_id` VARCHAR(45) NOT NULL,
  `amount_due` FLOAT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `urgent` TINYINT(1) NOT NULL,
  PRIMARY KEY (`job_id`, `fk_customer_id`),
  INDEX `fk_Job_Customer1_idx` (`fk_customer_id` ASC),
  CONSTRAINT `fk_Job_Customer1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `BAPERS`.`Customer_Account` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Payment_Info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Payment_Info` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Payment_Info` (
  `payment_id` INT NOT NULL,
  `amount_paid` FLOAT NOT NULL,
  `payment_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`payment_id`))
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
-- Table `BAPERS`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Payment` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Payment` (
  `Payment_payment_id` INT NOT NULL,
  `Payment_fk_job_id` INT NOT NULL,
  `Job_job_id` INT NOT NULL,
  `Job_fk_customer_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Payment_payment_id`, `Payment_fk_job_id`, `Job_job_id`, `Job_fk_customer_id`),
  INDEX `fk_Payment_has_Job_Job1_idx` (`Job_job_id` ASC, `Job_fk_customer_id` ASC),
  INDEX `fk_Payment_has_Job_Payment1_idx` (`Payment_payment_id` ASC, `Payment_fk_job_id` ASC),
  CONSTRAINT `fk_Payment_has_Job_Payment1`
    FOREIGN KEY (`Payment_payment_id`)
    REFERENCES `BAPERS`.`Payment_Info` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Job_Job1`
    FOREIGN KEY (`Job_job_id` , `Job_fk_customer_id`)
    REFERENCES `BAPERS`.`Job` (`job_id` , `fk_customer_id`)
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
  `Job_job_id` INT NOT NULL,
  `Job_fk_customer_id` VARCHAR(45) NOT NULL,
  `Task_task_id` INT NOT NULL,
  PRIMARY KEY (`Job_job_id`, `Job_fk_customer_id`, `Task_task_id`),
  INDEX `fk_Job_has_Task_Task1_idx` (`Task_task_id` ASC),
  INDEX `fk_Job_has_Task_Job1_idx` (`Job_job_id` ASC, `Job_fk_customer_id` ASC),
  CONSTRAINT `fk_Job_has_Task_Job1`
    FOREIGN KEY (`Job_job_id` , `Job_fk_customer_id`)
    REFERENCES `BAPERS`.`Job` (`job_id` , `fk_customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Job_has_Task_Task1`
    FOREIGN KEY (`Task_task_id`)
    REFERENCES `BAPERS`.`Task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

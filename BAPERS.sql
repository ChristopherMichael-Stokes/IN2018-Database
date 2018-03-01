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
  PRIMARY KEY (`account_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Job` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Job` (
  `job_id` VARCHAR(6) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `amount_due` INT NOT NULL,
  `deadline` DATETIME NULL,
  `urgent` TINYINT(1) NOT NULL,
  `fk_account_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`job_id`),
  INDEX `fk_Job_Customer_Account1_idx` (`fk_account_number` ASC),
  CONSTRAINT `fk_Job_Customer_Account1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Customer_Account` (`account_number`)
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
-- Table `BAPERS`.`Discount_Plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Discount_Plan` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Discount_Plan` (
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Job_Task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Job_Task` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Job_Task` (
  `fk_job_id` VARCHAR(6) NOT NULL,
  `fk_task_id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL,
  `fk_staff_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`fk_job_id`, `fk_task_id`),
  INDEX `fk_Job_has_Task_Task1_idx` (`fk_task_id` ASC),
  INDEX `fk_Tasks_Staff1_idx` (`fk_staff_id` ASC),
  INDEX `fk_Job_Task_Job1_idx` (`fk_job_id` ASC),
  CONSTRAINT `fk_Job_has_Task_Task1`
    FOREIGN KEY (`fk_task_id`)
    REFERENCES `BAPERS`.`Task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_Staff1`
    FOREIGN KEY (`fk_staff_id`)
    REFERENCES `BAPERS`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Job_Task_Job1`
    FOREIGN KEY (`fk_job_id`)
    REFERENCES `BAPERS`.`Job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Discount` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Discount` (
  `fk_type` VARCHAR(10) NOT NULL,
  `fk_account_number` VARCHAR(45) NOT NULL,
  INDEX `fk_Discount_Discount_Plan1_idx` (`fk_type` ASC),
  PRIMARY KEY (`fk_account_number`),
  CONSTRAINT `fk_Discount_Discount_Plan1`
    FOREIGN KEY (`fk_type`)
    REFERENCES `BAPERS`.`Discount_Plan` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discount_Customer_Account1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Customer_Account` (`account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Task_Discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Task_Discount` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Task_Discount` (
  `fk_account_number` VARCHAR(45) NOT NULL,
  `fk_task_id` INT NOT NULL,
  `percentage` FLOAT NOT NULL,
  PRIMARY KEY (`fk_account_number`, `fk_task_id`),
  INDEX `fk_Customer_Account_has_Task_Task1_idx` (`fk_task_id` ASC),
  INDEX `fk_Discounts_Discount1_idx` (`fk_account_number` ASC),
  CONSTRAINT `fk_Customer_Account_has_Task_Task1`
    FOREIGN KEY (`fk_task_id`)
    REFERENCES `BAPERS`.`Task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discounts_Discount1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Discount` (`fk_account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Discount_Band`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Discount_Band` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Discount_Band` (
  `fk_account_number` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `percentage` FLOAT NOT NULL,
  PRIMARY KEY (`fk_account_number`, `price`),
  CONSTRAINT `fk_table1_Discount1`
    FOREIGN KEY (`fk_account_number`)
    REFERENCES `BAPERS`.`Discount` (`fk_account_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BAPERS`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BAPERS`.`Payment` ;

CREATE TABLE IF NOT EXISTS `BAPERS`.`Payment` (
  `fk_payment_id` INT NOT NULL,
  `fk_job_id` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`fk_payment_id`, `fk_job_id`),
  INDEX `fk_Payment_Info_has_Job_Job1_idx` (`fk_job_id` ASC),
  INDEX `fk_Payment_Info_has_Job_Payment_Info1_idx` (`fk_payment_id` ASC),
  CONSTRAINT `fk_Payment_Info_has_Job_Payment_Info1`
    FOREIGN KEY (`fk_payment_id`)
    REFERENCES `BAPERS`.`Payment_Info` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Info_has_Job_Job1`
    FOREIGN KEY (`fk_job_id`)
    REFERENCES `BAPERS`.`Job` (`job_id`)
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
-- Data for table `BAPERS`.`Staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0000', 'chris', 'stokes', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'office manager');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0001', 'john', 'nash', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'technician');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0002', 'lee', 'hong', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'technician');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0003', 'julie', 'abbot', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'technician');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0004', 'marina', 'scott', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'technician');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0005', 'stewart', 'pask', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'technician');
INSERT INTO `BAPERS`.`Staff` (`staff_id`, `first_name`, `surname`, `passphrase`, `fk_type`) VALUES ('0006', 'rich', 'evans', 'b109f3bbbc244eb82441917ed06d618b9008dd09b3befd1b5e07394c706a8bb980b1d7785e5976ec049b46df5f1326af5a2ea6d103fd07c95385ffab0cacbc86', 'office manager');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Customer_Account`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`) VALUES ('acc0001', NULL, 'City University', 'prof', 'david', 'rhind', '02070408000', NULL);
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`) VALUES ('acc0002', NULL, 'AirVia Ltd', 'mr', 'boris', 'berezovsky', '02073218523', NULL);
INSERT INTO `BAPERS`.`Customer_Account` (`account_number`, `email`, `account_holder_name`, `title`, `first_name`, `surname`, `house_phone`, `mobile_phone`) VALUES ('acc0003', NULL, 'InfoPharma Ltd', 'mr', 'alex', 'wright', '02073218001', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Job`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Job` (`job_id`, `description`, `amount_due`, `deadline`, `urgent`, `fk_account_number`) VALUES ('abn54', '5 x 4 B& W copy negatives', 1900, NULL, false, 'acc0001');
INSERT INTO `BAPERS`.`Job` (`job_id`, `description`, `amount_due`, `deadline`, `urgent`, `fk_account_number`) VALUES ('acn54', '5 x 4 Colour copy negatives ', 1900, NULL, false, 'acc0001');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Address` (`address_line1`, `address_line2`, `postcode`, `city`, `country`, `fk_account_number`) VALUES ('northhampton square', NULL, 'ec1v 0hb', 'london', 'england', 'acc0001');
INSERT INTO `BAPERS`.`Address` (`address_line1`, `address_line2`, `postcode`, `city`, `country`, `fk_account_number`) VALUES ('12 bond street', NULL, 'wc1v 8hu', 'london', 'england', 'acc0002');
INSERT INTO `BAPERS`.`Address` (`address_line1`, `address_line2`, `postcode`, `city`, `country`, `fk_account_number`) VALUES ('25 bond street', '', 'wc1v 8ls', 'london', 'england', 'acc0003');

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


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Discount_Plan`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('fixed');
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('variable');
INSERT INTO `BAPERS`.`Discount_Plan` (`type`) VALUES ('flexible');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Job_Task`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('abn54', 1, '2018-01-13 12:00:00', '2018-01-13 12:20:00', '0001');
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('abn54', 2, '2018-01-13 12:30:00', '2018-01-13 13:10:00', '0002');
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('abn54', 3, '2018-01-13 13:20:00', '2018-01-13 13:30:00', '0004');
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('acn54', 1, '2018-01-13 12:20:00', '2018-01-13 12:55:00', '0001');
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('acn54', 4, '2018-01-13 13:10:00', '2018-01-13 13:50:00', '0002');
INSERT INTO `BAPERS`.`Job_Task` (`fk_job_id`, `fk_task_id`, `start_time`, `end_time`, `fk_staff_id`) VALUES ('acn54', 3, '2018-01-13 14:00:00', '2018-01-13 14:10:00', '0003');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Discount`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Discount` (`fk_type`, `fk_account_number`) VALUES ('fixed', 'acc0001');
INSERT INTO `BAPERS`.`Discount` (`fk_type`, `fk_account_number`) VALUES ('flexible', 'acc0002');
INSERT INTO `BAPERS`.`Discount` (`fk_type`, `fk_account_number`) VALUES ('variable', 'acc0003');

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Task_Discount`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 1, 0.01);
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 2, 0.01);
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 3, 0);
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 4, 0.02);
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 5, 0);
INSERT INTO `BAPERS`.`Task_Discount` (`fk_account_number`, `fk_task_id`, `percentage`) VALUES ('acc0002', 6, 0.02);

COMMIT;


-- -----------------------------------------------------
-- Data for table `BAPERS`.`Discount_Band`
-- -----------------------------------------------------
START TRANSACTION;
USE `BAPERS`;
INSERT INTO `BAPERS`.`Discount_Band` (`fk_account_number`, `price`, `percentage`) VALUES ('acc0003', 0, 0);
INSERT INTO `BAPERS`.`Discount_Band` (`fk_account_number`, `price`, `percentage`) VALUES ('acc0003', 100000, 0.01);
INSERT INTO `BAPERS`.`Discount_Band` (`fk_account_number`, `price`, `percentage`) VALUES ('acc0003', 200000, 0.02);
INSERT INTO `BAPERS`.`Discount_Band` (`fk_account_number`, `price`, `percentage`) VALUES ('acc0001', 0, 0.03);

COMMIT;
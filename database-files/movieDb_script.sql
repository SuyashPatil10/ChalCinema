-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moviedb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moviedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moviedb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `moviedb` ;

-- -----------------------------------------------------
-- Table `moviedb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(40) NOT NULL,
  `mobile` VARCHAR(15) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `mobile_UNIQUE` (`mobile` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `pincode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE INDEX `location_id_UNIQUE` (`location_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`user_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`user_location` (
  `location_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_user_location_location_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_user_location_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_location_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `moviedb`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_location_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `moviedb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`movie` (
  `movie_id` INT NOT NULL AUTO_INCREMENT,
  `movie_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `duration` VARCHAR(45) NULL,
  `genre` VARCHAR(45) NULL,
  `release_date` DATE NULL,
  `language` VARCHAR(45) NULL,
  `image_url` VARCHAR(100) NULL,
  PRIMARY KEY (`movie_id`),
  UNIQUE INDEX `movie_id_UNIQUE` (`movie_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`theatre_admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`theatre_admin` (
  `theatre_admin_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(15) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`theatre_admin_id`),
  UNIQUE INDEX `theatre_admin_id_UNIQUE` (`theatre_admin_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `mobile_UNIQUE` (`mobile` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `pincode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `city_id_UNIQUE` (`city_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`theatre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`theatre` (
  `theatre_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `no_of_screens` INT NOT NULL,
  `theatre_admin_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`theatre_id`),
  UNIQUE INDEX `theatre_id_UNIQUE` (`theatre_id` ASC) VISIBLE,
  INDEX `fk_theatre_theatre_admin1_idx` (`theatre_admin_id` ASC) VISIBLE,
  INDEX `fk_theatre_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_theatre_theatre_admin1`
    FOREIGN KEY (`theatre_admin_id`)
    REFERENCES `moviedb`.`theatre_admin` (`theatre_admin_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_theatre_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `moviedb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`screen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`screen` (
  `screen_id` INT NOT NULL AUTO_INCREMENT,
  `total_seats` VARCHAR(45) NOT NULL,
  `theatre_id` INT NOT NULL,
  PRIMARY KEY (`screen_id`),
  UNIQUE INDEX `screen_id_UNIQUE` (`screen_id` ASC) VISIBLE,
  INDEX `fk_screen_theatre1_idx` (`theatre_id` ASC) VISIBLE,
  CONSTRAINT `fk_screen_theatre1`
    FOREIGN KEY (`theatre_id`)
    REFERENCES `moviedb`.`theatre` (`theatre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`time` (
  `time_id` INT NOT NULL AUTO_INCREMENT,
  `start_time` VARCHAR(5) NULL,
  `end_time` VARCHAR(5) NULL,
  PRIMARY KEY (`time_id`),
  UNIQUE INDEX `time_id_UNIQUE` (`time_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`show`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`show` (
  `show_id` INT NOT NULL AUTO_INCREMENT,
  `show_date` DATE NOT NULL,
  `movie_id` INT NOT NULL,
  `screen_id` INT NOT NULL,
  `time_id` INT NOT NULL,
  PRIMARY KEY (`show_id`),
  UNIQUE INDEX `show_id_UNIQUE` (`show_id` ASC) VISIBLE,
  INDEX `fk_show_movie1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_show_screen1_idx` (`screen_id` ASC) VISIBLE,
  INDEX `fk_show_time1_idx` (`time_id` ASC) VISIBLE,
  CONSTRAINT `fk_show_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `moviedb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_show_screen1`
    FOREIGN KEY (`screen_id`)
    REFERENCES `moviedb`.`screen` (`screen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_show_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `moviedb`.`time` (`time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`screen_seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`screen_seat` (
  `screen_seat_id` INT NOT NULL AUTO_INCREMENT,
  `seatno` VARCHAR(10) NOT NULL,
  `screen_id` INT NOT NULL,
  PRIMARY KEY (`screen_seat_id`),
  UNIQUE INDEX `screen_id_UNIQUE` (`screen_seat_id` ASC) VISIBLE,
  INDEX `fk_screen_seat_screen1_idx` (`screen_id` ASC) VISIBLE,
  CONSTRAINT `fk_screen_seat_screen1`
    FOREIGN KEY (`screen_id`)
    REFERENCES `moviedb`.`screen` (`screen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`show_seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`show_seat` (
  `show_seat_id` INT NOT NULL AUTO_INCREMENT,
  `status` TINYINT NOT NULL,
  `price` DOUBLE NOT NULL,
  `duration` VARCHAR(10) NOT NULL,
  `show_id` INT NOT NULL,
  `screen_id` INT NOT NULL,
  PRIMARY KEY (`show_seat_id`),
  UNIQUE INDEX `show_seat_id_UNIQUE` (`show_seat_id` ASC) VISIBLE,
  INDEX `fk_show_seat_show1_idx` (`show_id` ASC) VISIBLE,
  INDEX `fk_show_seat_screen_seat1_idx` (`screen_id` ASC) VISIBLE,
  CONSTRAINT `fk_show_seat_show1`
    FOREIGN KEY (`show_id`)
    REFERENCES `moviedb`.`show` (`show_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_show_seat_screen_seat1`
    FOREIGN KEY (`screen_id`)
    REFERENCES `moviedb`.`screen_seat` (`screen_seat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviedb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `amount` DOUBLE NOT NULL,
  `date_time` VARCHAR(50) NOT NULL,
  `method` VARCHAR(20) NOT NULL,
  `transaction_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `moviedb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviedb`.`booking` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `no_of_seats` INT NOT NULL,
  `booking_time` VARCHAR(10) NOT NULL,
  `theatre_id` INT NOT NULL,
  `show_id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE,
  INDEX `fk_booking_theatre1_idx` (`theatre_id` ASC) VISIBLE,
  INDEX `fk_booking_show1_idx` (`show_id` ASC) VISIBLE,
  INDEX `fk_booking_payment1_idx` (`payment_id` ASC) VISIBLE,
  INDEX `fk_booking_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_theatre1`
    FOREIGN KEY (`theatre_id`)
    REFERENCES `moviedb`.`theatre` (`theatre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_show1`
    FOREIGN KEY (`show_id`)
    REFERENCES `moviedb`.`show` (`show_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `moviedb`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `moviedb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS `moviedb`.`movie_theatre` (
  `movie_theatre_id` INT NOT NULL AUTO_INCREMENT,
  `movie_id` INT NOT NULL,
  `theatre_id` INT NOT NULL,
  PRIMARY KEY (`movie_theatre_id`),
  UNIQUE INDEX `unique_movie_theatre` (`movie_id`, `theatre_id`),
  INDEX `fk_movie_theatre_movie_idx` (`movie_id` ASC),
  INDEX `fk_movie_theatre_theatre_idx` (`theatre_id` ASC),
  CONSTRAINT `fk_movie_theatre_movie`
    FOREIGN KEY (`movie_id`)
    REFERENCES `moviedb`.`movie` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movie_theatre_theatre`
    FOREIGN KEY (`theatre_id`)
    REFERENCES `moviedb`.`theatre` (`theatre_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;


SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
    
    drop table payment;
    
    
CREATE TABLE IF NOT EXISTS moviedb.payment (
  payment_id INT NOT NULL AUTO_INCREMENT,
  amount DOUBLE NOT NULL,
  date_time VARCHAR(50) NOT NULL,
  method VARCHAR(20) NOT NULL,
  transaction_id VARCHAR(50) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (payment_id),
  UNIQUE INDEX payment_id_UNIQUE (payment_id ASC) VISIBLE,
  CONSTRAINT fk_payment_user
    FOREIGN KEY (user_id)
    REFERENCES moviedb.user (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;


drop table booking;

CREATE TABLE booking (
    booking_id   INT AUTO_INCREMENT PRIMARY KEY,
    no_of_seats  INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    theatre_id   INT NOT NULL,
    show_id      INT NOT NULL,
    payment_id   INT NOT NULL,
    user_id      INT NOT NULL,
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES `show`(show_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

alter table booking add seat_number VARCHAR(50) NOT NULL;

alter TABLE booking MODIFY COLUMN seat_number VARCHAR(50) NOT NULL;

desc booking;

select * from payment;
select * from user;
select * from theatre_admin;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
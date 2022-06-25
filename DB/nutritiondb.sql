-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nutritiondb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nutritiondb` ;

-- -----------------------------------------------------
-- Schema nutritiondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nutritiondb` DEFAULT CHARACTER SET utf8 ;
USE `nutritiondb` ;

-- -----------------------------------------------------
-- Table `gender`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gender` ;

CREATE TABLE IF NOT EXISTS `gender` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `goal` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `height` DECIMAL(5,2) NOT NULL,
  `weight` DECIMAL(5,2) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `active` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `gender_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` TEXT NOT NULL,
  `team_id` INT NULL,
  `role` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `image_url` TEXT NULL,
  `updated_at` DATETIME NULL,
  `publicProfile` TINYINT NOT NULL,
  `activityLevel` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_gender1_idx` (`gender_id` ASC),
  INDEX `fk_user_team1_idx` (`team_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_gender1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `gender` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `goal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `goal` ;

CREATE TABLE IF NOT EXISTS `goal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `weight` DECIMAL(5,2) NULL,
  `achieved` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `description` VARCHAR(200) NULL,
  `date_achieved` DATE NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Goal_User_idx` (`user_id` ASC),
  CONSTRAINT `fk_Goal_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog` ;

CREATE TABLE IF NOT EXISTS `blog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `image_link` TEXT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blog_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_blog_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(200) NOT NULL,
  `blog_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_blog1_idx` (`blog_id` ASC),
  INDEX `fk_comment_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tracked_day`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tracked_day` ;

CREATE TABLE IF NOT EXISTS `tracked_day` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `day` DATE NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tracked_day_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_tracked_day_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_type` ;

CREATE TABLE IF NOT EXISTS `meal_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `link` TEXT NULL,
  `time_required` INT NULL,
  `recipe_text` TEXT NULL,
  `name` VARCHAR(45) NOT NULL,
  `protein` DECIMAL(5,2) NULL,
  `carbs` DECIMAL(5,2) NULL,
  `fats` DECIMAL(5,2) NULL,
  `sodium` INT NULL,
  `sugar` INT NULL,
  `calories` DECIMAL(6,2) NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `image_url` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal` ;

CREATE TABLE IF NOT EXISTS `meal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tracked_day_id` INT NOT NULL,
  `meal_type_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meal_tracked_day1_idx` (`tracked_day_id` ASC),
  INDEX `fk_meal_meal_type1_idx` (`meal_type_id` ASC),
  INDEX `fk_meal_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_meal_tracked_day1`
    FOREIGN KEY (`tracked_day_id`)
    REFERENCES `tracked_day` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_meal_type1`
    FOREIGN KEY (`meal_type_id`)
    REFERENCES `meal_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forum_post` ;

CREATE TABLE IF NOT EXISTS `forum_post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `topic` VARCHAR(45) NULL,
  `content` TEXT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_forum_post_User1_idx` (`user_id` ASC),
  INDEX `fk_forum_post_forum_post1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_forum_post_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forum_post_forum_post1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `forum_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diet` ;

CREATE TABLE IF NOT EXISTS `diet` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calories` INT NULL,
  `protein` DECIMAL(5,2) NULL,
  `carbs` DECIMAL(5,2) NULL,
  `fats` DECIMAL(5,2) NULL,
  `sodium` INT NULL,
  `sugar` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise_day`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `exercise_day` ;

CREATE TABLE IF NOT EXISTS `exercise_day` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wokout` VARCHAR(45) NULL,
  `calories` INT NULL,
  `exercised` TINYINT NULL,
  `tracked_day_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_exercise_day_tracked_day1_idx` (`tracked_day_id` ASC),
  CONSTRAINT `fk_exercise_day_tracked_day1`
    FOREIGN KEY (`tracked_day_id`)
    REFERENCES `tracked_day` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_recipe` ;

CREATE TABLE IF NOT EXISTS `user_has_recipe` (
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_user_has_recipe_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_user_has_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_recipe_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_recipe` ;

CREATE TABLE IF NOT EXISTS `user_recipe` (
  `user_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_user_has_recipe1_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_user_has_recipe1_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_recipe1_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_recipe1_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient_has_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient_has_ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient_has_ingredient` (
  `ingredient_id` INT NOT NULL,
  `ingredient_id1` INT NOT NULL,
  PRIMARY KEY (`ingredient_id`, `ingredient_id1`),
  INDEX `fk_ingredient_has_ingredient_ingredient2_idx` (`ingredient_id1` ASC),
  INDEX `fk_ingredient_has_ingredient_ingredient1_idx` (`ingredient_id` ASC),
  CONSTRAINT `fk_ingredient_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredient_has_ingredient_ingredient2`
    FOREIGN KEY (`ingredient_id1`)
    REFERENCES `ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_ingredient` ;

CREATE TABLE IF NOT EXISTS `recipe_ingredient` (
  `recipe_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`),
  INDEX `fk_recipe_has_ingredient_ingredient1_idx` (`ingredient_id` ASC),
  INDEX `fk_recipe_has_ingredient_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_has_ingredient_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chat` ;

CREATE TABLE IF NOT EXISTS `chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(200) NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `team_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_text_user1_idx` (`user_id` ASC),
  INDEX `fk_chat_team1_idx` (`team_id` ASC),
  CONSTRAINT `fk_text_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `topic` ;

CREATE TABLE IF NOT EXISTS `topic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog_topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog_topic` ;

CREATE TABLE IF NOT EXISTS `blog_topic` (
  `topic_id` INT NOT NULL,
  `blog_id` INT NOT NULL,
  PRIMARY KEY (`topic_id`, `blog_id`),
  INDEX `fk_topic_has_blog_blog1_idx` (`blog_id` ASC),
  INDEX `fk_topic_has_blog_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_topic_has_blog_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topic_has_blog_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS nutrition@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'nutrition'@'localhost' IDENTIFIED BY 'nutrition';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'nutrition'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `gender`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `gender` (`id`, `name`) VALUES (1, 'Female');
INSERT INTO `gender` (`id`, `name`) VALUES (2, 'Male');
INSERT INTO `gender` (`id`, `name`) VALUES (3, 'Other');

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `team` (`id`, `name`, `goal`) VALUES (1, 'Witcher', 'Kill Monsters, Get Rich');
INSERT INTO `team` (`id`, `name`, `goal`) VALUES (2, 'Cinnamon Crescent', 'Create an awesome website');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `publicProfile`, `activityLevel`) VALUES (1, 67, 150, '1995-03-21 ', 1, 'Katherine', 'Remick', 'remick.ka@gmail.com', 1, 'kate', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_ADMIN', '2022-06-21 03:20:20', NULL, NULL, 1, 2);
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `publicProfile`, `activityLevel`) VALUES (2, 65, 145, '1100-04-05', 1, 'Kiera', 'Metz', 'kmetz@witcher.game', 1, 'kiera', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_STANDARD', '2022-06-21 03:20:20', NULL, NULL, 1, 3);
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `publicProfile`, `activityLevel`) VALUES (3, 74, 200, '1050-7-12', 1, 'Geralt', 'of Rivia', 'grivia@witcher.game', 2, 'geralt', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_STANDARD', '2022-06-21 03:20:20', NULL, NULL, 0, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `goal` (`id`, `name`, `weight`, `achieved`, `user_id`, `description`, `date_achieved`, `created_at`) VALUES (1, 'Eat Grass', 200, 0, 3, NULL, NULL, '2022-06-21 03:20:20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (1, 'This is a test CAN YOU HEAR ME FROM IN HERE?', NULL, 1, '2022-06-21 20:51:21', 'Blog 1 TEST');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `comment` (`id`, `content`, `blog_id`, `user_id`, `created_at`) VALUES (1, 'YES I CAN HEAR YOU - WHY ARE YOU IN MY COMPUTER???!', 1, 1, '2022-06-21 08:20:20');
INSERT INTO `comment` (`id`, `content`, `blog_id`, `user_id`, `created_at`) VALUES (2, 'WHaT iS a COmpUTER?', 1, 3, '2022-06-21 08:20:20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tracked_day`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `tracked_day` (`id`, `day`, `user_id`) VALUES (1, '2022-06-21', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `meal_type` (`id`, `name`) VALUES (1, 'Breakfast');
INSERT INTO `meal_type` (`id`, `name`) VALUES (2, 'Lunch');
INSERT INTO `meal_type` (`id`, `name`) VALUES (3, 'Dinner');
INSERT INTO `meal_type` (`id`, `name`) VALUES (4, 'Snack');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (1, NULL, 10, '2 Eggs, 1 cup frozen hash brown mix, 1 tbsp vegetable oil: Add oil and hashbrowns to pan, set to medium heat. Beat eggs, add seasoning to taste. When hashbrowns begin to brown add in eggs. Stir and serve when at desired firmness.', 'Easy Morning Hash', 20, 10, 9, 20, 0, 300, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (2, NULL, 12, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (3, NULL, 34, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (4, NULL, 23, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (5, NULL, 13, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (6, NULL, 5, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (7, NULL, 56, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (8, NULL, 20, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (9, NULL, 23, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (10, NULL, 11, 'test 1', 'test name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `user_id`, `created_at`, `updated_at`, `image_url`) VALUES (11, NULL, 12, 'test 15000', 'name', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `recipe_id`) VALUES (1, 1, 1, 1);
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `recipe_id`) VALUES (2, 1, 2, 1);
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `recipe_id`) VALUES (3, 1, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `ingredient` (`id`, `name`) VALUES (1, 'egg');
INSERT INTO `ingredient` (`id`, `name`) VALUES (2, 'potatoes');
INSERT INTO `ingredient` (`id`, `name`) VALUES (3, 'vegetable oil');

COMMIT;


-- -----------------------------------------------------
-- Data for table `forum_post`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `forum_post` (`id`, `topic`, `content`, `user_id`, `created_at`, `in_reply_to_id`) VALUES (1, 'Tests', 'THIS IS A TEST... Your exam will begin now. If you see this - you passed', 1, '2022-06-21 21:00:00', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `user_recipe` (`user_id`, `recipe_id`) VALUES (2, 1);
INSERT INTO `user_recipe` (`user_id`, `recipe_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`) VALUES (1, 1);
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`) VALUES (1, 2);
INSERT INTO `recipe_ingredient` (`recipe_id`, `ingredient_id`) VALUES (1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chat`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `chat` (`id`, `content`, `user_id`, `created_at`, `team_id`) VALUES (1, 'So, what\'s the best way to kill a wyvern?', 3, '2022-06-22 09:22:22', 1);
INSERT INTO `chat` (`id`, `content`, `user_id`, `created_at`, `team_id`) VALUES (2, 'Rip its head off?', 2, '2022-06-22 10:22:22', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `topic`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `topic` (`id`, `name`, `description`) VALUES (1, 'Test Topic', 'blah blah blah');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_topic`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 1);

COMMIT;


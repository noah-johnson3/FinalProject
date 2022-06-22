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
-- Table `role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role` ;

CREATE TABLE IF NOT EXISTS `role` (
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
  `age` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `gender_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` TEXT NOT NULL,
  `team_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_gender1_idx` (`gender_id` ASC),
  INDEX `fk_user_role1_idx` (`role_id` ASC),
  INDEX `fk_user_team1_idx` (`team_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_gender1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `gender` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`id`)
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
  `topic` VARCHAR(45) NULL,
  `text` TEXT NOT NULL,
  `image_link` TEXT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
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
  `text` VARCHAR(200) NOT NULL,
  `blog_id` INT NOT NULL,
  `user_id` INT NOT NULL,
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
  `date` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `date_UNIQUE` (`date` ASC),
  INDEX `fk_tracked_day_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_tracked_day_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nutrition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nutrition` ;

CREATE TABLE IF NOT EXISTS `nutrition` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `protein` DECIMAL(5,2) NULL,
  `carbs` DECIMAL(5,2) NULL,
  `fats` DECIMAL(5,2) NULL,
  `sodium` INT NULL,
  `sugar` INT NULL,
  `calories` DECIMAL(6,2) NULL,
  PRIMARY KEY (`id`))
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
-- Table `meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal` ;

CREATE TABLE IF NOT EXISTS `meal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tracked_day_id` INT NOT NULL,
  `nutrition_id` INT NOT NULL,
  `meal_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meal_tracked_day1_idx` (`tracked_day_id` ASC),
  INDEX `fk_meal_nutrition1_idx` (`nutrition_id` ASC),
  INDEX `fk_meal_meal_type1_idx` (`meal_type_id` ASC),
  CONSTRAINT `fk_meal_tracked_day1`
    FOREIGN KEY (`tracked_day_id`)
    REFERENCES `tracked_day` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_nutrition1`
    FOREIGN KEY (`nutrition_id`)
    REFERENCES `nutrition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_meal_type1`
    FOREIGN KEY (`meal_type_id`)
    REFERENCES `meal_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `link` TEXT NULL,
  `time` INT NULL,
  `recipe_text` TEXT NULL,
  `name` VARCHAR(45) NOT NULL,
  `nutrition_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_nutrition1_idx` (`nutrition_id` ASC),
  CONSTRAINT `fk_recipe_nutrition1`
    FOREIGN KEY (`nutrition_id`)
    REFERENCES `nutrition` (`id`)
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
  `text` TEXT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_forum_post_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_forum_post_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reply` ;

CREATE TABLE IF NOT EXISTS `reply` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `forum_post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reply_forum_post1_idx` (`forum_post_id` ASC),
  INDEX `fk_reply_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_reply_forum_post1`
    FOREIGN KEY (`forum_post_id`)
    REFERENCES `forum_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
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
  PRIMARY KEY (`id`))
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
  `text` VARCHAR(200) NOT NULL,
  `chat_id` INT NOT NULL,
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
-- Data for table `role`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `role` (`id`, `name`) VALUES (1, 'admin');
INSERT INTO `role` (`id`, `name`) VALUES (2, 'user');

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
INSERT INTO `user` (`id`, `height`, `weight`, `age`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `role_id`, `username`, `password`, `team_id`) VALUES (1, 67, 150, 27, 1, 'Katherine', 'Remick', 'remick.ka@gmail.com', 1, 1, 'kate', 'password', 1);
INSERT INTO `user` (`id`, `height`, `weight`, `age`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `role_id`, `username`, `password`, `team_id`) VALUES (2, 65, 145, 25, 1, 'Kiera', 'Metz', 'kmetz@witcher.game', 1, 2, 'kiera', 'password', 1);
INSERT INTO `user` (`id`, `height`, `weight`, `age`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `role_id`, `username`, `password`, `team_id`) VALUES (3, 74, 200, 60, 1, 'Geralt', 'of Rivia', 'grivia@witcher.game', 2, 2, 'geralt', 'password', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `goal`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `goal` (`id`, `name`, `weight`, `achieved`, `user_id`) VALUES (1, 'Eat Grass', 200, 0, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `blog` (`id`, `topic`, `text`, `image_link`, `user_id`, `created_at`) VALUES (1, 'Test Blog', 'This is a test CAN YOU HEAR ME FROM IN HERE?', NULL, 1, '2022-06-21 20:51:21');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `comment` (`id`, `text`, `blog_id`, `user_id`) VALUES (1, 'YES I CAN HEAR YOU - WHY ARE YOU IN MY COMPUTER???!', 1, 1);
INSERT INTO `comment` (`id`, `text`, `blog_id`, `user_id`) VALUES (2, 'WHaT iS a COmpUTER?', 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tracked_day`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `tracked_day` (`id`, `date`, `user_id`) VALUES (1, '2022-06-21 21:00:00', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nutrition`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `nutrition` (`id`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`) VALUES (1, 40, 5, 10, 200, 3, 800);
INSERT INTO `nutrition` (`id`, `protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`) VALUES (2, 30, 20, 5, 50, 0, 300);

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
-- Data for table `meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `meal` (`id`, `tracked_day_id`, `nutrition_id`, `meal_type_id`) VALUES (1, 1, 1, 1);
INSERT INTO `meal` (`id`, `tracked_day_id`, `nutrition_id`, `meal_type_id`) VALUES (2, 1, 1, 2);
INSERT INTO `meal` (`id`, `tracked_day_id`, `nutrition_id`, `meal_type_id`) VALUES (3, 1, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `recipe` (`id`, `link`, `time`, `recipe_text`, `name`, `nutrition_id`) VALUES (1, NULL, 10, '2 Eggs, 1 cup frozen hash brown mix, 1 tbsp vegetable oil: Add oil and hashbrowns to pan, set to medium heat. Beat eggs, add seasoning to taste. When hashbrowns begin to brown add in eggs. Stir and serve when at desired firmness.', 'Easy Morning Hash', 2);

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
INSERT INTO `forum_post` (`id`, `topic`, `text`, `user_id`, `created_at`) VALUES (1, 'Tests', 'THIS IS A TEST... Your exam will begin now. If you see this - you passed', 1, '2022-06-21 21:00:00');

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
INSERT INTO `chat` (`id`, `text`, `chat_id`, `user_id`, `created_at`, `team_id`) VALUES (1, 'So, what\'s the best way to kill a wyvern?', 1, 3, '2022-06-22 09:22:22', 1);
INSERT INTO `chat` (`id`, `text`, `chat_id`, `user_id`, `created_at`, `team_id`) VALUES (2, 'Rip its head off?', 1, 2, '2022-06-22 10:22:22', 1);

COMMIT;


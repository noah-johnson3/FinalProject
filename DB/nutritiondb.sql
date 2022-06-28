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
  `public_profile` TINYINT NOT NULL,
  `activity_level` INT NOT NULL,
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
-- Table `nutrients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nutrients` ;

CREATE TABLE IF NOT EXISTS `nutrients` (
  `protein` DECIMAL(5,2) NULL,
  `carbs` DECIMAL(5,2) NULL,
  `fats` DECIMAL(5,2) NULL,
  `sodium` INT NULL,
  `sugar` INT NULL,
  `calories` DECIMAL(6,2) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `cholesterol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal` ;

CREATE TABLE IF NOT EXISTS `meal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tracked_day_id` INT NOT NULL,
  `meal_type_id` INT NOT NULL,
  `nutrients_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meal_tracked_day1_idx` (`tracked_day_id` ASC),
  INDEX `fk_meal_meal_type1_idx` (`meal_type_id` ASC),
  INDEX `fk_meal_nutrients1_idx` (`nutrients_id` ASC),
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
  CONSTRAINT `fk_meal_nutrients1`
    FOREIGN KEY (`nutrients_id`)
    REFERENCES `nutrients` (`id`)
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
  `time_required` INT NULL,
  `recipe_text` TEXT NULL,
  `name` VARCHAR(100) NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `image_url` TEXT NULL,
  `recipecol` VARCHAR(45) NULL,
  `nutrients_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC),
  INDEX `fk_recipe_nutrients1_idx` (`nutrients_id` ASC),
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_nutrients1`
    FOREIGN KEY (`nutrients_id`)
    REFERENCES `nutrients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  `nutrients_id` INT NULL,
  `portion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ingredient_nutrients1_idx` (`nutrients_id` ASC),
  CONSTRAINT `fk_ingredient_nutrients1`
    FOREIGN KEY (`nutrients_id`)
    REFERENCES `nutrients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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


-- -----------------------------------------------------
-- Table `meal_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal_ingredient` ;

CREATE TABLE IF NOT EXISTS `meal_ingredient` (
  `meal_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  PRIMARY KEY (`meal_id`, `ingredient_id`),
  INDEX `fk_meal_has_ingredient_ingredient1_idx` (`ingredient_id` ASC),
  INDEX `fk_meal_has_ingredient_meal1_idx` (`meal_id` ASC),
  CONSTRAINT `fk_meal_has_ingredient_meal1`
    FOREIGN KEY (`meal_id`)
    REFERENCES `meal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meal_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ingredient` (`id`)
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
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `public_profile`, `activity_level`) VALUES (1, 67, 150, '1995-03-21 ', 1, 'Katherine', 'Remick', 'remick.ka@gmail.com', 1, 'kate', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_ADMIN', '2022-06-21 03:20:20', NULL, NULL, 1, 2);
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `public_profile`, `activity_level`) VALUES (2, 65, 145, '1100-04-05', 1, 'Kiera', 'Metz', 'kmetz@witcher.game', 1, 'kiera', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_STANDARD', '2022-06-21 03:20:20', NULL, NULL, 1, 3);
INSERT INTO `user` (`id`, `height`, `weight`, `date_of_birth`, `active`, `first_name`, `last_name`, `email`, `gender_id`, `username`, `password`, `team_id`, `role`, `created_at`, `image_url`, `updated_at`, `public_profile`, `activity_level`) VALUES (3, 74, 200, '1050-7-12', 1, 'Geralt', 'of Rivia', 'grivia@witcher.game', 2, 'geralt', '$2a$10$BksOLP0ikdH575YcbXXmIOpDYCbuoULmmTLWkQ8galzRaiC3PWpgC', 1, 'ROLE_STANDARD', '2022-06-21 03:20:20', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyvKHB3QHycR8WxE49mLxs3Hh9auDw1Qrv8A&usqp=CAU', NULL, 0, 5);

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
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (16, '“Most of us don’t get the recommended servings of fruits and vegetables each day, partly because it can be time-intensive to wash, prep, and store fresh produce,” says Cara Harbstreet, M.S., R.D., L.D., of Street Smart Nutrition. Keeping frozen or canned options on hand can be a lifesaver when you’re short on time. “These options are just as nourishing, with the added benefit of being less perishable and (sometimes) less expensive,” Harbstreet adds. “Add frozen veggies to canned soup or reheated leftovers, serve canned veggies as a side dish, or enjoy canned fruit with mid-day snacks.” Voila—an easy way to load vitamins and nutrients into a meal with very minimal work involved.', NULL, 1, '2022-06-21 20:51:21', 'Look Beyond Fresh Produce');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (2, '“Always chop the whole onion (or pepper, carrot, or celery),” says Marisa Moore, R.D.N. L.D., M.B.A., culinary and integrative dietitian. Prepping when you do have the time will make it easy to just grab and use the ingredients when you don’t have time to chop and clean and cook but still want to make a healthy meal. “Having prepped aromatic vegetables ready to go makes it easy to whip up a quick soup, stew, stir-fry or a veggie tofu or egg scramble,” Moore adds. If you end up with too many chopped peppers and onions, Moore suggests spreading them in a single layer in a freezer-safe bag and laying flat until frozen. “Frozen onions and peppers work great as the base for soups and stews!”', NULL, 1, '2022-06-21 20:51:21', 'Chop Everything At Once');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (3, 'One of the easiest ways to throw together a meal is to basically just combine a bunch of snack foods to create a meal—with various flavors, textures, and nutrients. “This saves time because you don’t have to cook, and there’s no prep or clean up,” Harbstreet says. “Plus, it can combat boredom since various items can be combined in different ways each time.” Stock up on things like string cheese, deli meats, raw veggies, dips, crackers, dried fruit, and nuts, and then combine them depending on what you’re in the mood for. “Think of it as an elevated Lunchable or low key charcuterie board.”\n\nOne of the easiest ways to throw together a meal is to basically just combine a bunch of snack foods to create a meal—with various flavors, textures, and nutrients. “This saves time because you don’t have to cook, and there’s no prep or clean up,” Harbstreet says. “Plus, it can combat boredom since various items can be combined in different ways each time.” Stock up on things like string cheese, deli meats, raw veggies, dips, crackers, dried fruit, and nuts, and then combine them depending on what you’re in the mood for. “Think of it as an elevated Lunchable or low key charcuterie board.”\n\n', NULL, 1, '2022-06-21 20:51:21', 'Embrace the snack-meal');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (4, 'There’s no denying that the more budget-friendly option is to buy ingredients whole and prep them yourself. But if you’re really crunched for time and need a way to still get healthy food on the table? Amy Carson, R.D., L.D.N., C.P.T., recommends paying for the convenience when you can. Vegetable trays pre-cut, frozen vegetables, or bagged salads that come with all the mix-ins can all help you get a meal on the table in less time. “Sure, these are a little more expensive, but they save you time and give you energy.”', NULL, 1, '2022-06-21 20:51:21', 'Buy Pre-cut and Pre-bagged Foods');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (5, 'Among the many levels of busy is “so busy that you forget what the inside of a grocery store looks like.” To avoid getting stuck at home after a long day without anything on hand that you can throw together, make it a habit to keep a few meals in your freezer that you can simply open, heat up, and eat, without having to even think about prep or clean up. Sweet Earth’s plant-based frozen meals are a great option—they’re nutrient-diverse, affordable, and crafted for the discerning eater, meaning both taste and environmental impact are top of mind. Try the Pad Thai Entrée, Veggie Lovers Pizza, or Mindful Chik’n Strips, which are all made thoughtfully with ingredients to honor and sustain the environment they come from and your body.\n\nAmong the many levels of busy is “so busy that you forget what the inside of a grocery store looks like.” To avoid getting stuck at home after a long day without anything on hand that you can throw together, make it a habit to keep a few meals in your freezer that you can simply open, heat up, and eat, without having to even think about prep or clean up. Sweet Earth’s plant-based frozen meals are a great option—they’re nutrient-diverse, affordable, and crafted for the discerning eater, meaning both taste and environmental impact are top of mind. Try the Pad Thai Entrée, Veggie Lovers Pizza, or Mindful Chik’n Strips, which are all made thoughtfully with ingredients to honor and sustain the environment they come from and your body.\n\n', NULL, 1, '2022-06-21 20:51:21', 'Stock Your Freezer With Healthy Meals that Require zero Prep');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (6, 'To make sure you’ve got something good on hand for those extra busy days, Linzy Ziegelbaum, MS, RD, CDN, suggests cooking meals when you have the time and stashing some in the freezer. Then, defrost and heat up as needed. “For example, make a batch of chicken meatballs and keep them in your freezer for when you don\'t have time to make dinner,” she says. For an even more hands-off approach: Make big batches of soups and stews in your slow-cooker and then freeze half to make future-you’s life a lot less stressful.', NULL, 1, '2022-06-21 20:51:21', 'Batch cook and freeze');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (7, 'Meal prep is so popular because, well, it’s a really great way to cook efficiently and not have to make mealtime a big to-do every single time. To keep some variety in your meal prep game, try prepping individual ingredients instead of fully constructed meals. That way, you can combine them in different ways and keep things feeling fresh throughout the week. “For example, if you prepare a protein such as chicken, roasted vegetables and starches such as sweet potatoes or rice ahead of time it is easy to quickly get a healthy balanced meal onto a plate quickly,” Ziegelbaum says.\n\n', NULL, 1, '2022-06-21 20:51:21', 'Prep ingredients in advance');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (8, '\"Thanks to the popularity of so-called \'clean eating,’ I find a lot of people are afraid to keep store-bought condiments in the house,” says Rachael Hartley, RD, LD, Certified Intuitive Eating Counselor, Author of Gentle Nutrition. “In reality, having a variety of tasty sauces and dressings on hand makes cooking tasty and nutritious meals at home much easier, and saves a ton of time from making your own sauces!” Once you feel comfortable with a basic recipe, you can experiment with new flavors by switching up the sauces and making a meal feel different or new with minimal effort. Hartley’s go-tos are pesto, Japanese barbecue sauce, jerk marinade, and harissa.', NULL, 1, '2022-06-21 20:51:21', 'Get Creative with condiments');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (9, 'An unorganized and cluttered kitchen can cause even more anxiety and make the whole meal prep process overwhelming, says Kari Pitts, R.D., L.D.N., at Preg Appetit. A well-organized space can do just the opposite. “An organized kitchen can make finding your ingredients and tools easier, so you can move more quickly when preparing healthy meals,” Pitts says. Clear space on your countertop, so that you have a dedicated spot to prep meals, and keep appliances and gadgets that you use frequently in an easy-to-use place (not stashed away in the back of a cabinet that you can only reach with a step stool).', NULL, 1, '2022-06-21 20:51:21', 'Organize Your Workspace');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (10, '“When you’re busy, sticking to a rigid, planned set of meals can be challenging. It takes a lot of mental energy to think more than a few days in advance, and sometimes feels nearly impossible to predict what will sound good to you when that day comes,” Harbstreet says. Instead, she recommends keeping a few \"MVP meals” in your back pocket that require minimal prep or clean up and 20 minutes of cook time—or less. Keep the MVPs in mind when you’re doing your routine shopping, so that you can make sure you have options without having to do the extra mental work of planning, Harbstreet suggests.', NULL, 1, '2022-06-21 20:51:21', 'Have a plan withoug sticking to a meal plan');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (11, 'Take things one step further and actually put together a physical recipe book, Pitts suggests. “It can be frustrating and time consuming trying to remember or find your favorite healthy meals online or digging through old recipe books,” she says. “To keep track of healthy meals you like and would like to make again, create your own healthy-cooking notebook and store it in a designated place to quickly reference anytime.”', NULL, 1, '2022-06-21 20:51:21', 'Make a recipe book');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (12, '“I\'m a big fan of prepping and planning so that it\'s easy to grab food and go,” says Shana Minei Spence, M.S., R.D.N., C.D.N., founder of The Nutrition Tea. This can be especially helpful if you’re someone who never has time to eat breakfast in the morning. Spence suggests making egg and veggie muffins in a muffin tin, and then just popping them in the microwave when you need something quick and full of nutrients and protein. “These are a great way to add in veggies to your day, as most people don\'t eat enough,” she says. You can also pre-freeze smoothie bags. “Put all the fruit and veggies that you are using in a baggie and pop it in the freezer the night before. In the morning, all you have to do is pour into a blender with your choice of milk or yogurt,” Spence says. So quick and easy.', NULL, 1, '2022-06-21 20:51:21', 'Prep breakfast the night before');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (13, '“Remember that every meal and snack does not have to be fancy,” Ziegelbaum says. “Just because you did not spend a lot of time preparing your meal does not mean your meal is not a healthy one!” A simple peanut butter sandwich on whole wheat bread with fruit and yogurt makes a great lunch, she says. So does a snack-meal. Some days, you just have to remember that as long as you’re eating something that’s nourishing and gives you energy to go about your busy day without feeling hangry, then you’re doing great.', NULL, 1, '2022-06-21 20:51:21', 'Keep it simple');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (14, '“A well stocked pantry can save trips to the grocery store,” Pitts says. “Some examples of healthy foods to keep in your pantry include quinoa, brown rice, whole wheat pasta, canned beans, dried fruit, and nuts.” Keeping a variety on hand will make it easy to throw together whatever you have time for, without requiring you to get too creative or run out for that one missing-yet-essential ingredient.', NULL, 1, '2022-06-21 20:51:21', 'Stock up on healthy pantry essentials');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (15, 'If you really don’t have time for a meal, you want to make sure you at least have some healthy snacks you can grab to keep yourself satiated until you can sit down for a proper meal. Spence suggests stocking up on and carrying portable snacks that can curb hunger and fuel you quickly on the go. “I like to stash granola bars in my bags so I always have something ‘just in case.’ Other great options are pre-mixing trail mix with a combo of cereal, nuts, dried fruit, chocolate chips, seeds, etc.,” she suggests.', NULL, 1, '2022-06-21 20:51:21', 'Carry Snacks With You');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (1, 'Sure, you are busy. Work, kids, new opportunities, those are often the priority. Healthy eating becomes a secondary concern in your life. So you run down to the cafeteria, grab the easiest and quickest thing to eat, and run back to the office for a working lunch. Even when you get home, you probably are so tired you just call up the usual takeout. This may solve the food problem but eventually it takes its toll on your health, either through weight gain, lost energy, or both.\n\nThis was a problem for Ooshma Garg while she was a junior at Stanford University and starting her first company. Her intense schedule as an entrepreneur and student left no time to eat healthily.\n\nGarg was tired of eating fast food in her car, so she went on Craigslist and asked if there was anyone willing to cook for her for $8 a plate. She was surprised with the response she received. This simple act of solving the healthy home-cooked meal problem for herself eventually led her to found Gobble to solve everyone\'s problem with innovative 10-minute fresh dinner kits.\n\nAt Gobble, Garg not only figured out how to deliver fresh ingredients direct to your door, but also how her company can do all the prep and chopping so all you have to do is sizzle everything together in a pan and serve the meal. It\'s working so well that Gobble is expanding quickly and has raised funds in three rounds from high-profile investors including Andreessen Horowitz and Trinity Ventures.\n\nGarg believes that even the busiest workaholics can have a healthier diet by integrating these simple six tips into daily busy schedule.\n\n1. Make a simple breakfast a priority.\nPeople tend to be in a rush during the morning as they prepare to go to work, and they usually neglect the first meal of the day. Garg believes that breakfast is crucial to getting the body ready for the long day. Her recommendations? \"I\'m an on-the-go woman. I have two standard breakfast options, either probiotic-packed Greek yogurt or a spinach, banana, and coconut water smoothie with no extra added sugar,\" she revealed. She also recommends starting the day with eight ounces of hot lemon water, because it will \"rejuvenate your system, which has been on a fast all night long. This gives your immune system a boost, strengthens the brain, hydrates, aids digestion, and relieves stress with vitamin C.\"\n\n2. Pre-portion your snacks to avoid overeating.\nSnacking is one habit a lot of people get into throughout the day so that they can get something into their system. But even when avoiding junk food, people often lose track of how much they eat. Garg has a fix for this: \"My midmorning and afternoon snacks consist of pre-portioned nuts or fruit,\" she added. \"Pre-portioning in the kitchen is most important so that I don\'t get tempted to overeat. Better to put a small portion in a bowl than to take the whole bag or box of your snack.\"\n\n3. Drink a lot of water.\nPeople like to drink coffee throughout the workday to keep themselves energized, but Garg drinks water instead to ensure that \"my body is clear and free of any toxins I might eat or drink. I like to use a medium-size water bottle--that way I can take it everywhere and only have to fill it twice during the day.\" It\'s cheaper than a mocha latte and you don\'t have to take time to prepare it.\n\n4. Eat at the same time every day.\nMany busy people set daily routines at the office. This way they can control the things that are controllable, leaving them mentally free to deal with whatever unexpected challenges or opportunities come their way. Eating should be no different, according to Garg. Having a specific time and routine for eating ensures that you are able to prepare for it and make healthier choices than rushing through a meal. Then, when the exciting food adventure comes, you can make choices accordingly.\n\n5. Go for the lighter lunch.\nLunch is likely the meal that most directly impacts any hard worker, because it happens in the middle of the workday. Calorie-rich business lunches can bring on health risks and joining in on the take-out group can be tempting when busy. Nothing is easier and healthier than a simple salad, which can be prepared rather quickly. Of course you need to lay off the fatty dressing and opt instead for a little lemon juice with a hint of olive oil. \"Make lunch that consists of a green vegetable salad with protein, along with some sort of thin side carbs (low fat pretzels or crackers with hummus),\" recommends Garg.\n\n6. Walk and talk.\nEating healthy alone will not give you the energy and brain power you need for success. Exercise will make a positive impact as well. You may not think you have the time, but you do with Garg\'s process. \"All of my calls are walking calls. I carry a notepad and pen and walk around Silicon Valley with headphones, which allows me to speak on the calls hands-free,\" she explained. \"Sometimes, I have to stop and sit on a bench to write notes. I set a daily walking goal of 10,000 steps per day. This allows one to maintain a healthy lifestyle and with moderation, maintain a healthy body.\"', NULL, 1, '2022-06-21 20:51:21', '6 Ways to Eat Healthier When you are super busy');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (17, 'How to Start Exercising: A Beginner’s Guide to Working Out\nRegular exercise is one of the best things you can do for your health.\n\nIn fact, you’ll begin to see and feel the benefits consistent physical activity can have on your body and well-being quickly.\n\nHowever, working exercise into your routine takes a lot of determination, and sticking to it in the long term requires discipline.\n\nIf you’re considering starting to exercise but don’t know where to begin, this article is for you. Here’s all you need to know about starting a routine and sticking to it.\n\nLumina/Stocksy United\nWhy exercise?\nRegular exercise has been shown to improve your health significantly (1Trusted Source).\n\nIts primary benefits include helping you achieve and maintain a healthy body weight and muscle mass and reducing your risk for chronic diseases (2Trusted Source, 3Trusted Source, 4, 5Trusted Source).\n\nAdditionally, research has shown that exercise can lift your mood, boost your mental health, help you sleep better, and even enhance your sex life (6Trusted Source, 7Trusted Source, 8).\n\nAnd that’s not all. It can also help you maintain good energy levels (9Trusted Source).\n\nIn short, exercise is powerful and can help improve your life.\n\nSUMMARY\nExercise can help to improve mental function, reduce your risk for chronic disease and manage your weight.\n\n\nCommon types of exercise\nThere are various types of exercise, including:\n\nAerobic. The core of any fitness program should include some form of continuous movement. Examples include swimming, running, and dancing.\nStrength. These exercises help increase muscle power and strength. Examples include resistance training, plyometrics, weightlifting, and sprinting.\nCalisthenics. These moves are usually performed without gym equipment using large muscle groups. They’re done at a medium aerobic pace. Examples include lunges, situps, pushups, and pullups.\nHigh-intensity interval training (HIIT). This type of exercise includes repetitions of short bursts of high-intensity exercise followed by low-intensity exercises or rest periods.\nBoot camps. These are timed-based, high-intensity circuits that combine aerobic and resistance exercises.\nBalance or stability. These exercises are designed to strengthen muscles and improves body coordination. Examples include Pilates, tai chi poses, and core-strengthening exercises.\nFlexibility. These types of exercises help muscle recovery, maintain range of motion, and prevent injuries. Examples include yoga or individual muscle-stretch movements.\nThe activities above can be done individually or combined. The important thing is to do what works best for you and to have fun with it.\n\nSUMMARY\nCommon types of exercise include aerobic, strength, calisthenics, HIIT, boot camps, flexibility, and stability. You can do them individually or combined.\n\nHow to get started\nIt’s essential to consider a few things before starting a new workout routine.\n\n1. Check your health\nIt’s important to consult your healthcare provider and get a physical medical examination before starting an exercise routine.\n\nThis is particularly important for those new to strenuous and vigorous physical activities.\n\nAn early checkup can detect any health problems or conditions that could put you at risk for an injury during exercise.\n\nIt can also help you optimize your workout, making it easier for you and your personal trainer, if you choose to work with one, to understand your limitations and create an exercise plan tailored to your particular needs.\n\n2. Make a plan and set realistic goals\nOnce you decide to start exercising regularly, try to create a plan that includes attainable steps and goals.\n\nOne way to do this is to start with a plan of easy steps to follow. Then you can continue building on it as your fitness level improves.\n\nFor example, if your goal is to finish a 5-kilometer run, you can start by building a plan that includes shorter runs.\n\nOnce you can finish those short runs, increase the distance until you can run the whole 5 kilometers in one session.\n\nStarting with small achievable goals will increase your chances of success and keep you motivated every step of the way.\n\nSUMMARY\nBefore you start working out, get a health check-up and make a plan with realistic goals. Then, make exercise a habit by incorporating it into your daily routine.\n\n3. Make it a habit\nAnother key component of exercise success is to stick to your routine.\n\nIt seems to be easier for people to maintain an exercise routine in the long term if they make it a habit and do it regularly (9Trusted Source).\n\nA review of studies concluded that replacing an unhealthy behavior with a new healthier habit is an excellent approach to maintaining it in the long term (9Trusted Source).\n\nFurthermore, making a schedule or exercising at the same time every day are good ways to sustain your routine and make it last.\n\nFor example, you can make exercise a habit by planning to work out right after work every day or first thing in the morning. It’s important to choose a time that works best for you.\n\nSUMMARY\nThe minimum recommendation for exercise is at least 150 minutes per week. However, it is important to start slowly and let your body rest from time to time.\n\n\n1-week sample exercise program\nBelow is an easy-to-follow, 1-week exercise program that doesn’t require equipment and will only take you 30–45 minutes a day to complete.\n\nThis program can be adjusted to your fitness level and made as challenging as you want.\n\nMonday: 40-minute moderate-pace jog or brisk walk.\nTuesday: Rest day.\nWednesday: Walk briskly for 10 minutes. Then, complete the following circuits, resting 1 minute after each set but not between exercises. Stretch afterward.\nCircuit #1: 3 sets alternating 10 lunges for each leg, 10 pushups, 10 situps\nCircuit #2: 3 sets alternating 10 chair-dips, 10 jumping jacks, 10 air squats\nThursday: Rest day.\nFriday: 30-minute bike ride or moderate-pace jog.\nSaturday: Rest day.\nSunday: Run, jog, or take a long walk for 40 minutes.\nThe 1-week program above is just a simple sample to get you started. For more workout ideas and plans, check out the following links:\n\n20-minute workout for beginners\n30 moves to make the most of your at-home workout for various skill levels\n6 low impact cardio exercises in 20 minutes or less\nSUMMARY\nThere are various exercises you can do. The plan above is just one example to help get you started working out.\n\nA few tips for beginners\n1. Stay hydrated\nDrinking fluids throughout the day is essential for maintaining healthy hydration levels.\n\nReplenishing fluids during exercise is essential for maintaining optimal performance, especially when exercising in hot temperatures (10, 11Trusted Source).\n\nMoreover, hydrating after your workout can help you recover and get you ready for your next training session (12Trusted Source, 13Trusted Source).\n\n2. Optimize your nutrition\nBe sure to consume a balanced diet to support your fitness program.\n\nAll food groups are necessary to sustain healthy energy levels and get the most out of your workout. Carbs are vital, as they can fuel your muscles before exercise (14Trusted Source).\n\nCarbs are also important after exercise to replenish glycogen stores and assist with the absorption of amino acids into your muscles during recovery (15Trusted Source).\n\nAdditionally, protein helps improve muscle recovery after exercise, repairs tissue damage, and builds muscle mass (16Trusted Source).\n\nLastly, regularly consuming healthy fats has been shown to help burn body fat and preserve muscle fuel during workouts, making your energy last longer (14Trusted Source).\n\nClick these links for more info about pre-workout and post-workout nutrition.\n\n3. Warm up\nIt’s important to warm up before your workout. Doing so can help prevent injuries and improve your athletic performance (17Trusted Source, 18Trusted Source).\n\nIt can also help improve your flexibility and reduce soreness after your workout (18Trusted Source).\n\nSimply start your workout with some aerobic exercises like arm swings, leg kicks, and walking lunges.\n\nAlternatively, you can warm up by doing easy movements of the exercise you’re planning to do. For example, walk before you run.\n\n4. Cool down\nCooling down is also important because it helps your body return to its normal state.\n\nTaking a couple of minutes to cool down can help restore normal breathing patterns and even reduce the chance of muscle soreness (18Trusted Source, 19Trusted Source).\n\nSome cool-down ideas include light walking after aerobic exercise or stretching after resistance training.\n\n5. Listen to your body\nIf you’re not used to working out every day, be mindful of your limits.\n\nIf you feel pain or discomfort while exercising, stop and rest before continuing. Pushing through the pain is not a good idea, as it can cause injuries.\n\nAlso, remember that working out harder and faster is not necessarily better.\n\nTaking your time to progress through your fitness program can help you maintain your routine in the long term and make the most of it.\n\nSUMMARY\nBe sure to stay hydrated, eat a balanced diet, warm up before exercising, cool down afterward, and listen to your body.\n\nHow to stay motivated\nThe key to staying motivated and making exercise a habit is to have fun while doing it. This helps you to not dread exercising.\n\nLike the sample exercise program shown above, you can mix up activities while keeping it fun for you.\n\nIf you’re able to and want to, joining a gym or taking a virtual fitness class like yoga or Pilates, hiring a personal trainer, or doing team sports are good ideas to help increase motivation and enjoyment (19Trusted Source).\n\nWorking out as a group or with a friend can also help maintain accountability and motivate you to keep up your exercise routine.\n\nFurthermore, tracking your progress, such as logging your weightlifting levels or noting your running times, can help keep you motivated to improve your personal records.\n\nSUMMARY\nTo maintain your motivation, try mixing up your workouts, joining a gym, or participating in a team sport. And be sure to track your progress.\n\nThe bottom line\nStarting a new exercise routine can be challenging. However, having real objectives can help you maintain a fitness program in the long term.\n\nThere are many different types of physical activity to choose from. Find a few that work for you and be sure to vary them occasionally.\n\nThe goal is to start slowly, build up your fitness level, and let your body rest from time to time to help prevent injuries.\n\nKeeping track of your progress or taking a virtual group class are examples of actionable steps that can help you stay motivated and achieve your goals.\n\nIt’s also important to eat a healthy diet and hydrate regularly as well as check in with your healthcare provider to monitor your health.\n\nSo what are you waiting for?\n\nStart exercising today!', NULL, 3, '2022-06-21 20:51:21', 'Exercise tips for begginers');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (18, 'Who hasn’t left work late with a growling stomach but little energy to shop and cook? A busy schedule is one of the top reasons why people choose quick takeout meals, which are often calorie-laden and a contributor to expanding waistlines. [1-3]\n\nNow, imagine a different scenario where within a few minutes of walking through the door you have a delicious home-cooked dinner, and perhaps even lunch packed-up for the next day. Amidst hectic weekday schedules, meal prep or meal planning is a great tool to help keep us on a healthy eating track. Although any type of meal prep requires planning, there is no one correct method, as it can differ based on food preferences, cooking ability, schedules, and personal goals. Here are some examples:\n\nIf you now eat fast food or takeout several nights of the week, your goal may be to choose a specific day of the week to create a food shopping list and hit the grocery store.\nIf you already food shop once a week and have basic cooking skills, your goal may be to choose one day a week to do most of the cooking, or try a new recipe.\nIf you already cook some weekday meals for your family, you might decide to create a schedule so that you are not deciding last minute what to make and to ensure you have the needed ingredients on hand.\nSome benefits of meal prep:\n\nCan help save money\nCan ultimately save time\nCan help with weight control, as you decide the ingredients and portions served\nCan contribute to an overall more nutritionally balanced diet\nCan reduce stress as you avoid last minute decisions about what to eat, or rushed preparation\n\nTips for supermarket savings\nPlanning your meals ahead of the trip to the grocery store is a key strategy for eating well on a budget. From the supermarket to the kitchen, here are some other strategies to get the biggest nutrition bang for your buck.\n\nPrepping for Meal Prep\nDiscuss with your family what types of foods and favorite meals they like to eat.\nStart a monthly calendar or spreadsheet to record your meal ideas, favorite recipe sites, and food shopping lists.\nCollect healthy recipes. Clip recipes from print magazines and newspapers and save in a binder, or copy links of recipes onto an online spreadsheet.\nConsider specific meals or foods for different days of the week. Remember Wednesday as Prince Spaghetti Day? Some families enjoy the consistency of knowing what to expect, and it can help to ease your meal planning. Examples are Meatless Mondays, Whole Grain Wednesdays, Stir-Fry Fridays, etc.\nStart small: Aim to create enough dinners for 2-3 days of the week.\nGetting Started\nExample of a meal preparation calendarChoose a specific day of the week to: 1) plan the menu, whether week by week or for the whole month, and write out your grocery list 2) food shop, 3) do meal prep, or most of your cooking. Some of these days may overlap if you choose, but breaking up these tasks may help keep meal planning manageable.\nAs you find favorite ‘prep-able’ meals, or your menus become more familiar and consistent, watch for sales and coupons to stock up on frequently used shelf-stable ingredients like pasta, rice, and other whole grains, lentils, beans (canned or dried), jarred sauces, healthy oils, and spices.\nOn your meal prep day, focus first on foods that take the longest to cook: proteins like chicken and fish; whole grains like brown rice, quinoa, and farro; dried beans and legumes; and, roasted vegetables.\nAlso consider preparing staple foods that everyone in the family enjoys and which you can easily add to a weekday meal or grab for a snack: washed greens for a salad, hardboiled eggs, a bowl of chopped fruit, cooked beans.\nIf you prefer not to pre-cook proteins, consider marinating poultry, fish, or even tofu on your prep day so that you can quickly pop them into the oven or stir-fry later in the week.\nMulti-task! While foods are baking or bubbling on the stovetop, chop vegetables and fresh fruit, or wash and dry salad greens for later in the week.\nWhen you cook a recipe, make extra portions for another day or two of meals, or to freeze for a different week. Be sure to date and label what goes in the freezer so you know what you have on hand.\nFor lunches, get a head-start and use individual meal containers. Divide cooked food into the containers on prep day.\nStorage\nMeal prep can save time and money if you are preparing just enough for what is needed the following week. Refrigeration and freezing are an important step to successful meal planning. However, forgotten food such as produce hiding in a drawer or a stew stored on a back shelf in an opaque container for too long can spoil and lead to food waste. Label all prepped items with a date so that you can track when to use them by. Rotate stored items so that the oldest foods/meals are kept up front. Store highly perishable items like greens, herbs, and chopped fruits front-and-center at eye-level so you remember to use them.\n\nWhen it comes to freezing, some foods work better than others. Cooked meals tend to freeze well in airtight containers. Foods with high moisture content, such as salad greens, tomatoes, or watermelon, are not recommended as they tend to become mushy when frozen and thawed. Blanching vegetables for a few minutes before freezing can help. However, if the texture of a frozen food becomes undesirable after thawing, they might still be used in cooked recipes such as soups and stews.\n\nThe following are recommended times for various cooked foods that offer the best flavors, maximum nutrients, and food safety.\n\nRefrigeration at 40°F or lower\n1-2 days: Cooked ground poultry or ground beef\n3-4 days: Cooked whole meats, fish and poultry; soups and stews\n5 days: Cooked beans; hummus\n1 week: Hard boiled eggs; chopped vegetables if stored in air-tight container\n2 weeks: Soft cheese, opened\n5-6 weeks: Hard cheese, opened\n\nFreezing at 0°F or lower\n2-3 months: Soups and stews; cooked beans\n3-6 months: Cooked or ground meat and poultry\n6-8 months: Berries and chopped fruit (banana, apples, pears, plums, mango) stored in a freezer bag\n8-12 months: Vegetables, if blanched first for about 3-5 minutes (depending on the vegetable)\n\n', NULL, 2, '2022-06-21 20:51:21', 'A Guide to meal prepping');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (19, 'Meal prep doesn’t always involve cooking entire meals to store for later. Sometimes it’s simply about preparing key ingredients you can use to toss together a work lunch or weeknight meal in no time. Nail down the best ingredients for meal prep with a recipe planner, and you’ll be able to make your favorite dishes in a snap, any night of the week.\n\nCut down on stress by batch preparing the following ingredients to use throughout the week. Your future self—and your wallet!—will thank you.\n\n1. Chop Your Vegetables\nWhile it’s convenient to buy pre-chopped vegetables at the grocery store for use in stir fry, soups, or side dishes, you’ll save a ton of money when you chop them yourself. Chop and freeze some of your favorite veggies—like broccoli, cauliflower, and carrots—so you have them on hand. Be aware that veggies with high water content don’t freeze as well—they’ll be mushy when thawed—so keep prepped items like chopped cucumber, lettuce, and celery in the fridge.\n\nchopped-vegetables-best-ingredients-meal-prep\n\n2. Shred Your Chicken\nThere are endless uses for precooked, shredded chicken. Salads, quesadillas, sandwiches, casseroles, wraps, enchiladas .... the list goes on. This makes it a great item to prepare ahead of time, and one of the best ingredients for meal prep. To roast a whole chicken, rub with butter, season with salt and pepper, and stuff with lemon quarters. Then cook at 350 degrees in a roasting pan for 20 minutes per pound plus 15 minutes.\n\n3. Brown Your Beef\nSame goes for ground meat—you can buy it on sale, cook it the same day, and freeze it for use in chili, skillets, casseroles, and more.\n\n4. Boil Your Beans\nCanned beans, lentils, and chickpeas are an inexpensive protein with a long shelf life that can be useful for preparing quick meals. However, if you cook your own, you can save even more money in the long run. Make a batch on Sunday for the week and store in the fridge for convenient use in soups, salads, rice dishes, burritos, and more.\n\n5. Hard Boil Your Eggs\nHard-boiled eggs are a great grab-and-go protein that can be eaten for breakfast, or added to a salad or bento box for a lunchtime meal. Cook them in a batch but wait to peel them until you’re ready to eat, so they stay fresh for longer.\n\nhard-boiled-egg-best-meal-prep-ingredient\n\n6. Toss Your Greens\nChop and toss together your favorite combination of lettuce, kale, spinach, or other greens for a salad. Then store in separate containers for up to three days so you have grab-and-go greens to add to your lunch. Keep them from wilting by waiting to add the dressing until it’s time to eat, though. Step up your salad game when you emulsify your own vinaigrettes, too.\n\n7. Make Your Own Pasta Sauce\nHomemade pasta sauce is both healthier and cheaper than the jarred alternative. Make a large batch using canned tomatoes, onions, and garlic in less than 20 minutes with this recipe from Wellness Mama. Whatever you don’t plan to use within the week, you can freeze in ice cube trays for easier portioning and faster reheating on your next pasta night.\n\n8. Cook Your Grains\nIt’s easy to talk yourself out of a healthy meal on a weeknight when you know you have to wait 40 minutes for the brown rice to cook. Whether your grain of choice is rice, quinoa, or farro, prepare a large pot with a plan to use it throughout the week. Cooked grains keep well in the fridge and are a great staple to have on-hand for lunches, too.\n\nMeal planning mason jars\n\n9. Grate Your Cauliflower Rice\nIf you’re cutting out grains to go low-carb, cauliflower rice is an easy substitute. Once it’s prepped, it cooks in minutes, but that preparation takes time. Grate a large portion of cauliflower all in one go, then freeze for up to a month for convenient use later.\n\n', NULL, 1, '2022-06-21 20:51:21', 'Best Ingredients for Meal Prep');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (20, 'As we discover how bad a sedentary lifestyle can be for your health, experts now shout that sitting is the new smoking! It sounds extreme, but it really is a warning we should listen to. And change how we work.\n\nYou may think that doing sweaty workouts a few times a week is enough to balance out the amount of time you spend sitting sedentary at your desk, but new studies have found that you need to also stay active at your desk job in order to sustain your health.\n\nYou need to stay active at your desk and throughout your day in order to counteract the damage sitting can do to your body.\n\nGet more activity in your working day and you\'ll reap mass amounts of benefits! You may stop feeling sluggish at work and avoid feeling pain and discomfort from being at your desk all day. Bad posture can have knock-on effects for years to come so make proactive changes now before it\'s too late.\n\nRead on to find out why we’ve all got to incorporate movement throughout our days, how it can benefit our health, and of course, 10 ways to stay active at your desk job!\n\nWe’ve got some cool technology and some simple tips to help you get active whilst tied to your desk job. And don\'t worry. Our tips and tricks won’t involve you running a lap around the office every 30 minutes high-fiving bewildered co-workers.\n\nWhy your health needs you to take up office fitness\nDon’t be a desk potato!\nWe’re a country that’s in danger of being known as the \"nation of couch potatoes\" and this needs to change. The World Health Organisation has identified physical inactivity to be the fourth biggest killer of the modern world, and it has even overtaken obesity. And the scary thing? It’s so easy to see how it can happen without us even realising.\n\nMany of us spend 8 - 10 hours a day sitting at our desks, while some of us will spend up to 19 hours at the computer! We then all go home via cars or public transport to sit at the dining table for dinner before slumping on the sofa to unwind. Minimal activity, so much sitting... it\'s easy to see how it can happen.\n\nAre you “Actively Sedentary”?\nAt Move, we champion ALL movement and that we must all move whenever we can! And this is also true for everyday living. You may think you’ve done your moving for the day because of that morning HIIT class but think again.  \n\nWhile high-intensity exercise is brilliant for your health and can easily be fitted around your schedule, you must still remember to be active at your desk. Scientist Kathy Bowman has found that in today’s world, there’s now a new category of people who are ‘actively sedentary’.  These people sit for the whole day but blast out an hour of exercise expecting it to balance out their desk potato days.\n\nBut you can’t offset 10 hours of stillness with one hour of exercise a week.\n\n Pixabay how to stay active at your desk.jpg\n\nThe negative effects of sitting at your desk all day\nSedentary lifestyles are extremely common, but it takes a toll on health and productivity. Our bodies are built to move and be in regular action, and when it doesn\'t you risk the following health ailments:\n\nAs your blood flows slower and your muscles are burning less fat, there’s a higher risk of fatty acids clogging your heart.\nThe pancreas produces more insulin when sedentary, which could lead to diabetes. The efficiency of your body when dealing with sugar is affected by how physically active you are.\nIt’s believed that those who are sedentary are more at risk of various cancers, as the antioxidants in your body aren’t getting a boost from movement. These antioxidants are known to target potentially cancer-causing free radicals.\nDigestion problems\nBack and hip problems\nPoor posture.\nLeg issues, such as weak bones and varicose veins.\nA rise in stress levels.\nDecrease in productivity and energy.\nThe mental benefits of filling your days with movement\nSo what happens when you start to get more active and get away from the desk at regular intervals? Not only will your body feel benefits, but your mindset and energy will be affected too. Productivity is known to rise dramatically when employees are able to get physical activity into their working day.\n\nThe saying, \"there is no emotion without motion\", has so much meaning. Have you ever forced a smile until it became genuine? Philanthropist, Tony Robbins, has found that if you want to change your mental state in an instant, change your physiology (such as facial expression, breathing, posture) and it will result in a shift in your brain.\n\nThis can be applied to our day jobs: Move and change your mental state.\n\nIf you hit a slump, give yourself a good stretch at your desk and correct your posture. Or even take yourself away from the desk, get moving and return feeling refreshed and ready to tackle the task. It also helps alleviate stress levels so you don’t take your work frustrations home with you.\n\nPixabay_walking meetings - how to stay active at your desk.jpg\n\n10 ways to stay active at your desk job\n1. Use a stand-up desk\nStand-up desk, standing desk, adjustable desk - they come with many names but they all do the same thing. They allow you to work at your desk while standing. But why would you want to work on your feet?\n\nYou’ll find an improvement in your posture and circulation that will overall alleviate the effects of sitting. It may take a while to build up to a full day of standing, but even a few hours a day will do you good. Just make sure it is adjustable so it can be altered to fit your height.\n\nstand up desk.gif\n\n2. Sit on an exercise ball\nWelcome to ‘active sitting’! It might attract some attention from your co-workers but if you work whilst sitting on an exercise ball, you\'ll be working on your body without even realising it. Using an exercise ball as your chair will engage your core (your abs and back muscles), which will assist in maintaining good posture. \n\n3. Set a timer\nGet hold of a subtle app or Google Chrome plugin, such as Break Timer, to ensure that you are nudged to get active throughout your day. When the timer goes off, head out for a walk around the office or have a quick stretch to unkink those back muscles.\n\n4. Try out a treadmill desk\nIf you can persuade your boss to get this, then they sure know how to keep their employees fit and healthy! If you think standing while working would be a great way to be active, try walking throughout your day as you type on your laptop. We’re definitely keen to give this a go, although this multi-tasking might result in a few workplace accidents... \n\nstand up treadmill desk.gif\n\n5. Leg lifts under the desk with ankle weights\nWe’re all about subtle and easy ways to get moving in the office. This sneaky move will keep your legs toned without even leaving your desk, which is helpful if your boss has their beady eye on you.\n\nStrap on leg weights and every hour, do a few reps of leg raises under your desk. And if you want to level it up, wear them for a strut around the office to show ‘em off.\n\n6. Mini exercise bike\nA mini exercise bike that can fit under your desk is a fantastic way to get exercise whilst at your desk. Keep pedalling and work those legs - your circulation and calves will thank you later!\n\n7. Surfboard desks\nOK, this is only for the really cool workers… who have freakishly good balance. Fluidstance has brought out small platforms that require you to mimic the balance of a surfer at your stand up desk. It engages your core and increases your heart rate by 15%. Surf’s up!\n\nfluidstance surf board standing desk.gif\n\n \n\n8. \nWalking meetings\nTry doing workplace tasks that allow you to be active. Forget about meetings in stuffy boardrooms - take it outside!\n\nWhether it’s taking a call whilst walking around the block or having a gym session while talking shop, it can help keep your body moving. Not to mention you’ll be clocking up those important daily steps!\n\n9. Subtle stretches at your desk\nNo one will blink an eye at you doing some casual stretches a few times a day at your desk. Staying active whilst at work can come in the form of simple exercises, like shoulder raises, neck stretches, leg raises… or go full aerobics and get into these top deskercise moves!  \n\nsource.gif\n\n10. Lunchtime workouts at your nearest fitness venue \nIf you want even more out of your lunch break, then hit up your nearest fitness venue and squeeze in a class or a quick gym session. Even if you can only fit in 30 - 40 mins, you will feel the difference in your productivity and happiness levels. A lunchtime workout will re-energise you for the afternoon and get that blood pumping. See some of our top tips on how to work out at lunch!\n\nA study presented to the American College of Sports Medicine has found that those who workout for 30-60 minutes at lunch had an average performance boost of 15%.\n\nAnd 60% of employees claimed that time management, mental performance and ability to meet deadlines improved on the days they exercised. It also helped them avoid post-lunch energy slumps! Even if you don\'t want to get too sweaty (especially if there\'s no time for a shower), a low-impact stretching class - like yoga - gives your body time to move and realign.', NULL, 3, '2022-06-21 20:51:21', 'How to Stay Fit When You Have a Desk Job');
INSERT INTO `blog` (`id`, `content`, `image_link`, `user_id`, `created_at`, `title`) VALUES (21, 'It isn\'t all that difficult to eat a healthy diet on a budget, but the biggest question here is not so much about the budget as what constitutes optimum nutrition. What\'s considered healthy changes all the time. First eggs were evil, now they aren\'t; same with fat (as long as it\'s unsaturated); and it is a fairly sure bet that carbs, once sainted, now tainted, will go the same way. Author Michael Pollan breaks it down into three simple phrases: Eat food. Not too much. Mostly plants. By food, he means real food that your great-grandmother would recognize as food. In other words, food that is a plant or comes from plants, rather than food that is manufactured — which is, unfortunately, usually cheap and easy.\n\n\n\nEating nutritious foods can take a bit more time and effort than stuff that comes in a box, but it\'s better for you and can also budget-friendly. We show you how with these 26 healthy foods and meals that cost about $1 per serving or less.\n\n\nRelated: 12 Healthy Meal Hacks for Hectic Households\n\nHerbed Frittata2 / 27\nTatiana Volgutova/shutterstock\nDon\'t Be Afraid of Eggs\nEggs are one of the cheapest sources of protein: A dozen, which will feed six people, cost about $4 (a little more if they\'re organic, free-range, antibiotic- and hormone-free). And there is no need to fear them. They used to be considered a risky choice because they are high in cholesterol. But researchers have found that eating high-cholesterol foods is not necessarily bad as long as the foods are low in saturated fat. Eggs are low in fat, and contain many nutrients, so they make a good meal — and not just breakfast — when combined with other nutritious foods. There are many ways to make eggs into a meal, with frittatas, soufflés, and stratas that add vegetables to the mix for not a lot of extra money.\n\n\n\nRelated: 13 Simple Ways to Cook Eggs\n\nCuban Beans and Rice3 / 27\nFanfo/shutterstock\nLook to Beans as a Great Protein Source\nBlack beans are extremely protein-dense, high in fiber, and extremely cheap, at about $1.50 a pound (dry). They also have no cholesterol and are virtually free of saturated fat. Other varieties, such as pinto, cannellini, garbanzo, and kidney beans are equally inexpensive and healthy. All dried beans need to be soaked overnight before cooking, so many people opt for canned beans, which are equally nutritious and run about 30 cents per serving. Beans can easily be used to create hearty soups, salads, chili, and many other recipes. \n\n\nRelated: 30 Creative Rice and Bean Dishes From Around the World\n\nHummus4 / 27\nBrent Hofacker/shutterstock\nHummus Can Be More Than a Dip\nBuying hummus in a container is not so cheap, but making your own out of canned chickpeas is. (Canned chickpeas are better to use than dried because dried ones need to be skinned after cooking — every single one.) Hummus is not just a dip, either. It can be used instead of mayonnaise on sandwiches, as a spread for flatbread pizza, or as the basis for a homemade version of that Chinese classic: cold noodles with sesame sauce.\n\nLentils5 / 27\nOksanaKiian/istockphoto\nLentils Are Easy to Fix and High in Protein\nThere are many kinds of lentils from the super-cheap brown lentils to red lentils to the arguably superior French green lentils, which are pricier but still cost less than 50 cents per serving. The advantage of lentils over beans is that in dried form, they do not need to be soaked overnight and don\'t take as long to cook. In fact, red lentils cook very quickly. Like beans, they are also an excellent source of protein and fiber, and do not contain saturated fats. Lentils can be cooked into soup, as a curry over rice, or even as a sauce over pasta.\n\nPeanuts6 / 27\nMaKo-studio/shutterstock\nPeanuts Are an Inexpensive Protein and Easy Snack\nIn their shells, peanuts cost about $3 a pound, and though they are not actually nuts, they have similar health benefits as nuts that come from a tree. High in monounsaturated fats, they are heart-healthy, as well as a good source of protein. But they are also high in calories, so an ounce is a good-sized portion. Most people get their peanuts in peanut butter form, so they may be getting a major dose of white sugar along with the peanuts\' nutrients. Some supermarkets have peanut butter machines that will grind the nuts, so you can avoid additives. Peanuts can also be eaten boiled and salted out of hand, as a topping for cereal or salad, as an ingredient in Thai and Chinese recipes, and many other dishes, too.\n\nNot All Carbs are Bad7 / 27\nfcafotodigital/istockphoto\nNot All Carbs Are Evil\nCarbs have gotten a bad rap lately, with paleo, low-glycemic, and gluten-free diets taking pride of place in the diet world. However, not only are carbs not bad for us, they are essential. There is no such thing as a vegetable that is carb-free, for instance. There are, however, \"good carbs\" and \"bad carbs.\" Nutrition experts agree that the complex carbohydrates found in whole grains, brown rice, potatoes, and legumes are good carbs, while anything containing refined sugar, high-fructose corn syrup, or processed grains should be eaten sparingly. This includes virtually all processed foods such as cookies, convenience foods, most crackers, chips, and all those foods that your great-grandmother wouldn\'t recognize. \n\n\nRelated: 13 Restrictive Diets You Should Think Twice About Trying\n\nDiscover Variety in Brown Rice8 / 27\nvm2002/istockphoto\nDiscover the Versatility of Brown Rice\nBrown rice is high in nutritional value and has loads of fiber. Anyone who was alive during the \'70s got their fill of it at that time: sticky, gluey, bland, and cooked into everything. Since then, cooks have learned to dress it up a bit, and at about 20 cents per serving, it\'s a good source of healthy carbs. Brown rice can be used on its own as a side dish, such as this one from Food & Wine, which has plenty of garlic, herbs, and lemon to give it additional flavor. Or it can be used as the basis for a chicken and broccoli casserole that uses yogurt instead of canned soup as a base. \n\n\nRelated: 20 Cheap and Easy Ways to Use Rice\n\nPasta Can Be a Healthy Foundation9 / 27\nfcafotodigital/istockphoto\nPasta Can Be a Foundation for Healthy Meals\nPasta is the star in so many cheap meals. Since it costs about 25 cents per serving, we forgive the fact that it contains white flour. There is also whole-grain pasta that costs slightly more, but is still well within our $1 per serving price limit. Any pasta can be the basis for healthy meals, since it can be mixed with nutritious ingredients. Pasta e fagioli is a classic Italian soup; this recipe uses canned white beans and escarole, which might be pricey or hard to find — spinach is a good substitute. Pasta with broccoli walnut pesto uses the nuts as a source of protein to make this a complete meal; and penne with vegetables is good as a side dish, or it can be a full dinner with some leftover chicken or pork added into it.\n\nExperiment With Your Grains10 / 27\nDiane Labombarbe/istockphoto\nDiversify the Grains in Your Recipes\nWhole grains, such as oats, barley, and wheat are beneficial because they have a lot of fiber and help lower cholesterol. Some grains, such as quinoa, farro, and buckwheat, also contain protein and small amounts of omega-3 fatty acids. So whole grains are basically healthy, but not if they are also mixed with high-fructose corn syrup, as some whole-grain packaged breads and cookies are. The less adulterated, the better. So oatmeal can be great, but not as great if it is heaped with butter and sugar. Generally speaking, grains are quite inexpensive. Most of them cost between 10 cents and 25 cents per serving.\n\nTry Healthier Popcorn11 / 27\nbhofack2/istockphoto\nTry a Healthier and Cheaper Approach to Popcorn\nThat bag of microwave popcorn may cost a lot, but grab a bag of plain kernels for about a buck. You can still nuke them. Put them in a large bowl, cover them with a plate and heat on high until the popping stops, or they can be made in a paper bag. Add a bit of salt and skip the butter for a healthy treat. Eaten this way, popcorn is a good source of fiber, low in fat, and has other benefits of any whole grain. \n\n\nRelated: 50 Ways to Get Creative With Your Popcorn\n\nOlive Oil (Extra Virgin, Store Brand)12 / 27\nDUSAN ZIDAR/shutterstock\nOlive Oil Offers Versatility, Flavor and Health Benefits\nSome fat is necessary for a healthy diet, as long as it is not saturated fat or trans fat, the kind that is often used in processed food. It may not seem as though olive oil is cheap, since it can cost as much as $20 for a bottle of extra virgin, first cold-pressed stuff; but it can cost much less. Olive oil is low in saturated fats and high in monounsaturated fatty acids, which can help lower cholesterol and are beneficial for blood-sugar control. Plus, it tastes really good. In addition to using olive oil as a base for stir-fry and salad dressing, it can be used as an ingredient for things such as chocolate olive oil cake, which uses almond meal instead of white flour for those who have issues with gluten.\n\nGreek Yogurt13 / 27\nDani Vincek/shutterstock\nYogurt Offers Digestive Benefits\nLike most dairy products, yogurt has several things going for it nutritionally — protein, calcium that helps maintain strong bones, and low sugar, provided that it\'s plain and not mixed with fruit. But yogurt has something that milk, for instance, does not: It is fermented with live bacteria cultures that are considered probiotic, and can therefore promote intestinal health. At about $4 for a 32-ounce container, each half-cup serving costs about 50 cents. Greek yogurt is somewhat more expensive, but it can be made easily by straining regular yogurt through a coffee filter for several hours, or until it is thick. Add berries or other fruit, sunflower seeds or other flavorings to yogurt rather than buying it flavored. It will be lower in sugar than pre-flavored yogurts. \n\n\nRelated: 40 Breakfast Foods Ranked by Their Calorie Count\n\nSpinach14 / 27\nNataliya Arzamasova/shutterstock\nEat More Vegetables Daily\nHow are vegetables good for us? Let us count the ways. They reduce our risk of many chronic diseases such as heart disease, some forms of cancer, and diabetes. They\'re the best sources of most of the nutrition that we need daily. They\'re low in fat and calories, and high in fiber. And they are not too expensive, either. A bunch of spinach, for instance, costs a little over a dollar, so does a bag of carrots. In winter, some vegetables can get a bit pricey. But they are cheaper frozen, while still being just as nutritious as fresh.\n\n\nThe biggest issue with vegetables is access for people who live in inner cities or other areas known as \"food deserts,\" where there are few supermarkets or farmers markets nearby. But community gardens and other urban farming facilities are springing up all the time, and increasingly more people grow their own vegetables — by far the cheapest way to get them.\n\n\nRelated: 30 Vegetable Recipes for People Who Hate Vegetables\n\nBroccoli salad slaw15 / 27\nfusaromike/istockphoto\nDiscover the Flexibility of Broccoli\nBroccoli can be eaten on its own as a side dish, and a head can feed four people at about $1.75. Consider adding this antioxidant- and nutrient-rich vegetable to all sorts of meals, from egg dishes to salad to casseroles. And when it\'s hard to find, a box of frozen chopped broccoli can be found for $1 or less.\n\nBaked Sweet Potato Fries16 / 27\nBrent Hofacker/shutterstock\nTrade Up to Sweet Potatoes\nThe health benefits of sweet potatoes, which cost about $1 per pound, are many. They are high in antioxidants and anti-inflammatory properties, and they help regulate insulin. Regular potatoes, while they are low in fat and not high in calories, do not offer the same advantages. Of course, sweet potatoes can be made into pie or with marshmallows, sugar, and butter, but they can be used in healthier ways as well. They add heartiness to soups and stews. They can be combined with beans and spinach to make nutritious burritos, mixed with a variety of exotic herbs and spices, with protein filled chickpeas and yogurt to create an Indian chana masala, or simply roasted with olive oil, salt and pepper for a healthy version of fries.\n\nCauliflower Crust Pizza17 / 27\nFascinadora/istockphoto\nFind Out Why Cauliflower Is Suddenly Trendy\nCauliflower may overtake kale as the vegetable of the hour. This humble plant in the mustard family has become the darling of the paleo set, acting as a substitute for rice or couscous. It has even been touted as a good basis for pizza crust. While a whole cauliflower can cost up to $3 a head out of season, that head can easily feed four people when mixed with other vegetables in a stir-fry, or roasted as a side dish. An interesting cauliflower cake is a different take on a frittata.\n\nStart Snacking on Edamame18 / 27\ntaka4332/istockphoto\nStart Snacking on Edamame\nEdamame — basically young soybeans still in the pod — are filled with fiber and protein and make a great afternoon snack. A half-cup serving costs about 50 cents, and when they\'re steamed and sprinkled with salt, they fill the same satisfaction niche as chips.\n\nEat Your Fruits Whole19 / 27\nRichLegg/istockphoto\nEat Your Fruits Whole\nWhen eaten in their pure form and not squeezed into juice, fruits are one of the big building blocks of a healthy diet. Although fruit contains sugar, it acts differently on the body than, say, high-fructose corn syrup does. Fruit contains several beneficial nutrients such as fiber and antioxidants that promote health. It\'s hard to find a snack that\'s healthier than an apple, clementine, or pear, each of which will cost under $1 in season. Berries, also budget-friendly in season but less so when they\'re frozen or transported from South America, are a tasty addition to whole grain cereals as well as being delicious eaten by themselves. Bananas, which run about 70 cents a pound, should be eaten when their skins are turning brown.\n\nAvocado Toast20 / 27\nNatashaPhoto/shutterstock\nAvocados Are a Worthy Purchase\nAvocados are a fruit that holds a special place in the food universe. While a whole avocado costs more than $1, it can easily spread over two or more servings. Avocados, unlike other fruits, contain large quantities of monounsaturated fatty acids, in other words, good fat, like olive oil. Avocados have several nutrients that support not only heart health but also cancer prevention. Avocado toast is a popular lunch, but for a real nutritional power meal, spread it on a baked slice of sweet potato. Avocado, because of its mild flavor and soft texture, is a good food for babies, too.\n\nGive the Gift of Snack Delivery21 / 27\nPremyuda Yospim/istockphoto\nEnjoy Nutrient-Dense Nuts in Moderation\nNuts and seeds pack a lot of nutrition in a small handful. In fact, a serving size of nuts or seeds is only about 1 ounce. While they are very nutrient-dense, they are also rather high in calories. They are proven to support cardiovascular health and are great sources of protein, monounsaturated fats, fiber, and vitamins and minerals. Some nuts can be very expensive (pine nuts, for instance cost about $35 a pound), but almonds and walnuts run about $5 a pound if they\'re bought from the bulk bin. Sunflower seeds and pumpkin seeds are about the same. Nuts can be toasted, chopped and used in salads, stir-fries, and whole grain cereals to add crunch. Helpful tips: Keep them in the freezer because the oils in them can go rancid after a while; and if you prefer them toasted and salted, do this yourself to save some bucks. They\'re also good mixed with other spices, such as chili, garlic powder, or rosemary.\n\nEat Meat Sparingly22 / 27\nMagone/istockphoto\nFind a Healthy Balance With Meat\nFamously, Thomas Jefferson said that he ate meat only in small quantities, using it as a \"condiment for the vegetables, which constitute my principal diet.\" This approach by the Sage of Monticello fits neatly with Michael Pollan\'s advice to eat food, not too much, and mostly plants. For those of us who aren\'t vegetarians, though, meat adds a level of satisfaction few other foods can. Meat from cattle is very high in saturated fat, so its intake should be limited. Protein, the principal nutrient in fish and animal foods, should make up about 20% of daily calories from all sources. A serving size of meat is about 3 ounces, which is less than a quarter-pound burger. Eating this way makes a little meat go further.\n\nStretch Out the Beef23 / 27\nLauriPatterson/istockphoto\nStretch Out the Beef\nGround beef can be found for as low as $3 a pound when bought in quantity on sale. This will not be particularly lean, though. Usually it is about 85% lean (which means it\'s 15% fat). Stretching it to feed at least four people is an easy task when it\'s mixed with many other foods and not eaten as a hunk. Mix it with vegetables in a Korean rice bowl, in a stir-fry, or combine it with ground pork to make meatballs in an Italian Wedding soup.\n\nLook Beyond Bacon with Pork24 / 27\nNoirChocolate/istockphoto\nWith Pork, Look Beyond Bacon\nWhen considering foods that come from pigs, many people immediately think of bacon. It can be found for under $5 a pound these days, putting it within our price limits. One slice is often considered one serving, and that may be about all anybody should eat, once in a while, since it\'s loaded with fat, salt, and little else but crunch. Pork loin, on the other hand, is low in fat and high in protein and is also one of the cheapest forms of animal protein there is, at about $2.50 a pound. It\'s a very neutral flavor, so it takes well to being zipped up with peppers or chili paste and mixed with vegetables in a stir-fry.  \n\n\nRelated: How to Feed a Crowd 15 Ways With a Cheap Cut of Pork\n\nChicken Tacos25 / 27\nJoshua Resnick/shutterstock\nGet Creative With Poultry\nChicken breasts get all the glory, but it\'s chicken thighs that have actual flavor. Of course, it\'s cheaper (usually about $3 a pound) to buy a whole chicken rather than its parts, and cut them up yourself. Chicken breasts get the good rep because they are lower in fat than thighs, but in a 3-ounce serving, there\'s not that much difference. Either of them can be chopped up and mixed with vegetables in a stir-fry, simmered in sauce for a tikka masala, cut into strips and mixed with taco seasoning for burritos, or mixed into fried brown rice with any choice of veggies. Ground chicken or turkey, both about $4 a pound, can also be used in tomato sauces or green chili. Then of course, there\'s soup, a gallon of which can be made with one chicken or a turkey carcass. \n\n\nRelated: 50 Cheap and Easy Chicken Recipes\n\nConsider New Tuna Recipes26 / 27\nNelliSyr/istockphoto\nConsider New Recipes for Tuna\nCanned tuna is often on sale for about $1.25 for a large 5½-ounce can that will serve 2 people. It\'s a source of protein that is high in omega-3 fatty acids. It\'s also low in fat, as long as it\'s not mixed with mayonnaise. Fortunately, there\'s a world of things that can be made with tuna. Tuna and white bean salad is an Italian staple; a tuna and olive pasta feeds three people with one can; and tuna and corn salad is fresh tasting with summer vegetables straight from the garden or farmers market. \n\n\nRelated: 15 Simple, Tasty Sandwiches That Cost $1 or Less to Make\n\nExpand Your Seafood Horizons27 / 27\nmpessaris/istockphoto\nExpand Your Seafood Horizons\nOutside of tuna in a can, it can seem pretty hard to find any seafood that fits into the frugal lifestyle. Shrimp used to be on the no-eating list because it\'s high in cholesterol, but like eggs, it is now considered okay, because it is very low in fat. It is a bit of a splurge, even on sale costing about $6 a pound. This recipe for pasta primavera with shrimp only uses 8 ounces of the crustacean and is loaded with vegetables that are fresh and in season in spring. Other inexpensive seafood options that can be healthy and sustainably caught, include mackerel, porgy, sardines, and catfish.', NULL, 1, '2022-06-21 20:51:21', 'Healthy Eating On a Budget');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `comment` (`id`, `content`, `blog_id`, `user_id`, `created_at`) VALUES (1, 'These are some great tips! I never have time to follow them tho...  XD', 1, 2, '2022-06-21 08:20:20');
INSERT INTO `comment` (`id`, `content`, `blog_id`, `user_id`, `created_at`) VALUES (2, 'What if you don\'t have the money to buy pre-packaged, pre-cut ingredients... Seems expensive. ', 1, 3, '2022-06-21 08:20:20');

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
-- Data for table `nutrients`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (9, 3, 4, 0, 0, 80, 1, NULL);
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (2, 15, 2, 0, 0, 100, 2, NULL);
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (0, 0, 10, 0, 0, 30, 3, NULL);
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (0, 0, 0, 0, 0, 128, 4, '0');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (26, 35, 10, NULL, NULL, 331, 5, NULL);
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (4, 19, 2, NULL, 8, 88, 6, NULL);
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (36.63, 17.61, 45.26, 477, 19.61, 616, 7, '221');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (27, 34, 13, 686, 6, 363, 8, '54');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (14, 30, 12, 585, 3, 281, 9, '24');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (24, 35, 15, 607, 18, 357, 10, '57');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (24, 1, 5, 350, 1, 148, 11, '73');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (37, 17, 18, 574, 11, 377, 12, '106');
INSERT INTO `nutrients` (`protein`, `carbs`, `fats`, `sodium`, `sugar`, `calories`, `id`, `cholesterol`) VALUES (9, 26, 9, 459, 6, 218, 13, '8');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `nutrients_id`) VALUES (1, 1, 1, NULL);
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `nutrients_id`) VALUES (2, 1, 2, NULL);
INSERT INTO `meal` (`id`, `tracked_day_id`, `meal_type_id`, `nutrients_id`) VALUES (3, 1, 3, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (1, NULL, 10, '2 Eggs, 1 cup frozen hash brown mix, 1 tbsp vegetable oil: Add oil and hashbrowns to pan, set to medium heat. Beat eggs, add seasoning to taste. When hashbrowns begin to brown add in eggs. Stir and serve when at desired firmness.', 'Easy Morning Hash', 1, '2022-06-21 03:20:20', NULL, 'https://www.countrycleaver.com/wp-content/uploads/2017/07/Pesto-Chicken-Pasta-Skillet-with-Asparagus-and-Tomatoes-2-e1638331582218.jpg', NULL, NULL);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (2, 'https://www.jaroflemons.com/healthy-sriracha-shredded-chicken-tacos/', 30, 'Ingredients\n▢2 thinly sliced chicken breasts\n▢2 Tbsp Sriracha\n▢6 corn tortillas\n▢1 cup chopped red cabbage\n▢1/2 cup chopped peppers\n▢1/4 cup feta cheese\n▢1 lime Preheat oven to 375 degrees. Place the chicken breasts on a baking sheet and top with Sriracha. Bake for 30 minutes (or until they\'re fully cooked). While the chicken is baking, heat the tortillas up (optional). Top each tortilla with chopped red cabbage and chopped peppers. When the chicken has finished baking, shred it and place in the tortillas. Top each taco with feta cheese and a drizzle of lime. Enjoy!', 'Healthy Sriracha Shredded Chicken Tacos', 1, '2022-06-21 03:20:20', NULL, 'data:image/jpeg;base64,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', NULL, 4);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (3, 'https://www.jaroflemons.com/the-best-easy-healthy-lasagna-recipe/', 75, 'Ingredients\n▢1/2 lb ground beef\n▢1/4 onion (chopped)\n▢2 zucchini (medium)\n▢1 summer squash (medium)\n▢15 oz. whole tomatoes (canned)\n▢10 oz. tomato sauce\n▢1/2 tsp garlic powder\n▢1/2 tsp dried parsley\n▢1 tsp dried basil\n▢6 uncooked lasagna noodles\n▢10 oz. cottage cheese (small curd)\n▢1/2 cup parmesan (grated)\n▢1 cup mozzarella (shredded)\n▢salt/pepper\n\nAD\nInstructions\nPreheat oven to 375 degrees.\nCook the chopped onion and ground beef until the beef is fully cooked.\nWhile the beef is cooking, cut the zucchini and summer squash into small, 1/4\" - 1/2\" cubes.\nOnce the beef is done cooking, set aside and drain.\nCook the zucchini and summer squash for about 10 minutes.\nAdd in the tomatoes, tomato sauce, and spices.\nContinue cooking over medium heat for another 15 minutes, stirring often.\nAdd the cooked beef and onions back into the tomato sauce mixture and stir.\nPour about 1/2 of the tomato sauce mixture into a 8\" x 10\" casserole dish.\nPlace 3 of the lasagna noodles on top of the mixture (breaking each one in half if necessary), pressing each one down so that it\'s covered with about 1/4\" of the tomato mixture on top.\nAdd 1/2 of the cottage cheese to the casserole dish.\nTop with 1/2 of the parmesan and 1/2 of the mozzarella.\nRepeat steps 9-12 with the remaining ingredients.\nCover the casserole dish with foil and bake for 30 minutes.\nUncover and bake for another 15 minutes.\nServe warm and enjoy!\nNotes\nCarbs: 35  Fat: 10  Protein: 26', 'Easy Healthy Lasagna', 1, '2022-06-21 03:20:20', NULL, 'data:image/jpeg;base64,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', NULL, 5);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (4, 'https://www.jaroflemons.com/pumpkin-curry-soup/', 25, 'Ingredients\n▢2 15 oz . cans pumpkin puree\n▢4 cups vegetable stock\n▢2 tsp curry powder\n▢1/2 tsp ginger\n▢1/4 cup light coconut milk\n▢1 tsp crushed red pepper\n\nAD\nInstructions\nCook the pumpkin puree and vegetable stock over medium heat for 10-15 minutes (or until everything is hot throughout).\nAdd in the curry powder and ginger. Continue cooking for 5 minutes.\nMix in the coconut milk and crushed red pepper and cook until warm.\nServe warm and enjoy!', 'Pumpkin Curry Soup', 1, '2022-06-21 03:20:20', NULL, 'data:image/jpeg;base64,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', NULL, 6);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (5, 'https://www.eatwell101.com/lemon-garlic-butter-thighs-and-green-beans-skillet', 40, 'INGREDIENTS LIST FOR THE LEMON GARLIC BUTTER CHICKEN THIGHS AND GREEN BEANS SKILLET\n3 – 6 skinless, boneless chicken thighs\n1 pound (450g) green beans, trimmed\n3 tablespoons butter, divided or (ghee for paleo diet)\n4 garlic cloves, minced\n1 teaspoon paprika\n1 teaspoon onion powder\n1/4 teaspoon salt and fresh cracked black pepper\nJuice of 1/2 lemon + lemon slices, for garnish\n1/2 cup (125ml) chicken stock\n1 tablespoon hot sauce (we used Sriracha)\n1/4 teaspoon crushed red chili pepper flakes, optional\n1/2 cup fresh chopped parsley\n1. To make the lemon garlic butter chicken thighs recipe with green beans: In a small bowl, combine onion powder, paprika, salt, and pepper. Season chicken thighs generously with the spice mixture. Set aside while you prepare green beans.  2. Arrange green beans in a microwave-safe dish with 1/2 cup (125ml) water. Cook in the microwave for 8-10 minutes, until almost done but still crisp.  3. Melt 2 tablespoons butter in a large skillet over medium-low heat. Lay the seasoned chicken thighs in one layer in the skillet. Cook for 5-6 minutes then flip and cook another 5-6 minutes, until cooked through and a cooking thermometer displays 165°F (75°C). If chicken browns too quickly, lower the heat. Adjust timing depending on the thickness. Transfer chicken to a plate and set aside.  4. In the same skillet, lower the heat and melt the remaining tablespoon of butter. Add chopped parsley, garlic, hot sauce, red crushed chili pepper flakes, and pre-cooked green beans and cook for 4 to 5 minutes, stirring regularly, until cooked to your liking. Add lemon juice and chicken stock and reduce the sauce for a couple of minutes, until slightly thickened.  5. Push green beans to the side and add cooked chicken thighs back to the pan and reheat quickly. Adjust seasoning with pepper and serve the lemon garlic butter chicken thighs immediately, garnished with more crushed chili pepper, fresh parsley, and a slice of lemon if you like. Enjoy!', 'Lemon Garlic Butter Chicken & Green Bean Skillet', 1, '2022-06-21 03:20:20', NULL, 'https://www.eatwell101.com/wp-content/uploads/2019/03/chicken-and-green-beans-recipe4.jpg', NULL, 7);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (6, 'https://www.tasteofhome.com/recipes/simple-grilled-steak-fajitas/', 25, 'Ingredients\n1 beef top sirloin steak (3/4 inch thick and 1 pound)\n2 tablespoons fajita seasoning mix\n1 large sweet onion, cut crosswise into 1/2-inch slices\n1 medium sweet red pepper, halved\n1 medium green pepper, halved\n1 tablespoon olive oil\n4 whole wheat tortillas (8 inches), warmed\nOptional: Sliced avocado, minced fresh cilantro and lime wedges\nBuy Ingredients\nPowered by Chicory\ntap here\nDirections\nRub steak with seasoning mix. Brush onion and peppers with oil.\nGrill steak and vegetables, covered, on a greased rack over medium direct heat 4-6 minutes on each side or until meat reaches desired doneness (for medium-rare, a thermometer should read 135°; medium, 140°; and medium-well, 145°) and vegetables are tender. Remove from grill. Let steak stand, covered, 5 minutes before slicing.\nCut vegetables and steak into strips; serve in tortillas. If desired, top with avocado and cilantro, and serve with lime wedges.\n', 'Simple Grilled Steak Fajitas', 1, '2022-06-21 03:20:20', NULL, 'https://www.tasteofhome.com/wp-content/uploads/2018/01/exps158452_SD163615C04_07_5b-2.jpg?fit=700,1024', NULL, 8);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (7, 'https://www.tasteofhome.com/recipes/spinach-quesadillas/', 20, 'Ingredients\n3 ounces fresh baby spinach (about 4 cups)\ntap here\n4 green onions, chopped\n1 small tomato, chopped\n2 tablespoons lemon juice\n1 teaspoon ground cumin\n1/4 teaspoon garlic powder\n1 cup shredded reduced-fat Monterey Jack cheese or Mexican cheese blend\n1/4 cup reduced-fat ricotta cheese\n6 flour tortillas (6 inches)\nReduced-fat sour cream, optional\nBuy Ingredients\nPowered by Chicory\ntap here\nDirections\nIn a large nonstick skillet, cook and stir first 6 ingredients until spinach is wilted. Remove from heat; stir in cheeses.\nTop half of each tortilla with spinach mixture; fold other half over filling. Place on a griddle coated with cooking spray; cook over medium heat until golden brown, 1-2 minutes per side. Cut quesadillas in half; if desired, serve with sour cream.\n', 'Spinach Quesadillas', 1, '2022-06-21 03:20:20', NULL, 'https://www.tasteofhome.com/wp-content/uploads/2018/01/Spinach-Quesadillas_EXPS_SDON16_39915_A06_02_11b-4.jpg?fit=700,1024', NULL, 9);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (8, 'https://www.tasteofhome.com/recipes/ginger-salmon-with-green-beans/', 30, 'Ingredients\n1/4 cup lemon juice\n2 tablespoons rice vinegar\n3 garlic cloves, minced\n2 teaspoons minced fresh gingerroot\n2 teaspoons honey\n1/8 teaspoon salt\n1/8 teaspoon pepper\n2 salmon fillets (4 ounces each)\ntap here\n1 medium lemon, thinly sliced\ngreen beans:\n3/4 pound fresh green beans, trimmed\n2 tablespoons water\n2 teaspoons olive oil\n1/2 cup finely chopped onion\n3 garlic cloves, minced\n1/8 teaspoon salt\nBuy Ingredients\nPowered by Chicory\ntap here\nDirections\nPreheat oven to 325°. Mix first 7 ingredients.\nPlace each salmon fillet on an 18x12-in. piece of heavy-duty foil; fold up edges of foil to create a rim around the fish. Spoon lemon juice mixture over salmon; top with lemon slices. Carefully fold foil around fish, sealing tightly.\nPlace packets in a 15x10x1-in. pan. Bake until fish just begins to flake easily with a fork, 15-20 minutes. Open foil carefully to allow steam to escape.\nMeanwhile, place green beans, water and oil in a large skillet; bring to a boil. Reduce heat; simmer, covered, 5 minutes. Stir in remaining ingredients; cook, uncovered, until beans are crisp-tender, stirring occasionally. Serve with salmon.', 'Ginger Salmon With Green Beans', 1, '2022-06-21 03:20:20', NULL, 'https://www.tasteofhome.com/wp-content/uploads/2018/01/Ginger-Salmon-with-Green-Beans_EXPS_SDJJ17_198867_D02_14_6b-4.jpg?fit=700,1024', NULL, 10);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (9, 'https://ifoodreal.com/air-fryer-chicken-breast/', 35, 'Ingredients\n\nAD\n▢2 lbs boneless & skinless chicken breasts\n▢1 tbsp oil\n▢1 tsp smoked paprika\n▢1 tsp garlic powder\n▢1 tsp onion powder\n▢1 tsp oregano dried\n▢3/4 tsp salt\n▢Ground black pepper to taste\n▢Cooking spray I use Misto\n\nUS Customary – Metric\nInstructions\nPreheat air fryer at 380 F degrees for 5 minutes. In the meanwhile, in a large bowl or dish, add chicken, drizzle with oil and toss to coat. Sprinkle with smoked paprika, garlic powder, onion powder, oregano, salt and pepper. Toss to coat.\nSpray air fryer basket with cooking spray, add chicken breasts in a single layer and not touching.\nAir fry at 380 F degrees for 16 minutes, no need to turn or shake.\nOpen the basket and make sure internal read thermometer inserted in the thickest part reads minimum 150 degrees F.\nTransfer onto a platter, cover with tin foil and let rest for 5 minutes to allow juices to settle.\nSlice against the grain and serve along any side with a salad. Meal prep for the week, use in salads and casseroles.\nMake ahead: Rub chicken with spices, cover and refrigerate overnight (up to 12 hours before cooking). \nStore: Refrigerate in an airtight container for up to 1 week.\nFreeze: Freeze in an airtight container for up to 3 months.\nReheat: Reheat air-fried chicken breast in a lidded pot with a splash of water or broth to ‘steam’ them until warm.\n', 'Air Fryer Chicken Breast', 1, '2022-06-21 03:20:20', NULL, 'https://ifoodreal.com/wp-content/uploads/2021/05/air-fryer-chicken-breast-recipe-6.jpg', NULL, 11);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (10, 'https://ifoodreal.com/caprese-chicken-and-zucchini/', 25, 'Ingredients\n\nAD\n▢1.5 lbs boneless & skinless chicken breasts cut into 1″ cubes\n▢2 lbs zucchini cut in to 1″ cubes\n▢9 oz fresh mozzarella cheese thinly sliced\n▢7 garlic cloves minced\n▢1.5 lb tomatoes sliced\n▢6 oz can tomato paste low sodium\n▢2 tbsp oil divided\n▢1 tbsp balsamic vinegar\n▢1 tsp dried oregano\n▢1/2 tsp salt divided\n▢Ground black pepper to taste\n▢Handful fresh basil thinly sliced\n\nUS Customary – Metric\nInstructions\nPreheat large deep skillet on medium heat and swirl 1 tbsp oil to coat. Add chicken, 1/4 tsp salt and pepper. Cook for 5 minutes, stirring once.\nMove chicken to the side of the skillet and keep empty part over the burner. Add 1 tbsp oil, garlic and saute for 30 seconds, stirring frequently.\nAdd tomatoes, tomato paste, balsamic vinegar, oregano, 1/4 tsp salt and a handful of basil. Cook this “tomato pile” for about 5 minutes, stirring occasionally.\nAdd zucchini, stir everything together, cover and cook on low-medium for 12 minutes.\nLay mozzarella slices on top, reduce heat to low, cover and simmer for 5 minutes.\nSprinkle more basil and ground black pepper on top. Serve hot, on its own or with spaghetti, brown rice or quinoa.\nStore: Refrigerate covered for up to 3 – 4 days. Do not freeze.\nTo reheat: Simmer on low heat in a skillet for 5 minutes covered. If you use non-stick skillet you should not need any water or oil to reheat the dish as zucchini will release water.', 'Caprese Chicken with Zucchini', 1, '2022-06-21 03:20:20', NULL, 'https://ifoodreal.com/wp-content/uploads/2020/06/caprese-chicken-and-zucchini-skillet-24.jpg', NULL, 12);
INSERT INTO `recipe` (`id`, `link`, `time_required`, `recipe_text`, `name`, `user_id`, `created_at`, `updated_at`, `image_url`, `recipecol`, `nutrients_id`) VALUES (11, 'https://ifoodreal.com/healthy-pasta/', 40, 'Ingredients\n\nAD\n▢2 cups any shape pasta uncooked\n▢1 cup pasta water reserved\n▢2 large garlic cloves minced\n▢1 tbsp olive oil extra virgin\n▢1/4 cup + 2 tbsp pesto divided\n▢2 cups grape tomatoes cut in halves\n▢4 cups broccoli florets coarsely chopped\n▢1/3 cup sun dried tomatoes thinly sliced\n▢1/2 cup (2 oz) Parmesan cheese grated\n▢1/2 tsp salt more to taste\n▢1/8 tsp red pepper flakes\n▢Ground black pepper to taste\n\nUS Customary – Metric\nInstructions\nCook pasta as per package instructions.\nWhile pasta is cooking, get all ingredients ready – chop veggies and grate cheese.\nReserve 1 cup of pasta water, draining the rest. Set aside.\nPreheat large deep skillet or a dutch oven on medium heat, add olive oil and garlic. Sauté for 30 seconds, stirring frequently.\nAdd 1 tbsp pesto, tomatoes and stir. Cook for 1 – 2 minutes, stir and cook another 1 – 2 minutes.\nMove to one side of the skillet and make sure the empty side of is positioned directly over heat. Add 1 tbsp pesto and broccoli, stir and cook for 4 minutes, stirring once.\nRemove skillet from heat and add remaining 1/4 cup pesto, sun dried tomatoes, half Parmesan cheese, salt, black pepper, red pepper flakes, pasta and pasta water. Stir gently and let flavours marinate for a few minutes. Do not cover because broccoli will become a mushy mess.\nSprinkle with remaining half Parmesan cheese. Serve hot.\nStore: Refrigerate in an airtight container for up to 3 – 5 days or freeze for up to 3 months.\nFreeze: If you have leftovers or made more than enough, you can definitely freeze it for up to 3 months.\nReheat: To reheat, thaw in the fridge overnight and reheat on the stovetop on low-medium heat. Add a bit more pesto if needed.\nNotes\n\nAD\nPasta: Gluten free, whole wheat, brown rice, quinoa, kamut pasta. You name it! Pictured is my kids’ favourite (organic if I can find) Garofalo brand from Costco. It’s one of the best quality pasta I ever tried.\nPesto: If using store-bought, try to find one with as fewer additives as possible. \nParmesan cheese: Freshly grated is the way to go. \nProtein: For added protein, throw in some baked turkey meatballs or chopped up healthy turkey burgers.\nFrozen broccoli: If you are using frozen broccoli, you don’t need to thaw first. Keep an extra eye out so that it doesn’t get overcooked and mushy.\nServe with: A smaller portion can definitely be served as a side dish. It accompanies a healthy turkey burgers or lemon butter baked cod very nicely!', 'Healthy Pasta', 1, '2022-06-21 03:20:20', NULL, 'https://ifoodreal.com/wp-content/uploads/2014/10/top-skillet-healthy-pesto-tomato-broccoli-pasta-recipe.jpg', NULL, 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `ingredient` (`id`, `name`, `nutrients_id`, `portion`) VALUES (1, 'egg', 1, NULL);
INSERT INTO `ingredient` (`id`, `name`, `nutrients_id`, `portion`) VALUES (2, 'potatoes', 2, NULL);
INSERT INTO `ingredient` (`id`, `name`, `nutrients_id`, `portion`) VALUES (3, 'vegetable oil', 3, NULL);

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
INSERT INTO `topic` (`id`, `name`, `description`) VALUES (1, 'Time Saving Tips', 'Tips for busy people on the go');
INSERT INTO `topic` (`id`, `name`, `description`) VALUES (2, 'Exercise Tips', 'Sharing Ideas for keeping fit');
INSERT INTO `topic` (`id`, `name`, `description`) VALUES (3, 'Meal Prep', 'Ideas on how to prepare foods ahead of time for nutritious and quick meals.');
INSERT INTO `topic` (`id`, `name`, `description`) VALUES (4, 'Budget Eating', 'Ways to eat well with limited resources');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_topic`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 1);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 2);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 3);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 4);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 5);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 6);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 7);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 8);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 9);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 10);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 11);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 12);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 13);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 14);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 15);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 16);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (2, 17);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (3, 18);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (3, 19);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (1, 19);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (2, 20);
INSERT INTO `blog_topic` (`topic_id`, `blog_id`) VALUES (4, 21);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meal_ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `nutritiondb`;
INSERT INTO `meal_ingredient` (`meal_id`, `ingredient_id`) VALUES (1, 1);
INSERT INTO `meal_ingredient` (`meal_id`, `ingredient_id`) VALUES (2, 2);
INSERT INTO `meal_ingredient` (`meal_id`, `ingredient_id`) VALUES (3, 2);
INSERT INTO `meal_ingredient` (`meal_id`, `ingredient_id`) VALUES (1, 2);
INSERT INTO `meal_ingredient` (`meal_id`, `ingredient_id`) VALUES (1, 3);

COMMIT;


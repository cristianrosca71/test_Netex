-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: new_database
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contact_info`
--

DROP TABLE IF EXISTS `contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_info` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `contact_first_name` varchar(45) NOT NULL,
  `contact_last_name` varchar(45) NOT NULL,
  `contact_email_address` varchar(60) NOT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`contact_id`,`contact_email_address`),
  UNIQUE KEY `contact_email_address_UNIQUE` (`contact_email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info`
--

LOCK TABLES `contact_info` WRITE;
/*!40000 ALTER TABLE `contact_info` DISABLE KEYS */;
INSERT INTO `contact_info` VALUES (1001,'Shawna','Buck','shawna.buck@gmail.com','845-226-8495','941 Bowman Lane Englewood, NJ 07631'),(1002,'Nathaniel','Burke','nathaniel.burke@walmart.com','828-210-2834','50 James Circle Asheville, NC 28803'),(1003,'Elisabeth','Foster','elisabeth.foster@gmail.com','508-821-1700','8412 Pine Rd. Taunton, MA 02780'),(1004,'Briana','Lancaster','briana.lancaster@yahoo.com','732-731-9488','8760 Meadowbrook Ave. Lakewood, NJ 08701'),(1005,'Estella','Potter','estella.potter@gmail.com','845-227-3021','9192 10th Avenue Hopewell Junction, NY 12533'),(1006,'Lamont','Woods','lamont.woods@hotmail.com','877-265-7317','9898 Church Road Gaithersburg, MD 20877'),(1007,'Melinda','Lopez','melinda.lopez@hotmail.com','330-677-3734','25 Stillwater St. Kent, OH 44240'),(1008,'Shanna','Silva','shanna.silva@gmail.com','859-392-1980','3 Littleton Drive Independence, KY 41051'),(1009,'Jasmine','Freeman','jasmine.freeman@gmail.com','',''),(1010,'Madge','Sargent','madge.sargent@aol.com','','');
/*!40000 ALTER TABLE `contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_photo`
--

DROP TABLE IF EXISTS `contact_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_photo` (
  `contact_id` int NOT NULL,
  `contact_photo` varchar(64) NOT NULL,
  PRIMARY KEY (`contact_id`),
  UNIQUE KEY `contact_photo_UNIQUE` (`contact_photo`),
  CONSTRAINT `FK_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `contact_info` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_photo`
--

LOCK TABLES `contact_photo` WRITE;
/*!40000 ALTER TABLE `contact_photo` DISABLE KEYS */;
INSERT INTO `contact_photo` VALUES (1001,'B88efmNkhB2DC7SxhXjT'),(1006,'GeujhCNU9Rd4OiVnsdQ5'),(1002,'I6r2J3Wk65L0v5U6oU9Y'),(1007,'I9bnkap8mYzZtEjT9Mkw'),(1004,'Jy0FTe6O0YS0Vhex7OYd'),(1010,'kAIjXoNn0EZJU8ZCtGc9'),(1003,'QhqPgy4obG8xSQ92EL9M'),(1008,'tDByU9IAJH0LcykmpGFN'),(1009,'UuT7eoNs5hW7blaw8pEM'),(1005,'XFbQxzU6q6Wg5JYiAisU');
/*!40000 ALTER TABLE `contact_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_first_name` varchar(45) DEFAULT NULL,
  `user_last_name` varchar(45) NOT NULL,
  `user_email_address` varchar(60) NOT NULL,
  PRIMARY KEY (`user_id`,`user_email_address`),
  UNIQUE KEY `user_email_address_UNIQUE` (`user_email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1001,'Cristian','Rosca','cristian.rosca71@gmail.com'),(1002,'Alina','Rosca','alina_rosca73@yahoo.com'),(1003,'Cristian','Rosca','cristian_rosca7@yahoo.com'),(1004,'Cristian','Rosca','cristian_rosca1@yahoo.com'),(1008,'Cristian','Rosca','cristian_rosca741@yahoo.com'),(1010,'\"test\"','\"x\"','\"hh@r.com\"'),(1012,'Cristian','Rosca','cristian_rosca71@yahoo.com');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_passw`
--

DROP TABLE IF EXISTS `user_passw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_passw` (
  `user_id` int NOT NULL,
  `user_login` varchar(60) NOT NULL,
  `user_passw` varchar(45) NOT NULL,
  PRIMARY KEY (`user_login`),
  UNIQUE KEY `user_login_UNIQUE` (`user_login`),
  KEY `FK_user_id` (`user_id`),
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_passw`
--

LOCK TABLES `user_passw` WRITE;
/*!40000 ALTER TABLE `user_passw` DISABLE KEYS */;
INSERT INTO `user_passw` VALUES (1010,'\"hh@r.com\"','\"gg\"'),(1002,'alina_rosca73@yahoo.com','222'),(1004,'cristian_rosca1@yahoo.com','aaa'),(1003,'cristian_rosca7@yahoo.com','qqq'),(1012,'cristian_rosca71@yahoo.com','a'),(1008,'cristian_rosca741@yahoo.com','www'),(1001,'cristian.rosca71@gmail.com','aaa');
/*!40000 ALTER TABLE `user_passw` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-17 15:29:27

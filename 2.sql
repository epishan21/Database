-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: museum
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `id_museum` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employees_museum_id` (`id_museum`),
  CONSTRAINT `fk_employees_museum_id` FOREIGN KEY (`id_museum`) REFERENCES `museums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Бражник Д.А.','охранник',1),(2,'Бурова Е.С.','уборщик',1);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exhibits`
--

DROP TABLE IF EXISTS `exhibits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exhibits` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `author` varchar(40) NOT NULL,
  `condition_exhibit` varchar(50) NOT NULL,
  `id_showroom` int unsigned NOT NULL,
  `id_reprositiry` int unsigned NOT NULL,
  `id_thematic_section` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exhibits_showroom_id` (`id_showroom`),
  KEY `fk_exhibits_reprositiries_id` (`id_reprositiry`),
  KEY `fk_exhibits_thematic_section_id` (`id_thematic_section`),
  CONSTRAINT `fk_exhibits_reprositiries_id` FOREIGN KEY (`id_reprositiry`) REFERENCES `reprositiries` (`id`),
  CONSTRAINT `fk_exhibits_showroom_id` FOREIGN KEY (`id_showroom`) REFERENCES `showrooms` (`id`),
  CONSTRAINT `fk_exhibits_thematic_section_id` FOREIGN KEY (`id_thematic_section`) REFERENCES `thematic_sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exhibits`
--

LOCK TABLES `exhibits` WRITE;
/*!40000 ALTER TABLE `exhibits` DISABLE KEYS */;
INSERT INTO `exhibits` VALUES (1,'Разгром немецко-фашистских войск под Сталинградом','Художники студии имени М. Б. Грекова','Отличное',2,1,1),(2,'Трость Николая Романова','Взятов М.Н.','Отличное',1,2,2);
/*!40000 ALTER TABLE `exhibits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `museums`
--

DROP TABLE IF EXISTS `museums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `museums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `museums`
--

LOCK TABLES `museums` WRITE;
/*!40000 ALTER TABLE `museums` DISABLE KEYS */;
INSERT INTO `museums` VALUES (1,'Музей-панорама «Сталинградская битва»','ул. им. маршала Чуйкова, 47'),(2,'Интерактивный музей «Россия — Моя история»','Набережная 62-й армии, 1 Б');
/*!40000 ALTER TABLE `museums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reprositiries`
--

DROP TABLE IF EXISTS `reprositiries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reprositiries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `size` varchar(20) NOT NULL,
  `id_museum` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reprositiries_museums_id` (`id_museum`),
  CONSTRAINT `fk_reprositiries_museums_id` FOREIGN KEY (`id_museum`) REFERENCES `museums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reprositiries`
--

LOCK TABLES `reprositiries` WRITE;
/*!40000 ALTER TABLE `reprositiries` DISABLE KEYS */;
INSERT INTO `reprositiries` VALUES (1,'50х30х5',0),(2,'20х20х5',0);
/*!40000 ALTER TABLE `reprositiries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showrooms`
--

DROP TABLE IF EXISTS `showrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showrooms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `size` varchar(50) NOT NULL,
  `id_museum` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_showrooms_museum_id` (`id_museum`),
  CONSTRAINT `fk_showrooms_museum_id` FOREIGN KEY (`id_museum`) REFERENCES `museums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showrooms`
--

LOCK TABLES `showrooms` WRITE;
/*!40000 ALTER TABLE `showrooms` DISABLE KEYS */;
INSERT INTO `showrooms` VALUES (1,'Романовы.','30х20х5',2),(2,'Панорама','20х10х4',1),(3,'Романовы','30х20х5',2),(4,'Панорама','20х10х4',1);
/*!40000 ALTER TABLE `showrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thematic_sections`
--

DROP TABLE IF EXISTS `thematic_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thematic_sections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thematic_sections`
--

LOCK TABLES `thematic_sections` WRITE;
/*!40000 ALTER TABLE `thematic_sections` DISABLE KEYS */;
INSERT INTO `thematic_sections` VALUES (1,'Историческая'),(2,'Военно-патриотическая');
/*!40000 ALTER TABLE `thematic_sections` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-27 19:33:27

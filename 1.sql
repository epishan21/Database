-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cinema
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
-- Table structure for table `booth_employees`
--

DROP TABLE IF EXISTS `booth_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booth_employees` (
  `Id_booth_employees` int NOT NULL AUTO_INCREMENT,
  `Id_booth` int DEFAULT NULL,
  PRIMARY KEY (`Id_booth_employees`),
  KEY `fk_boothemp_ticketboot_idx` (`Id_booth`),
  CONSTRAINT `fk_boothemp_employees` FOREIGN KEY (`Id_booth_employees`) REFERENCES `employees` (`Id_employee`),
  CONSTRAINT `fk_boothemp_ticketboot` FOREIGN KEY (`Id_booth`) REFERENCES `ticket_booths` (`Id_ticket_booths`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booth_employees`
--

LOCK TABLES `booth_employees` WRITE;
/*!40000 ALTER TABLE `booth_employees` DISABLE KEYS */;
INSERT INTO `booth_employees` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `booth_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinemas`
--

DROP TABLE IF EXISTS `cinemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinemas` (
  `Id_cinemas` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  PRIMARY KEY (`Id_cinemas`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinemas`
--

LOCK TABLES `cinemas` WRITE;
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
INSERT INTO `cinemas` VALUES (1,' 5 звезд','Рабоче-Крестьянская, 9Б'),(2,'Киномакс','Рабоче-Крестьянская, 10'),(3,'Mori Cinema',' Землячки, 110Б'),(4,'Москва','Охотный ряд, 2'),(5,'Пирамида',' Краснознаменская, 9'),(6,'Гиппопо',' Героев Сталинграда, 68'),(7,'Пионер','Кутузовский просп., 21'),(8,'Родина','Семёновская пл., 5'),(9,'Балтика','Сходненская, 56'),(10,'Иллюзион','Котельническая наб., 1/15');
/*!40000 ALTER TABLE `cinemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaners`
--

DROP TABLE IF EXISTS `cleaners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaners` (
  `id_cleaner` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_cleaner`),
  CONSTRAINT `fk_otheremployees_employees` FOREIGN KEY (`id_cleaner`) REFERENCES `employees` (`Id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaners`
--

LOCK TABLES `cleaners` WRITE;
/*!40000 ALTER TABLE `cleaners` DISABLE KEYS */;
INSERT INTO `cleaners` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
/*!40000 ALTER TABLE `cleaners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaners_to_halls`
--

DROP TABLE IF EXISTS `cleaners_to_halls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaners_to_halls` (
  `id_cleaner` int NOT NULL,
  `id_hall` int NOT NULL,
  `day_of_week_of_cleaning` date NOT NULL,
  `time_of_cleaning` time NOT NULL,
  PRIMARY KEY (`id_cleaner`,`id_hall`),
  KEY `fk_CTH_hall_id` (`id_hall`),
  CONSTRAINT `fk_CTH_cleaners_id` FOREIGN KEY (`id_cleaner`) REFERENCES `cleaners` (`id_cleaner`),
  CONSTRAINT `fk_CTH_hall_id` FOREIGN KEY (`id_hall`) REFERENCES `halls` (`Id_hall`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaners_to_halls`
--

LOCK TABLES `cleaners_to_halls` WRITE;
/*!40000 ALTER TABLE `cleaners_to_halls` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaners_to_halls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `Id_employee` int NOT NULL AUTO_INCREMENT,
  `Fullname` varchar(45) NOT NULL,
  `Shedule` varchar(45) NOT NULL,
  `Qualification` varchar(45) NOT NULL,
  `Id_cinema` int NOT NULL,
  PRIMARY KEY (`Id_employee`),
  KEY `fk_employees_cinemas_idx` (`Id_cinema`),
  CONSTRAINT `fk_employees_cinemas` FOREIGN KEY (`Id_cinema`) REFERENCES `cinemas` (`Id_cinemas`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Кравц Андрей','5-2','Высококвалифицированные',1),(2,'Легкова Снежанна','5-2','Высококвалифицированные',1),(3,'Великий Максим','5-2','Высококвалифицированные',1),(4,'Ковалев Константин','2-2','Среднеквалифицированные',2),(5,'Ширяев Иван','2-2','Среднеквалифицированные',2),(6,'Ситников Дмитрий','2-2','Среднеквалифицированные',2),(7,'Щербакова Екатерина','2-2','Среднеквалифицированные',3),(8,'Ирина Лабунько','3-2','Среднеквалифицированные',3),(9,'Алина суханова','1-1','Низкоквалифицированные',3),(10,'Антон капитанов','1-1','Низкоквалифицированные',3);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `films`
--

DROP TABLE IF EXISTS `films`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `films` (
  `Id_films` int NOT NULL AUTO_INCREMENT,
  `Length` int unsigned NOT NULL,
  `Genre` varchar(45) NOT NULL,
  `Rating` float unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Actors` varchar(45) DEFAULT NULL,
  `Directors` varchar(45) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Film_company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_films`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `films`
--

LOCK TABLES `films` WRITE;
/*!40000 ALTER TABLE `films` DISABLE KEYS */;
INSERT INTO `films` VALUES (1,178,'фэнтези',8.6,'Властелин колец: Братство Кольца','Элайджа Вуд	Питер Джексон','Питер Джексон','Захватывает','America'),(2,139,'военный',8,'По соображениям совести','Эндрю Гарфилд','Мэл Гибсон','Классно','DemaRest'),(3,189,'драма',9.1,'Зеленая миля','Том Хэнкс','Фрэнк Дарабонт','Грустно','WB'),(4,120,'фантастика',7.2,'Робот по имени Чаппи','Йоланди Фиссер','Нил Бломкамп','Прикольно','Columbia'),(5,136,'мелодрама',7.3,'Серебряные коньки','Фёдор Федотов','Михаил Локшин','Красиво','Central partnership'),(6,194,'мелодрама',8.4,'Титаник','Леонардо Ди Каприо','Джеймс Кэмерон','Классика','20th Century Studios'),(7,98,'боевик',6.4,'Пушки Акимбо','Дэниел Рэдклифф','Джейсон Ли Хауден','Подвижно','Saban Films'),(8,86,'мультфильм',8.1,'Стальной Гигант','Вин Дизель','Брэд Бёрд','Мило','WB'),(9,142,'драма',9.1,'Побег из Шоушенка','Тим Роббинс','Фрэнк Дарабон','Превосходно','WB'),(10,133,'драма',7.5,'Мотылек','Рами малек','Михаэль Ноер','Сильно','Universal pictures');
/*!40000 ALTER TABLE `films` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hall_sectors`
--

DROP TABLE IF EXISTS `hall_sectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hall_sectors` (
  `Id_hall_sectors` int NOT NULL AUTO_INCREMENT,
  `Price` int unsigned NOT NULL,
  `Start_line` int unsigned NOT NULL,
  `End_line` int unsigned NOT NULL,
  `Id_hall` int NOT NULL,
  PRIMARY KEY (`Id_hall_sectors`),
  KEY `fk_hallsectors_halls_idx` (`Id_hall`),
  CONSTRAINT `fk_hallsectors_halls` FOREIGN KEY (`Id_hall`) REFERENCES `halls` (`Id_hall`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hall_sectors`
--

LOCK TABLES `hall_sectors` WRITE;
/*!40000 ALTER TABLE `hall_sectors` DISABLE KEYS */;
INSERT INTO `hall_sectors` VALUES (1,120,1,2,1),(2,150,3,5,1),(3,170,6,10,1),(4,100,1,3,2),(5,130,4,6,2),(6,150,7,10,2),(7,180,1,5,3),(8,200,6,8,3),(9,250,9,10,3),(10,300,1,10,4);
/*!40000 ALTER TABLE `hall_sectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `halls`
--

DROP TABLE IF EXISTS `halls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `halls` (
  `Id_hall` int NOT NULL AUTO_INCREMENT,
  `Size` varchar(10) DEFAULT NULL,
  `Number` int unsigned NOT NULL,
  `Id_cinema` int NOT NULL,
  PRIMARY KEY (`Id_hall`),
  KEY `fk_halls_cinemas_idx` (`Id_cinema`),
  CONSTRAINT `fk_halls_cinemas` FOREIGN KEY (`Id_cinema`) REFERENCES `cinemas` (`Id_cinemas`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `halls`
--

LOCK TABLES `halls` WRITE;
/*!40000 ALTER TABLE `halls` DISABLE KEYS */;
INSERT INTO `halls` VALUES (1,'30х50х5',1,1),(2,'50x70x6',2,1),(3,'40x60x5',3,1),(4,'30х50х5',1,2),(5,'50x70x6',2,2),(6,'40x60x5',3,2),(7,'30х50х5',1,3),(8,'50x70x6',2,3),(9,'40x60x5',3,3),(10,'30х50х5',1,4);
/*!40000 ALTER TABLE `halls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `places`
--

DROP TABLE IF EXISTS `places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `places` (
  `Id_places` int NOT NULL AUTO_INCREMENT,
  `Place_№` tinyint unsigned NOT NULL,
  `Line_№` tinyint unsigned NOT NULL,
  `Id_sector` int NOT NULL,
  PRIMARY KEY (`Id_places`),
  KEY `fk_places_hallsectors_idx` (`Id_sector`),
  CONSTRAINT `fk_places_hallsectors` FOREIGN KEY (`Id_sector`) REFERENCES `hall_sectors` (`Id_hall_sectors`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `places`
--

LOCK TABLES `places` WRITE;
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
INSERT INTO `places` VALUES (1,1,1,1),(2,2,1,2),(3,3,1,3),(4,4,2,4),(5,5,2,5),(6,6,2,6),(7,7,2,7),(8,8,3,8),(9,9,3,9),(10,10,3,10);
/*!40000 ALTER TABLE `places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `Id_session` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Format` varchar(45) NOT NULL,
  `Id_hall` int NOT NULL,
  `Id_films` int NOT NULL,
  PRIMARY KEY (`Id_session`),
  KEY `fk_sessions_films_idx` (`Id_films`),
  KEY `fk_sessions_halls_idx` (`Id_hall`),
  CONSTRAINT `fk_sessions_films` FOREIGN KEY (`Id_films`) REFERENCES `films` (`Id_films`),
  CONSTRAINT `fk_sessions_halls` FOREIGN KEY (`Id_hall`) REFERENCES `halls` (`Id_hall`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'2011-12-20','15:20:00','2D',1,1),(2,'2028-11-20','12:30:00','2D',2,2),(3,'2002-12-20','11:50:00','3D',3,3),(4,'2010-12-20','16:00:00','2D',4,4),(5,'2018-03-20','18:00:00','IMAX',5,5),(6,'2019-03-20','15:20:00','IMAX',6,6),(7,'2020-03-20','12:30:00','2D',7,7),(8,'2021-03-20','11:50:00','3D',8,8),(9,'2022-03-20','16:00:00','2D',9,9),(10,'2023-03-20','18:00:00','IMAX',10,10);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_booths`
--

DROP TABLE IF EXISTS `ticket_booths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_booths` (
  `Id_ticket_booths` int NOT NULL AUTO_INCREMENT,
  `Number` tinyint unsigned NOT NULL,
  PRIMARY KEY (`Id_ticket_booths`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_booths`
--

LOCK TABLES `ticket_booths` WRITE;
/*!40000 ALTER TABLE `ticket_booths` DISABLE KEYS */;
INSERT INTO `ticket_booths` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `ticket_booths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `Id_tickets` int NOT NULL,
  `Reservation` varchar(10) NOT NULL DEFAULT '0',
  `Id_session` int NOT NULL,
  `Id_place` int NOT NULL,
  `Id_booth_employee` int NOT NULL,
  PRIMARY KEY (`Id_tickets`),
  KEY `fk_tckets_sessions_idx` (`Id_session`),
  KEY `fk_tckets_sessions2_idx` (`Id_place`),
  KEY `fk_tckets_sessions3_idx` (`Id_booth_employee`),
  CONSTRAINT `fk_tckets_sessions1` FOREIGN KEY (`Id_session`) REFERENCES `sessions` (`Id_session`),
  CONSTRAINT `fk_tckets_sessions2` FOREIGN KEY (`Id_place`) REFERENCES `places` (`Id_places`),
  CONSTRAINT `fk_tckets_sessions3` FOREIGN KEY (`Id_booth_employee`) REFERENCES `booth_employees` (`Id_booth_employees`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'True',1,1,1),(2,'False',2,2,2),(3,'False',3,3,3),(4,'False',4,4,4),(5,'True',5,5,5),(6,'False',6,6,6),(7,'False',7,7,7),(8,'True',8,8,8),(9,'True',9,9,9),(10,'True',10,10,10);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-27 19:34:05

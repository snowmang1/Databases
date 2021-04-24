-- MySQL dump 10.13  Distrib 8.0.23, for Linux (aarch64)
--
-- Host: localhost    Database: teamProject
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Book_Copy`
--

DROP TABLE IF EXISTS `Book_Copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book_Copy` (
  `Title` varchar(255) NOT NULL,
  `Author` varchar(255) NOT NULL,
  `Genre` varchar(128) DEFAULT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Page_No` mediumint unsigned NOT NULL,
  `Edition` tinyint unsigned DEFAULT NULL,
  `Condition` tinyint NOT NULL,
  `Renewal` tinyint unsigned NOT NULL DEFAULT (0),
  `Copy_num` tinyint unsigned NOT NULL,
  `ISBN` char(17) NOT NULL,
  PRIMARY KEY (`ISBN`,`Copy_num`),
  CONSTRAINT `Book_Copy_chk_1` CHECK ((`Condition` between 0 and 5)),
  CONSTRAINT `Book_Copy_chk_2` CHECK ((`Renewal` between 0 and 5)),
  CONSTRAINT `Book_Copy_chk_3` CHECK ((`Copy_num` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_Copy`
--

LOCK TABLES `Book_Copy` WRITE;
/*!40000 ALTER TABLE `Book_Copy` DISABLE KEYS */;
INSERT INTO `Book_Copy` (`Title`, `Author`, `Genre`, `Availability`, `Page_No`, `Edition`, `Condition`, `Renewal`, `Copy_num`, `ISBN`) VALUES ('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',0,208,1,2,0,1,'9780001857018'),('The Lion, the Witch and the Wardrobe','C. S. Lewis','Children\'s fantasy',1,208,1,3,0,2,'9780001857018'),('Charlotte\'s Web','E. B. White','Children\'s literature',1,192,1,4,0,1,'9780062658753'),('Charlotte\'s Web','E. B. White','Children\'s literature',1,192,1,3,0,2,'9780062658753'),('Charlotte\'s Web','E. B. White','Children\'s literature',0,192,1,3,0,3,'9780062658753'),('The Da Vinci Code','Dan Brown','Mystery Thriller',1,689,1,4,0,1,'9780385504201'),('The Da Vinci Code','Dan Brown','Mystery Thriller',0,689,1,1,0,2,'9780385504201'),('The Da Vinci Code','Dan Brown','Mystery Thriller',1,689,1,5,0,3,'9780385504201'),('To Kill a Mockingbird','Harper Lee','Southern Gothic',0,281,1,4,0,1,'9780446310789'),('To Kill a Mockingbird','Harper Lee','Southern Gothic',1,281,1,1,0,2,'9780446310789'),('To Kill a Mockingbird','Harper Lee','Southern Gothic',0,281,1,3,0,3,'9780446310789'),('To Kill a Mockingbird','Harper Lee','Southern Gothic',0,281,1,4,0,4,'9780446310789'),('The Bridges of Madison County','Robert James Waller','Romance novel',1,192,1,4,0,1,'9780446364492'),('The Bridges of Madison County','Robert James Waller','Romance novel',0,192,1,3,0,2,'9780446364492'),('The Hobbit','	J. R. R. Tolkien','High fantasy',1,310,2,5,0,1,'9780547928227'),('The Hobbit','	J. R. R. Tolkien','High fantasy',1,310,2,5,0,2,'9780547928227'),('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',1,309,5,1,0,1,'9780747532743'),('Harry Potter and the Philosopher\'s Stone','J. K. Rowling','Fantasy',1,309,5,3,0,2,'9780747532743'),('Black Beauty','Anna Sewell','Novel',0,255,1,5,0,1,'9781613821008'),('Black Beauty','Anna Sewell','Novel',1,255,1,3,0,2,'9781613821008');
/*!40000 ALTER TABLE `Book_Copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Check_Out`
--

DROP TABLE IF EXISTS `Check_Out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Check_Out` (
  `Library_ID` char(10) NOT NULL,
  `Checkout_date` date NOT NULL DEFAULT (curdate()),
  `ISBN` char(17) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,
  PRIMARY KEY (`Library_ID`,`ISBN`,`Copy_num`),
  KEY `ISBN` (`ISBN`,`Copy_num`),
  CONSTRAINT `Check_Out_ibfk_1` FOREIGN KEY (`Library_ID`) REFERENCES `Member` (`Library_ID`),
  CONSTRAINT `Check_Out_ibfk_2` FOREIGN KEY (`ISBN`, `Copy_num`) REFERENCES `Book_Copy` (`ISBN`, `Copy_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Check_Out`
--

LOCK TABLES `Check_Out` WRITE;
/*!40000 ALTER TABLE `Check_Out` DISABLE KEYS */;
INSERT INTO `Check_Out` (`Library_ID`, `Checkout_date`, `ISBN`, `Copy_num`) VALUES ('6900712420','2021-04-21','9780062658753',3),('6900712420','2021-04-21','9780446310789',3),('6900713609','2021-04-21','9780446364492',2),('6900715776','2021-04-21','9780446310789',4),('6900715776','2021-04-21','9781613821008',1),('6900719356','2021-04-11','9780001857018',1),('6900719369','2021-04-21','9780446310789',1),('6900720420','2021-04-20','9780385504201',2),('6900720420','2021-04-20','9780446364492',2);
/*!40000 ALTER TABLE `Check_Out` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS update_aval */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ubuntu`@`localhost`*/ /*!50003 TRIGGER `update_aval` AFTER INSERT ON `Check_Out` FOR EACH ROW BEGIN
    UPDATE `Book_Copy`
    SET
        `Availability` = false
    WHERE
        `ISBN` = NEW.ISBN AND
        `Copy_num` = NEW.Copy_num AND
        `Availability` = true;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Member` (
  `Name` varchar(32) NOT NULL,
  `Library_ID` char(10) NOT NULL,
  `Street` varchar(32) DEFAULT NULL,
  `Zip_Code` decimal(6,0) DEFAULT NULL,
  `City` varchar(32) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Strike_Count` tinyint unsigned NOT NULL DEFAULT (0),
  `Payment_Method` varchar(32) NOT NULL,
  `Outstanding_Balance` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`Library_ID`),
  CONSTRAINT `Member_chk_1` CHECK ((`Strike_Count` between 0 and 3)),
  CONSTRAINT `Member_chk_2` CHECK ((`Outstanding_Balance` between 0.00 and 100.00))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
INSERT INTO `Member` (`Name`, `Library_ID`, `Street`, `Zip_Code`, `City`, `State`, `Strike_Count`, `Payment_Method`, `Outstanding_Balance`) VALUES ('Carson Lucasarts','6900712420',NULL,94536,'Fremont','CA',2,'4767818474664511',5.20),('Evan Dynamix','6900713609','111 Hollywood Blvd',90001,'Los Angeles','CA',3,'4767818474664511',10.55),('John Valve','6900715776','North Campus',92612,'Irvine','CA',0,'4767818474664511',NULL),('Max King','6900719356',NULL,NULL,NULL,NULL,1,'4767718464694209',3.50),('Cole Hothead','6900719369',NULL,NULL,NULL,'CA',0,'4767818474664511',1.20),('Jeremiah Mojang','6900720420','123 Any Street, APT 6',95926,'Chico','CA',0,'4767718464004078',NULL);
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Overdue_Books`
--

DROP TABLE IF EXISTS `Overdue_Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Overdue_Books` (
  `Library_ID` char(10) NOT NULL,
  `ISBN` char(17) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,
  PRIMARY KEY (`Library_ID`,`ISBN`,`Copy_num`),
  KEY `Overdue_books` (`ISBN`,`Copy_num`),
  CONSTRAINT `Overdue_Books_ibfk_1` FOREIGN KEY (`Library_ID`) REFERENCES `Member` (`Library_ID`),
  CONSTRAINT `Overdue_Books_ibfk_2` FOREIGN KEY (`ISBN`, `Copy_num`) REFERENCES `Book_Copy` (`ISBN`, `Copy_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Overdue_Books`
--

LOCK TABLES `Overdue_Books` WRITE;
/*!40000 ALTER TABLE `Overdue_Books` DISABLE KEYS */;
INSERT INTO `Overdue_Books` (`Library_ID`, `ISBN`, `Copy_num`) VALUES ('6900719356','9780001857018',1);
/*!40000 ALTER TABLE `Overdue_Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Preferences`
--

DROP TABLE IF EXISTS `Preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Preferences` (
  `Library_ID` char(10) NOT NULL,
  `type` varchar(32) DEFAULT NULL,
  `value` varchar(32) DEFAULT NULL,
  KEY `Library_ID` (`Library_ID`),
  CONSTRAINT `Preferences_ibfk_1` FOREIGN KEY (`Library_ID`) REFERENCES `Member` (`Library_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Preferences`
--

LOCK TABLES `Preferences` WRITE;
/*!40000 ALTER TABLE `Preferences` DISABLE KEYS */;
INSERT INTO `Preferences` (`Library_ID`, `type`, `value`) VALUES ('6900720420','Genre','Romance novel'),('6900720420','Genre','Mystery Thriller'),('6900719356','Genre','Fantasy');
/*!40000 ALTER TABLE `Preferences` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-23 18:27:09

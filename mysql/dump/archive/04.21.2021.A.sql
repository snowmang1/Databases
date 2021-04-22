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
  `Title` varchar(32) NOT NULL,
  `Author` varchar(32) NOT NULL,
  `Quantity` tinyint unsigned NOT NULL,
  `Genre` varchar(32) DEFAULT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Page_No` mediumint unsigned NOT NULL,
  `Edition` tinyint unsigned DEFAULT NULL,
  `Condition` varchar(32) NOT NULL,
  `Renewal` tinyint(1) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,
  `ISBN` varchar(10) NOT NULL,
  PRIMARY KEY (`ISBN`,`Copy_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_Copy`
--

LOCK TABLES `Book_Copy` WRITE;
/*!40000 ALTER TABLE `Book_Copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `Book_Copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Check_Out`
--

DROP TABLE IF EXISTS `Check_Out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Check_Out` (
  `Library_ID` decimal(10,0) NOT NULL,
  `Due_date` date NOT NULL,
  `ISBN` varchar(10) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,
  KEY `Library_ID` (`Library_ID`),
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
    UPDATE Book_Copy
    SET
        Availability = false
    WHERE
        ISBN = NEW.ISBN AND
        Copy_num = NEW.Copy_num;
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
  `Library_ID` decimal(10,0) NOT NULL,
  `Street` varchar(32) DEFAULT NULL,
  `Zip_Code` decimal(6,0) DEFAULT NULL,
  `City` varchar(32) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Strike_Count` decimal(1,0) NOT NULL,
  `Payment_Method` varchar(32) NOT NULL,
  `Outstanding_Balance` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`Library_ID`),
  CONSTRAINT `Member_chk_1` CHECK ((`Outstanding_Balance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Overdue_Books`
--

DROP TABLE IF EXISTS `Overdue_Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Overdue_Books` (
  `Library_ID` decimal(10,0) NOT NULL,
  `ISBN` varchar(10) NOT NULL,
  `Copy_num` tinyint unsigned NOT NULL,
  KEY `Library_ID` (`Library_ID`),
  KEY `ISBN` (`ISBN`,`Copy_num`),
  CONSTRAINT `Overdue_Books_ibfk_1` FOREIGN KEY (`Library_ID`) REFERENCES `Member` (`Library_ID`),
  CONSTRAINT `Overdue_Books_ibfk_2` FOREIGN KEY (`ISBN`, `Copy_num`) REFERENCES `Book_Copy` (`ISBN`, `Copy_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Overdue_Books`
--

LOCK TABLES `Overdue_Books` WRITE;
/*!40000 ALTER TABLE `Overdue_Books` DISABLE KEYS */;
/*!40000 ALTER TABLE `Overdue_Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Preferences`
--

DROP TABLE IF EXISTS `Preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Preferences` (
  `Library_ID` decimal(10,0) NOT NULL,
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

-- Dump completed on 2021-04-21 12:54:12

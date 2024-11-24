-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: martkart
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `Address_Id` int NOT NULL AUTO_INCREMENT,
  `Login_ID` int DEFAULT NULL,
  `address_line` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fullName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Address_Id`),
  KEY `Login_ID` (`Login_ID`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`Login_ID`) REFERENCES `login` (`Login_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,NULL,'chennai at tnagar','chennai','Tamil nadu','600121','indian','2024-07-18 05:13:51','maharaja'),(2,NULL,'dfsxdsf brtt','chennai','Tamil nadu','600127','indian','2024-07-18 10:40:19','maharaja'),(3,NULL,'3 B, Amaravathy Street, Sandrorkuppam, Ambur-635814','Ambur','Tamil Nadu','635814','India','2024-07-25 11:23:47','RAMYA S'),(4,NULL,'3 B, Amaravathy Street, Sandrorkuppam, Ambur-635814','Ambur','Tamil Nadu','635814','India','2024-07-25 11:49:57','RAMYA S'),(5,NULL,'nn','nmm','nmnms','65789','India','2024-07-27 09:21:28','jggh'),(6,NULL,'3 B, Amaravathy Street, Sandrorkuppam, Ambur-635814','Ambur','Tamil Nadu','635814','India','2024-07-27 10:05:00','RAMYA S'),(7,NULL,'b nbm,','Ambur','Tamil Nadu','635814','India','2024-07-27 10:08:57','RAMYA S'),(8,NULL,'3 B, Amaravathy Street, Sandrorkuppam, Ambur-635814','Ambur','Tamil Nadu','635814','India','2024-08-01 04:12:39','RAMYA S'),(9,NULL,'nn','nmm','nmnms','65789','India','2024-08-01 04:17:58','jggh');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-07 16:37:15

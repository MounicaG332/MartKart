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
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `Product_ID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Description` text NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Category` varchar(50) NOT NULL,
  `Quantity_Available` int NOT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `reviews` int DEFAULT NULL,
  `Image_URL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Product_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'MK101 Smart Watch','Stay connected and elevate your fitness game with this sleek, multi-functional smart watch.',1299.00,'Smart Watch',50,1599.00,20,3.2,89,'img/mk101_smart_watch01.jpg'),(2,'SmartW AP403','Track your fitness and stay updated with notifications using this stylish, feature-packed smart watch.',1099.00,'Smart Watch',50,1200.00,15,4.2,31,'img/SmartW AP403.jpg'),(3,'Net501 SmartWatch','Enhance your daily routine with this smart watch, offering health tracking and seamless connectivity.',2299.00,'Smart Watch',50,4299.00,50,4.8,301,'img/Net501 SmartWatch.jpg'),(4,'Smart Watch 332','A smart watch with various features like heart rate monitor, GPS, and waterproof.',799.99,'Electronics',50,859.00,10,4.5,150,'img/SmartWatch332.jpg'),(5,'Wireless Earbuds','High-quality wireless earbuds with noise cancellation and long battery life.',999.99,'Electronics',100,1299.99,25,4.3,85,'img/buds01.jpg'),(6,'Earbuds top090','Premium wireless earbuds with superior sound quality, ergonomic design, and long-lasting battery life.',899.99,'Electronics',120,1099.99,25,4.6,20,'img/buds02.jpg'),(7,'Wireless Bluetooth Earphones','Comfortable wireless Bluetooth earphones with noise cancellation, long battery life, and high-quality sound.',1059.99,'Electronics',100,1079.99,25,4.6,20,'img/headset01.jpg'),(8,'Noise Cancelling Headphones','High-quality noise cancelling headphones with superior sound, comfortable design, and long-lasting battery.',829.99,'Electronics',75,859.99,15,4.8,22,'img/headset02.jpg'),(9,'Portable Bluetooth Speaker','High-quality portable Bluetooth speaker with robust sound, water resistance, and up to 12 hours of playtime.',1889.99,'Electronics',75,2119.99,25,4.7,110,'img/speaker01.jpg'),(10,'Portable Speaker 2.o','Compact and powerful portable Bluetooth speaker with superior sound quality, waterproof design, and long battery life.',779.99,'Electronics',120,999.99,20,4.6,350,'img/speaker02.jpg'),(11,'Outdoor Bluetooth Speaker','A durable outdoor Bluetooth speaker with excellent sound quality, long battery life, and waterproof design.',1089.99,'Electronics',100,1229.99,30,4.8,32,'img/speaker03.jpg'),(12,'Bluetooth Speaker332','Top branded A portable Bluetooth speaker with powerful sound, long battery life, and waterproof design, perfect for outdoor use.',559.99,'Electronics',15,779.99,25,4.7,48,'img/speaker05.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-07 16:37:16

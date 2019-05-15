CREATE DATABASE  IF NOT EXISTS `ib` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `ib`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: ib
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `accounts` (
  `acno` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  `balance` decimal(10,2) DEFAULT '0.00',
  `rate` int(1) NOT NULL DEFAULT '5',
  `nomonth` int(2) DEFAULT '0',
  `opening` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiry` datetime GENERATED ALWAYS AS ((`opening` + interval `nomonth` month)) STORED,
  `installment` decimal(10,2) DEFAULT '0.00',
  `status` varchar(45) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`acno`),
  UNIQUE KEY `acno_UNIQUE` (`acno`),
  KEY `_idx` (`uname`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `login` (`uname`)
) ENGINE=InnoDB AUTO_INCREMENT=789507 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`acno`, `uname`, `type`, `balance`, `rate`, `nomonth`, `opening`, `installment`, `status`) VALUES (789456,'manish','sb',42321.36,5,0,'2019-03-28 09:07:31',0.00,'active'),(789457,'adrita','sb',20148.64,5,0,'2019-04-03 09:07:31',0.00,'active'),(789493,'kush','sb',39010.12,5,0,'2019-05-03 09:07:31',0.00,'active'),(789495,'kush','fd',0.00,5,0,'2019-05-03 09:07:31',0.00,'inactive'),(789499,'deb','sb',9000.00,5,0,'2019-05-03 09:07:31',0.00,'active'),(789503,'manish','fd',10000.00,5,24,'2019-05-03 09:07:31',10000.00,'active'),(789505,'adrita','rd',500.00,5,18,'2019-05-03 09:39:28',500.00,'active'),(789506,'deb','rd',1000.00,5,12,'2019-05-05 00:18:40',1000.00,'active');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-13 22:01:38

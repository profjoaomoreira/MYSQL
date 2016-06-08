CREATE DATABASE  IF NOT EXISTS `dbinfox` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `dbinfox`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: 182.168.1.102    Database: dbinfox
-- ------------------------------------------------------
-- Server version	5.5.49-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbusuarios`
--

DROP TABLE IF EXISTS `tbusuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbusuarios` (
  `iduser` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `fone` varchar(15) DEFAULT NULL,
  `login` varchar(15) NOT NULL,
  `senha` varchar(15) NOT NULL,
  `perfil` varchar(20) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbusuarios`
--

LOCK TABLES `tbusuarios` WRITE;
/*!40000 ALTER TABLE `tbusuarios` DISABLE KEYS */;
INSERT INTO `tbusuarios` VALUES (1,'joao moreira','9999-9999','joaomoreira','123456','admin'),(2,'administrador','9999-9999','admin','admin','admin'),(3,'Leandro Lima','9999-9999','leandro','123456','user'),(4,'Silvio Langer','7777-7777','silvio','123456','user'),(5,'Marlene Oliveira','5555-5555','marlene','123456','user'),(6,'bruce alisson','3333-3333','bruce','123456','user'),(8,'Pedro deboni','4444-4444','pedro','1234567','user'),(9,'Jeferson Leon','2222-2222','leon','123456','user'),(12,'maria cristina','2222-2222','maria','123456','user'),(13,'maria ana','4444-4444','ana','123456','user'),(14,'Jurema do bar','4444-4444','jurema','123456','user'),(15,'joca nunes','5555-5555','joca','123456','user'),(16,'Maria aparecida','1111-1111','aparecida','123456','user'),(17,'joao alan','3333-3333','alan','123456','user'),(18,'uriel cardoso','4444-4444','uriel','123456','user'),(19,'uzias oliveira','7777-7777','uzias','123456','user'),(20,'Rodrigo Faro','1234-4321','Faro','123456','user'),(67,'Ricardo','5191886547','ric','12345678','user'),(100,'','','','','admin'),(101,'jhon moreira','1111-1111','jhon','123456','admin');
/*!40000 ALTER TABLE `tbusuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-30  2:47:23

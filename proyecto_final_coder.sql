CREATE DATABASE  IF NOT EXISTS `proyecto_colegio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto_colegio`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_colegio
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `Id_Alumno` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Edad` int NOT NULL,
  `Direccion_Residencia` varchar(50) NOT NULL,
  `id_profesor` int DEFAULT NULL,
  PRIMARY KEY (`Id_Alumno`),
  KEY `id_profesor` (`id_profesor`),
  CONSTRAINT `alumnos_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`Id_Profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (2,'Ana','Santamarina',10,'J.A.Sarachaga 1166',11),(3,'Carolina','Sanz',10,'Gral Paz 6',44),(4,'Maria','Fuentes',38,'J.A.',10),(6,'Patricio','Martinez',14,'Rivadavía',44),(50,'Maria','Toreal',20,'Calle 9',10);
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_id_apellido_alumno` BEFORE INSERT ON `alumnos` FOR EACH ROW BEGIN
    IF NEW.Id_Alumno IS NULL OR NEW.Id_Alumno = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Recuerde ingresar el ID del alumno.';
    END IF;

    IF NEW.Apellido IS NULL OR NEW.Apellido = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Recuerde ingresar el teléfono del alumno.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `GUARDAR_ALUMNOS_ELIMINADOS` BEFORE DELETE ON `alumnos` FOR EACH ROW BEGIN
    INSERT INTO alumnos_aud_eliminados (Id_Alumno, Nombre, Apellido, Edad, Direccion_Residencia, id_profesor)
    VALUES (OLD.Id_Alumno, OLD.Nombre, OLD.Apellido, OLD.Edad, OLD.Direccion_Residencia, OLD.id_profesor);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alumnos_aud_eliminados`
--

DROP TABLE IF EXISTS `alumnos_aud_eliminados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos_aud_eliminados` (
  `Id_Alumno` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Edad` int NOT NULL,
  `Direccion_Residencia` varchar(50) NOT NULL,
  `id_profesor` int DEFAULT NULL,
  PRIMARY KEY (`Id_Alumno`),
  KEY `id_profesor` (`id_profesor`),
  CONSTRAINT `alumnos_aud_eliminados_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`Id_Profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos_aud_eliminados`
--

LOCK TABLES `alumnos_aud_eliminados` WRITE;
/*!40000 ALTER TABLE `alumnos_aud_eliminados` DISABLE KEYS */;
INSERT INTO `alumnos_aud_eliminados` VALUES (1,'Romina','Carranza',38,'J.A.Sarachaga',10);
/*!40000 ALTER TABLE `alumnos_aud_eliminados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `Id_calificacion` int NOT NULL AUTO_INCREMENT,
  `Id_Alumno` int DEFAULT NULL,
  `Id_Curricula` int DEFAULT NULL,
  PRIMARY KEY (`Id_calificacion`),
  KEY `Id_Curricula` (`Id_Curricula`),
  KEY `calificaciones_ibfk_1` (`Id_Alumno`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`Id_Alumno`) REFERENCES `alumnos` (`Id_Alumno`) ON DELETE CASCADE,
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`Id_Curricula`) REFERENCES `materias` (`Id_Curricula`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (3,3,2),(4,3,1),(5,3,3);
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `id_profesor` int DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `id_profesor` (`id_profesor`),
  CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`Id_Profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'primero',10),(2,'segundo',11),(3,'tercero',44);
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripciones` (
  `id_inscripcion` int NOT NULL AUTO_INCREMENT,
  `fecha_inscripcion` date DEFAULT NULL,
  `Id_Alumno` int DEFAULT NULL,
  `id_curso` int DEFAULT NULL,
  PRIMARY KEY (`id_inscripcion`),
  KEY `id_curso` (`id_curso`),
  KEY `inscripciones_ibfk_1` (`Id_Alumno`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`Id_Alumno`) REFERENCES `alumnos` (`Id_Alumno`) ON DELETE CASCADE,
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materias` (
  `Id_Curricula` int NOT NULL AUTO_INCREMENT,
  `Nombre_Materia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Curricula`),
  UNIQUE KEY `Nombre_Materia` (`Nombre_Materia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (2,'CIENCIAS'),(1,'LENGUA'),(3,'MATEMATICAS');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `Id_nota` int NOT NULL AUTO_INCREMENT,
  `Id_Curricula` int DEFAULT NULL,
  `Id_Alumno` int DEFAULT NULL,
  PRIMARY KEY (`Id_nota`),
  KEY `Id_Curricula` (`Id_Curricula`),
  KEY `Id_Alumno` (`Id_Alumno`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`Id_Curricula`) REFERENCES `materias` (`Id_Curricula`),
  CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`Id_Alumno`) REFERENCES `alumnos` (`Id_Alumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `Id_Profesor` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Edad` int NOT NULL,
  `Direccion_Residencia` varchar(50) NOT NULL,
  `Id_Curricula` int DEFAULT NULL,
  `Id_Alumno` int DEFAULT NULL,
  PRIMARY KEY (`Id_Profesor`),
  KEY `Id_Curricula` (`Id_Curricula`),
  CONSTRAINT `profesor_ibfk_1` FOREIGN KEY (`Id_Curricula`) REFERENCES `materias` (`Id_Curricula`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (10,'lengua@gmail.com','Tomas','Perez',42,'Rivera 150',1,1),(11,'ciencias@gmail.com','Jose','Lopez',38,'Viso 500',2,2),(44,'matematicas@gmail.com','Maria','Asuncion',50,'Cabrera 10',3,3);
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` (
  `id_tutoria` int NOT NULL AUTO_INCREMENT,
  `Id_Curricula` int DEFAULT NULL,
  `Id_Profesor` int DEFAULT NULL,
  `Nombre_Materia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tutoria`),
  KEY `Id_Curricula` (`Id_Curricula`),
  KEY `Nombre_Materia` (`Nombre_Materia`),
  KEY `Id_Profesor` (`Id_Profesor`),
  CONSTRAINT `tutoria_ibfk_1` FOREIGN KEY (`Id_Curricula`) REFERENCES `materias` (`Id_Curricula`),
  CONSTRAINT `tutoria_ibfk_2` FOREIGN KEY (`Nombre_Materia`) REFERENCES `materias` (`Nombre_Materia`),
  CONSTRAINT `tutoria_ibfk_3` FOREIGN KEY (`Id_Profesor`) REFERENCES `profesor` (`Id_Profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutoria`
--

LOCK TABLES `tutoria` WRITE;
/*!40000 ALTER TABLE `tutoria` DISABLE KEYS */;
INSERT INTO `tutoria` VALUES (1,1,10,NULL),(2,1,11,NULL),(3,1,44,NULL);
/*!40000 ALTER TABLE `tutoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_administracion`
--

DROP TABLE IF EXISTS `view_administracion`;
/*!50001 DROP VIEW IF EXISTS `view_administracion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_administracion` AS SELECT 
 1 AS `Id_Alumno`,
 1 AS `Nombre`,
 1 AS `Apellido`,
 1 AS `id_profesor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_alumnos_profesor`
--

DROP TABLE IF EXISTS `vista_alumnos_profesor`;
/*!50001 DROP VIEW IF EXISTS `vista_alumnos_profesor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_alumnos_profesor` AS SELECT 
 1 AS `Id_Alumno`,
 1 AS `Nombre`,
 1 AS `Apellido`,
 1 AS `Edad`,
 1 AS `Direccion_Residencia`,
 1 AS `id_profesor`,
 1 AS `Nombre_Materia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_alumnos_tutoria`
--

DROP TABLE IF EXISTS `vista_alumnos_tutoria`;
/*!50001 DROP VIEW IF EXISTS `vista_alumnos_tutoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_alumnos_tutoria` AS SELECT 
 1 AS `Id_Alumno`,
 1 AS `Nombre`,
 1 AS `Apellido`,
 1 AS `Edad`,
 1 AS `Direccion_Residencia`,
 1 AS `Nombre_Materia`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'proyecto_colegio'
--

--
-- Dumping routines for database 'proyecto_colegio'
--
/*!50003 DROP FUNCTION IF EXISTS `ObtenerNombreDeAlumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerNombreDeAlumno`(alu INT) RETURNS varchar(100) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE Nom VARCHAR(100);
    DECLARE Apel VARCHAR(100);
    DECLARE NombreCompleto VARCHAR(200);
    
    SELECT Nombre,Apellido INTO Nom, Apel FROM alumnos WHERE Id_Alumno = alu;
    
   
	SET NombreCompleto = CONCAT(Nom, ' ', Apel);
    RETURN NombreCompleto;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ObtenerProfesorDeAlumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerProfesorDeAlumno`(alu INT) RETURNS varchar(300) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE respuesta VARCHAR(300) DEFAULT '';
    DECLARE profesor_nombre VARCHAR(45);
    DECLARE profesor_apellido VARCHAR(45);
    
    -- Manejar la situación en la que no se encuentra un profesor
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET respuesta = 'No se encontró el profesor para el alumno especificado';

    -- Seleccionar el nombre y apellido del profesor
    SELECT p.Nombre, p.Apellido
    INTO profesor_nombre, profesor_apellido
    FROM Alumnos a
    JOIN Profesor p ON a.id_profesor = p.Id_Profesor
    WHERE a.Id_Alumno = alu;

    -- Concatenar la respuesta si se encuentra el profesor
    IF respuesta = '' THEN
        SET respuesta = CONCAT('El profesor es ', profesor_nombre, ' ', profesor_apellido);
    END IF;

    RETURN respuesta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ObtenerProfesorMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ObtenerProfesorMateria`(Mat varchar(45)) RETURNS varchar(100) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE Nom VARCHAR(100);
    DECLARE Apel VARCHAR(100);
    DECLARE NombreCompleto VARCHAR(200);
    
    SELECT Nombre,Apellido INTO Nom, Apel FROM profesor WHERE Id_Curricula = Mat ;
    
	SET NombreCompleto = CONCAT(Nom, ' ', Apel);
    RETURN NombreCompleto;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAlumnos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAlumnos`( IN Id_Alum INT)
BEGIN
	SELECT * FROM alumnos where Id_Alumno= Id_Alum ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GuardarAlumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GuardarAlumno`( IN 
Id_Alum INT,
name varchar(50),
Apel varchar(50),
Ed int,
dire varchar(50),
id_prof int)
BEGIN
	INSERT INTO alumnos( Id_Alumno,Nombre,Apellido ,Edad  ,Direccion_Residencia ,id_profesor)
    VALUES(Id_Alum ,name ,Apel ,Ed ,dire ,id_prof );
	SELECT * FROM alumnos where Id_Alumno= Id_Alum ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_administracion`
--

/*!50001 DROP VIEW IF EXISTS `view_administracion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_administracion` AS select `alumnos`.`Id_Alumno` AS `Id_Alumno`,`alumnos`.`Nombre` AS `Nombre`,`alumnos`.`Apellido` AS `Apellido`,`alumnos`.`id_profesor` AS `id_profesor` from `alumnos` limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_alumnos_profesor`
--

/*!50001 DROP VIEW IF EXISTS `vista_alumnos_profesor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_alumnos_profesor` AS select `a`.`Id_Alumno` AS `Id_Alumno`,`a`.`Nombre` AS `Nombre`,`a`.`Apellido` AS `Apellido`,`a`.`Edad` AS `Edad`,`a`.`Direccion_Residencia` AS `Direccion_Residencia`,`a`.`id_profesor` AS `id_profesor`,`m`.`Nombre_Materia` AS `Nombre_Materia` from ((`alumnos` `a` join `profesor` `p` on((`a`.`id_profesor` = `p`.`Id_Profesor`))) join `materias` `m` on((`p`.`Id_Curricula` = `m`.`Id_Curricula`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_alumnos_tutoria`
--

/*!50001 DROP VIEW IF EXISTS `vista_alumnos_tutoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_alumnos_tutoria` AS select `a`.`Id_Alumno` AS `Id_Alumno`,`a`.`Nombre` AS `Nombre`,`a`.`Apellido` AS `Apellido`,`a`.`Edad` AS `Edad`,`a`.`Direccion_Residencia` AS `Direccion_Residencia`,`m`.`Nombre_Materia` AS `Nombre_Materia` from ((`alumnos` `a` join `calificaciones` `c` on((`a`.`Id_Alumno` = `c`.`Id_Alumno`))) join `materias` `m` on((`c`.`Id_Curricula` = `m`.`Id_Curricula`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-30  9:23:26

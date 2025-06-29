CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_biblioteca_202401
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `idAlumno` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `dni` char(8) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idPais` int NOT NULL,
  PRIMARY KEY (`idAlumno`),
  KEY `fk_alumno_pais_idx` (`idPais`),
  CONSTRAINT `fk_alumno_pais` FOREIGN KEY (`idPais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (1,'Elba Carlos','Flores Arcos','912345678','74859685','elbafloreso@gmail.com','2000-10-10','2022-04-04 10:59:04','2022-04-04 10:59:04',1,2),(2,'Juan Jorge','Quispe Llanos','998574858','87474747','juanPerez@gmail.com','2010-10-10','2022-04-04 10:59:07','2022-04-04 10:59:04',0,4),(3,'Pedro Luisa','Perez Gutarra','996857474','74859685','elbafloreso@gmail.com','2021-05-10','2022-04-04 10:59:05','2022-04-04 10:59:04',1,6);
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `idAutor` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idGrado` int NOT NULL,
  PRIMARY KEY (`idAutor`),
  KEY `fk_autor_grado_idx` (`idGrado`),
  CONSTRAINT `fk_autor_grado` FOREIGN KEY (`idGrado`) REFERENCES `grado_autor` (`idGrado`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Vargas','Llosa','2020-10-11','2022-04-04 11:59:07','912345678','2022-04-04 11:59:07',1,2),(2,'Cesar','Vallejo','1995-10-11','2022-04-04 11:59:07','998874747','2022-04-04 10:57:07',1,3);
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_libro`
--

DROP TABLE IF EXISTS `categoria_libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_libro` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_libro`
--

LOCK TABLES `categoria_libro` WRITE;
/*!40000 ALTER TABLE `categoria_libro` DISABLE KEYS */;
INSERT INTO `categoria_libro` VALUES (1,'Novela'),(2,'Cuento'),(3,'Poesía'),(4,'Enciclopedia');
/*!40000 ALTER TABLE `categoria_libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `idAlumno` int NOT NULL,
  `idUsuario` int NOT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `fechaDevolucion` datetime DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_devolucion_alumno1_idx` (`idAlumno`),
  KEY `fk_devolucion_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_devolucion_alumno1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_devolucion_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion_has_libro`
--

DROP TABLE IF EXISTS `devolucion_has_libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion_has_libro` (
  `idDevolucion` int NOT NULL,
  `idLibro` int NOT NULL,
  PRIMARY KEY (`idDevolucion`,`idLibro`),
  KEY `fk_devolucion_has_libro_libro1_idx` (`idLibro`),
  KEY `fk_devolucion_has_libro_devolucion_idx` (`idDevolucion`),
  CONSTRAINT `fk_devolucion_has_libro_devolucion` FOREIGN KEY (`idDevolucion`) REFERENCES `devolucion` (`idDevolucion`),
  CONSTRAINT `fk_devolucion_has_libro_libro1` FOREIGN KEY (`idLibro`) REFERENCES `libro` (`idLibro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion_has_libro`
--

LOCK TABLES `devolucion_has_libro` WRITE;
/*!40000 ALTER TABLE `devolucion_has_libro` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion_has_libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editorial` (
  `idEditorial` int NOT NULL AUTO_INCREMENT,
  `razonSocial` varchar(45) NOT NULL,
  `direccion` text NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `ruc` varchar(11) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idPais` int NOT NULL,
  PRIMARY KEY (`idEditorial`),
  KEY `fk_editorial_pais_idx` (`idPais`),
  CONSTRAINT `fk_editorial_pais` FOREIGN KEY (`idPais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editorial`
--

LOCK TABLES `editorial` WRITE;
/*!40000 ALTER TABLE `editorial` DISABLE KEYS */;
INSERT INTO `editorial` VALUES (1,'Isai Lazo','Av Lima 123','987485858','74859621414','1998-10-08','2022-04-04 10:59:07','2022-04-04 10:59:07',1,2),(2,'Editorial Lima','Av Tacna 747','987485888','10474747747','2024-04-30','2022-04-04 10:59:12','2022-04-04 10:59:07',1,4);
/*!40000 ALTER TABLE `editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grado_autor`
--

DROP TABLE IF EXISTS `grado_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grado_autor` (
  `idGrado` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGrado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grado_autor`
--

LOCK TABLES `grado_autor` WRITE;
/*!40000 ALTER TABLE `grado_autor` DISABLE KEYS */;
INSERT INTO `grado_autor` VALUES (1,'Técnico'),(2,'Profesional'),(3,'Magister'),(4,'Doctor');
/*!40000 ALTER TABLE `grado_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `idLibro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `anio` int NOT NULL,
  `serie` varchar(100) NOT NULL,
  `tema` varchar(45) NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idCategoria` int NOT NULL,
  PRIMARY KEY (`idLibro`),
  KEY `fk_libro_categoria_idx` (`idCategoria`),
  CONSTRAINT `fk_libro_categoria` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_libro` (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'Trilce',2020,'AAA1111111','Ciencia','2021-05-06 00:00:00','2021-05-06 00:00:00',1,1),(2,'Fuente Ovejuna',2021,'XS7474499888','Letras','2021-05-06 00:00:00','2021-05-06 00:00:00',1,2),(3,'La ciudad y los perros',2021,'VC8174132525','Letras','2021-05-06 00:00:00','2021-05-06 00:00:00',1,3);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro_tiene_autor`
--

DROP TABLE IF EXISTS `libro_tiene_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro_tiene_autor` (
  `lidLibro` int NOT NULL,
  `idAutor` int NOT NULL,
  PRIMARY KEY (`lidLibro`,`idAutor`),
  KEY `fk_libro_has_autor_autor1_idx` (`idAutor`),
  KEY `fk_libro_has_autor_libro_idx` (`lidLibro`),
  CONSTRAINT `fk_libro_has_autor_autor1` FOREIGN KEY (`idAutor`) REFERENCES `autor` (`idAutor`),
  CONSTRAINT `fk_libro_has_autor_libro` FOREIGN KEY (`lidLibro`) REFERENCES `libro` (`idLibro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro_tiene_autor`
--

LOCK TABLES `libro_tiene_autor` WRITE;
/*!40000 ALTER TABLE `libro_tiene_autor` DISABLE KEYS */;
INSERT INTO `libro_tiene_autor` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `libro_tiene_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalidad`
--

DROP TABLE IF EXISTS `modalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modalidad` (
  `idModalidad` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idModalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalidad`
--

LOCK TABLES `modalidad` WRITE;
/*!40000 ALTER TABLE `modalidad` DISABLE KEYS */;
INSERT INTO `modalidad` VALUES (1,'Físico'),(2,'Virtual');
/*!40000 ALTER TABLE `modalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcion`
--

DROP TABLE IF EXISTS `opcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcion` (
  `idOpcion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `ruta` text,
  `tipo` smallint DEFAULT NULL,
  PRIMARY KEY (`idOpcion`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcion`
--

LOCK TABLES `opcion` WRITE;
/*!40000 ALTER TABLE `opcion` DISABLE KEYS */;
INSERT INTO `opcion` VALUES 
(2, 'Registro Libro', '1', 'intranetRegistraLibro.jsp', 1),
(6, 'Registro Proveedor', '1', 'intranetRegistraProveedor.jsp', 1),
(13, 'CRUD Sala', '1', 'intranetCrudSala.jsp', 2),
(14, 'CRUD Proveedor', '1', 'intranetCrudProveedor.jsp', 2),
(21, 'Consulta Sala', '1', 'intranetConsultaSala.jsp', 3),
(22, 'Consulta Proveedor', '1', 'intranetConsultaProveedor.jsp', 3);
/*!40000 ALTER TABLE `opcion` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `idPais` int NOT NULL AUTO_INCREMENT,
  `iso` char(2) DEFAULT NULL,
  `nombre` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'AF','Afganistán'),(2,'AX','Islas Gland'),(3,'AL','Albania'),(4,'DE','Alemania'),(5,'AD','Andorra'),(6,'AO','Angola'),(7,'AI','Anguilla'),(8,'AQ','Antártida'),(9,'AG','Antigua y Barbuda'),(10,'AN','Antillas Holandesas'),(11,'SA','Arabia Saudí'),(12,'DZ','Argelia'),(13,'AR','Argentina'),(14,'AM','Armenia'),(15,'AW','Aruba'),(16,'AU','Australia'),(17,'AT','Austria'),(18,'AZ','Azerbaiyán'),(19,'BS','Bahamas'),(20,'BH','Bahréin'),(21,'BD','Bangladesh'),(22,'BB','Barbados'),(23,'BY','Bielorrusia'),(24,'BE','Bélgica'),(25,'BZ','Belice'),(26,'BJ','Benin'),(27,'BM','Bermudas'),(28,'BT','Bhután'),(29,'BO','Bolivia'),(30,'BA','Bosnia y Herzegovina'),(31,'BW','Botsuana'),(32,'BV','Isla Bouvet'),(33,'BR','Brasil'),(34,'BN','Brunéi'),(35,'BG','Bulgaria'),(36,'BF','Burkina Faso'),(37,'BI','Burundi'),(38,'CV','Cabo Verde'),(39,'KY','Islas Caimán'),(40,'KH','Camboya'),(41,'CM','Camerún'),(42,'CA','Canadá'),(43,'CF','República Centroafricana'),(44,'TD','Chad'),(45,'CZ','República Checa'),(46,'CL','Chile'),(47,'CN','China'),(48,'CY','Chipre'),(49,'CX','Isla de Navidad'),(50,'VA','Ciudad del Vaticano'),(51,'CC','Islas Cocos'),(52,'CO','Colombia'),(53,'KM','Comoras'),(54,'CD','República Democrática del Congo'),(55,'CG','Congo'),(56,'CK','Islas Cook'),(57,'KP','Corea del Norte'),(58,'KR','Corea del Sur'),(59,'CI','Costa de Marfil'),(60,'CR','Costa Rica'),(61,'HR','Croacia'),(62,'CU','Cuba'),(63,'DK','Dinamarca'),(64,'DM','Dominica'),(65,'DO','República Dominicana'),(66,'EC','Ecuador'),(67,'EG','Egipto'),(68,'SV','El Salvador'),(69,'AE','Emiratos Árabes Unidos'),(70,'ER','Eritrea'),(71,'SK','Eslovaquia'),(72,'SI','Eslovenia'),(73,'ES','España'),(74,'UM','Islas ultramarinas de Estados Unidos'),(75,'US','Estados Unidos'),(76,'EE','Estonia'),(77,'ET','Etiopía'),(78,'FO','Islas Feroe'),(79,'PH','Filipinas'),(80,'FI','Finlandia'),(81,'FJ','Fiyi'),(82,'FR','Francia'),(83,'GA','Gabón'),(84,'GM','Gambia'),(85,'GE','Georgia'),(86,'GS','Islas Georgias del Sur y Sandwich del Sur'),(87,'GH','Ghana'),(88,'GI','Gibraltar'),(89,'GD','Granada'),(90,'GR','Grecia'),(91,'GL','Groenlandia'),(92,'GP','Guadalupe'),(93,'GU','Guam'),(94,'GT','Guatemala'),(95,'GF','Guayana Francesa'),(96,'GN','Guinea'),(97,'GQ','Guinea Ecuatorial'),(98,'GW','Guinea-Bissau'),(99,'GY','Guyana'),(100,'HT','Haití'),(101,'HM','Islas Heard y McDonald'),(102,'HN','Honduras'),(103,'HK','Hong Kong'),(104,'HU','Hungría'),(105,'IN','India'),(106,'ID','Indonesia'),(107,'IR','Irán'),(108,'IQ','Iraq'),(109,'IE','Irlanda'),(110,'IS','Islandia'),(111,'IL','Israel'),(112,'IT','Italia'),(113,'JM','Jamaica'),(114,'JP','Japón'),(115,'JO','Jordania'),(116,'KZ','Kazajstán'),(117,'KE','Kenia'),(118,'KG','Kirguistán'),(119,'KI','Kiribati'),(120,'KW','Kuwait'),(121,'LA','Laos'),(122,'LS','Lesotho'),(123,'LV','Letonia'),(124,'LB','Líbano'),(125,'LR','Liberia'),(126,'LY','Libia'),(127,'LI','Liechtenstein'),(128,'LT','Lituania'),(129,'LU','Luxemburgo'),(130,'MO','Macao'),(131,'MK','ARY Macedonia'),(132,'MG','Madagascar'),(133,'MY','Malasia'),(134,'MW','Malawi'),(135,'MV','Maldivas'),(136,'ML','Malí'),(137,'MT','Malta'),(138,'FK','Islas Malvinas'),(139,'MP','Islas Marianas del Norte'),(140,'MA','Marruecos'),(141,'MH','Islas Marshall'),(142,'MQ','Martinica'),(143,'MU','Mauricio'),(144,'MR','Mauritania'),(145,'YT','Mayotte'),(146,'MX','México'),(147,'FM','Micronesia'),(148,'MD','Moldavia'),(149,'MC','Mónaco'),(150,'MN','Mongolia'),(151,'MS','Montserrat'),(152,'MZ','Mozambique'),(153,'MM','Myanmar'),(154,'NA','Namibia'),(155,'NR','Nauru'),(156,'NP','Nepal'),(157,'NI','Nicaragua'),(158,'NE','Níger'),(159,'NG','Nigeria'),(160,'NU','Niue'),(161,'NF','Isla Norfolk'),(162,'NO','Noruega'),(163,'NC','Nueva Caledonia'),(164,'NZ','Nueva Zelanda'),(165,'OM','Omán'),(166,'NL','Países Bajos'),(167,'PK','Pakistán'),(168,'PW','Palau'),(169,'PS','Palestina'),(170,'PA','Panamá'),(171,'PG','Papúa Nueva Guinea'),(172,'PY','Paraguay'),(173,'PE','Perú'),(174,'PN','Islas Pitcairn'),(175,'PF','Polinesia Francesa'),(176,'PL','Polonia'),(177,'PT','Portugal'),(178,'PR','Puerto Rico'),(179,'QA','Qatar'),(180,'GB','Reino Unido'),(181,'RE','Reunión'),(182,'RW','Ruanda'),(183,'RO','Rumania'),(184,'RU','Rusia'),(185,'EH','Sahara Occidental'),(186,'SB','Islas Salomón'),(187,'WS','Samoa'),(188,'AS','Samoa Americana'),(189,'KN','San Cristóbal y Nevis'),(190,'SM','San Marino'),(191,'PM','San Pedro y Miquelón'),(192,'VC','San Vicente y las Granadinas'),(193,'SH','Santa Helena'),(194,'LC','Santa Lucía'),(195,'ST','Santo Tomé y Príncipe'),(196,'SN','Senegal'),(197,'CS','Serbia y Montenegro'),(198,'SC','Seychelles'),(199,'SL','Sierra Leona'),(200,'SG','Singapur'),(201,'SY','Siria'),(202,'SO','Somalia'),(203,'LK','Sri Lanka'),(204,'SZ','Suazilandia'),(205,'ZA','Sudáfrica'),(206,'SD','Sudán'),(207,'SE','Suecia'),(208,'CH','Suiza'),(209,'SR','Surinam'),(210,'SJ','Svalbard y Jan Mayen'),(211,'TH','Tailandia'),(212,'TW','Taiwán'),(213,'TZ','Tanzania'),(214,'TJ','Tayikistán'),(215,'IO','Territorio Británico del Océano Índico'),(216,'TF','Territorios Australes Franceses'),(217,'TL','Timor Oriental'),(218,'TG','Togo'),(219,'TK','Tokelau'),(220,'TO','Tonga'),(221,'TT','Trinidad y Tobago'),(222,'TN','Túnez'),(223,'TC','Islas Turcas y Caicos'),(224,'TM','Turkmenistán'),(225,'TR','Turquía'),(226,'TV','Tuvalu'),(227,'UA','Ucrania'),(228,'UG','Uganda'),(229,'UY','Uruguay'),(230,'UZ','Uzbekistán'),(231,'VU','Vanuatu'),(232,'VE','Venezuela'),(233,'VN','Vietnam'),(234,'VG','Islas Vírgenes Británicas'),(235,'VI','Islas Vírgenes de los Estados Unidos'),(236,'WF','Wallis y Futuna'),(237,'YE','Yemen'),(238,'DJ','Yibuti'),(239,'ZM','Zambia'),(240,'ZW','Zimbabue');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `idPrestamo` int NOT NULL AUTO_INCREMENT,
  `fechaPrestamo` datetime DEFAULT NULL,
  `fechaDevolucion` datetime DEFAULT NULL,
  `idAlumno` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idPrestamo`),
  KEY `fk_prestamo_alumno1_idx` (`idAlumno`),
  KEY `fk_prestamo_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_prestamo_alumno1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_prestamo_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo_tiene_libro`
--

DROP TABLE IF EXISTS `prestamo_tiene_libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo_tiene_libro` (
  `idPrestamo` int NOT NULL,
  `idLibro` int NOT NULL,
  PRIMARY KEY (`idPrestamo`,`idLibro`),
  KEY `fk_prestamo_has_libro_libro1_idx` (`idLibro`),
  KEY `fk_prestamo_has_libro_prestamo1_idx` (`idPrestamo`),
  CONSTRAINT `fk_prestamo_has_libro_libro1` FOREIGN KEY (`idLibro`) REFERENCES `libro` (`idLibro`),
  CONSTRAINT `fk_prestamo_has_libro_prestamo1` FOREIGN KEY (`idPrestamo`) REFERENCES `prestamo` (`idPrestamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo_tiene_libro`
--

LOCK TABLES `prestamo_tiene_libro` WRITE;
/*!40000 ALTER TABLE `prestamo_tiene_libro` DISABLE KEYS */;
/*!40000 ALTER TABLE `prestamo_tiene_libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(100) NOT NULL,
  `ruc` char(11) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `celular` char(9) NOT NULL,
  `contacto` varchar(200) NOT NULL,
  `estado` smallint NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `idPais` int NOT NULL,
  PRIMARY KEY (`idProveedor`),
  KEY `fk_proveedor_pais_idx` (`idPais`),
  CONSTRAINT `fk_proveedor_pais` FOREIGN KEY (`idPais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Lumbreras','74747478845','Av Lima 141','','Juan Vargas',1,'2022-04-04 10:59:05','2021-05-06 00:00:00',1),(2,'Libun','98747474325','Av Lima 874','','Luis Quispe',1,'2022-04-04 10:59:07','2021-05-06 00:00:00',2);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revista`
--

DROP TABLE IF EXISTS `revista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revista` (
  `idRevista` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `frecuencia` varchar(200) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idModalidad` int NOT NULL,
  PRIMARY KEY (`idRevista`),
  KEY `fk_revista_modalidad_idx` (`idModalidad`),
  CONSTRAINT `fk_revista_modalidad` FOREIGN KEY (`idModalidad`) REFERENCES `modalidad` (`idModalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revista`
--

LOCK TABLES `revista` WRITE;
/*!40000 ALTER TABLE `revista` DISABLE KEYS */;
INSERT INTO `revista` VALUES (1,'Gente','Semanal Todos los miércoles','2021-05-06','2021-05-06 00:00:00',1,1),(3,'Etiqueta Negra','Semanal Todos los lunes','2021-05-06','2021-05-06 00:00:00',1,2);
/*!40000 ALTER TABLE `revista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'Bibliotecologo','1');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_has_opcion`
--

DROP TABLE IF EXISTS `rol_has_opcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_has_opcion` (
  `idrol` int NOT NULL,
  `idopcion` int NOT NULL,
  PRIMARY KEY (`idrol`,`idopcion`),
  KEY `fk_rol_has_opcion_opcion1_idx` (`idopcion`),
  KEY `fk_rol_has_opcion_rol1_idx` (`idrol`),
  CONSTRAINT `fk_rol_has_opcion_opcion1` FOREIGN KEY (`idopcion`) REFERENCES `opcion` (`idOpcion`),
  CONSTRAINT `fk_rol_has_opcion_rol1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_has_opcion`
--

LOCK TABLES `rol_has_opcion` WRITE;
/*!40000 ALTER TABLE `rol_has_opcion` DISABLE KEYS */;
INSERT INTO `rol_has_opcion` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27);
/*!40000 ALTER TABLE `rol_has_opcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sala` (
  `idSala` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(45) NOT NULL,
  `piso` int NOT NULL,
  `numAlumnos` int NOT NULL,
  `recursos` text NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `idSede` int NOT NULL,
  PRIMARY KEY (`idSala`),
  KEY `fk_sala_sede_idx` (`idSede`),
  CONSTRAINT `fk_sala_sede` FOREIGN KEY (`idSede`) REFERENCES `sede` (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (1,'A001',1,10,'tablet plumones','2021-05-06 00:00:00',1,'2021-05-06 00:00:00',1),(2,'A002',1,3,'tablet plumones','2021-05-06 00:00:00',1,'2021-05-06 00:00:00',4),(3,'A003',2,2,'tablet plumones','2021-05-06 00:00:00',1,'2021-05-06 00:00:00',5);
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sede`
--

DROP TABLE IF EXISTS `sede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sede` (
  `idSede` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sede`
--

LOCK TABLES `sede` WRITE;
/*!40000 ALTER TABLE `sede` DISABLE KEYS */;
INSERT INTO `sede` VALUES (1,'Lima'),(2,'Arequipa'),(3,'Ayacucho'),(4,'Centro'),(5,'San Miguel'),(6,'Miraflores'),(7,'Independencia');
/*!40000 ALTER TABLE `sede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `separacion`
--

DROP TABLE IF EXISTS `separacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `separacion` (
  `idSeparacion` int NOT NULL AUTO_INCREMENT,
  `fechaSeparacion` datetime DEFAULT NULL,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `estado` smallint DEFAULT NULL,
  `idAlumno` int NOT NULL,
  `idSala` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idSeparacion`),
  KEY `fk_separacion_alumno1_idx` (`idAlumno`),
  KEY `fk_separacion_sala1_idx` (`idSala`),
  KEY `fk_separacion_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_separacion_alumno1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_separacion_sala1` FOREIGN KEY (`idSala`) REFERENCES `sala` (`idSala`),
  CONSTRAINT `fk_separacion_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `separacion`
--

LOCK TABLES `separacion` WRITE;
/*!40000 ALTER TABLE `separacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `separacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tesis`
--

DROP TABLE IF EXISTS `tesis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tesis` (
  `idTesis` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `tema` varchar(200) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  `estado` smallint NOT NULL,
  `idAlumno` int NOT NULL,
  PRIMARY KEY (`idTesis`),
  KEY `fk_tesis_alumno_idx` (`idAlumno`),
  CONSTRAINT `fk_tesis_alumno` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tesis`
--

LOCK TABLES `tesis` WRITE;
/*!40000 ALTER TABLE `tesis` DISABLE KEYS */;
INSERT INTO `tesis` VALUES (1,'Sistema de Redes neuronales aplicado a los colegios','Sistemas','2021-05-10','2022-04-04 10:59:04','2021-05-06 00:00:00',1,1),(2,'Sistema de inteligencia artificial aplicado al gobierno','Sistemas','2021-05-10','2022-04-04 10:59:04','2021-05-06 00:00:00',1,3);
/*!40000 ALTER TABLE `tesis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `login` varchar(15) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `direccion` text,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idUsuario_UNIQUE` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;

INSERT INTO `usuario` VALUES 
(1,'Jose Roberto','La rosa Ledezma','74747474','jose','jose','jose@gmail.com','2022-04-04 10:59:07','2000-10-10','Av Lima 123'),
(2,'Angel Daniel','Pintado Nizama','12345678','angel','angel','angel@gmail.com','2023-03-12 09:15:23','1995-05-16','Calle Ficticia 456'),
(3,'Matias','Becerra Acosta','87654321','matias','matias','matias@gmail.com','2023-01-22 11:30:01','1998-07-22','Av. Siempre Viva 789'),
(4,'Jhonatan','Villalobos Taqquere','11223344','jhonatan','jhonatan','jhonatan@gmail.com','2023-02-15 14:20:45','1997-11-30','Calle 45 101');


/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `usuario_has_rol`
--

DROP TABLE IF EXISTS `usuario_has_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_has_rol` (
  `idUsuario` int NOT NULL,
  `idRol` int NOT NULL,
  PRIMARY KEY (`idUsuario`,`idRol`),
  KEY `fk_usuario_has_rol_rol1_idx` (`idRol`),
  KEY `fk_usuario_has_rol_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_usuario_has_rol_rol1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`),
  CONSTRAINT `fk_usuario_has_rol_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_has_rol`
--

LOCK TABLES `usuario_has_rol` WRITE;
/*!40000 ALTER TABLE `usuario_has_rol` DISABLE KEYS */;
INSERT INTO `usuario_has_rol` VALUES (1,1);
/*!40000 ALTER TABLE `usuario_has_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database ''
--

--
-- Dumping routines for database ''
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-31 18:54:54



-- Crear tabla para las solicitudes de administrador
CREATE TABLE IF NOT EXISTS admin_request (
    id_request INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'PENDIENTE', -- PENDIENTE, APROBADA, RECHAZADA
    fecha_respuesta TIMESTAMP NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario)
);

-- Indices
CREATE INDEX idx_admin_request_usuario ON admin_request(id_usuario);
CREATE INDEX idx_admin_request_estado ON admin_request(estado);


INSERT INTO `rol` (`idRol`, `nombre`, `estado`) 
VALUES (2, 'Usuario', '1');





INSERT INTO `libro` (`idLibro`, `titulo`, `anio`, `serie`, `tema`, `fechaRegistro`, `fechaActualizacion`, `estado`, `idCategoria`) VALUES
(4, 'Cien Años de Soledad', 2021, 'CA1000001', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(5, 'El Quijote', 2021, 'EQ1000002', 'Clásicos', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(6, 'Rayuela', 2021, 'RA1000003', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(7, 'Pedro Páramo', 2021, 'PP1000004', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(8, 'Ficciones', 2021, 'FI1000005', 'Cuento', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(9, 'El Aleph', 2021, 'EA1000006', 'Cuento', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(10, 'La Casa de los Espíritus', 2021, 'CE1000007', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(11, 'Crónica de una Muerte Anunciada', 2021, 'CM1000008', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(12, 'Los Detectives Salvajes', 2021, 'DS1000009', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(13, '2666', 2021, 'TS1000010', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(14, 'El Amor en los Tiempos del Cólera', 2021, 'AC1000011', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(15, 'La Sombra del Viento', 2021, 'SV1000012', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(16, 'Marina', 2021, 'MA1000013', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(17, 'El Príncipe', 2021, 'EP1000014', 'Política', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(18, 'Utopía', 2021, 'UT1000015', 'Política', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(19, '1984', 2021, 'NO1000016', 'Ciencia Ficción', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(20, 'Rebelión en la Granja', 2021, 'RG1000017', 'Ciencia Ficción', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(21, 'Fahrenheit 451', 2021, 'FH1000018', 'Ciencia Ficción', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(22, 'Ensayo sobre la Ceguera', 2021, 'EC1000019', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(23, 'Memorias de una Geisha', 2021, 'MG1000020', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(24, 'Los Pilares de la Tierra', 2021, 'PT1000021', 'Histórica', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(25, 'Un Mundo Feliz', 2021, 'UF1000022', 'Ciencia Ficción', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(26, 'La Ladrona de Libros', 2021, 'LL1000023', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(27, 'El Niño con el Pijama de Rayas', 2021, 'NP1000024', 'Narrativa', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(28, 'La Catedral del Mar', 2021, 'CM1000025', 'Histórica', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(29, 'Inferno', 2021, 'IN1000026', 'Suspense', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(30, 'Ángeles y Demonios', 2021, 'AD1000027', 'Suspense', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3),
(31, 'El Código Da Vinci', 2021, 'CD1000028', 'Suspense', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 1),
(32, 'La Chica del Tren', 2021, 'CT1000029', 'Suspense', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 2),
(33, 'El Psicoanalista', 2021, 'PS1000030', 'Suspense', '2021-05-06 00:00:00', '2021-05-06 00:00:00', 1, 3);

--------------------------------------------------------------------
INSERT INTO `alumno` (`nombres`, `apellidos`, `telefono`, `dni`, `correo`, `fechaNacimiento`, `fechaRegistro`, `fechaActualizacion`, `estado`, `idPais`) VALUES
('María Fernanda', 'Gómez Ruiz', '912000001', '70000001', 'maria.fernanda@gmail.com', '2001-03-15', NOW(), NOW(), 1, 1),
('Luis Alberto', 'Martínez Castro', '912000002', '70000002', 'luis.alberto@gmail.com', '2002-07-22', NOW(), NOW(), 1, 2),
('Camila Andrea', 'Torres López', '912000003', '70000003', 'camila.andrea@gmail.com', '2003-05-11', NOW(), NOW(), 1, 3),
('Jorge Antonio', 'Ramírez Flores', '912000004', '70000004', 'jorge.antonio@gmail.com', '2000-09-25', NOW(), NOW(), 1, 4),
('Andrea Lucía', 'Pérez Vargas', '912000005', '70000005', 'andrea.lucia@gmail.com', '2001-12-30', NOW(), NOW(), 1, 5),
('Ricardo Javier', 'Sánchez Díaz', '912000006', '70000006', 'ricardo.javier@gmail.com', '1999-06-18', NOW(), NOW(), 1, 6),
('Valentina Sofía', 'Morales Peña', '912000007', '70000007', 'valentina.sofia@gmail.com', '2002-04-05', NOW(), NOW(), 1, 1),
('Daniel Felipe', 'Herrera Campos', '912000008', '70000008', 'daniel.felipe@gmail.com', '2001-08-14', NOW(), NOW(), 1, 2),
('Gabriela Mariana', 'Rojas Núñez', '912000009', '70000009', 'gabriela.mariana@gmail.com', '2003-01-23', NOW(), NOW(), 1, 3),
('Carlos Eduardo', 'Reyes Medina', '912000010', '70000010', 'carlos.eduardo@gmail.com', '1998-11-09', NOW(), NOW(), 1, 4),
('Sofía Isabel', 'Mendoza Salas', '912000011', '70000011', 'sofia.isabel@gmail.com', '2000-02-27', NOW(), NOW(), 1, 5),
('Diego Sebastián', 'Cárdenas Paredes', '912000012', '70000012', 'diego.sebastian@gmail.com', '2002-10-13', NOW(), NOW(), 1, 6),
('Natalia Alejandra', 'Guerrero Silva', '912000013', '70000013', 'natalia.alejandra@gmail.com', '2001-07-08', NOW(), NOW(), 1, 1),
('Juan Pablo', 'Cruz Rivas', '912000014', '70000014', 'juan.pablo@gmail.com', '1999-12-19', NOW(), NOW(), 1, 2),
('Paula Andrea', 'Castillo León', '912000015', '70000015', 'paula.andrea@gmail.com', '2003-05-29', NOW(), NOW(), 1, 3),
('Andrés Nicolás', 'Ortega Lozano', '912000016', '70000016', 'andres.nicolas@gmail.com', '2000-09-03', NOW(), NOW(), 1, 4),
('Mariana Victoria', 'Salazar Palacios', '912000017', '70000017', 'mariana.victoria@gmail.com', '2002-11-16', NOW(), NOW(), 1, 5),
('Miguel Ángel', 'Luna Escobar', '912000018', '70000018', 'miguel.angel@gmail.com', '2001-06-21', NOW(), NOW(), 1, 6),
('Isabella Renata', 'Campos Ibáñez', '912000019', '70000019', 'isabella.renata@gmail.com', '2003-02-12', NOW(), NOW(), 1, 1),
('Santiago Matías', 'Peña Aguilar', '912000020', '70000020', 'santiago.matias@gmail.com', '1999-10-04', NOW(), NOW(), 1, 2),
('Emma Julieta', 'Moreno Fuentes', '912000021', '70000021', 'emma.julieta@gmail.com', '2000-08-20', NOW(), NOW(), 1, 3),
('Leonardo Joaquín', 'Vega Bustos', '912000022', '70000022', 'leonardo.joaquin@gmail.com', '2002-05-02', NOW(), NOW(), 1, 4),
('Victoria Antonella', 'Navarro Guevara', '912000023', '70000023', 'victoria.antonella@gmail.com', '2001-12-07', NOW(), NOW(), 1, 5),
('Martín Emilio', 'Ramos Villanueva', '912000024', '70000024', 'martin.emilio@gmail.com', '2003-03-26', NOW(), NOW(), 1, 6),
('Antonella Paulina', 'Ponce Serrano', '912000025', '70000025', 'antonella.paulina@gmail.com', '2000-07-31', NOW(), NOW(), 1, 1),
('Tomás Ignacio', 'Muñoz Andrade', '912000026', '70000026', 'tomas.ignacio@gmail.com', '1998-01-15', NOW(), NOW(), 1, 2),
('Luciana Elisa', 'Sosa Zambrano', '912000027', '70000027', 'luciana.elisa@gmail.com', '2002-09-28', NOW(), NOW(), 1, 3),
('Emilio Benjamín', 'Figueroa Mora', '912000028', '70000028', 'emilio.benjamin@gmail.com', '2001-04-10', NOW(), NOW(), 1, 4),
('María José', 'Araya Cárdenas', '912000029', '70000029', 'maria.jose@gmail.com', '2003-11-01', NOW(), NOW(), 1, 5),
('Benjamín Samuel', 'Campos Pizarro', '912000030', '70000030', 'benjamin.samuel@gmail.com', '2000-06-06', NOW(), NOW(), 1, 6);








--  Cuidado: esto significa que cada vez que borres un alumno, también se borrarán todos sus registros de tesis automáticamente.
ALTER TABLE tesis
DROP FOREIGN KEY fk_tesis_alumno;

ALTER TABLE tesis
ADD CONSTRAINT fk_tesis_alumno
FOREIGN KEY (idAlumno)
REFERENCES alumno (idAlumno)
ON DELETE CASCADE;

INSERT INTO `rol` (`idRol`, `nombre`, `estado`) VALUES
(1, 'Bibliotecologo', '1'),
(2, 'Administrador', '1'),
(3, 'Usuario', '1')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre), estado=VALUES(estado);



	SELECT * FROM rol;

DELETE FROM usuario_has_rol WHERE idRol NOT IN (1,2,3);


SELECT * FROM usuario_has_rol;



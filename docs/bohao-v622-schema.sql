-- MySQL dump 10.13  Distrib 5.7.44, for Win64 (x86_64)
--
-- Host: localhost    Database: bohaosupermarket3
-- ------------------------------------------------------
-- Server version	5.7.44

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
-- Table structure for table `abono`
--

DROP TABLE IF EXISTS `abono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abono` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FacturaNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonoarticulo`
--

DROP TABLE IF EXISTS `abonoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonoarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonodiariolista`
--

DROP TABLE IF EXISTS `abonodiariolista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonodiariolista` (
  `Fecha` date NOT NULL,
  `DiarioListaNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonoivatotal`
--

DROP TABLE IF EXISTS `abonoivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonoivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonoproveedor`
--

DROP TABLE IF EXISTS `abonoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonoproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonoproveedorarticulo`
--

DROP TABLE IF EXISTS `abonoproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonoproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abonoproveedorivatotal`
--

DROP TABLE IF EXISTS `abonoproveedorivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonoproveedorivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adjunto`
--

DROP TABLE IF EXISTS `adjunto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adjunto` (
  `AdjuntoID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Tipo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Titulo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ObjetoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ObjetoID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `BinaryID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`AdjuntoID`),
  KEY `BinaryID` (`BinaryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adjuntotemp`
--

DROP TABLE IF EXISTS `adjuntotemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adjuntotemp` (
  `AdjuntoID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Tipo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Titulo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ObjetoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ObjetoID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `BinaryID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`AdjuntoID`),
  KEY `BinaryID` (`BinaryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agente`
--

DROP TABLE IF EXISTS `agente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agente` (
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Contrasena` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'b59c67bf196a4758191e42f76670ceba',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AgenteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agenteclase`
--

DROP TABLE IF EXISTS `agenteclase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agenteclase` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Comision` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PoderesPrecioUsado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `TabletaPoderes` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreGrupo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albaran`
--

DROP TABLE IF EXISTS `albaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albaran` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `AbonoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CobroTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Cobrado` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albaranarticulo`
--

DROP TABLE IF EXISTS `albaranarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albaranarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albaranivatotal`
--

DROP TABLE IF EXISTS `albaranivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albaranivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albaranproveedor`
--

DROP TABLE IF EXISTS `albaranproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albaranproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albaranproveedorarticulo`
--

DROP TABLE IF EXISTS `albaranproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albaranproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacen` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SoloSubTienda` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AlmacenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `almacencloud`
--

DROP TABLE IF EXISTS `almacencloud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacencloud` (
  `AlmacenID` smallint(5) NOT NULL DEFAULT '0',
  `NombreES` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SoloSubTienda` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AlmacenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `almacenmovimiento`
--

DROP TABLE IF EXISTS `almacenmovimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenmovimiento` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AlmacenOrigenID` smallint(5) NOT NULL DEFAULT '1',
  `AlmacenDestinoID` smallint(5) NOT NULL DEFAULT '1',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `almacenmovimientoarticulo`
--

DROP TABLE IF EXISTS `almacenmovimientoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenmovimientoarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archivoconfiguracion`
--

DROP TABLE IF EXISTS `archivoconfiguracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivoconfiguracion` (
  `NombreID` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Familia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Configuracion` longtext COLLATE utf8mb4_unicode_ci,
  `ContenidoMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`NombreID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Prop1Titulo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Prop2Titulo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` tinyint(4) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Descripcion` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PrecioDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioDomicilio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioSocio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioMayor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioFactura` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioInternet` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioAmigo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioEspecial` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioOferta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadPorUnidad` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `CantidadPorUnidad2` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `VolumenPeso` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `UnidadUsarRegla` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `UnidadNombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `FechaPrecioCoste` date DEFAULT NULL,
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FechaCaducada` date DEFAULT NULL,
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Oferta` tinyint(1) NOT NULL DEFAULT '0',
  `Privado` tinyint(1) NOT NULL DEFAULT '0',
  `UsarPrecioPorCantidad` tinyint(1) NOT NULL DEFAULT '0',
  `UsarDescuentoPorCantidad` tinyint(1) NOT NULL DEFAULT '0',
  `Precio1` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Cantidad1` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Precio2` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Cantidad2` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Precio3` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Cantidad3` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Precio4` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento4` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Cantidad4` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Precio5` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento5` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Cantidad5` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Precio6` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento6` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Nombre1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre3` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre4` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre5` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre6` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre7` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre8` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre9` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SitioEnAlmacen` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SitioEnEstante` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `MiniStock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `MaxiStock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `DibujoID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Recomendado` tinyint(1) NOT NULL DEFAULT '0',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `AliIngrediente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliPesoTotal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliPesoNeto` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliFechaCaducada` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliLugarFabricante` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliImportador` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliNumeroSanitario` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliNumeroLote` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AliAdjuncion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `MultiCodigo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenNoFinal` bigint(20) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ArticuloID`),
  KEY `CodigoBarra` (`CodigoBarra`),
  KEY `ClaseID` (`ClaseID`),
  KEY `DibujoID` (`DibujoID`),
  KEY `OrdenNoFinal` (`OrdenNoFinal`),
  KEY `OrdenNo` (`OrdenNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloclase`
--

DROP TABLE IF EXISTS `articuloclase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloclase` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVAID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento4` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento5` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento6` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento7` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento8` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento9` decimal(5,2) NOT NULL DEFAULT '0.00',
  `TicketDescuentoUsarRegla` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `UnidadUsarRegla` smallint(5) unsigned NOT NULL DEFAULT '0',
  `UnidadNombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ContarGanancias` tinyint(1) NOT NULL DEFAULT '0',
  `ContarVolumenPeso` tinyint(1) NOT NULL DEFAULT '0',
  `StockBloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `PadreGrupo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `ClienteInvisible` tinyint(1) NOT NULL DEFAULT '0',
  `Oferta` tinyint(1) NOT NULL DEFAULT '0',
  `Privado` tinyint(1) NOT NULL DEFAULT '0',
  `ArticuloTipo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre1` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre2` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre3` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre4` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre5` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre6` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre7` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre8` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre9` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PrecioDetalleGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioDomicilioGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioSocioGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioMayorGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioFacturaGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioInternetGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioAmigoGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioEspecialGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioOfertaGananciaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloclaseorden`
--

DROP TABLE IF EXISTS `articuloclaseorden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloclaseorden` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `OrdenNo` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ClaseID`),
  UNIQUE KEY `OrdenNo` (`OrdenNo`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articulocodigobarra`
--

DROP TABLE IF EXISTS `articulocodigobarra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulocodigobarra` (
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CodigoBarra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articulodibujo`
--

DROP TABLE IF EXISTS `articulodibujo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulodibujo` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DibujoMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DibujoID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ArticuloID`,`DibujoMD5`),
  KEY `DibujoID` (`DibujoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloeliminado`
--

DROP TABLE IF EXISTS `articuloeliminado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloeliminado` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Fecha` datetime DEFAULT NULL,
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloextra`
--

DROP TABLE IF EXISTS `articuloextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloextra` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ConsultaParcial` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Signo` tinyint(1) NOT NULL DEFAULT '-1',
  `TiempoSigno` datetime DEFAULT NULL,
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PrecioPrivado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`ArticuloID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloorden`
--

DROP TABLE IF EXISTS `articuloorden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloorden` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenNo` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ArticuloID`),
  UNIQUE KEY `OrdenNo` (`OrdenNo`)
) ENGINE=InnoDB AUTO_INCREMENT=1672 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloprecioconsulta`
--

DROP TABLE IF EXISTS `articuloprecioconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloprecioconsulta` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Vez` int(10) unsigned NOT NULL DEFAULT '0',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ArticuloID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articulopreciocoste`
--

DROP TABLE IF EXISTS `articulopreciocoste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulopreciocoste` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioFinal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Fecha` datetime DEFAULT NULL,
  KEY `ArticuloID` (`ArticuloID`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articuloprop`
--

DROP TABLE IF EXISTS `articuloprop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articuloprop` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropIndex` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `PropID` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ArticuloID`,`PropIndex`,`PropID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articulotiempoultimousar`
--

DROP TABLE IF EXISTS `articulotiempoultimousar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulotiempoultimousar` (
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PrecioPrivado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `TiempoUltimoUsar` datetime DEFAULT NULL,
  PRIMARY KEY (`ArticuloID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bartender`
--

DROP TABLE IF EXISTS `bartender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bartender` (
  `BarTenderID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Family` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FormatFile` longtext COLLATE utf8mb4_unicode_ci,
  `FormatMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`BarTenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `binaryfile`
--

DROP TABLE IF EXISTS `binaryfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `binaryfile` (
  `BinaryID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FileName` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `FileExt` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `FileMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `BinaryFile` longblob,
  `Shared` tinyint(1) NOT NULL DEFAULT '-1',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`BinaryID`),
  KEY `FileMD5` (`FileMD5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenaentrada`
--

DROP TABLE IF EXISTS `cadenaentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenaentrada` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaSalidaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaEntradaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Cargado` tinyint(1) NOT NULL DEFAULT '0',
  `Descargado` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenaentradaarticulo`
--

DROP TABLE IF EXISTS `cadenaentradaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenaentradaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenamovimiento`
--

DROP TABLE IF EXISTS `cadenamovimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenamovimiento` (
  `DocumentoNo` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaSalidaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaEntradaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `CadenaSalidaNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CadenaEntradaNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `ArticuloXML` longtext COLLATE utf8mb4_unicode_ci,
  `BinaryID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ArticuloXMLMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ZipFormato` enum('NONE','7Z','BZ2','ZIP') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenasalida`
--

DROP TABLE IF EXISTS `cadenasalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenasalida` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaSalidaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `CadenaTiendaEntradaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Cargado` tinyint(1) NOT NULL DEFAULT '0',
  `Descargado` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenasalidaarticulo`
--

DROP TABLE IF EXISTS `cadenasalidaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenasalidaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cadenatienda`
--

DROP TABLE IF EXISTS `cadenatienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cadenatienda` (
  `CadenaTiendaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IP` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IPFijo` tinyint(1) NOT NULL DEFAULT '0',
  `PuertoDB` int(10) unsigned NOT NULL DEFAULT '0',
  `PuertoHTTP` int(10) unsigned NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CadenaTiendaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cajon`
--

DROP TABLE IF EXISTS `cajon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajon` (
  `CajonID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Saldo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `SoloSaldo` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CajonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cajonimpexp`
--

DROP TABLE IF EXISTS `cajonimpexp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajonimpexp` (
  `CajonImpExpNo` int(10) unsigned NOT NULL DEFAULT '0',
  `CajonID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ImpExpEspecial` tinyint(1) NOT NULL DEFAULT '0',
  `Fecha` datetime DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CajonImpExpNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NumeroIVA` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Sexo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Cumpleano` date DEFAULT NULL,
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaSDIID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `FacturaCEC` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `BancoCuentaNo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NecesitaFactura` tinyint(1) NOT NULL DEFAULT '0',
  `AutoEmailDocumento` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoSerie` tinyint(3) NOT NULL DEFAULT '0',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `MaxSobregiro` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `SerSocio` tinyint(1) NOT NULL DEFAULT '0',
  `TarjetaSocioID` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ChinoProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `Extrajero` tinyint(1) NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `LoginEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `ImprimirArticuloOrden` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`),
  UNIQUE KEY `TarjetaSocioID` (`TarjetaSocioID`),
  KEY `ClaseID` (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clienteclase`
--

DROP TABLE IF EXISTS `clienteclase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clienteclase` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) NOT NULL DEFAULT '-1',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `NecesitaFactura` tinyint(1) NOT NULL DEFAULT '0',
  `AutoEmailDocumento` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoSerie` tinyint(3) NOT NULL DEFAULT '0',
  `MaxSobregiro` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `SerSocio` tinyint(1) NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ChinoProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `Extrajero` tinyint(1) NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ImprimirArticuloOrden` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Privado` tinyint(1) NOT NULL DEFAULT '0',
  `ArticuloClaseInvisible` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PadreGrupo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientediariototal`
--

DROP TABLE IF EXISTS `clientediariototal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientediariototal` (
  `Fecha` date NOT NULL,
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Vez` int(10) unsigned NOT NULL DEFAULT '0',
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`Fecha`),
  KEY `EmpresaID` (`EmpresaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clienteextra`
--

DROP TABLE IF EXISTS `clienteextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clienteextra` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `TiempoUltimoUsar` datetime DEFAULT NULL,
  `ConsultaParcial` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Signo` tinyint(1) NOT NULL DEFAULT '-1',
  `TiempoSigno` datetime DEFAULT NULL,
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmpresaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientelogin`
--

DROP TABLE IF EXISTS `clientelogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientelogin` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LoginID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Contrasena` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LastLoginTime` datetime DEFAULT NULL,
  `LastLoginInfo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`,`Nombre`),
  UNIQUE KEY `LoginID` (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientesucursal`
--

DROP TABLE IF EXISTS `clientesucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientesucursal` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`,`SucursalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cobro`
--

DROP TABLE IF EXISTS `cobro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cobro` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoOriginalTipo` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOriginalNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `PagoFormaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `codigobarrabalanza`
--

DROP TABLE IF EXISTS `codigobarrabalanza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codigobarrabalanza` (
  `CodigoBarraBalanza` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreES` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CodigoBarraBalanza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultatipo`
--

DROP TABLE IF EXISTS `consultatipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultatipo` (
  `ConsultaTipoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ConsultaTipoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Country3L` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryNo` int(10) NOT NULL DEFAULT '0',
  `NameEN` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NameCN` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SearchInfo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CountryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cupon`
--

DROP TABLE IF EXISTS `cupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cupon` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `Localizador` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `MiniImporte` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaInicio` date DEFAULT NULL,
  `FechaCaducada` date DEFAULT NULL,
  `CreadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TiempoCreado` datetime DEFAULT NULL,
  `TiendasCadenaIDCreado` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Usado` tinyint(1) NOT NULL DEFAULT '0',
  `UsadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TiempoUsado` datetime DEFAULT NULL,
  `TiendasCadenaIDUsado` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currencyrate`
--

DROP TABLE IF EXISTS `currencyrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencyrate` (
  `CurrencyRateID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EUR` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `USD` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `CNY` decimal(12,4) NOT NULL DEFAULT '1.0000',
  PRIMARY KEY (`CurrencyRateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dbsql`
--

DROP TABLE IF EXISTS `dbsql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbsql` (
  `SQLID` int(10) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SQLContenido` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SQLID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ProgramID` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ActiveType` tinyint(4) NOT NULL DEFAULT '0',
  `ExpireDateValue` int(11) unsigned NOT NULL DEFAULT '0',
  `SoftRegInfo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceName` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceAlias` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `AuthCode` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Actived` tinyint(1) NOT NULL DEFAULT '0',
  `ActiveCode` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SystemInfo` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Comments` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`DeviceUUID`,`ProgramID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolucion` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CobroTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `CajonID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `AbonoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Cobrado` tinyint(1) NOT NULL DEFAULT '-1',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devolucionarticulo`
--

DROP TABLE IF EXISTS `devolucionarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolucionarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devolucionproveedor`
--

DROP TABLE IF EXISTS `devolucionproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolucionproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devolucionproveedorarticulo`
--

DROP TABLE IF EXISTS `devolucionproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolucionproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dibujo`
--

DROP TABLE IF EXISTS `dibujo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dibujo` (
  `DibujoID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Dibujo` longblob,
  PRIMARY KEY (`DibujoID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentclouded`
--

DROP TABLE IF EXISTS `documentclouded`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentclouded` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoNoEnSubTienda` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `SubTiendaDB` tinyint(1) NOT NULL DEFAULT '0',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SubTiendaID`,`DocumentoTipo`,`DocumentoNoEnSubTienda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentlog`
--

DROP TABLE IF EXISTS `documentlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentlog` (
  `LogID` bigint(20) unsigned NOT NULL,
  `SubLogID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `LogTime` datetime DEFAULT NULL,
  `LogUser` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LogKey` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`SubLogID`),
  KEY `LogID` (`LogID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentointercambio`
--

DROP TABLE IF EXISTS `documentointercambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentointercambio` (
  `DocumentoNo` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `DocCount` int(10) unsigned NOT NULL DEFAULT '0',
  `DocLista` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LineaTotal` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ContenidoXML` longtext COLLATE utf8mb4_unicode_ci,
  `BinaryID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ContenidoFilePath` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ContenidoMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ZipFormato` enum('NONE','7Z','BZ2','ZIP') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `Resultado` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentono`
--

DROP TABLE IF EXISTS `documentono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentono` (
  `DocumentoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `No` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Especial` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`DocumentoTipo`,`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documenttocloud`
--

DROP TABLE IF EXISTS `documenttocloud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documenttocloud` (
  `DocumentoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `SubTiendaDB` tinyint(1) NOT NULL DEFAULT '0',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`DocumentoTipo`,`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documenttosubtienda`
--

DROP TABLE IF EXISTS `documenttosubtienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documenttosubtienda` (
  `DocumentoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DocumentoNoEnSubTienda` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`DocumentoTipo`,`DocumentoNo`,`SubTiendaID`,`AlmacenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsent`
--

DROP TABLE IF EXISTS `emailsent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsent` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DocCatalog` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocFormat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `SenderCatalog` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `SenderID` bigint(12) NOT NULL DEFAULT '0',
  `Sender` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmailAddress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CreateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sent` tinyint(1) NOT NULL DEFAULT '0',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DocCatalog` (`DocCatalog`),
  KEY `DocID` (`DocID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empaque`
--

DROP TABLE IF EXISTS `empaque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empaque` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaranProveedor` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CaseNumber` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ShipDate` date DEFAULT NULL,
  `ForecastDate` date DEFAULT NULL,
  `ActualDate` date DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empaquearticulo`
--

DROP TABLE IF EXISTS `empaquearticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empaquearticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `CaseNumber` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PedidoProveedorNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `PedidoProveedorOrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleado` (
  `EmpleadoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Contrasena` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LastLoginTime` datetime DEFAULT NULL,
  `LastLoginInfo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpleadoID`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleadoclase`
--

DROP TABLE IF EXISTS `empleadoclase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleadoclase` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PoderesLogin` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PoderesUsar` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PoderesCloud` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PadreGrupo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `ReglaTicketPrecio` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `TicketPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `PresupuestoPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `PedidoPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `AlbaranPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `FacturaPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `ExtraPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `AbonoPrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `SoloSubTienda` tinyint(1) NOT NULL DEFAULT '0',
  `SubTiendaLista` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleadotodo`
--

DROP TABLE IF EXISTS `empleadotodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleadotodo` (
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmpleadoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`SubTiendaID`,`EmpleadoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etiqueta`
--

DROP TABLE IF EXISTS `etiqueta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etiqueta` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etiquetaarticulo`
--

DROP TABLE IF EXISTS `etiquetaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etiquetaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extra`
--

DROP TABLE IF EXISTS `extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extra` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extraarticulo`
--

DROP TABLE IF EXISTS `extraarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extraarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extradiariolista`
--

DROP TABLE IF EXISTS `extradiariolista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extradiariolista` (
  `Fecha` date NOT NULL,
  `DiarioListaNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extraivatotal`
--

DROP TABLE IF EXISTS `extraivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extraivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturaarticulo`
--

DROP TABLE IF EXISTS `facturaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturadiariolista`
--

DROP TABLE IF EXISTS `facturadiariolista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturadiariolista` (
  `Fecha` date NOT NULL,
  `DiarioListaNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturaivatotal`
--

DROP TABLE IF EXISTS `facturaivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturaivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturaproveedor`
--

DROP TABLE IF EXISTS `facturaproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturaproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturaproveedorarticulo`
--

DROP TABLE IF EXISTS `facturaproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturaproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facturaproveedorivatotal`
--

DROP TABLE IF EXISTS `facturaproveedorivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturaproveedorivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gananciacambio`
--

DROP TABLE IF EXISTS `gananciacambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gananciacambio` (
  `Fecha` date DEFAULT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `CuentaTipo` enum('Ticket','Albaran') COLLATE utf8mb4_unicode_ci DEFAULT 'Ticket'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gananciadiariototal`
--

DROP TABLE IF EXISTS `gananciadiariototal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gananciadiariototal` (
  `Fecha` date NOT NULL,
  `Ticket` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `TicketGanancia` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Albaran` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `AlbaranGanancia` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Devolucion` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `DevolucionGanancia` decimal(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hanzipinyin`
--

DROP TABLE IF EXISTS `hanzipinyin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hanzipinyin` (
  `hanzi` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `pinyin` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hanzi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `impresoraservidor`
--

DROP TABLE IF EXISTS `impresoraservidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impresoraservidor` (
  `ID` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PapelTipo` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `informeespecial`
--

DROP TABLE IF EXISTS `informeespecial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `informeespecial` (
  `ID` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Familia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PaisID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `InformeRPT` longtext COLLATE utf8mb4_unicode_ci,
  `ContenidoMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Tipo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `InformeProcesadorID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `InformeVersion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Extra` tinyint(1) NOT NULL DEFAULT '0',
  `TiempoActualizado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloClaseID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventarioarticulo`
--

DROP TABLE IF EXISTS `inventarioarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventarioarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventariodocstock`
--

DROP TABLE IF EXISTS `inventariodocstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventariodocstock` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadPorUnidad` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `CantidadPorUnidad2` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `SitioEnAlmacen` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SitioEnEstante` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `DibujoID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EmpleadoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Lote` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Stock` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivatipo`
--

DROP TABLE IF EXISTS `ivatipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivatipo` (
  `IVAID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA1` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ1` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA2` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ2` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA3` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ3` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA4` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ4` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA5` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ5` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA6` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ6` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA7` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ7` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA8` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ8` decimal(6,3) NOT NULL DEFAULT '0.000',
  `IVA9` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ9` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IVAID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labeltemplate`
--

DROP TABLE IF EXISTS `labeltemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labeltemplate` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Family` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CommandSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TemplateSQL` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `TemplateMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LabelTemplate` mediumtext COLLATE utf8mb4_unicode_ci,
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `LogID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `LogTime` datetime DEFAULT NULL,
  `ProgramName` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `UserID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LogType` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceIP` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`LogID`),
  KEY `LogTime` (`LogTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opcion`
--

DROP TABLE IF EXISTS `opcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcion` (
  `ID` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IntegerValor` bigint(20) DEFAULT NULL,
  `DecimalValor` decimal(16,4) DEFAULT NULL,
  `VarCharValor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TextValor` longtext COLLATE utf8mb4_unicode_ci,
  `Publico` tinyint(1) NOT NULL DEFAULT '0',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordenadorejecutando`
--

DROP TABLE IF EXISTS `ordenadorejecutando`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenadorejecutando` (
  `MySQLID` bigint(4) NOT NULL DEFAULT '0',
  `ProgramaID` enum('BohaoMarket','BohaoMarketMan','BohaoMarketPriAdv','BohaoMarketPDA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BohaoMarket',
  `MysqlIDUser` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmpleadoNombre` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LoginTiempo` datetime DEFAULT NULL,
  `EmpresaIDPorDescuento` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MySQLID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otrosincobrado`
--

DROP TABLE IF EXISTS `otrosincobrado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otrosincobrado` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobroTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otrosinpagado`
--

DROP TABLE IF EXISTS `otrosinpagado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otrosinpagado` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pago` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoOriginalTipo` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOriginalNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `PagoFormaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagoforma`
--

DROP TABLE IF EXISTS `pagoforma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagoforma` (
  `PagoFormaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PagoFormaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaran` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidoarticulo`
--

DROP TABLE IF EXISTS `pedidoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidoarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidocliente`
--

DROP TABLE IF EXISTS `pedidocliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidocliente` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaran` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ClienteLoginID` bigint(12) NOT NULL DEFAULT '0',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidoclientearticulo`
--

DROP TABLE IF EXISTS `pedidoclientearticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidoclientearticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidoproveedor`
--

DROP TABLE IF EXISTS `pedidoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidoproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaranProveedor` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidoproveedorarticulo`
--

DROP TABLE IF EXISTS `pedidoproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidoproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `EmpaqueCantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidotableta`
--

DROP TABLE IF EXISTS `pedidotableta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidotableta` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaran` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidotabletaarticulo`
--

DROP TABLE IF EXISTS `pedidotabletaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidotabletaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidotemp`
--

DROP TABLE IF EXISTS `pedidotemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidotemp` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaran` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ClienteLoginID` bigint(12) NOT NULL DEFAULT '0',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidotemparticulo`
--

DROP TABLE IF EXISTS `pedidotemparticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidotemparticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preformadepago`
--

DROP TABLE IF EXISTS `preformadepago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preformadepago` (
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `FormaDePago` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ClienteBancoInfoIncluido` tinyint(1) NOT NULL DEFAULT '0',
  `Vencimientos` date DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PreFormaDePagoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuesto`
--

DROP TABLE IF EXISTS `presupuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presupuesto` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaran` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuestoarticulo`
--

DROP TABLE IF EXISTS `presupuestoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presupuestoarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuestoproveedor`
--

DROP TABLE IF EXISTS `presupuestoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presupuestoproveedor` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `UsarFechaStock` tinyint(1) NOT NULL DEFAULT '0',
  `FechaStock` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `FechaAlbaranProveedor` date DEFAULT NULL,
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `presupuestoproveedorarticulo`
--

DROP TABLE IF EXISTS `presupuestoproveedorarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presupuestoproveedorarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prop`
--

DROP TABLE IF EXISTS `prop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prop` (
  `PropID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PropID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `propdeta`
--

DROP TABLE IF EXISTS `propdeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propdeta` (
  `PropID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropDetaID` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PropID`,`PropDetaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NumeroIVA` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Sexo` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Cumpleano` date DEFAULT NULL,
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaSDIID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `FacturaCEC` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `BancoCuentaNo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NecesitaFactura` tinyint(1) NOT NULL DEFAULT '0',
  `AutoEmailDocumento` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoSerie` tinyint(3) NOT NULL DEFAULT '0',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `MaxSobregiro` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `SerSocio` tinyint(1) NOT NULL DEFAULT '0',
  `TarjetaSocioID` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ChinoProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `Extrajero` tinyint(1) NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `LoginEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `ImprimirArticuloOrden` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`),
  UNIQUE KEY `TarjetaSocioID` (`TarjetaSocioID`),
  KEY `ClaseID` (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedorclase`
--

DROP TABLE IF EXISTS `proveedorclase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorclase` (
  `ClaseID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `PadreID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) NOT NULL DEFAULT '-1',
  `FacturaPorcentaje` decimal(5,2) NOT NULL DEFAULT '0.00',
  `FacturaDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `NecesitaFactura` tinyint(1) NOT NULL DEFAULT '0',
  `AutoEmailDocumento` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `MaxSobregiro` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `SerSocio` tinyint(1) NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ChinoProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `Extrajero` tinyint(1) NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ImprimirArticuloOrden` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Privado` tinyint(1) NOT NULL DEFAULT '0',
  `PadreGrupo` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClaseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedordiariototal`
--

DROP TABLE IF EXISTS `proveedordiariototal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedordiariototal` (
  `Fecha` date NOT NULL,
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Vez` int(10) unsigned NOT NULL DEFAULT '0',
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`Fecha`),
  KEY `EmpresaID` (`EmpresaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedorextra`
--

DROP TABLE IF EXISTS `proveedorextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorextra` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `TiempoUltimoUsar` datetime DEFAULT NULL,
  `ConsultaParcial` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Signo` tinyint(1) NOT NULL DEFAULT '-1',
  `TiempoSigno` datetime DEFAULT NULL,
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmpresaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedorlogin`
--

DROP TABLE IF EXISTS `proveedorlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorlogin` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LoginID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Contrasena` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Idioma` tinyint(3) NOT NULL DEFAULT '0',
  `IdiomaSerie` tinyint(3) NOT NULL DEFAULT '0',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `LastLoginTime` datetime DEFAULT NULL,
  `LastLoginInfo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`,`Nombre`),
  UNIQUE KEY `LoginID` (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedorsucursal`
--

DROP TABLE IF EXISTS `proveedorsucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorsucursal` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`,`SucursalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `punto`
--

DROP TABLE IF EXISTS `punto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `punto` (
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `FechaInicio` date DEFAULT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Vez` int(10) unsigned NOT NULL DEFAULT '0',
  `Saldo` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Cupon` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Vale` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `ServidorActualizar` tinyint(1) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`EmpresaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `puntoentrada`
--

DROP TABLE IF EXISTS `puntoentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puntoentrada` (
  `DocumentoNo` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `ServidorActualizar` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `puntosalida`
--

DROP TABLE IF EXISTS `puntosalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puntosalida` (
  `DocumentoNo` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `ServidorActualizar` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reglacupon`
--

DROP TABLE IF EXISTS `reglacupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reglacupon` (
  `ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `MiniImporte` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FechaInicio` date DEFAULT NULL,
  `FechaCaducada` date DEFAULT NULL,
  `Activado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `ReportID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Family` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Parameter` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ReportMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ReportFile` longtext COLLATE utf8mb4_unicode_ci,
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `Country` smallint(5) NOT NULL DEFAULT '0',
  `Comments` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ReportID`),
  KEY `ReportMD5` (`ReportMD5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `stock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `SitioEnAlmacen` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SitioEnEstante` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `MiniStock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `MaxiStock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`AlmacenID`,`ArticuloID`,`PropID1`,`PropID2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockajuste`
--

DROP TABLE IF EXISTS `stockajuste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockajuste` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockajustearticulo`
--

DROP TABLE IF EXISTS `stockajustearticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockajustearticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcambio`
--

DROP TABLE IF EXISTS `stockcambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcambio` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcambiocloud`
--

DROP TABLE IF EXISTS `stockcambiocloud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcambiocloud` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockentrada`
--

DROP TABLE IF EXISTS `stockentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockentrada` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockentradaarticulo`
--

DROP TABLE IF EXISTS `stockentradaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockentradaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockextra`
--

DROP TABLE IF EXISTS `stockextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockextra` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Stock` decimal(18,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`AlmacenID`,`ArticuloID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockextracambio`
--

DROP TABLE IF EXISTS `stockextracambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockextracambio` (
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stocksalida`
--

DROP TABLE IF EXISTS `stocksalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksalida` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stocksalidaarticulo`
--

DROP TABLE IF EXISTS `stocksalidaarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksalidaarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subtienda`
--

DROP TABLE IF EXISTS `subtienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtienda` (
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreES` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NumeroIVA` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Pais` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CountryID` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PersonaContacto` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DBBasicSync` enum('FromCloudNoClient','FromCloud','ToCloudNoClient','ToCloud','None') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FromCloudNoClient',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `AlmacenMovimiento` enum('None','Related','All') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'None',
  `StockUpdate` enum('None','Cloud2Sub','Sub2Cloud','All') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'None',
  `ImportGoodsPic` tinyint(1) NOT NULL DEFAULT '0',
  `RegID` int(10) unsigned NOT NULL DEFAULT '0',
  `Users` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Actived` tinyint(1) NOT NULL DEFAULT '0',
  `AuthCode` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DBName` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SystemInfo` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SubTiendaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tablapropiedad`
--

DROP TABLE IF EXISTS `tablapropiedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tablapropiedad` (
  `TablaNombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Basico` tinyint(1) NOT NULL DEFAULT '0',
  `Publico` tinyint(1) NOT NULL DEFAULT '0',
  `Mysql2Sqlite` tinyint(1) NOT NULL DEFAULT '0',
  `Client2Cloud` tinyint(1) NOT NULL DEFAULT '0',
  `Local4Cloud` tinyint(1) NOT NULL DEFAULT '0',
  `ContenidoMD5` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `TiempoActualizar` datetime DEFAULT NULL,
  PRIMARY KEY (`TablaNombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `FormaDePago` enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Efectivo',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoUsarRegla` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CobroTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `CajonID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `AbonoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Cobrado` tinyint(1) NOT NULL DEFAULT '-1',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketarticulo`
--

DROP TABLE IF EXISTS `ticketarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketcambio`
--

DROP TABLE IF EXISTS `ticketcambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcambio` (
  `Fecha` date DEFAULT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketcobro`
--

DROP TABLE IF EXISTS `ticketcobro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcobro` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `CobroDocNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `FormaDePago` enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Efectivo',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `DocNo` (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketcolgando`
--

DROP TABLE IF EXISTS `ticketcolgando`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcolgando` (
  `DocumentoNo` bigint(18) unsigned NOT NULL AUTO_INCREMENT,
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteNombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CobroIntentado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `ColgarNota` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketcolgandoarticulo`
--

DROP TABLE IF EXISTS `ticketcolgandoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcolgandoarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketdiariototal`
--

DROP TABLE IF EXISTS `ticketdiariototal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketdiariototal` (
  `Fecha` date NOT NULL,
  `Total` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Tarjeta` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Cheque` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Transferencia` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Vale` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `ValeSalida` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `DescuentoCliente` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Otro` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `Pendiente` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `GenTiendasCadenaDatos` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketextra`
--

DROP TABLE IF EXISTS `ticketextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketextra` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ClienteIVAClase` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ClienteReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `UsarClienteReglaIVA` tinyint(1) NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobrarTipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Efectivo` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PreFormaDePagoNo` int(10) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketextraarticulo`
--

DROP TABLE IF EXISTS `ticketextraarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketextraarticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketextradiariolista`
--

DROP TABLE IF EXISTS `ticketextradiariolista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketextradiariolista` (
  `Fecha` date NOT NULL,
  `DiarioListaNo` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketextraivatotal`
--

DROP TABLE IF EXISTS `ticketextraivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketextraivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketivatotal`
--

DROP TABLE IF EXISTS `ticketivatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketivatotal` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `BaseImponible` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ImporteIVA` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ImporteREQ` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `SubTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketoferta`
--

DROP TABLE IF EXISTS `ticketoferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketoferta` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Punto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Descuento` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoCliente` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Cupon` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CuponNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Vale` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `ValeNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticketsincobrado`
--

DROP TABLE IF EXISTS `ticketsincobrado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketsincobrado` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CobroTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transporte`
--

DROP TABLE IF EXISTS `transporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transporte` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `SucursalID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Descuento2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoDirecto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `ReglaIVA` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `IVASerie` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `PrecioUsado` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `Total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `DescuentoTotal` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `DescuentoExtra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Ganancias` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PagoTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `CantidadTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `PaqueteTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `CajaTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `VolumenPesoTotal` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `LineaTotal` int(10) unsigned NOT NULL DEFAULT '0',
  `Fecha` date DEFAULT NULL,
  `FechaEntrada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaOriginal` datetime DEFAULT NULL,
  `TiempoUltimoEditar` datetime DEFAULT NULL,
  `TiempoUltimoActualizar` datetime DEFAULT NULL,
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `AgenteID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `OperadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AlmacenID` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoHash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Anulado` tinyint(1) NOT NULL DEFAULT '0',
  `Modificando` tinyint(1) NOT NULL DEFAULT '0',
  `EmailMandado` tinyint(1) NOT NULL DEFAULT '0',
  `ProgressID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ProgressStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LogID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `HayAdjunto` tinyint(1) NOT NULL DEFAULT '0',
  `Imprimido` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`),
  KEY `Fecha` (`Fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transportearticulo`
--

DROP TABLE IF EXISTS `transportearticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transportearticulo` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `ArticuloID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PropID1` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PropID2` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Propiedad` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SerialNo` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoBarraBalanza` tinyint(1) NOT NULL DEFAULT '0',
  `NombreES` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `NombreCN` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Precio` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Cantidad` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `IVA` decimal(6,3) NOT NULL DEFAULT '0.000',
  `REQ` decimal(6,3) NOT NULL DEFAULT '0.000',
  `Descuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DescuentoCambioProhibido` tinyint(1) NOT NULL DEFAULT '0',
  `PrecioCoste` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Comentario` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NecesitaSerialNo` tinyint(1) NOT NULL DEFAULT '0',
  `Temporal` tinyint(1) NOT NULL DEFAULT '0',
  `OrdenNo` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `DocNo` (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transportemodo`
--

DROP TABLE IF EXISTS `transportemodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transportemodo` (
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`TransporteModoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transportista`
--

DROP TABLE IF EXISTS `transportista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transportista` (
  `TransportistaID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TransporteModoID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `EnvioGasto` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CIF` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Domicilio` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CodigoPostal` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Poblacion` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Provincia` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Telefono2` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Fax` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Web` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IM` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CocheNo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`TransportistaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vale`
--

DROP TABLE IF EXISTS `vale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vale` (
  `DocumentoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoEnServidor` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoNoOriginal` bigint(18) unsigned NOT NULL DEFAULT '0',
  `Importe` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `Fecha` date DEFAULT NULL,
  `FormaDePago` enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Efectivo',
  `Localizador` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Origen` enum('Precobro','Devolucion','Restante','Descuento','Otro') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Otro',
  `EmpresaID` bigint(12) unsigned NOT NULL DEFAULT '0',
  `Caducado` tinyint(1) NOT NULL DEFAULT '0',
  `FechaCaducada` date DEFAULT NULL,
  `CreadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TiempoCreado` datetime DEFAULT NULL,
  `TiendasCadenaIDCreado` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Usado` tinyint(1) NOT NULL DEFAULT '0',
  `UsadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TiempoUsado` datetime DEFAULT NULL,
  `TiendasCadenaIDUsado` smallint(5) unsigned NOT NULL DEFAULT '0',
  `VerificadorID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DocumentoAdjuntoSimbolo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoOrigenNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `DocumentoDestinoTipo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoDestinoNo` bigint(18) unsigned NOT NULL DEFAULT '0',
  `OrdenadorNombre` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `SubTiendaID` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DocumentoIntercambioNo` bigint(18) NOT NULL DEFAULT '0',
  `Bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `DeviceUUID` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Observacion` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`DocumentoNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warn`
--

DROP TABLE IF EXISTS `warn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warn` (
  `WarnID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `WarnTime` datetime DEFAULT NULL,
  `ProgramName` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DBVersion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `UserID` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `WarnType` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `WarnUrl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DeviceIP` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Content` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`WarnID`),
  KEY `WarnTime` (`WarnTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-21 15:12:45

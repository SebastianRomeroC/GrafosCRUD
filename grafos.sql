-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-12-2024 a las 04:48:53
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grafos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCiudad` (IN `p_id` INT, IN `p_nuevo_nombre` VARCHAR(255), IN `p_nueva_poblacion` INT)   BEGIN
    UPDATE Ciudades
    SET nombre = p_nuevo_nombre, poblacion = p_nueva_poblacion
    WHERE id_ciudad = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarConexion` (IN `p_ciudad_origen` VARCHAR(255), IN `p_ciudad_destino` VARCHAR(255), IN `p_nueva_ciudad_origen` VARCHAR(255), IN `p_nueva_ciudad_destino` VARCHAR(255))   BEGIN
    UPDATE Conexiones
    SET ciudad_origen_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_nueva_ciudad_origen LIMIT 1),
        ciudad_destino_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_nueva_ciudad_destino LIMIT 1)
    WHERE ciudad_origen_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_origen LIMIT 1)
    AND ciudad_destino_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_destino LIMIT 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarCiudades` ()   BEGIN
    SELECT * FROM Ciudades;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarConexionesCiudad` (IN `p_ciudad_nombre` VARCHAR(255))   BEGIN
    SELECT c1.nombre AS Ciudad_Origen, c2.nombre AS Ciudad_Destino
    FROM Conexiones con
    JOIN Ciudades c1 ON con.ciudad_origen_id = c1.id_ciudad
    JOIN Ciudades c2 ON con.ciudad_destino_id = c2.id_ciudad
    WHERE c1.nombre = p_ciudad_nombre OR c2.nombre = p_ciudad_nombre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCiudad` (IN `p_id` INT)   BEGIN
    DELETE FROM Ciudades WHERE id_ciudad = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarConexion` (IN `p_ciudad_origen` VARCHAR(255), IN `p_ciudad_destino` VARCHAR(255))   BEGIN
    DELETE FROM Conexiones
    WHERE ciudad_origen_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_origen LIMIT 1)
    AND ciudad_destino_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_destino LIMIT 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCiudad` (IN `p_nombre` VARCHAR(255))   BEGIN
    INSERT INTO Ciudades (nombre)
    VALUES (p_nombre);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarConexion` (IN `p_ciudad_origen` VARCHAR(255), IN `p_ciudad_destino` VARCHAR(255))   BEGIN
    INSERT INTO Conexiones (ciudad_origen_id, ciudad_destino_id)
    VALUES 
        ((SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_origen LIMIT 1),
         (SELECT id_ciudad FROM Ciudades WHERE nombre = p_ciudad_destino LIMIT 1));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id_ciudad` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id_ciudad`, `nombre`) VALUES
(1, 'Manizales'),
(2, 'Pereira'),
(3, 'Armenia'),
(4, 'Chinchiná'),
(5, 'Villamaria'),
(6, 'Palestina'),
(7, 'Neira'),
(8, 'La Virginia'),
(9, 'Dosquebradas'),
(10, 'Santa Rosa de Cabal'),
(11, 'Cartago'),
(12, 'Calarcá'),
(13, 'Ciscasia'),
(14, 'La Tebaida'),
(15, 'Montenegro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conexiones`
--

CREATE TABLE `conexiones` (
  `id_conexion` int(11) NOT NULL,
  `ciudad_origen_id` int(11) DEFAULT NULL,
  `ciudad_destino_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `conexiones`
--

INSERT INTO `conexiones` (`id_conexion`, `ciudad_origen_id`, `ciudad_destino_id`) VALUES
(1, 1, 7),
(2, 1, 6),
(3, 1, 5),
(4, 1, 4),
(5, 1, 10),
(6, 1, 9),
(7, 1, 2),
(8, 1, 11),
(9, 1, 3),
(10, 10, 2),
(11, 10, 3),
(12, 9, 3),
(13, 9, 2),
(14, 9, 11),
(15, 8, 2),
(16, 8, 11),
(17, 2, 11),
(18, 2, 13),
(19, 3, 13),
(20, 3, 12),
(21, 3, 14),
(22, 3, 15);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`id_ciudad`);

--
-- Indices de la tabla `conexiones`
--
ALTER TABLE `conexiones`
  ADD PRIMARY KEY (`id_conexion`),
  ADD KEY `ciudad_origen_id` (`ciudad_origen_id`),
  ADD KEY `ciudad_destino_id` (`ciudad_destino_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `conexiones`
--
ALTER TABLE `conexiones`
  MODIFY `id_conexion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `conexiones`
--
ALTER TABLE `conexiones`
  ADD CONSTRAINT `conexiones_ibfk_1` FOREIGN KEY (`ciudad_origen_id`) REFERENCES `ciudades` (`id_ciudad`),
  ADD CONSTRAINT `conexiones_ibfk_2` FOREIGN KEY (`ciudad_destino_id`) REFERENCES `ciudades` (`id_ciudad`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.0.10.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.4.131.130:3306
-- Tiempo de generación: 03-10-2016 a las 15:02:16
-- Versión del servidor: 5.5.45
-- Versión de PHP: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `app`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE IF NOT EXISTS `contactos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `usuario_contacto` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`,`usuario_contacto`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rec_mensajes`
--

CREATE TABLE IF NOT EXISTS `rec_mensajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_remite` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `id_destinatario` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `contenido` text COLLATE utf8_unicode_ci NOT NULL,
  `fecha` bigint(11) NOT NULL,
  `visto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_remite` (`id_remite`,`id_destinatario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rt_password`
--

CREATE TABLE IF NOT EXISTS `rt_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(23) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(264) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tiempo` bigint(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE IF NOT EXISTS `solicitudes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remite` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `destinatario` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `remite` (`remite`,`destinatario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `timezones`
--

CREATE TABLE IF NOT EXISTS `timezones` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `timezone_location` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `gmt` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `offset` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(23) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `encrypted_password` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `salt` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `verificacion_envio` int(11) NOT NULL DEFAULT '0',
  `verificado` int(11) NOT NULL DEFAULT '0',
  `codigo_verificacion` varchar(264) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `unique_id` (`unique_id`),
  UNIQUE KEY `email` (`email`),
  KEY `email_2` (`email`),
  KEY `encrypted_password` (`encrypted_password`),
  KEY `unique_id_2` (`unique_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

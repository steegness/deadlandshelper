-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 02, 2018 at 10:12 AM
-- Server version: 5.5.58-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `deadlandschips`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignChipToOwner`(IN `idUser` INT, IN `idChip` INT)
    MODIFIES SQL DATA
UPDATE  `deadlandschips`.`chips` 
SET  `idOwner` =  idUser 
WHERE  `chips`.`id` = idChip$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllOwnedChips`(OUT `p_id` INT, OUT `p_color` VARCHAR(6), OUT `p_idOwner` INT, OUT `p_firstName` VARCHAR(25), OUT `p_lastName` VARCHAR(25))
    READS SQL DATA
SELECT
	chips.id,
	chips.color,
	chips.idOwner,
	users.firstName,
	users.lastName
INTO
	p_id,
	p_color,
	p_idOwner,
	p_firstName,
	p_lastName
FROM
	chips
	INNER JOIN users on users.id = chips.idOwner
WHERE
	idOwner is not null
ORDER BY
	users.lastName$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getChipsForOwner`(IN `p_idOwnerIn` INT, OUT `P_idChip` INT, OUT `p_color` VARCHAR(6), OUT `p_idOwnerOut` INT)
    READS SQL DATA
SELECT
	chips.id,
	chips.color,
	chips.idOwnerIn
INTO
	p_idChip,
	p_color,
	p_idOwnerOut
FROM
	deadlandschips.chips
WHERE
	chips.idOwner = p_idOwnerIn$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `mostRecentChipDateTime`() RETURNS timestamp
    READS SQL DATA
RETURN (
SELECT
	max(chips.lastUpdated) as mostRecentUpdate
FROM
	chips
WHERE
	idOwner is not NULL
)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `randomUnownedCard`() RETURNS int(11)
    READS SQL DATA
RETURN (
SELECT
	cards.id idCard
FROM
	cards
WHERE
	idOwner is NULL
ORDER BY
	rand()
LIMIT 1
)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `randomUnownedChip`() RETURNS int(11)
    READS SQL DATA
RETURN (
SELECT
	chips.id idChip
FROM
	chips
WHERE
	idOwner is NULL
ORDER BY
	rand()
LIMIT 1
)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` int(11) NOT NULL,
  `value` varchar(2) NOT NULL,
  `suit` varchar(1) NOT NULL,
  `idOwner` int(11) DEFAULT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `rank`, `value`, `suit`, `idOwner`, `lastUpdated`) VALUES
(1, 0, 'X', 'R', NULL, '2018-03-02 02:36:12'),
(2, 1, 'A', 'S', 9, '2018-03-02 02:37:24'),
(3, 1, 'A', 'H', NULL, '2018-03-02 02:36:12'),
(4, 1, 'A', 'D', NULL, '2018-03-02 02:36:12'),
(5, 1, 'A', 'C', NULL, '2018-03-02 02:36:12'),
(6, 13, 'K', 'S', 9, '2018-03-02 02:37:26'),
(7, 13, 'K', 'H', NULL, '2018-03-02 02:36:12'),
(8, 13, 'K', 'D', NULL, '2018-03-02 02:36:12'),
(9, 13, 'K', 'C', 3, '2018-03-02 02:37:29'),
(10, 12, 'Q', 'S', NULL, '2018-03-02 02:36:12'),
(11, 12, 'Q', 'H', NULL, '2018-03-02 02:36:12'),
(12, 12, 'Q', 'D', NULL, '2018-03-02 02:37:18'),
(13, 12, 'Q', 'C', NULL, '2018-03-02 02:36:12'),
(14, 11, 'J', 'S', 9, '2018-03-02 02:37:27'),
(15, 11, 'J', 'H', NULL, '2018-03-02 02:36:12'),
(16, 11, 'J', 'D', NULL, '2018-03-02 02:36:12'),
(17, 11, 'J', 'C', NULL, '2018-03-02 02:36:12'),
(18, 10, '10', 'S', NULL, '2018-03-02 02:36:12'),
(19, 10, '10', 'H', NULL, '2018-03-02 02:36:12'),
(20, 10, '10', 'D', NULL, '2018-03-02 02:36:12'),
(21, 10, '10', 'C', NULL, '2018-03-02 02:36:12'),
(22, 9, '9', 'S', NULL, '2018-03-02 02:36:12'),
(23, 9, '9', 'H', NULL, '2018-03-02 13:48:34'),
(24, 9, '9', 'D', NULL, '2018-03-02 02:36:12'),
(25, 9, '9', 'C', NULL, '2018-03-02 02:36:12'),
(26, 8, '8', 'S', NULL, '2018-03-02 02:36:12'),
(27, 8, '8', 'H', NULL, '2018-03-02 02:36:12'),
(28, 8, '8', 'D', NULL, '2018-03-02 02:36:12'),
(29, 8, '8', 'C', 5, '2018-03-02 02:37:24'),
(30, 7, '7', 'S', NULL, '2018-03-02 02:36:12'),
(31, 7, '7', 'H', NULL, '2018-03-02 02:36:12'),
(32, 7, '7', 'D', NULL, '2018-03-02 02:36:12'),
(33, 7, '7', 'C', NULL, '2018-03-02 02:36:12'),
(34, 6, '6', 'S', 4, '2018-03-02 02:37:27'),
(35, 6, '6', 'H', NULL, '2018-03-02 13:47:49'),
(36, 6, '6', 'D', 10, '2018-03-02 02:37:37'),
(37, 6, '6', 'C', NULL, '2018-03-02 02:36:12'),
(38, 5, '5', 'S', NULL, '2018-03-02 02:36:12'),
(39, 5, '5', 'H', NULL, '2018-03-02 02:36:12'),
(40, 5, '5', 'D', NULL, '2018-03-02 02:36:12'),
(41, 5, '5', 'C', NULL, '2018-03-02 02:36:12'),
(42, 4, '4', 'S', NULL, '2018-03-02 02:36:12'),
(43, 4, '4', 'H', NULL, '2018-03-02 02:36:12'),
(44, 4, '4', 'D', NULL, '2018-03-02 02:36:12'),
(45, 4, '4', 'C', NULL, '2018-03-02 02:36:12'),
(46, 3, '3', 'S', NULL, '2018-03-02 13:47:32'),
(47, 3, '3', 'H', NULL, '2018-03-02 02:36:12'),
(48, 3, '3', 'D', NULL, '2018-03-02 02:36:12'),
(49, 3, '3', 'C', NULL, '2018-03-02 02:36:12'),
(50, 2, '2', 'S', NULL, '2018-03-02 02:37:18'),
(51, 2, '2', 'H', NULL, '2018-03-02 02:36:12'),
(52, 2, '2', 'D', NULL, '2018-03-02 02:36:12'),
(53, 2, '2', 'C', NULL, '2018-03-02 02:36:12'),
(54, 0, 'X', 'B', 1, '2018-03-02 02:37:31');

-- --------------------------------------------------------

--
-- Table structure for table `chips`
--

CREATE TABLE IF NOT EXISTS `chips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(6) NOT NULL,
  `idOwner` int(11) DEFAULT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Dumping data for table `chips`
--

INSERT INTO `chips` (`id`, `color`, `idOwner`, `lastUpdated`) VALUES
(0, 'red', 5, '2018-02-28 21:34:47'),
(1, 'white', 1, '2018-02-27 20:30:30'),
(2, 'white', NULL, '2018-02-27 19:49:43'),
(3, 'white', NULL, '0000-00-00 00:00:00'),
(4, 'white', 4, '2018-02-27 20:57:35'),
(5, 'white', NULL, '2018-03-02 01:56:58'),
(6, 'white', NULL, '2018-02-27 21:58:49'),
(7, 'white', 1, '2018-03-01 17:07:15'),
(8, 'white', NULL, '0000-00-00 00:00:00'),
(9, 'white', 4, '2018-02-27 20:34:55'),
(10, 'white', 5, '2018-02-28 21:44:56'),
(11, 'white', NULL, '2018-02-28 21:41:08'),
(12, 'white', NULL, '0000-00-00 00:00:00'),
(13, 'white', NULL, '0000-00-00 00:00:00'),
(14, 'white', NULL, '2018-02-28 23:31:17'),
(15, 'white', NULL, '0000-00-00 00:00:00'),
(16, 'white', NULL, '2018-02-27 20:29:21'),
(17, 'white', NULL, '0000-00-00 00:00:00'),
(18, 'white', 1, '2018-02-27 20:30:12'),
(19, 'white', NULL, '0000-00-00 00:00:00'),
(20, 'white', NULL, '2018-02-27 20:04:36'),
(21, 'white', NULL, '0000-00-00 00:00:00'),
(22, 'white', 1, '2018-02-27 20:30:14'),
(23, 'white', NULL, '2018-02-27 20:04:37'),
(24, 'white', NULL, '2018-02-27 20:10:47'),
(25, 'white', NULL, '0000-00-00 00:00:00'),
(26, 'white', NULL, '2018-02-27 20:10:46'),
(27, 'white', NULL, '0000-00-00 00:00:00'),
(28, 'white', NULL, '2018-02-27 20:35:11'),
(29, 'white', NULL, '0000-00-00 00:00:00'),
(30, 'white', NULL, '2018-02-27 21:58:45'),
(31, 'white', NULL, '0000-00-00 00:00:00'),
(32, 'white', NULL, '2018-02-27 21:58:54'),
(33, 'white', 6, '2018-03-01 21:20:22'),
(34, 'white', 9, '2018-02-27 20:59:39'),
(35, 'white', 3, '2018-02-27 20:06:30'),
(36, 'white', NULL, '2018-03-02 13:59:40'),
(37, 'white', NULL, '2018-02-27 19:49:42'),
(38, 'white', NULL, '0000-00-00 00:00:00'),
(39, 'white', 10, '2018-03-02 02:37:46'),
(40, 'white', NULL, '0000-00-00 00:00:00'),
(41, 'white', NULL, '0000-00-00 00:00:00'),
(42, 'white', NULL, '0000-00-00 00:00:00'),
(43, 'white', NULL, '2018-02-27 20:10:48'),
(44, 'white', NULL, '2018-02-27 20:04:43'),
(45, 'white', 6, '2018-03-02 01:38:47'),
(46, 'white', NULL, '0000-00-00 00:00:00'),
(47, 'white', 2, '2018-03-02 01:48:03'),
(48, 'white', NULL, '0000-00-00 00:00:00'),
(49, 'white', NULL, '0000-00-00 00:00:00'),
(50, 'white', NULL, '2018-02-27 20:00:55'),
(51, 'red', NULL, '0000-00-00 00:00:00'),
(53, 'red', NULL, '0000-00-00 00:00:00'),
(54, 'red', NULL, '0000-00-00 00:00:00'),
(55, 'red', NULL, '2018-02-27 19:55:21'),
(56, 'red', NULL, '0000-00-00 00:00:00'),
(57, 'red', NULL, '2018-02-27 19:55:19'),
(58, 'red', NULL, '2018-02-27 19:49:46'),
(59, 'red', 9, '2018-02-28 16:23:16'),
(60, 'red', NULL, '0000-00-00 00:00:00'),
(61, 'red', NULL, '2018-02-27 20:05:52'),
(62, 'red', NULL, '2018-03-02 14:49:55'),
(63, 'red', NULL, '0000-00-00 00:00:00'),
(64, 'red', NULL, '0000-00-00 00:00:00'),
(65, 'red', NULL, '0000-00-00 00:00:00'),
(66, 'red', 4, '2018-02-27 20:57:34'),
(67, 'red', NULL, '2018-03-02 14:50:03'),
(68, 'red', NULL, '2018-02-27 20:35:47'),
(69, 'red', NULL, '0000-00-00 00:00:00'),
(70, 'red', 2, '2018-02-27 20:00:44'),
(71, 'red', NULL, '2018-03-02 14:49:48'),
(72, 'red', NULL, '0000-00-00 00:00:00'),
(73, 'red', NULL, '2018-02-27 21:59:00'),
(74, 'red', NULL, '0000-00-00 00:00:00'),
(75, 'red', NULL, '2018-02-27 19:49:42'),
(76, 'blue', 10, '2018-02-27 20:57:50'),
(77, 'blue', NULL, '0000-00-00 00:00:00'),
(78, 'blue', NULL, '0000-00-00 00:00:00'),
(79, 'blue', NULL, '0000-00-00 00:00:00'),
(80, 'blue', NULL, '2018-02-27 21:58:54'),
(81, 'blue', NULL, '2018-03-02 01:56:50'),
(82, 'blue', 10, '2018-03-02 02:37:39'),
(83, 'blue', NULL, '2018-02-27 19:49:38'),
(84, 'blue', NULL, '2018-02-27 20:57:09'),
(85, 'blue', 5, '2018-03-02 02:06:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `lastName` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`) VALUES
(1, 'Sean', 'Steeg'),
(2, 'Don', 'Mewha'),
(3, 'Janis', 'Gilham'),
(4, 'Kat', 'Powell'),
(5, 'Jodi', 'Bierlair'),
(6, 'Geoff', 'Hedgspeth'),
(7, 'Ben', 'Cash'),
(8, 'Jo Ann', 'Kester'),
(9, 'Game', 'Marshall'),
(10, 'Diana Lee', 'Whitie');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

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

CREATE DEFINER=`root`@`localhost` FUNCTION `specificUnownedColoredChip`(`desiredColor` VARCHAR(6)) RETURNS int(11)
    READS SQL DATA
RETURN 
(
SELECT chips.id
FROM chips
WHERE chips.idOwner IS NULL
and chips.color = desiredColor
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
(1,0,'X','R',NULL,'0000-00-00 00:00:00'),
(2,1,'A','S',NULL,'0000-00-00 00:00:00'),
(3,1,'A','H',NULL,'0000-00-00 00:00:00'),
(4,1,'A','D',NULL,'0000-00-00 00:00:00'),
(5,1,'A','C',NULL,'0000-00-00 00:00:00'),
(6,13,'K','S',NULL,'0000-00-00 00:00:00'),
(7,13,'K','H',NULL,'0000-00-00 00:00:00'),
(8,13,'K','D',NULL,'0000-00-00 00:00:00'),
(9,13,'K','C',NULL,'0000-00-00 00:00:00'),
(10,12,'Q','S',NULL,'0000-00-00 00:00:00'),
(11,12,'Q','H',NULL,'0000-00-00 00:00:00'),
(12,12,'Q','D',NULL,'0000-00-00 00:00:00'),
(13,12,'Q','C',NULL,'0000-00-00 00:00:00'),
(14,11,'J','S',NULL,'0000-00-00 00:00:00'),
(15,11,'J','H',NULL,'0000-00-00 00:00:00'),
(16,11,'J','D',NULL,'0000-00-00 00:00:00'),
(17,11,'J','C',NULL,'0000-00-00 00:00:00'),
(18,10,'10','S',NULL,'0000-00-00 00:00:00'),
(19,10,'10','H',NULL,'0000-00-00 00:00:00'),
(20,10,'10','D',NULL,'0000-00-00 00:00:00'),
(21,10,'10','C',NULL,'0000-00-00 00:00:00'),
(22,9,'9','S',NULL,'0000-00-00 00:00:00'),
(23,9,'9','H',NULL,'0000-00-00 00:00:00'),
(24,9,'9','D',NULL,'0000-00-00 00:00:00'),
(25,9,'9','C',NULL,'0000-00-00 00:00:00'),
(26,8,'8','S',NULL,'0000-00-00 00:00:00'),
(27,8,'8','H',NULL,'0000-00-00 00:00:00'),
(28,8,'8','D',NULL,'0000-00-00 00:00:00'),
(29,8,'8','C',NULL,'0000-00-00 00:00:00'),
(30,7,'7','S',NULL,'0000-00-00 00:00:00'),
(31,7,'7','H',NULL,'0000-00-00 00:00:00'),
(32,7,'7','D',NULL,'0000-00-00 00:00:00'),
(33,7,'7','C',NULL,'0000-00-00 00:00:00'),
(34,6,'6','S',NULL,'0000-00-00 00:00:00'),
(35,6,'6','H',NULL,'0000-00-00 00:00:00'),
(36,6,'6','D',NULL,'0000-00-00 00:00:00'),
(37,6,'6','C',NULL,'0000-00-00 00:00:00'),
(38,5,'5','S',NULL,'0000-00-00 00:00:00'),
(39,5,'5','H',NULL,'0000-00-00 00:00:00'),
(40,5,'5','D',NULL,'0000-00-00 00:00:00'),
(41,5,'5','C',NULL,'0000-00-00 00:00:00'),
(42,4,'4','S',NULL,'0000-00-00 00:00:00'),
(43,4,'4','H',NULL,'0000-00-00 00:00:00'),
(44,4,'4','D',NULL,'0000-00-00 00:00:00'),
(45,4,'4','C',NULL,'0000-00-00 00:00:00'),
(46,3,'3','S',NULL,'0000-00-00 00:00:00'),
(47,3,'3','H',NULL,'0000-00-00 00:00:00'),
(48,3,'3','D',NULL,'0000-00-00 00:00:00'),
(49,3,'3','C',NULL,'0000-00-00 00:00:00'),
(50,2,'2','S',NULL,'0000-00-00 00:00:00'),
(51,2,'2','H',NULL,'0000-00-00 00:00:00'),
(52,2,'2','D',NULL,'0000-00-00 00:00:00'),
(53,2,'2','C',NULL,'0000-00-00 00:00:00'),
(54,0,'X','B',NULL,'0000-00-00 00:00:00');

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
(0,'white',NULL,'0000-00-00 00:00:00'),
(1,'white',NULL,'0000-00-00 00:00:00'),
(2,'white',NULL,'0000-00-00 00:00:00'),
(3,'white',NULL,'0000-00-00 00:00:00'),
(4,'white',NULL,'0000-00-00 00:00:00'),
(5,'white',NULL,'0000-00-00 00:00:00'),
(6,'white',NULL,'0000-00-00 00:00:00'),
(7,'white',NULL,'0000-00-00 00:00:00'),
(8,'white',NULL,'0000-00-00 00:00:00'),
(9,'white',NULL,'0000-00-00 00:00:00'),
(10,'white',NULL,'0000-00-00 00:00:00'),
(11,'white',NULL,'0000-00-00 00:00:00'),
(12,'white',NULL,'0000-00-00 00:00:00'),
(13,'white',NULL,'0000-00-00 00:00:00'),
(14,'white',NULL,'0000-00-00 00:00:00'),
(15,'white',NULL,'0000-00-00 00:00:00'),
(16,'white',NULL,'0000-00-00 00:00:00'),
(17,'white',NULL,'0000-00-00 00:00:00'),
(18,'white',NULL,'0000-00-00 00:00:00'),
(19,'white',NULL,'0000-00-00 00:00:00'),
(20,'white',NULL,'0000-00-00 00:00:00'),
(21,'white',NULL,'0000-00-00 00:00:00'),
(22,'white',NULL,'0000-00-00 00:00:00'),
(23,'white',NULL,'0000-00-00 00:00:00'),
(24,'white',NULL,'0000-00-00 00:00:00'),
(25,'white',NULL,'0000-00-00 00:00:00'),
(26,'white',NULL,'0000-00-00 00:00:00'),
(27,'white',NULL,'0000-00-00 00:00:00'),
(28,'white',NULL,'0000-00-00 00:00:00'),
(29,'white',NULL,'0000-00-00 00:00:00'),
(30,'white',NULL,'0000-00-00 00:00:00'),
(31,'white',NULL,'0000-00-00 00:00:00'),
(32,'white',NULL,'0000-00-00 00:00:00'),
(33,'white',NULL,'0000-00-00 00:00:00'),
(34,'white',NULL,'0000-00-00 00:00:00'),
(35,'white',NULL,'0000-00-00 00:00:00'),
(36,'white',NULL,'0000-00-00 00:00:00'),
(37,'white',NULL,'0000-00-00 00:00:00'),
(38,'white',NULL,'0000-00-00 00:00:00'),
(39,'white',NULL,'0000-00-00 00:00:00'),
(40,'white',NULL,'0000-00-00 00:00:00'),
(41,'white',NULL,'0000-00-00 00:00:00'),
(42,'white',NULL,'0000-00-00 00:00:00'),
(43,'white',NULL,'0000-00-00 00:00:00'),
(44,'white',NULL,'0000-00-00 00:00:00'),
(45,'white',NULL,'0000-00-00 00:00:00'),
(46,'white',NULL,'0000-00-00 00:00:00'),
(47,'white',NULL,'0000-00-00 00:00:00'),
(48,'white',NULL,'0000-00-00 00:00:00'),
(49,'white',NULL,'0000-00-00 00:00:00'),
(50,'white',NULL,'0000-00-00 00:00:00'),
(51,'red',NULL,'0000-00-00 00:00:00'),
(53,'red',NULL,'0000-00-00 00:00:00'),
(54,'red',NULL,'0000-00-00 00:00:00'),
(55,'red',NULL,'0000-00-00 00:00:00'),
(56,'red',NULL,'0000-00-00 00:00:00'),
(57,'red',NULL,'0000-00-00 00:00:00'),
(58,'red',NULL,'0000-00-00 00:00:00'),
(59,'red',NULL,'0000-00-00 00:00:00'),
(60,'red',NULL,'0000-00-00 00:00:00'),
(61,'red',NULL,'0000-00-00 00:00:00'),
(62,'red',NULL,'0000-00-00 00:00:00'),
(63,'red',NULL,'0000-00-00 00:00:00'),
(64,'red',NULL,'0000-00-00 00:00:00'),
(65,'red',NULL,'0000-00-00 00:00:00'),
(66,'red',NULL,'0000-00-00 00:00:00'),
(67,'red',NULL,'0000-00-00 00:00:00'),
(68,'red',NULL,'0000-00-00 00:00:00'),
(69,'red',NULL,'0000-00-00 00:00:00'),
(70,'red',NULL,'0000-00-00 00:00:00'),
(71,'red',NULL,'0000-00-00 00:00:00'),
(72,'red',NULL,'0000-00-00 00:00:00'),
(73,'red',NULL,'0000-00-00 00:00:00'),
(74,'red',NULL,'0000-00-00 00:00:00'),
(75,'red',NULL,'0000-00-00 00:00:00'),
(76,'blue',NULL,'0000-00-00 00:00:00'),
(77,'blue',NULL,'0000-00-00 00:00:00'),
(78,'blue',NULL,'0000-00-00 00:00:00'),
(79,'blue',NULL,'0000-00-00 00:00:00'),
(80,'blue',NULL,'0000-00-00 00:00:00'),
(81,'blue',NULL,'0000-00-00 00:00:00'),
(82,'blue',NULL,'0000-00-00 00:00:00'),
(83,'blue',NULL,'0000-00-00 00:00:00'),
(84,'blue',NULL,'0000-00-00 00:00:00'),
(85,'blue',NULL,'0000-00-00 00:00:00');
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
(1, 'First', 'User'),
(2, 'Second', 'Person')

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

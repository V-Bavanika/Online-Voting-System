-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2023 at 02:09 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `votingsystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `age_calculator` (IN `v_id` VARCHAR(50), IN `dob` DATE, OUT `val` INT)   Begin
	SET val = TIMESTAMPDIFF(YEAR,dob,CURDATE());
	UPDATE voters SET voters.age = TIMESTAMPDIFF(YEAR,dob,CURDATE()) WHERE voters.voters_id = v_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWinnerNameList` (INOUT `winner_name_list` TEXT)   BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE winner_name varchar(100) DEFAULT "";
   #Cursor declaration
      DEClARE curName
        CURSOR FOR
             SELECT name FROM winner WHERE year_of_winning = 2019 LIMIT 10;
               #declare NOT FOUND handler
               DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    #Open cursor
               OPEN curName;
    #fetch records
               getName: LOOP
                              FETCH curName INTO winner_name;
                              IF finished = 1 THEN LEAVE getName;
                              END IF;
                              SET winner_name_list = CONCAT(winner_name,";",winner_name_list);
               END LOOP getName;
               CLOSE curName;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `votingstatus` (`v` INT) RETURNS VARCHAR(100) CHARSET utf8mb4  BEGIN
 
	DECLARE status_msg varchar(100);
    
    IF v>1 THEN  
	   SET status_msg = 'voting done';
	   
	ELSE 
	   SET status_msg = 'yet to vote';  
    END IF;
	RETURN status_msg;
	
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `votingstatus1` (`v_id` INT) RETURNS VARCHAR(100) CHARSET utf8mb4  BEGIN
	DECLARE status_msg varchar(100);
    IF (v_id in (SELECT distinct voters_id from votes)) THEN  
	   SET status_msg = 'voting done';
	   
	ELSE 
	   SET status_msg = 'yet to vote';  
    END IF;
	RETURN status_msg;
	
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_no` bigint(20) DEFAULT NULL,
  `photo` varchar(150) DEFAULT NULL,
  `created_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `firstname`, `lastname`, `email`, `phone_no`, `photo`, `created_on`) VALUES
(1, 'Admin', '$2y$10$Sh5RFtZ/Y9wtQ3PVgTVeteqoG5kCg4hPb9mSpZVfncKdhvnBLBdP6', 'Bavanika', 'V', 'pesug20cs374@pesu.pes.edu', 9823778248, 'ad.png', '2022-09-23'),
(2, 'Admin1', '$2y$10$Sh5RFtZ/Y9wtQ3PVgTVeteqoG5kCg4hPb9mSpZVfncKdhvnBLBdP6', 'Joe', 'Ann', NULL, 7264872564, 'ad.jpeg', '2022-09-23');

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `photo` varchar(150) NOT NULL,
  `platform` text NOT NULL,
  `dob` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_no` bigint(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`id`, `position_id`, `firstname`, `lastname`, `photo`, `platform`, `dob`, `age`, `email`, `phone_no`, `gender`) VALUES
(22, 14, 'Ayaan', 'Pandey', 'sport_icon.jfif', 'I\'m Ayaan Pandey, currently in final year. ', '1998-05-08', 24, 'panAyan231@gmail.com', 9328627245, 'Male'),
(23, 14, 'Pankuri', 'Singh', 'sp_w.jfif', 'I\'m Pankuri Sign, currently pursuing M.tech in ECE', '1995-08-04', 27, 'SiGhkuri.986@gmail.com', 8467243729, 'Female'),
(25, 10, 'Ishika', 'Ranjan', 'profile.jpg', 'I\'m Ishika Ranjan, currently in final year. ', '1996-04-03', 26, 'ishuuu3120@yahoo.com', 9284678221, 'Female'),
(26, 11, 'Deepak', 'Reddy', 'profile.jpg', 'I\'m Deepak Reddy, currently pursuing M.tech in ECE', '1998-02-11', 24, 'dpk813reddy@gmail.com', 6242710813, 'Male'),
(27, 11, 'Akanksha', 'Pilla', 'profile.jpg', 'I\'m Akanksha Pilla , currently pursuing Ph.D. My current interests are magnetic fields', '2000-12-30', 22, NULL, 8264872152, 'Female'),
(28, 11, 'Meghana', ' Gupta', 'profile.jpg', 'I\'m Meghana Gupta, currently in final year. ', '1996-11-25', 26, 'GuptGHAaaa110@gmail.com', 9274201468, 'Female'),
(29, 12, 'Vikrant', 'Annamalai', 'profile.jpg', 'I\'m Vikrant Annamalai, currently pursuing M.tech in ECE', '1991-08-17', 31, NULL, 7735231009, 'Male'),
(30, 12, 'Furqan', 'Mouhamad', 'profile.jpg', 'I\'m  Furqan Mouhamad, currently pursuing M.tech in ECE', '1996-09-01', 26, 'MouhhQFur1810@gmail.com', 6181319017, 'Male');

--
-- Triggers `candidates`
--
DELIMITER $$
CREATE TRIGGER `candidate_age_check` BEFORE INSERT ON `candidates` FOR EACH ROW BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('candidates age should be between 20 and 35');  
    IF new.age > 35 or new.age<20 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `election`
--

CREATE TABLE `election` (
  `E_id` int(11) NOT NULL,
  `E_name` varchar(100) NOT NULL,
  `Year_of_conduction` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `election`
--

INSERT INTO `election` (`E_id`, `E_name`, `Year_of_conduction`) VALUES
(2854, 'University Elections', 2018),
(3473, 'Cultural Event Heads Selection ', 2019),
(3851, 'College Club Elections', 2020),
(4243, 'University Elections', 2020),
(4244, 'Cultural Event Heads Selection ', 2021),
(4245, 'University Elections', 2022);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `password`) VALUES
('Admin', '$2y$10$Sh5RFtZ/Y9wtQ3PVgTVeteqoG5kCg4hPb9mSpZVfncKdhvnBLBdP6'),
('Admin1', '$2y$10$Sh5RFtZ/Y9wtQ3PVgTVeteqoG5kCg4hPb9mSpZVfncKdhvnBLBdP6'),
('xi251YPJMUvmhcL', '$2y$10$rgOnoKou3peqlZIWG4qMku1.pXZkSVn7ViCC0yp3HGR8CWI0aQ9ou'),
('rHpvgqP9s7WNKXB', '$2y$10$lGLn/1tBO8.U0MS.5wSf4.e2ez5GwM7SGn0g70T2AFb2ZfcMubko6'),
('9XanpSMBILRbhim', '$2y$10$gNnFxL6UYJ/7.D/REV74b.UvgY11Pzes1qD0N19Vnn5cex0wGh3ti'),
('JQLU4hqFoO3id6W', '$2y$10$gEEoUr5SPRDTqsaPDYVRUul21kOly5xdcVLLuUL/2kGcNWNruJd2u'),
('B6kdKFt1H3Vgw7n', '$2y$10$uVZNeiC/udJhT8Far4rMZuoyMZgmwT1XPzrOveOTx4ObqzFeIUGOq'),
('v6sIXcjYK2qAax8', '$2y$10$uJvschwO0xUIVcGYmU3mQ.L5tW0Zbu9dgECk2tqLT2QnFnfEZVs1i'),
('YSl1EtPiZj9Mrs2', '$2y$10$V0kFrhDbrJ.4vkFOGBSCSeGvQbWiSGG6N.II2Bfg6f.92j3x.HCiW'),
('aMIwSEX4813vKqU', '$2y$10$xjtBjomdSF1.Z5NOf2aGdeKisx4an7y/PDuOUoA1WNhj0Jmfir0KK'),
('smCStHi8PwXU4pb', '$2y$10$0ub6lkOZZ6KDahNz8Ls3i./MqXJ3uhu7kPJJG.OHAs0wDOOjnQgRm'),
('LsDwdqSRPUTBjFf', '$2y$10$RXaijeI9vWFAnEGjdMkRleC2BRQVMuNx1IFwHzhuuWsnVkOAIhGGq'),
('NSRLtv2TzxFMkUW', '$2y$10$V91.RfBQlLVIwuq0hlYkn.kaO2xCTKWm4zs1nDbf6Sd0RymoAwAzu'),
('y2UhBMizIxdcRlJ', '$2y$10$/i6GRQe01H4CzJDl3Lbv1ORlzztnTrB5N3.eafLna5QOEoME/sE9S'),
('762JwjX1FgSlMpO', '$2y$10$m0dRxe.ULZUJqLsEzZUquOA7Fa2WIFNQMvIwGQpJcOMYj8KxsRv22'),
('sAZE7d2hipcGbL8', '$2y$10$qrdTvaBLkv8F4IoDQurcYexahEtyxunGzefgvAGyXmQDuFLa0D4X.'),
('SQAUKhf2HICucVn', '$2y$10$153A9l/i2ykIWuzt7xYx8uPSc3Kaba.54QtDiU7QWW/ZHRFZAX2T.'),
('8NTM1VeaCFyg5sn', '$2y$10$h8ZLzi7u//cUbQVTsIaERed4LCVLZm1.lQRPlI2CaJEAJHda2MndO'),
('18mcQYnzkXFauVp', '$2y$10$/1GHCKQzj/gMceamtPn44.//WMIZ4VweNiq82f8lYkt9yyB/5ZH2S'),
('oakmgIunRCAtPx3', '$2y$10$ea6Ct5cjMZa1BjqWitkSK.r68nX6wRYdbgDRlpWjghA1InB8QCLFW'),
('L7GN6kBltyhRW8q', '$2y$10$rRrAc04.qZOkh1CDQb/lzuBZtSkcABBP5zPqbdV6BKFEzq83MGxWO'),
('Q7AHgYwK2ql5voa', '$2y$10$PbuJbCWm.xXMjKCkPXf/CunM56pAnG/39G/39tU1uD.gbGdpnsF52'),
('CwJGWh5EDyLju4a', '$2y$10$Awep0Ofvo7QoHSF6/nuDhO8hRMuzNvCzqvIpp2WOxM3.DY5fqjgOW');

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `id` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `max_vote` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `E_id` int(11) DEFAULT 4245
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `description`, `max_vote`, `priority`, `E_id`) VALUES
(10, 'President', 1, 1, 4245),
(11, 'Vice President', 1, 2, 4245),
(12, 'Student Counsel Head', 1, 3, 4245),
(14, 'Sports Captain', 1, 4, 4245);

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

CREATE TABLE `voters` (
  `id` int(11) NOT NULL,
  `voters_id` varchar(15) NOT NULL,
  `password` varchar(60) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `photo` varchar(150) NOT NULL,
  `gender` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `voters`
--

INSERT INTO `voters` (`id`, `voters_id`, `password`, `firstname`, `lastname`, `dob`, `age`, `email`, `photo`, `gender`) VALUES
(4, 'xi251YPJMUvmhcL', '$2y$10$rgOnoKou3peqlZIWG4qMku1.pXZkSVn7ViCC0yp3HGR8CWI0aQ9ou', 'Ayaan', 'Pandey', '1998-05-08', 24, 'panAyan231@gmail.com', 'profile.jpg', 'Male'),
(5, 'rHpvgqP9s7WNKXB', '$2y$10$lGLn/1tBO8.U0MS.5wSf4.e2ez5GwM7SGn0g70T2AFb2ZfcMubko6', 'Pankuri', 'Singh', '1998-09-28', 24, 'SiGhkuri.986@gmail.com', 'profile.jpg', 'Female'),
(6, '9XanpSMBILRbhim', '$2y$10$gNnFxL6UYJ/7.D/REV74b.UvgY11Pzes1qD0N19Vnn5cex0wGh3ti', 'Reyansh', 'Shah', '1994-12-19', 27, 'yashHH55shaaa@gmail.com', 'profile.jpg', 'Male'),
(7, 'JQLU4hqFoO3id6W', '$2y$10$gEEoUr5SPRDTqsaPDYVRUul21kOly5xdcVLLuUL/2kGcNWNruJd2u', 'Ishika', 'Ranjan', '1996-04-03', 26, 'ishuuu3120@yahoo.com', 'profile.jpg', 'Female'),
(8, 'B6kdKFt1H3Vgw7n', '$2y$10$uVZNeiC/udJhT8Far4rMZuoyMZgmwT1XPzrOveOTx4ObqzFeIUGOq', 'Deepak', 'Reddy', '1998-02-11', 24, 'dpk813reddy@gmail.com', 'profile.jpg', 'Male'),
(9, 'v6sIXcjYK2qAax8', '$2y$10$uJvschwO0xUIVcGYmU3mQ.L5tW0Zbu9dgECk2tqLT2QnFnfEZVs1i', 'Akanksha', 'Pilla', '2000-12-30', 22, NULL, 'profile.jpg', 'Female'),
(10, 'YSl1EtPiZj9Mrs2', '$2y$10$V0kFrhDbrJ.4vkFOGBSCSeGvQbWiSGG6N.II2Bfg6f.92j3x.HCiW', 'Meghana', 'Gupta', '1996-11-25', 26, 'MeghhGG7712@gmail.com', 'profile.jpg', 'Female'),
(11, 'aMIwSEX4813vKqU', '$2y$10$xjtBjomdSF1.Z5NOf2aGdeKisx4an7y/PDuOUoA1WNhj0Jmfir0KK', 'Vikrant', 'Annamalai', '1991-08-17', 31, 'AkV12sad@gmail.com', 'profile.jpg', 'Male'),
(12, 'smCStHi8PwXU4pb', '$2y$10$0ub6lkOZZ6KDahNz8Ls3i./MqXJ3uhu7kPJJG.OHAs0wDOOjnQgRm', 'Saba', 'Shaik', '1996-09-01', 26, NULL, 'profile.jpg', 'Female'),
(13, 'LsDwdqSRPUTBjFf', '$2y$10$RXaijeI9vWFAnEGjdMkRleC2BRQVMuNx1IFwHzhuuWsnVkOAIhGGq', 'Vivek', 'Rapaka', '2002-12-08', 20, 'vivek18Rap@gamil.com', 'profile.jpg', 'Male'),
(14, 'NSRLtv2TzxFMkUW', '$2y$10$V91.RfBQlLVIwuq0hlYkn.kaO2xCTKWm4zs1nDbf6Sd0RymoAwAzu', 'Hannah', 'Dayle', '1999-04-19', 23, NULL, 'profile.jpg', 'Female'),
(15, 'y2UhBMizIxdcRlJ', '$2y$10$/i6GRQe01H4CzJDl3Lbv1ORlzztnTrB5N3.eafLna5QOEoME/sE9S', 'Marina', 'Khanna', '1993-11-28', 29, 'Khannamy2312@yahoo.com', 'profile.jpg', 'Female'),
(16, '762JwjX1FgSlMpO', '$2y$10$m0dRxe.ULZUJqLsEzZUquOA7Fa2WIFNQMvIwGQpJcOMYj8KxsRv22', 'Eve', 'Pabullo', '1999-11-11', 23, 'Evepabullo173042@gmail.com', 'profile.jpg', 'Female'),
(17, 'sAZE7d2hipcGbL8', '$2y$10$qrdTvaBLkv8F4IoDQurcYexahEtyxunGzefgvAGyXmQDuFLa0D4X.', 'Zareena', 'Hussain', '1995-01-18', 27, 'HZzzhus@gmail.com', 'profile.jpg', 'Female'),
(18, 'SQAUKhf2HICucVn', '$2y$10$153A9l/i2ykIWuzt7xYx8uPSc3Kaba.54QtDiU7QWW/ZHRFZAX2T.', 'Yusaf', 'Khan', '1999-07-13', 23, 'YuYuu123@gmail.com', 'profile.jpg', 'Male'),
(19, '8NTM1VeaCFyg5sn', '$2y$10$h8ZLzi7u//cUbQVTsIaERed4LCVLZm1.lQRPlI2CaJEAJHda2MndO', 'Anish', 'Kumar', '1993-09-27', 29, NULL, 'sport_icon.jfif', 'Male'),
(20, '18mcQYnzkXFauVp', '$2y$10$/1GHCKQzj/gMceamtPn44.//WMIZ4VweNiq82f8lYkt9yyB/5ZH2S', 'Abbas', 'Kureshi', '1991-08-17', 31, 'kukuabbbas@yahoo.com', 'profile.jpg', 'Male'),
(21, 'oakmgIunRCAtPx3', '$2y$10$ea6Ct5cjMZa1BjqWitkSK.r68nX6wRYdbgDRlpWjghA1InB8QCLFW', 'Aisha', 'Malhotra', '1990-03-18', 32, NULL, 'profile.jpg', 'Female'),
(22, 'L7GN6kBltyhRW8q', '$2y$10$rRrAc04.qZOkh1CDQb/lzuBZtSkcABBP5zPqbdV6BKFEzq83MGxWO', 'Neelima', 'Prabhakaran', '1997-12-19', 25, 'P.Neeli41maa@gmail.com', 'profile.jpg', 'Female'),
(24, 'CwJGWh5EDyLju4a', '$2y$10$Awep0Ofvo7QoHSF6/nuDhO8hRMuzNvCzqvIpp2WOxM3.DY5fqjgOW', 'Furqan', 'Mouhamad', '1996-09-01', 26, 'MouhhQFur1810@gmail.com', 'profile.jpg', 'Male');

--
-- Triggers `voters`
--
DELIMITER $$
CREATE TRIGGER `age_check` BEFORE INSERT ON `voters` FOR EACH ROW BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('voters cannot have age  < 18');  
    IF new.age < 18 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `voters_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `voters_id`, `candidate_id`, `position_id`) VALUES
(83, 23, 25, 10),
(84, 23, 26, 11),
(85, 23, 30, 12),
(86, 23, 22, 14),
(87, 9, 25, 10),
(88, 9, 27, 11),
(89, 9, 29, 12),
(90, 9, 23, 14),
(91, 15, 24, 10),
(92, 15, 26, 11),
(93, 15, 30, 12),
(94, 15, 22, 14),
(95, 6, 24, 10),
(96, 6, 26, 11),
(97, 6, 30, 12),
(98, 6, 23, 14),
(100, 19, 25, 10),
(101, 19, 27, 11),
(102, 19, 29, 12),
(103, 19, 23, 14);

-- --------------------------------------------------------

--
-- Table structure for table `winner`
--

CREATE TABLE `winner` (
  `name` varchar(255) DEFAULT NULL,
  `election_name` varchar(100) DEFAULT NULL,
  `position_name` varchar(100) DEFAULT NULL,
  `election_id` int(11) DEFAULT NULL,
  `position_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  `Year_of_winning` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `winner`
--

INSERT INTO `winner` (`name`, `election_name`, `position_name`, `election_id`, `position_id`, `candidate_id`, `Year_of_winning`) VALUES
('Devansh Kumar', 'University Elections', 'Club Head', 2854, 735, 13, 2018),
('Nandana Gopal', 'University Elections', 'President', 2854, 713, 138, 2018),
('Varsha Vishwanathan', 'University Elections', 'Vice-President', 2854, 722, 21, 2018),
('Kanishq Dubey', 'University Elections', 'Sports Captain', 2854, 735, 53, 2018),
('Anna', 'Cultural Event Heads Selection', 'Event Head', 3473, 253, 524, 2019),
('Zaffar', 'Cultural Event Heads Selection', 'Sponsership Head', 3473, 768, 642, 2019),
('Tina Agarwal', 'Cultural Event Heads Selection', 'Logistics Head', 3473, 134, 513, 2019),
('Harsha Jayendra Varma', 'Cultural Event Heads Selection', 'Design Head', 3473, 654, 271, 2019),
('Megha Niranjan', 'Cultural Event Heads Selection', 'Volunteering Head', 3473, 851, 21, 2019),
('Tina Agarwal', 'Cultural Event Heads Selection', 'Logistics Head', 3473, 134, 513, 2019),
('Vikrant Annamalai', 'IEE Club Elections', 'Chair', 3851, 134, 462, 2020),
('Sana Alam', 'IEE Club Elections', 'Vice-Chair', 3851, 254, 382, 2020),
('Revanth Gowda', 'IEE Club Elections', 'Seceretry', 3851, 916, 12, 2020),
('John ', 'IEE Club Elections', 'Team Lead', 3851, 422, 455, 2020),
('Michael Philip', 'University Elections', 'President', 4243, 85, 546, 2020),
('Joshna Shivakumar', 'University Elections', 'Vice-President', 4243, 71, 324, 2020),
('Prabha Anand', 'University Elections', 'Sports Captain', 4243, 536, 770, 2020),
('Vishnu Leo', 'University Elections', 'Student Counsel Head', 4243, 63, 12, 2020);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `election`
--
ALTER TABLE `election`
  ADD PRIMARY KEY (`E_id`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- AUTO_INCREMENT for table `election`
--
ALTER TABLE `election`
  MODIFY `E_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4248;

--
-- AUTO_INCREMENT for table `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `Actor` (
  `name` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Actor` (`name`, `lastname`, `title`) VALUES
('Emma', 'Stone', 'Birdman or (The Unexpected Virtue of Ignorance)'),
('Jake', 'Gyllenhaal', 'Birdman or (The Unexpected Virtue of Ignorance)'),
('Paul', 'Reiser', 'Birdman or (The Unexpected Virtue of Ignorance)'),
('Christian', 'Bale', 'Jurassic World '),
('Alejandro ', 'G. Iñárritu', 'Source Code '),
('Jake', 'Gyllenhaal', 'Source Code '),
('Christopher', 'Nolan', 'Star Wars: Episode VII - The Force Awakens'),
('Emma', 'Stone', 'Star Wars: Episode VII - The Force Awakens'),
('Michael', 'Keaton', 'Star Wars: Episode VII - The Force Awakens'),
('Aaron', 'Eckhart', 'The Dark Knight '),
('Christopher', 'Nolan', 'The Dark Knight '),
('Heath', 'Ledger', 'The Dark Knight '),
('Zach', 'Galifianakis', 'The Dark Knight '),
('Christian', 'Bale', 'Whiplash'),
('Emma', 'Stone', 'Whiplash');

CREATE TABLE `Award` (
  `name` varchar(255) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Award` (`name`, `description`) VALUES
('BAFTA Film Award', NULL),
('Oscar', NULL),
('Saturn Award', NULL);

CREATE TABLE `Award_Movie` (
  `title` varchar(255) NOT NULL,
  `award_name` varchar(255) NOT NULL,
  `date_of_award` year(4) NOT NULL,
  `status` enum('Candidate','Winner') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Award_Movie` (`title`, `award_name`, `date_of_award`, `status`) VALUES
('Birdman or (The Unexpected Virtue of Ignorance)', 'BAFTA Film Award', 2014, 'Candidate'),
('Birdman or (The Unexpected Virtue of Ignorance)', 'Oscar', 2015, 'Winner'),
('Source Code ', 'Saturn Award', 2011, 'Candidate'),
('The Dark Knight ', 'Oscar', 2008, 'Winner'),
('Whiplash', 'Oscar', 2015, 'Winner');

CREATE TABLE `Award_Person` (
  `name` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `award_name` varchar(255) NOT NULL,
  `date_of_award` year(4) NOT NULL,
  `status` enum('Candidate','Winner') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Award_Person` (`name`, `lastname`, `award_name`, `date_of_award`, `status`) VALUES
('Aaron', 'Eckhart', 'Oscar', 2014, 'Candidate'),
('Christopher', 'Nolan', 'BAFTA Film Award', 2008, 'Winner'),
('Emma', 'Stone', 'Oscar', 2015, 'Winner'),
('Emma', 'Stone', 'Saturn Award', 2007, 'Winner'),
('Heath', 'Ledger', 'Oscar', 2008, 'Winner'),
('J.J.', 'Abrams', 'Oscar', 2015, 'Winner');

CREATE TABLE `Bonus_Card` (
  `card_id` int(5) NOT NULL,
  `bonus_points` int(3) DEFAULT NULL,
  `free_tickets` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Bonus_Card` (`card_id`, `bonus_points`, `free_tickets`) VALUES
(100, 187, 6),
(101, 111, 0),
(102, 82, 0),
(103, 50, 2),
(104, 88, 0),
(105, 154, 1);
DELIMITER $$
CREATE TRIGGER `Points_Trigger` BEFORE UPDATE ON `Bonus_Card` FOR EACH ROW BEGIN
IF (NEW.bonus_points >= 200) THEN
SET NEW.bonus_points = NEW.bonus_points-200;
SET NEW.free_tickets = OLD.free_tickets + 2;
INSERT INTO Free_tickets(card_id,date_of_winning)
VALUES(NEW.card_id,CURDATE());
END IF;

END
$$
DELIMITER ;

CREATE TABLE `Customer` (
  `id` int(5) NOT NULL,
  `birthday` date DEFAULT NULL,
  `marital_status` set('Married','Single','0-1 Children','2-4 Children','4+ Children') DEFAULT NULL,
  `sex` enum('Male','Female') DEFAULT NULL,
  `card_id` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Customer` (`id`, `birthday`, `marital_status`, `sex`, `card_id`) VALUES
(1, '1990-10-09', 'Married', 'Male', 100),
(2, '1992-12-30', 'Married', 'Female', 100),
(3, '1990-01-06', 'Single', 'Female', 101),
(4, '1987-08-01', 'Married,0-1 Children', 'Female', 104),
(5, '2000-08-15', 'Single', 'Male', 105),
(6, NULL, 'Married,2-4 Children', 'Male', 102),
(7, '1990-11-03', 'Married,2-4 Children', 'Female', 102),
(8, '1980-10-05', 'Single', 'Female', 105);

CREATE TABLE `Director` (
  `name` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Director` (`name`, `lastname`, `title`) VALUES
('J.J.', 'Abrams', 'Birdman or (The Unexpected Virtue of Ignorance)'),
('Zach', 'Galifianakis', 'Birdman or (The Unexpected Virtue of Ignorance)'),
('Aaron', 'Eckhart', 'Jurassic World '),
('Duncan', 'Jones', 'Source Code '),
('Michael', 'Keaton', 'Source Code '),
('J.J.', 'Abrams', 'Star Wars: Episode VII - The Force Awakens'),
('Christian', 'Bale', 'The Dark Knight '),
('Christopher', 'Nolan', 'The Dark Knight '),
('Alejandro ', 'G. Iñárritu', 'Whiplash'),
('Christopher', 'Nolan', 'Whiplash');

CREATE TABLE `Employee` (
  `name` varchar(25) DEFAULT NULL,
  `lastname` varchar(25) DEFAULT NULL,
  `id` int(5) NOT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `years` int(2) DEFAULT NULL,
  `bio` text,
  `hourly_salary` int(4) NOT NULL,
  `job` enum('Cashier','Usher','Cleaner','Manager') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Employee` (`name`, `lastname`, `id`, `degree`, `starting_date`, `years`, `bio`, `hourly_salary`, `job`) VALUES
('Steven', 'Lopez', 1, 'Chemistry', '2014-01-01', 10, NULL, 2, 'Cashier'),
('Rose', 'Sanders', 2, 'Physics', '2015-01-01', 5, NULL, 2, 'Cashier'),
('Martin', 'Welch', 3, NULL, NULL, NULL, NULL, 2, 'Cashier'),
('Brian', 'Armstrong', 4, NULL, NULL, NULL, NULL, 2, 'Cashier'),
('Wanda', 'Griffin', 5, NULL, NULL, NULL, NULL, 2, 'Cashier'),
('Catherine', 'Daniels', 6, NULL, NULL, NULL, NULL, 2, 'Cashier'),
('Anna', 'Miller', 7, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Louise', 'Lopez', 8, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Jack', 'Wills', 9, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Marie', 'Wood', 10, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Julia', 'Butler', 11, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Samuel', 'Stevens', 12, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Debra', 'Romero', 13, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Carlos', 'Ford', 14, NULL, NULL, NULL, NULL, 3, 'Usher'),
('Jeremy', 'Reid', 15, NULL, NULL, NULL, NULL, 4, 'Cleaner'),
('Jack', 'Gibson', 16, NULL, NULL, NULL, NULL, 4, 'Cleaner'),
('Judy', 'Michel', 17, NULL, NULL, NULL, NULL, 4, 'Cleaner'),
('Joe', 'Flores', 18, NULL, NULL, NULL, NULL, 4, 'Cleaner'),
('Roger', 'Long', 19, NULL, NULL, NULL, NULL, 5, 'Manager'),
('Olivia', 'Reed', 20, NULL, NULL, NULL, NULL, 5, 'Manager'),
('John', 'Doe', 21, NULL, NULL, NULL, NULL, 5, 'Manager');

CREATE TABLE `Free_tickets` (
  `card_id` int(5) NOT NULL,
  `date_of_winning` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Free_tickets` (`card_id`, `date_of_winning`) VALUES
(100, '2016-08-05'),
(100, '2016-08-06'),
(100, '2016-08-21'),
(103, '2008-03-12'),
(105, '2016-08-07');

CREATE TABLE `Genre` (
  `title` varchar(255) DEFAULT NULL,
  `genre` set('Action','Adventure','Animation','Biography','Comedy','Documentary','Fantasy','Drama','Horror','Mystery','Romance','Sci-Fi','Thriller') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Genre` (`title`, `genre`) VALUES
('Birdman or (The Unexpected Virtue of Ignorance)', 'Adventure,Biography'),
('Jurassic World ', 'Adventure,Thriller'),
('Source Code ', 'Action,Mystery'),
('Star Wars: Episode VII - The Force Awakens', 'Adventure,Fantasy,Sci-Fi'),
('The Dark Knight ', 'Action,Adventure,Fantasy,Mystery'),
('Whiplash', 'Biography');

CREATE TABLE `Movie` (
  `title` varchar(255) NOT NULL,
  `plot` text,
  `date_of_production` year(4) DEFAULT NULL,
  `Duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Movie` (`title`, `plot`, `date_of_production`, `Duration`) VALUES
('Birdman or (The Unexpected Virtue of Ignorance)', 'Illustrated upon the progress of his latest Broadway play, a former popular actor\'s struggle to cope with his current life as a wasted actor is shown.', 2014, 120),
('Jurassic World ', 'A new theme park is built on the original site of Jurassic Park. Everything is going well until the park\'s newest attraction - a genetically modified giant stealth killing machine - escapes containment and goes on a killing spree.', 2015, 130),
('Source Code ', 'A soldier wakes up in someone else\'s body and discovers he\'s part of an experimental government program to find the bomber of a commuter train. A mission he has only 8 minutes to complete.', 2011, 100),
('Star Wars: Episode VII - The Force Awakens', 'Three decades after the defeat of the Galactic Empire, a new threat arises. The First Order attempts to rule the galaxy and only a ragtag group of heroes can stop them, along with the help of the Resistance.', 2015, 180),
('The Dark Knight ', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.', 2008, 240),
('Whiplash', 'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student\'s potential.', 2014, 60);

CREATE TABLE `Movies_Watched` (
  `id` int(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `rating` enum('1','2','3','4','5') DEFAULT NULL,
  `date_watched` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Movies_Watched` (`id`, `title`, `rating`, `date_watched`) VALUES
(1, 'Source Code ', '3', '2016-08-07'),
(1, 'The Dark Knight ', '4', '2016-08-14'),
(1, 'Whiplash', '4', '2016-08-15'),
(2, 'Source Code ', '5', '2016-08-07'),
(2, 'Star Wars: Episode VII - The Force Awakens', '5', '2016-08-06'),
(2, 'The Dark Knight ', '5', '2016-08-14'),
(2, 'Whiplash', '5', '2016-08-15'),
(3, 'Source Code ', '5', '2016-08-07'),
(3, 'Star Wars: Episode VII - The Force Awakens', '3', '2016-08-06'),
(3, 'The Dark Knight ', '5', '2016-08-14'),
(3, 'Whiplash', '5', '2016-08-15'),
(4, 'Source Code ', '3', '2016-08-07'),
(4, 'Star Wars: Episode VII - The Force Awakens', '5', '2016-08-06'),
(4, 'Whiplash', '4', '2016-08-15'),
(5, 'Birdman or (The Unexpected Virtue of Ignorance)', '5', '2016-08-05'),
(5, 'Source Code ', '2', '2016-08-07'),
(5, 'Star Wars: Episode VII - The Force Awakens', '4', '2016-08-06'),
(5, 'The Dark Knight', '4', '2016-08-14'),
(5, 'Whiplash', '3', '2016-08-15'),
(6, 'Source Code ', '4', '2016-08-07'),
(6, 'Star Wars: Episode VII - The Force Awakens', '5', '2016-08-06'),
(6, 'Whiplash', '2', '2016-08-15'),
(7, 'Star Wars: Episode VII - The Force Awakens', '4', '2016-08-06');

CREATE TABLE `Person` (
  `name` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `bio` text,
  `photo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Person` (`name`, `lastname`, `bio`, `photo`) VALUES
('Aaron', 'Eckhart', NULL, NULL),
('Alejandro ', 'G. Iñárritu', 'Alejandro González Iñárritu (ih-nyar-ee-too), born August 15th, 1963, is a Mexican film director. González Iñárritu is the first Mexican director to be nominated for the Academy Award for Best Director and by the Directors Guild of America for Best Director. He is also the first Mexican-born director to have won the Prix de la mise en scene', NULL),
('Christian', 'Bale', NULL, NULL),
('Christopher', 'Nolan', NULL, NULL),
('Duncan', 'Jones', NULL, NULL),
('Emma', 'Stone', NULL, NULL),
('Heath', 'Ledger', NULL, NULL),
('J.J.', 'Abrams', NULL, NULL),
('J.K.', 'Simons', 'J.K. Simmons\r\nActor | Producer | Soundtrack\r\nJ.K. Simmons is an American actor. He was born Jonathan Kimble Simmons in Grosse Pointe, Michigan, to Patricia (Kimble), an administrator, and Donald William Simmons, a music teacher. He attended the Ohio State University, Columbus, OH; University of Montana, Missoula, MT (BA in Music). He had originally planned to be a singer', 'http://www.imdb.com/name/nm0799777/?ref_=tt_cl_t2'),
('Jake', 'Gyllenhaal', NULL, NULL),
('Michael', 'Keaton', NULL, NULL),
('Michelle', 'Monaghan', NULL, NULL),
('Miles', 'Teller', 'Miles Alexander Teller is an American actor and musician. For his performance in the film The Spectacular Now (2013), he won the Dramatic Special Jury Award for Acting at the 2013 Sundance Film Festival. He has appeared in the films Rabbit Hole (2010), Footloose (2011), Project X (2012), That Awkward Moment (2014), Divergent (2014), ', 'http://www.imdb.com/name/nm1886602/mediaviewer/rm470610432?ref_=nm_ov_ph'),
('Paul', 'Reiser', 'As a seasoned actor, writer, and stand-up comedian, Paul Reiser continues to add to his list of accomplishments. In addition to co-creating and starring in the critically-acclaimed NBC series, Mad About You (1992), which garnered him Emmy, Golden Globe, American Comedy Award and Screen Actors Guild nominations for Best Actor in a Comedy Series,', 'http://www.imdb.com/name/nm0001663/?ref_=tt_cl_t3'),
('Zach', 'Galifianakis', NULL, NULL);

CREATE TABLE `Schedule` (
  `id` int(5) NOT NULL,
  `working_date` date NOT NULL,
  `shift` enum('Morning','Afternoon') DEFAULT NULL,
  `screen` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Schedule` (`id`, `working_date`, `shift`, `screen`) VALUES
(1, '2016-08-05', 'Morning', NULL),
(1, '2016-08-06', 'Afternoon', NULL),
(1, '2016-08-07', 'Morning', NULL),
(1, '2016-08-09', 'Morning', NULL),
(2, '2016-08-05', 'Morning', NULL),
(2, '2016-08-06', 'Afternoon', NULL),
(2, '2016-08-07', 'Morning', NULL),
(2, '2016-08-09', 'Morning', NULL),
(3, '2016-08-05', 'Morning', NULL),
(3, '2016-08-06', 'Afternoon', NULL),
(3, '2016-08-07', 'Morning', NULL),
(3, '2016-08-09', 'Morning', NULL),
(4, '2016-08-05', 'Afternoon', NULL),
(4, '2016-08-06', 'Morning', NULL),
(4, '2016-08-07', 'Afternoon', NULL),
(5, '2016-08-05', 'Afternoon', NULL),
(5, '2016-08-06', 'Morning', NULL),
(5, '2016-08-07', 'Afternoon', NULL),
(6, '2016-08-05', 'Afternoon', NULL),
(6, '2016-08-06', 'Morning', NULL),
(6, '2016-08-07', 'Afternoon', NULL),
(7, '2016-08-05', 'Morning', 11),
(7, '2016-08-06', 'Afternoon', 11),
(7, '2016-08-07', 'Morning', 11),
(8, '2016-08-05', 'Morning', 12),
(8, '2016-08-06', 'Afternoon', 12),
(8, '2016-08-07', 'Morning', 12),
(9, '2016-08-05', 'Morning', 21),
(9, '2016-08-06', 'Afternoon', 21),
(9, '2016-08-07', 'Morning', 21),
(10, '2016-08-05', 'Morning', 22),
(10, '2016-08-06', 'Afternoon', 22),
(10, '2016-08-07', 'Morning', 22),
(11, '2016-08-05', 'Afternoon', 11),
(11, '2016-08-06', 'Morning', 11),
(11, '2016-08-07', 'Afternoon', 11),
(11, '2016-08-09', 'Morning', 11),
(12, '2016-08-05', 'Afternoon', 12),
(12, '2016-08-06', 'Morning', 12),
(12, '2016-08-07', 'Afternoon', 12),
(13, '2016-08-05', 'Afternoon', 21),
(13, '2016-08-06', 'Morning', 21),
(13, '2016-08-07', 'Afternoon', 21),
(14, '2016-08-05', 'Afternoon', 22),
(14, '2016-08-06', 'Morning', 22),
(14, '2016-08-07', 'Afternoon', 22),
(15, '2016-08-05', 'Morning', NULL),
(15, '2016-08-06', 'Afternoon', NULL),
(15, '2016-08-07', 'Morning', NULL),
(16, '2016-08-05', 'Morning', NULL),
(16, '2016-08-06', 'Afternoon', NULL),
(16, '2016-08-07', 'Morning', NULL),
(17, '2016-08-05', 'Afternoon', NULL),
(17, '2016-08-06', 'Morning', NULL),
(17, '2016-08-07', 'Afternoon', NULL),
(18, '2016-08-05', 'Afternoon', NULL),
(18, '2016-08-06', 'Morning', NULL),
(18, '2016-08-07', 'Afternoon', NULL),
(19, '2016-08-05', 'Morning', NULL),
(19, '2016-08-06', 'Afternoon', NULL),
(19, '2016-08-07', 'Morning', NULL),
(20, '2016-08-05', 'Afternoon', NULL),
(20, '2016-08-06', 'Morning', NULL),
(20, '2016-08-07', 'Afternoon', NULL);
DELIMITER $$
CREATE TRIGGER `validateWorktime` BEFORE INSERT ON `Schedule` FOR EACH ROW BEGIN
DECLARE tempDate DATE;
DECLARE job_count INT(2);
DECLARE job enum('Cashier', 'Usher', 'Cleaner', 'Manager');



SELECT Schedule.working_date INTO tempDate FROM Schedule WHERE Schedule.id = NEW.id AND Schedule.working_date = NEW.working_date;
IF(tempDate IS NOT NULL) THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'This employee has already been assigned a shift for this day';
END IF;




SELECT Employee.job INTO job FROM Employee WHERE Employee.id = NEW.id;
SELECT count(Employee.job) INTO job_count FROM Employee INNER JOIN Schedule ON Employee.id = Schedule.id
WHERE Schedule.shift= NEW.shift AND Schedule.working_date = NEW.working_date AND Employee.job = job GROUP BY(Employee.job);
IF (job = 'Cashier' AND job_count>=3) THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'There are enough Cashiers for this shift';
ELSEIF (job = 'Usher' AND job_count>=4) THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'There are enough Ushers for this shift'; 
ELSEIF (job = 'Cleaner' AND job_count>=2) THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'There are enough Cleaners for this shift';
ELSEIF (job = 'Manager' AND job_count>=1) THEN
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'There are enough Managers for this shift';
END IF;
END
$$
DELIMITER ;

CREATE TABLE `Screen` (
  `name` int(2) NOT NULL,
  `capacity` int(2) DEFAULT NULL,
  `air_conditioning` tinyint(1) DEFAULT NULL,
  `floor` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Screen` (`name`, `capacity`, `air_conditioning`, `floor`) VALUES
(11, 30, 0, 1),
(12, 30, 0, 1),
(21, 18, 1, 2),
(22, 18, 1, 2);

CREATE TABLE `Screening_Times` (
  `title` varchar(255) NOT NULL,
  `name` int(2) NOT NULL,
  `beg_time` datetime NOT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Screening_Times` (`title`, `name`, `beg_time`, `end_time`) VALUES
('Source Code ', 11, '2016-08-05 18:00:00', '2016-08-05 19:40:00'),
('Source Code ', 11, '2016-08-07 00:00:00', '2016-08-07 01:40:00'),
('Source Code ', 11, '2016-08-07 14:00:00', '2016-08-07 15:40:00'),
('Star Wars: Episode VII - The Force Awakens', 11, '2016-08-05 00:00:00', '2016-08-05 00:00:00'),
('Star Wars: Episode VII - The Force Awakens', 11, '2016-08-05 14:00:00', '2016-08-05 00:00:00'),
('Star Wars: Episode VII - The Force Awakens', 11, '2016-08-05 21:00:00', '2016-08-06 00:00:00'),
('Star Wars: Episode VII - The Force Awakens', 11, '2016-08-06 18:00:00', '2016-08-06 21:00:00'),
('Birdman or (The Unexpected Virtue of Ignorance)', 12, '2016-08-05 12:00:00', '2016-08-05 14:00:00'),
('Birdman or (The Unexpected Virtue of Ignorance)', 12, '2016-08-05 14:00:00', '2016-08-05 16:00:00'),
('Birdman or (The Unexpected Virtue of Ignorance)', 12, '2016-08-05 18:00:00', '2016-08-05 20:00:00'),
('Birdman or (The Unexpected Virtue of Ignorance)', 12, '2016-08-05 21:00:00', '2016-08-05 23:00:00'),
('Birdman or (The Unexpected Virtue of Ignorance)', 12, '2016-08-07 10:00:00', '2016-08-07 12:00:00'),
('Jurassic World ', 21, '2016-08-05 00:00:00', '2016-08-05 04:10:00'),
('Jurassic World ', 21, '2016-08-05 10:00:00', '2016-08-05 12:10:00'),
('Jurassic World ', 21, '2016-08-05 18:00:00', '2016-08-05 20:10:00'),
('Whiplash', 21, '2016-08-05 12:00:00', '2016-08-05 13:00:00'),
('Whiplash', 21, '2016-08-05 17:00:00', '2016-08-05 18:00:00'),
('The Dark Knight ', 22, '2016-08-05 17:00:00', '2016-08-05 21:00:00'),
('The Dark Knight ', 22, '2016-08-05 20:00:00', '2016-08-06 00:00:00'),
('The Dark Knight ', 22, '2016-08-05 23:00:00', '2016-08-05 03:00:00'),
('The Dark Knight ', 22, '2016-08-06 00:00:00', '2016-08-06 04:00:00');
DELIMITER $$
CREATE TRIGGER `Screening_times_trigger` BEFORE INSERT ON `Screening_Times` FOR EACH ROW BEGIN
DECLARE duration_Temp int(11);




SELECT duration INTO duration_Temp FROM Movie WHERE Movie.title = NEW.title;
SET NEW.end_time = ADDDATE(NEW.beg_time ,INTERVAL duration_Temp MINUTE);
END
$$
DELIMITER ;

CREATE TABLE `Seats` (
  `name` int(2) NOT NULL,
  `number` int(2) NOT NULL,
  `description_y` enum('LOW','MIDDLE','HIGH') NOT NULL,
  `description_x` enum('LEFT','CENTER','RIGHT') NOT NULL,
  `corridor` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Seats` (`name`, `number`, `description_y`, `description_x`, `corridor`) VALUES
(11, 1, 'HIGH', 'LEFT', 0),
(11, 2, 'HIGH', 'LEFT', 1),
(11, 3, 'HIGH', 'CENTER', 1),
(11, 4, 'HIGH', 'CENTER', 1),
(11, 5, 'HIGH', 'RIGHT', 1),
(11, 6, 'HIGH', 'RIGHT', 0),
(11, 7, 'MIDDLE', 'LEFT', 0),
(11, 8, 'MIDDLE', 'LEFT', 1),
(11, 9, 'MIDDLE', 'CENTER', 1),
(11, 10, 'MIDDLE', 'CENTER', 1),
(11, 11, 'MIDDLE', 'RIGHT', 1),
(11, 12, 'MIDDLE', 'RIGHT', 0),
(11, 13, 'MIDDLE', 'LEFT', 0),
(11, 14, 'MIDDLE', 'LEFT', 1),
(11, 15, 'MIDDLE', 'CENTER', 1),
(11, 16, 'MIDDLE', 'CENTER', 1),
(11, 17, 'MIDDLE', 'RIGHT', 1),
(11, 18, 'MIDDLE', 'RIGHT', 0),
(11, 19, 'MIDDLE', 'LEFT', 0),
(11, 20, 'MIDDLE', 'LEFT', 1),
(11, 21, 'MIDDLE', 'CENTER', 1),
(11, 22, 'MIDDLE', 'CENTER', 1),
(11, 23, 'MIDDLE', 'RIGHT', 1),
(11, 24, 'MIDDLE', 'RIGHT', 0),
(11, 25, 'LOW', 'LEFT', 0),
(11, 26, 'LOW', 'LEFT', 1),
(11, 27, 'LOW', 'CENTER', 1),
(11, 28, 'LOW', 'CENTER', 1),
(11, 29, 'LOW', 'RIGHT', 1),
(11, 30, 'LOW', 'RIGHT', 0),
(12, 1, 'HIGH', 'LEFT', 0),
(12, 2, 'HIGH', 'LEFT', 1),
(12, 3, 'HIGH', 'CENTER', 1),
(12, 4, 'HIGH', 'CENTER', 1),
(12, 5, 'HIGH', 'RIGHT', 1),
(12, 6, 'HIGH', 'RIGHT', 0),
(12, 7, 'MIDDLE', 'LEFT', 0),
(12, 8, 'MIDDLE', 'LEFT', 1),
(12, 9, 'MIDDLE', 'CENTER', 1),
(12, 10, 'MIDDLE', 'CENTER', 1),
(12, 11, 'MIDDLE', 'RIGHT', 1),
(12, 12, 'MIDDLE', 'RIGHT', 0),
(12, 13, 'MIDDLE', 'LEFT', 0),
(12, 14, 'MIDDLE', 'LEFT', 1),
(12, 15, 'MIDDLE', 'CENTER', 1),
(12, 16, 'MIDDLE', 'CENTER', 1),
(12, 17, 'MIDDLE', 'RIGHT', 1),
(12, 18, 'MIDDLE', 'RIGHT', 0),
(12, 19, 'MIDDLE', 'LEFT', 0),
(12, 20, 'MIDDLE', 'LEFT', 1),
(12, 21, 'MIDDLE', 'CENTER', 1),
(12, 22, 'MIDDLE', 'CENTER', 1),
(12, 23, 'MIDDLE', 'RIGHT', 1),
(12, 24, 'MIDDLE', 'RIGHT', 0),
(12, 25, 'LOW', 'LEFT', 0),
(12, 26, 'LOW', 'LEFT', 1),
(12, 27, 'LOW', 'CENTER', 1),
(12, 28, 'LOW', 'CENTER', 1),
(12, 29, 'LOW', 'RIGHT', 1),
(12, 30, 'LOW', 'RIGHT', 0),
(21, 1, 'HIGH', 'LEFT', 0),
(21, 2, 'HIGH', 'LEFT', 1),
(21, 3, 'HIGH', 'CENTER', 1),
(21, 4, 'HIGH', 'CENTER', 1),
(21, 5, 'HIGH', 'RIGHT', 1),
(21, 6, 'HIGH', 'RIGHT', 0),
(21, 7, 'MIDDLE', 'LEFT', 0),
(21, 8, 'MIDDLE', 'LEFT', 1),
(21, 9, 'MIDDLE', 'CENTER', 1),
(21, 10, 'MIDDLE', 'CENTER', 1),
(21, 11, 'MIDDLE', 'RIGHT', 1),
(21, 12, 'MIDDLE', 'RIGHT', 0),
(21, 13, 'LOW', 'LEFT', 0),
(21, 14, 'LOW', 'LEFT', 1),
(21, 15, 'LOW', 'CENTER', 1),
(21, 16, 'LOW', 'CENTER', 1),
(21, 17, 'LOW', 'RIGHT', 1),
(21, 18, 'LOW', 'RIGHT', 0),
(22, 1, 'HIGH', 'LEFT', 0),
(22, 2, 'HIGH', 'LEFT', 1),
(22, 3, 'HIGH', 'CENTER', 1),
(22, 4, 'HIGH', 'CENTER', 1),
(22, 5, 'HIGH', 'RIGHT', 1),
(22, 6, 'HIGH', 'RIGHT', 0),
(22, 7, 'MIDDLE', 'LEFT', 0),
(22, 8, 'MIDDLE', 'LEFT', 1),
(22, 9, 'MIDDLE', 'CENTER', 1),
(22, 10, 'MIDDLE', 'CENTER', 1),
(22, 11, 'MIDDLE', 'RIGHT', 1),
(22, 12, 'MIDDLE', 'RIGHT', 0),
(22, 13, 'LOW', 'LEFT', 0),
(22, 14, 'LOW', 'LEFT', 1),
(22, 15, 'LOW', 'CENTER', 1),
(22, 16, 'LOW', 'CENTER', 1),
(22, 17, 'LOW', 'RIGHT', 1),
(22, 18, 'LOW', 'RIGHT', 0);

CREATE TABLE `Tickets` (
  `title` varchar(255) NOT NULL,
  `name` int(2) NOT NULL,
  `ticket_number` int(2) NOT NULL,
  `beg_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `type` enum('Regular','3D') NOT NULL,
  `buyer` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Tickets` (`title`, `name`, `ticket_number`, `beg_time`, `end_time`, `type`, `buyer`) VALUES
('Birdman or (The Unexpected Virtue of Ignorance)', 12, 10, '2016-08-05 12:00:00', '2016-08-05 14:00:00', 'Regular', 5),
('Source Code ', 11, 6, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 1),
('Source Code ', 11, 7, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 2),
('Source Code ', 11, 8, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 3),
('Source Code ', 11, 9, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 4),
('Source Code ', 11, 10, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 5),
('Source Code ', 11, 11, '2016-08-07 00:00:00', '2016-08-07 01:40:00', 'Regular', 6),
('Star Wars: Episode VII - The Force Awakens', 11, 1, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 4),
('Star Wars: Episode VII - The Force Awakens', 11, 2, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 5),
('Star Wars: Episode VII - The Force Awakens', 11, 3, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 6),
('Star Wars: Episode VII - The Force Awakens', 11, 4, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 7),
('Star Wars: Episode VII - The Force Awakens', 11, 5, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 3),
('Star Wars: Episode VII - The Force Awakens', 11, 6, '2016-08-06 18:00:00', '2016-08-06 21:00:00', 'Regular', 2),
('The Dark Knight ', 22, 1, '2016-08-05 20:00:00', '2016-08-06 00:00:00', 'Regular', 2),
('The Dark Knight', 22, 6, '2016-08-05 20:00:00', '2016-08-06 00:00:00', '3D', 5),
('The Dark Knight ', 22, 10, '2016-08-05 20:00:00', '2016-08-06 00:00:00', 'Regular', 3),
('The Dark Knight ', 22, 14, '2016-08-05 20:00:00', '2016-08-06 00:00:00', '3D', 1),
('Whiplash', 21, 5, '2016-08-05 12:00:00', '2016-08-05 13:00:00', '3D', 1),
('Whiplash', 21, 6, '2016-08-05 12:00:00', '2016-08-05 13:00:00', 'Regular', 3),
('Whiplash', 21, 7, '2016-08-05 12:00:00', '2016-08-05 13:00:00', 'Regular', 4),
('Whiplash', 21, 8, '2016-08-05 12:00:00', '2016-08-05 13:00:00', 'Regular', 5),
('Whiplash', 21, 9, '2016-08-05 12:00:00', '2016-08-05 13:00:00', 'Regular', 6),
('Whiplash', 21, 18, '2016-08-05 12:00:00', '2016-08-05 13:00:00', 'Regular', 2);
DELIMITER $$
CREATE TRIGGER `Ticket_trigger` AFTER INSERT ON `Tickets` FOR EACH ROW BEGIN
DECLARE buyer_id INT(5);
DECLARE card_idt INT(5);
DECLARE movie_title VARCHAR(255);
DECLARE ticket_type enum ('Regular','3D');
DECLARE points int(3);
DECLARE date_temp date;








SET buyer_id = NEW.buyer;
SET movie_title = NEW.title;
SET date_temp = DATE(NEW.beg_time);
INSERT INTO Movies_Watched(id,title,date_watched)
VALUES(buyer_id,movie_title,date_temp);

SELECT card_id INTO card_idt FROM Customer WHERE buyer_id = id;
SELECT bonus_points INTO points FROM Bonus_Card WHERE card_id=card_idt;
IF (NEW.type like '3D') THEN
SET points = points + 3;
ELSE
SET points = points + 2;
END IF;
UPDATE Bonus_Card SET bonus_points = points WHERE card_id=card_idt;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Ticket_trigger2` BEFORE INSERT ON `Tickets` FOR EACH ROW BEGIN
DECLARE status_temp enum ('FREE','OCCUPIED');
DECLARE title_tmp VARCHAR(255);
DECLARE duration_Temp int(11);




SELECT duration INTO duration_Temp FROM Movie WHERE Movie.title = NEW.title;
SET NEW.end_time = ADDDATE(NEW.beg_time ,INTERVAL duration_Temp MINUTE);



SELECT title INTO title_tmp FROM Screening_Times WHERE beg_time = NEW.beg_time AND name = NEW.name;
IF (title_tmp IS NULL) THEN 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'There is no such Screening Time';
END IF;




END
$$
DELIMITER ;

CREATE TABLE `Trailer` (
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Trailer` (`title`, `url`) VALUES
('Birdman or (The Unexpected Virtue of Ignorance)', 'http://www.imdb.com/video/imdb/vi1360441113?ref_=tt_pv_vi_aiv_1'),
('Birdman or (The Unexpected Virtue of Ignorance)', 'http://www.imdb.com/video/imdb/vi701017881?ref_=tt_pv_vi_aiv_2'),
('Jurassic World ', 'http://www.imdb.com/video/imdb/vi3224219673?ref_=tt_pv_vi_aiv_2'),
('Jurassic World ', 'http://www.imdb.com/video/imdb/vi773894169?ref_=tt_pv_vi_aiv_1'),
('Source Code ', 'http://www.imdb.com/video/imdb/vi3948911129?ref_=tt_ov_vi'),
('Star Wars: Episode VII - The Force Awakens', 'http://www.imdb.com/video/imdb/vi2469114393?ref_=tt_pv_vi_aiv_2'),
('Star Wars: Episode VII - The Force Awakens', 'http://www.imdb.com/video/imdb/vi3451171609?ref_=tt_pv_vi_aiv_1'),
('Star Wars: Episode VII - The Force Awakens', 'http://www.imdb.com/video/imdb/vi645838105?ref_=tt_ov_vi'),
('The Dark Knight ', 'https://www.youtube.com/watch?v=EXeTwQWrcwY'),
('Whiplash', 'https://www.youtube.com/watch?v=Tkh5I9w4ySY');


ALTER TABLE `Actor`
  ADD PRIMARY KEY (`name`,`lastname`,`title`),
  ADD KEY `Actor_Movie` (`title`);

ALTER TABLE `Award`
  ADD PRIMARY KEY (`name`);

ALTER TABLE `Award_Movie`
  ADD PRIMARY KEY (`title`,`award_name`,`date_of_award`),
  ADD KEY `Award_Movie_Award` (`award_name`);

ALTER TABLE `Award_Person`
  ADD PRIMARY KEY (`name`,`lastname`,`award_name`,`date_of_award`),
  ADD KEY `Award_Person_Award` (`award_name`);

ALTER TABLE `Bonus_Card`
  ADD PRIMARY KEY (`card_id`);

ALTER TABLE `Customer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Customer_Card` (`card_id`);

ALTER TABLE `Director`
  ADD PRIMARY KEY (`name`,`lastname`,`title`),
  ADD KEY `Director_Movie` (`title`);

ALTER TABLE `Employee`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Free_tickets`
  ADD PRIMARY KEY (`card_id`,`date_of_winning`);

ALTER TABLE `Genre`
  ADD KEY `Genre_Movie` (`title`);

ALTER TABLE `Movie`
  ADD PRIMARY KEY (`title`);

ALTER TABLE `Movies_Watched`
  ADD PRIMARY KEY (`id`,`title`),
  ADD KEY `Movie_Movie` (`title`);

ALTER TABLE `Person`
  ADD PRIMARY KEY (`name`,`lastname`);

ALTER TABLE `Schedule`
  ADD PRIMARY KEY (`id`,`working_date`),
  ADD KEY `screen` (`screen`);

ALTER TABLE `Screen`
  ADD PRIMARY KEY (`name`);

ALTER TABLE `Screening_Times`
  ADD PRIMARY KEY (`title`,`name`,`beg_time`,`end_time`),
  ADD KEY `Screening_Times_Screens` (`name`);

ALTER TABLE `Seats`
  ADD PRIMARY KEY (`name`,`number`);

ALTER TABLE `Tickets`
  ADD PRIMARY KEY (`title`,`name`,`ticket_number`,`beg_time`),
  ADD KEY `Tickets_times` (`title`,`name`,`beg_time`,`end_time`),
  ADD KEY `Tickets_Customer` (`buyer`),
  ADD KEY `temp` (`name`,`ticket_number`);

ALTER TABLE `Trailer`
  ADD PRIMARY KEY (`title`,`url`);


ALTER TABLE `Customer`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `Employee`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

ALTER TABLE `Actor`
  ADD CONSTRAINT `Actor_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Actor_Person` FOREIGN KEY (`name`,`lastname`) REFERENCES `Person` (`name`, `lastname`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Award_Movie`
  ADD CONSTRAINT `Award_Movie_Award` FOREIGN KEY (`award_name`) REFERENCES `Award` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Award_Movie_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Award_Person`
  ADD CONSTRAINT `Award_Person_Award` FOREIGN KEY (`award_name`) REFERENCES `Award` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Award_Person_Person` FOREIGN KEY (`name`,`lastname`) REFERENCES `Person` (`name`, `lastname`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Customer`
  ADD CONSTRAINT `Customer_Card` FOREIGN KEY (`card_id`) REFERENCES `Bonus_Card` (`card_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Director`
  ADD CONSTRAINT `Director_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Director_Person` FOREIGN KEY (`name`,`lastname`) REFERENCES `Person` (`name`, `lastname`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Free_tickets`
  ADD CONSTRAINT `Free_Card` FOREIGN KEY (`card_id`) REFERENCES `Bonus_Card` (`card_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Genre`
  ADD CONSTRAINT `Genre_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Movies_Watched`
  ADD CONSTRAINT `Movie_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Movies_Customer` FOREIGN KEY (`id`) REFERENCES `Customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Schedule`
  ADD CONSTRAINT `Schedule_Employee` FOREIGN KEY (`id`) REFERENCES `Employee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Schedule_ibfk_1` FOREIGN KEY (`screen`) REFERENCES `Screen` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Screening_Times`
  ADD CONSTRAINT `Screening_Times_Screens` FOREIGN KEY (`name`) REFERENCES `Screen` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Screening_times_Movie` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Seats`
  ADD CONSTRAINT `Seats_Screen` FOREIGN KEY (`name`) REFERENCES `Screen` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Tickets`
  ADD CONSTRAINT `Tickets_Customer` FOREIGN KEY (`buyer`) REFERENCES `Customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Tickets_times` FOREIGN KEY (`title`,`name`,`beg_time`,`end_time`) REFERENCES `Screening_Times` (`title`, `name`, `beg_time`, `end_time`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `temp` FOREIGN KEY (`name`,`ticket_number`) REFERENCES `Seats` (`name`, `number`);

ALTER TABLE `Trailer`
  ADD CONSTRAINT `MovTrailer` FOREIGN KEY (`title`) REFERENCES `Movie` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

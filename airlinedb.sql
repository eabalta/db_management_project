-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 13 Şub 2021, 02:47:04
-- Sunucu sürümü: 10.4.17-MariaDB
-- PHP Sürümü: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `airlinedb`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `airline`
--

CREATE TABLE `airline` (
  `Airline_code` varchar(5) NOT NULL,
  `Company` varchar(225) NOT NULL,
  `Airline_name` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `airline`
--

INSERT INTO `airline` (`Airline_code`, `Company`, `Airline_name`) VALUES
('012', 'Supreme Corp.', 'Northwest Airlines'),
('014', 'Star Alliance', 'Air Canada'),
('016', 'Supreme Corp.', 'United Airlines'),
('200', 'WWP', 'Thailand Airlines'),
('235', 'Star Alliance', 'Turkish Airlines'),
('260', 'Oneworld', 'Air Pacific'),
('738', 'WWP', 'China Airlines');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `airplane`
--

CREATE TABLE `airplane` (
  `Airplane_id` varchar(5) NOT NULL,
  `Company` varchar(225) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Total_number_of__seats` int(11) NOT NULL,
  `Airplane_type` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `airplane`
--

INSERT INTO `airplane` (`Airplane_id`, `Company`, `Name`, `Total_number_of__seats`, `Airplane_type`) VALUES
('100', 'Globe', 'Boeng 747 Dream', 6, 'Cargo'),
('111', 'Airbus', 'Airbus A200', 140, 'Civil'),
('113', 'Airbus', 'Airbus A300', 130, 'Civil'),
('16', 'Star Alliance', 'Star Cavalier', 100, 'Civil'),
('55', 'Supreme Corp.', 'MIG', 4, 'Military'),
('78', 'Supermarine', 'Supermarine Chinnel', 80, 'Civil');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `airplane_type`
--

CREATE TABLE `airplane_type` (
  `Airplane_type_name` varchar(25) NOT NULL,
  `Max_seats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `airplane_type`
--

INSERT INTO `airplane_type` (`Airplane_type_name`, `Max_seats`) VALUES
('Cargo', 10),
('Civil', 800),
('Military', 20);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `airport`
--

CREATE TABLE `airport` (
  `Airport_code` varchar(3) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `airport`
--

INSERT INTO `airport` (`Airport_code`, `Name`, `City`, `State`) VALUES
('AMS', 'Amsterdam Schipol', 'Amsterdam', 'NED'),
('ATA', 'Atatürk Airport', 'Erzurum', 'TUR'),
('CDG', 'Charles De Gaulle Airport', 'Paris', 'FRA'),
('CPH', 'Copehagen Airport', 'Copenhag', 'DEN'),
('ESN', 'Esenboga Airport', 'Ankara', 'TUR'),
('FRA', 'Frankfurt Am Main Airport', 'Frankfurt', 'DEU'),
('HND', 'Tokyo Haneda Airport', 'Tokyo', 'JPN'),
('ISL', 'Atatürk International Airport', 'Istanbul', 'TUR'),
('LAX', 'Los Angeles Airport', 'Los Angeles', 'USA'),
('MAN', 'Manchester Airport', 'Manchester', 'ENG'),
('MUN', 'Munich Airport', 'Munich', 'DEU'),
('OSL', 'Oslo Gardermoen Airport', 'Oslo', 'NOR'),
('SAM', 'Carsamba Airport', 'Samsun', 'TUR');

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `airportsturkey`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `airportsturkey` (
`Airport_code` varchar(3)
,`Name` varchar(45)
,`City` varchar(15)
,`State` varchar(5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `can_land`
--

CREATE TABLE `can_land` (
  `Airplane_type_name` varchar(25) NOT NULL,
  `Airport_code` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `can_land`
--

INSERT INTO `can_land` (`Airplane_type_name`, `Airport_code`) VALUES
('Cargo', 'CDG'),
('Cargo', 'ISL'),
('Cargo', 'MAN'),
('Civil', 'CDG'),
('Civil', 'FRA'),
('Civil', 'ISL'),
('Civil', 'MAN'),
('Civil', 'OSL'),
('Military', 'CDG'),
('Military', 'HND'),
('Military', 'MAN');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `check_in`
--

CREATE TABLE `check_in` (
  `Check_in_id` int(11) NOT NULL,
  `Customer_pass` int(11) NOT NULL,
  `Flight_number` int(11) NOT NULL,
  `Leg_number` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Seat_number` int(11) NOT NULL,
  `Mileage` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `check_in`
--

INSERT INTO `check_in` (`Check_in_id`, `Customer_pass`, `Flight_number`, `Leg_number`, `Date`, `Seat_number`, `Mileage`) VALUES
(85, 90147895, 4543, 1, '2020-07-08', 10, 355),
(86, 90147895, 7374, 1, '2020-09-15', 50, 5590),
(87, 90147895, 4543, 2, '2020-07-09', 15, 5798),
(88, 90147895, 7374, 2, '2020-09-16', 51, 490.7),
(90, 90147895, 7374, 3, '2020-09-16', 45, 1691),
(91, 14789542, 1150, 1, '2020-11-18', 78, 276.7),
(92, 14867898, 1150, 1, '2020-11-18', 43, 276.7),
(93, 90899545, 1150, 1, '2020-11-18', 77, 276.7),
(94, 14867898, 7374, 1, '2020-09-15', 62, 5590),
(95, 14789542, 7374, 2, '2020-09-16', 14, 490.7),
(96, 14789542, 7374, 1, '2020-09-15', 63, 5590),
(98, 90147895, 2200, 1, '2021-02-02', 100, 9120);

--
-- Tetikleyiciler `check_in`
--
DELIMITER $$
CREATE TRIGGER `after_checkin_delete` AFTER DELETE ON `check_in` FOR EACH ROW BEGIN
	DECLARE comp_name VARCHAR(255);
    SET SQL_SAFE_UPDATES=0;
    SELECT Company
    INTO comp_name
    FROM flight
    WHERE flight.Flight_number = OLD.Flight_number;
    #Uygun koltuk sayısından bir tane arttırıldı
    UPDATE leg_instance
    SET Number_of_available_seats = Number_of_available_seats + 1
    WHERE Flight_number = OLD.Flight_number AND Leg_number = OLD.Leg_number;
    
    IF (SELECT EXISTS(SELECT * FROM T_record WHERE Customer_pass = OLD.Customer_pass AND Company = comp_name) =1) THEN
		UPDATE t_record
        SET Mileage_per_company = Mileage_per_company - OLD.Mileage
        WHERE Customer_pass = OLD.Customer_pass AND t_record.Company = comp_name;
        IF ((SELECT Mileage_per_company FROM t_record WHERE Customer_pass = OLD.Customer_pass AND Company = comp_name) = 0) THEN
			DELETE FROM t_record WHERE Customer_pass = OLD.Customer_pass AND Company = comp_name;
		END IF;
    END IF;
	SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_checkin_insert` AFTER INSERT ON `check_in` FOR EACH ROW BEGIN
	DECLARE comp_name VARCHAR(255);
    SET SQL_SAFE_UPDATES=0;
    SELECT Company
    INTO comp_name
    FROM flight
    WHERE flight.Flight_number = NEW.Flight_number;
    
    #Uygun koltuk sayısından bir tane düşüldü
    UPDATE leg_instance
    SET Number_of_available_seats = Number_of_available_seats - 1
    WHERE Flight_number = NEW.Flight_number AND Leg_number = NEW.Leg_number;
    
    IF (SELECT EXISTS(SELECT * FROM T_record WHERE Customer_pass = NEW.Customer_pass AND Company = comp_name) =0) THEN
		INSERT INTO t_record SET Customer_pass = NEW.Customer_pass, Company = comp_name, Mileage_per_company = NEW.Mileage;
    ELSE 
		UPDATE t_record
        SET Mileage_per_company = Mileage_per_company + NEW.Mileage
        WHERE Customer_pass = NEW.Customer_pass AND t_record.Company = comp_name;
    END IF;
	SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `cokyonluhavaalanları`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `cokyonluhavaalanları` (
`airport_code` varchar(3)
,`name` varchar(45)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `company`
--

CREATE TABLE `company` (
  `company_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `company`
--

INSERT INTO `company` (`company_name`) VALUES
('Aero Engineers'),
('Airbus'),
('Curtiss'),
('Dornier'),
('Eagle Aircraft'),
('Eagle Airways'),
('Fairchild Aircraft'),
('Fokker'),
('Globe'),
('Oneworld'),
('Star Alliance'),
('Supermarine'),
('Supreme Corp.'),
('WWP');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customer`
--

CREATE TABLE `customer` (
  `Passport_no` int(11) NOT NULL,
  `Name` varchar(80) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Country` varchar(3) NOT NULL,
  `Address` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `customer`
--

INSERT INTO `customer` (`Passport_no`, `Name`, `Phone`, `Email`, `Country`, `Address`) VALUES
(14445789, 'Morten Levernes', '+47 225415', 'mbl@gmail.com', 'NOR', '5 Boslowick Close, Falmouth'),
(14789542, 'Erik Halfdansson', '+47 415785', 'erik@gmail.com', 'NOR', 'Unit G5, Oslo Close'),
(14867898, 'Harald Hardrada', '+47 985365', 'finehair@gmail.com', 'NOR', 'Unit 2, Oslo Rd'),
(31145789, 'Mike George', '+1 4512356', 'mike@gmail.com', 'USA', '606 W 57th St, New York'),
(31195855, 'Rahul Brahma', '+1 4517854', 'rahul@gmail.com', 'USA', '606 W 54th St, New York'),
(65451758, 'Andrew Mc\'Nail', '+44 784578', 'mcand@gmail.com', 'ENG', '6 Horseman Avenue, York'),
(65752415, 'Andrew Robertson', '+44 665785', 'andrew@gmail.com', 'ENG', '32 Chapel Walk, York'),
(90147895, 'Yunus Özdemir', '+90 554754', 'kasva@gmail.com', 'TUR', 'Yenimahalle, Ankara'),
(90899545, 'Fatma Kara', '+90 354785', 'kara@gmail.com', 'TUR', 'Kecioren, Ankara');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `fare`
--

CREATE TABLE `fare` (
  `Flight_number` int(11) NOT NULL,
  `Fare_code` varchar(8) NOT NULL,
  `Amount` float NOT NULL,
  `Restrictions` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `fare`
--

INSERT INTO `fare` (`Flight_number`, `Fare_code`, `Amount`, `Restrictions`) VALUES
(1456, 'CH', 219, 'Child Fare'),
(1456, 'F', 439.9, 'First-class'),
(1456, 'W', 365.75, 'Premium Economy'),
(4543, 'CH', 35, 'Child Fare'),
(4543, 'F', 91, 'First-class'),
(4543, 'W', 79, 'Premium Economy'),
(6568, 'CH', 76, 'Child Fare'),
(6568, 'F', 150, 'First-class'),
(6568, 'W', 115.3, 'Premium Economy');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ff_customer`
--

CREATE TABLE `ff_customer` (
  `Cust_pass` int(11) NOT NULL,
  `Company` varchar(225) NOT NULL,
  `Rank_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `ff_customer`
--

INSERT INTO `ff_customer` (`Cust_pass`, `Company`, `Rank_no`) VALUES
(90147895, 'Oneworld', 1),
(14789542, 'WWP', 1),
(90147895, 'WWP', 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `flight`
--

CREATE TABLE `flight` (
  `Flight_number` int(11) NOT NULL,
  `Airline_code` varchar(5) NOT NULL,
  `Company` varchar(45) NOT NULL,
  `Weekdays` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `flight`
--

INSERT INTO `flight` (`Flight_number`, `Airline_code`, `Company`, `Weekdays`) VALUES
(1150, '235', 'Star Alliance', 'Friday,Saturday,Sunday'),
(1151, '235', 'Star Alliance', 'Friday,Saturday,Monday'),
(1456, '235', 'Star Alliance', 'Saturday,Sunday'),
(1727, '016', 'Supreme Corp.', 'Monday,Tuesday,Friday'),
(2200, '200', 'WWP', 'Friday,Saturday,Sunday'),
(4543, '260', 'Oneworld', 'Thursday'),
(6568, '016', 'Supreme Corp.', 'Wednesday,Friday'),
(7374, '738', 'WWP', 'Saturday,Monday'),
(9987, '012', 'Supreme Corp.', 'Friday,Saturday,Sunday');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `flight_leg`
--

CREATE TABLE `flight_leg` (
  `Flight_number` int(11) NOT NULL,
  `Leg_number` int(11) NOT NULL,
  `Departure_airport_code` varchar(3) NOT NULL,
  `Scheduled_depature_time` time NOT NULL,
  `Arrival_airport_code` varchar(3) NOT NULL,
  `Scheduled_arrival_time` time NOT NULL,
  `Mileage_information` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `flight_leg`
--

INSERT INTO `flight_leg` (`Flight_number`, `Leg_number`, `Departure_airport_code`, `Scheduled_depature_time`, `Arrival_airport_code`, `Scheduled_arrival_time`, `Mileage_information`) VALUES
(1150, 1, 'ISL', '12:00:00', 'ESN', '14:00:00', 276.7),
(1150, 2, 'ESN', '15:30:00', 'ATA', '18:00:00', 450),
(1151, 1, 'SAM', '17:35:00', 'ATA', '19:55:00', 358.5),
(1456, 1, 'OSL', '23:25:00', 'ISL', '03:25:00', 1996.6),
(1456, 2, 'ISL', '05:00:00', 'MAN', '09:30:00', 2095.3),
(2200, 1, 'LAX', '15:31:00', 'ATA', '01:30:00', 9120),
(4543, 1, 'CDG', '10:10:10', 'FRA', '11:30:10', 355),
(4543, 2, 'FRA', '12:30:10', 'HND', '07:55:05', 5798),
(6568, 1, 'FRA', '17:15:00', 'MAN', '21:35:00', 2095.3),
(6568, 2, 'MAN', '17:15:00', 'CDG', '21:35:00', 1000),
(7374, 1, 'LAX', '04:00:00', 'CPH', '23:35:00', 5590),
(7374, 2, 'CPH', '12:30:00', 'AMS', '13:45:00', 490.7),
(7374, 3, 'AMS', '15:00:00', 'ISL', '20:25:00', 1691),
(9987, 1, 'HND', '00:30:00', 'FRA', '22:45:00', 5798),
(9987, 2, 'FRA', '00:45:00', 'CPH', '02:25:00', 511.8),
(9987, 3, 'CPH', '04:55:00', 'HND', '21:45:00', 5438);

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `ichatlarturkiye`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `ichatlarturkiye` (
`Flight_number` int(11)
,`Leg_Number` int(11)
,`Date` date
,`Depature_airport_code` varchar(3)
,`Arrival_airport_code` varchar(3)
,`State` varchar(5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `leg_instance`
--

CREATE TABLE `leg_instance` (
  `Flight_number` int(11) NOT NULL,
  `Leg_number` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Number_of_available_seats` int(11) DEFAULT NULL,
  `Airplane_id` varchar(5) NOT NULL,
  `Depature_airport_code` varchar(3) NOT NULL,
  `Depature_time` time NOT NULL,
  `Arrival_airport_code` varchar(3) NOT NULL,
  `Arrival_time` time NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `leg_instance`
--

INSERT INTO `leg_instance` (`Flight_number`, `Leg_number`, `Date`, `Number_of_available_seats`, `Airplane_id`, `Depature_airport_code`, `Depature_time`, `Arrival_airport_code`, `Arrival_time`) VALUES
(1150, 1, '2020-11-18', 97, '111', 'ISL', '12:00:00', 'ESN', '14:05:00'),
(1150, 2, '2020-11-18', 140, '111', 'ESN', '15:35:00', 'ATA', '18:05:00'),
(1151, 1, '2020-12-03', 130, '113', 'SAM', '17:35:00', 'ATA', '20:00:00'),
(1456, 1, '2020-07-07', 100, '16', 'OSL', '23:35:00', 'ISL', '01:35:00'),
(1456, 2, '2020-07-08', 130, '113', 'ISL', '05:00:00', 'MAN', '09:30:00'),
(2200, 1, '2021-02-02', 139, '113', 'LAX', '15:35:00', 'ATA', '02:00:00'),
(4543, 1, '2020-07-08', 79, '78', 'CDG', '10:10:10', 'FRA', '11:30:10'),
(4543, 2, '2020-07-09', 129, '113', 'FRA', '12:45:10', 'HND', '08:10:05'),
(6568, 1, '2020-08-22', 140, '111', 'FRA', '17:15:00', 'MAN', '21:35:00'),
(6568, 2, '2020-08-22', 140, '111', 'MAN', '17:15:00', 'CDG', '21:35:00'),
(7374, 1, '2020-09-15', 137, '111', 'LAX', '04:00:00', 'CPH', '23:35:00'),
(7374, 2, '2020-09-16', 128, '113', 'CPH', '12:30:00', 'AMS', '13:45:00'),
(7374, 3, '2020-09-16', 139, '111', 'AMS', '15:00:00', 'ISL', '20:38:00'),
(9987, 1, '2020-10-22', 100, '16', 'HND', '00:30:00', 'FRA', '22:55:00'),
(9987, 2, '2020-10-23', 100, '16', 'FRA', '00:45:00', 'CPH', '03:25:00'),
(9987, 3, '2020-10-24', 130, '111', 'CPH', '04:55:00', 'HND', '21:45:00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `rank`
--

CREATE TABLE `rank` (
  `Company` varchar(225) NOT NULL,
  `Rank_no` int(11) NOT NULL,
  `Reward` varchar(100) NOT NULL,
  `Minimum_mileage` float NOT NULL
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `rank`
--

INSERT INTO `rank` (`Company`, `Rank_no`, `Reward`, `Minimum_mileage`) VALUES
('Oneworld', 1, '%10 Discount on cafe service', 5000),
('Oneworld', 2, 'An airplane model', 12500),
('Oneworld', 3, '%15 pay-back', 15000),
('Star Alliance', 1, '%10 Discount on cafe service', 11000),
('Star Alliance', 2, 'An airplane model', 14500),
('Star Alliance', 3, '%15 pay-back', 17500),
('Supreme Corp.', 1, 'A key-holder', 8500),
('Supreme Corp.', 2, '%35 discount for children', 13000),
('Supreme Corp.', 3, '%15 pay-back', 16500),
('WWP', 1, '%10 Discount on cafe service', 6000),
('WWP', 2, 'An airplane model', 7500),
('WWP', 3, '%15 pay-back', 9000);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `seat_reservation`
--

CREATE TABLE `seat_reservation` (
  `Customer_pass` int(11) NOT NULL,
  `Flight_number` int(11) NOT NULL,
  `Leg_number` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Seat_number` int(11) NOT NULL,
  `check_in_flag` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `seat_reservation`
--

INSERT INTO `seat_reservation` (`Customer_pass`, `Flight_number`, `Leg_number`, `Date`, `Seat_number`, `check_in_flag`) VALUES
(14789542, 1150, 1, '2020-11-18', 78, 1),
(14789542, 7374, 1, '2020-09-15', 63, 1),
(14789542, 7374, 2, '2020-09-16', 14, 1),
(14867898, 1150, 1, '2020-11-18', 43, 1),
(14867898, 7374, 1, '2020-09-15', 62, 1),
(90147895, 2200, 1, '2021-02-02', 100, 1),
(90147895, 4543, 1, '2020-07-08', 10, 1),
(90147895, 7374, 1, '2020-09-15', 50, 1),
(90147895, 4543, 2, '2020-07-09', 15, 1),
(90147895, 7374, 2, '2020-09-16', 51, 1),
(90147895, 7374, 3, '2020-09-16', 45, 1),
(90899545, 1150, 1, '2020-11-18', 77, 1);

--
-- Tetikleyiciler `seat_reservation`
--
DELIMITER $$
CREATE TRIGGER `after_seatreservation_insert` AFTER INSERT ON `seat_reservation` FOR EACH ROW BEGIN
	DECLARE millpoint FLOAT;
    
	SELECT Mileage_information
    INTO millpoint
    FROM flight_leg
    WHERE flight_leg.Flight_number=NEW.Flight_number AND
	flight_leg.Leg_number=NEW.Leg_number;
          
    SET SQL_SAFE_UPDATES=0;
	IF NEW.check_in_flag=1 THEN
		INSERT INTO check_in SET Customer_pass = NEW.Customer_pass, Flight_number = NEW.Flight_number, Leg_number = NEW.Leg_number, 
		Date = NEW.Date, Seat_number= NEW.Seat_number, Mileage = millpoint;
	END IF;
    SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_seatreservation_update` AFTER UPDATE ON `seat_reservation` FOR EACH ROW BEGIN
	DECLARE millpoint FLOAT;
    
	SELECT Mileage_information
    INTO millpoint
    FROM flight_leg
    WHERE flight_leg.Flight_number=NEW.Flight_number AND
	flight_leg.Leg_number=NEW.Leg_number;
          
    SET SQL_SAFE_UPDATES=0;
	IF NEW.check_in_flag=1 THEN
		INSERT INTO check_in SET Customer_pass = NEW.Customer_pass, Flight_number = NEW.Flight_number, Leg_number = NEW.Leg_number, 
		Date = NEW.Date, Seat_number= NEW.Seat_number, Mileage = millpoint;
    ELSEIF NEW.check_in_flag=0 THEN
		DELETE FROM check_in WHERE Customer_pass = NEW.Customer_pass AND Flight_number = NEW.Flight_number AND Leg_number = NEW.Leg_number;    
	END IF;
 SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `supremecorpflights`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `supremecorpflights` (
`Company` varchar(45)
,`Flight_number` int(11)
,`Leg_number` int(11)
,`Departure_airport_code` varchar(3)
,`Arrival_airport_code` varchar(3)
);

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `turkyolcular`
-- (Asıl görünüm için aşağıya bakın)
--
CREATE TABLE `turkyolcular` (
`Name` varchar(80)
,`Flight_number` int(11)
,`Leg_number` int(11)
,`Date` date
,`Seat_number` int(11)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `t_record`
--

CREATE TABLE `t_record` (
  `Customer_pass` int(11) NOT NULL,
  `Company` varchar(255) NOT NULL,
  `Mileage_per_company` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `t_record`
--

INSERT INTO `t_record` (`Customer_pass`, `Company`, `Mileage_per_company`) VALUES
(14789542, 'Star Alliance', 276.7),
(14789542, 'WWP', 6080.7),
(14867898, 'Star Alliance', 276.7),
(14867898, 'WWP', 5590),
(90147895, 'Oneworld', 6153),
(90147895, 'WWP', 16891.7),
(90899545, 'Star Alliance', 276.7);

--
-- Tetikleyiciler `t_record`
--
DELIMITER $$
CREATE TRIGGER `after_trecord_delete` AFTER DELETE ON `t_record` FOR EACH ROW BEGIN
	DELETE FROM ff_customer WHERE Cust_pass = OLD.Customer_pass AND Company = OLD.Company;
	
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_trecord_insert` AFTER INSERT ON `t_record` FOR EACH ROW BEGIN
	DECLARE max_rank INT;
    SET SQL_SAFE_UPDATES=0;
    
    SELECT MAX(Rank_no)
    INTO max_rank
    FROM airlinedb.rank
    WHERE Company = NEW.Company AND NEW.Mileage_per_company > Minimum_mileage;
    
    IF(max_rank > 0) THEN
		IF(SELECT EXISTS(SELECT Cust_pass,Company FROM ff_customer WHERE Cust_pass = NEW.Customer_pass AND Company = NEW.Company) = 0) THEN
			INSERT INTO ff_customer SET Cust_pass = NEW.Customer_pass, Company = NEW.Company, Rank_no = max_rank;
		ELSE 
			UPDATE ff_customer SET Cust_pass = NEW.Customer_pass, Company = NEW.Company, Rank_no = max_rank;
		END IF;	
    END IF;
	
    SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_trecord_update` AFTER UPDATE ON `t_record` FOR EACH ROW BEGIN
	DECLARE max_rank INT;
    DECLARE min_rank INT;
    SET SQL_SAFE_UPDATES=0;
    SELECT MAX(Rank_no)
    INTO max_rank
    FROM airlinedb.rank
    WHERE Company = NEW.Company AND NEW.Mileage_per_company > Minimum_mileage;
    SELECT MIN(Rank_no)								/* min_rank Check_in varligi silinmesi dolayisiyla ff_customerdan cikarilmasi gereken varlik icin tanimlanmistir */
    INTO min_rank
    FROM airlinedb.rank
    WHERE Company = NEW.Company;
    IF(NEW.Mileage_per_company < (SELECT Minimum_mileage FROM airlinedb.rank WHERE Company = NEW.Company AND Rank_no = min_rank)) THEN
			DELETE FROM ff_customer WHERE Cust_pass = NEW.Customer_pass AND Company = NEW.Company;
	ELSE
		INSERT INTO ff_customer SET Cust_pass = NEW.Customer_pass, Company = NEW.Company, Rank_no = max_rank ON DUPLICATE KEY UPDATE Rank_no = max_rank;
	END IF;	
    SET SQL_SAFE_UPDATES=1;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `airportsturkey`
--
DROP TABLE IF EXISTS `airportsturkey`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `airportsturkey`  AS SELECT `airport`.`Airport_code` AS `Airport_code`, `airport`.`Name` AS `Name`, `airport`.`City` AS `City`, `airport`.`State` AS `State` FROM `airport` WHERE `airport`.`State` = 'TUR' ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `cokyonluhavaalanları`
--
DROP TABLE IF EXISTS `cokyonluhavaalanları`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cokyonluhavaalanları`  AS SELECT `airport`.`Airport_code` AS `airport_code`, `airport`.`Name` AS `name` FROM (`airport` join `can_land`) WHERE `airport`.`Airport_code` = `can_land`.`Airport_code` GROUP BY `airport`.`Airport_code` HAVING count(0) = 3 ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `ichatlarturkiye`
--
DROP TABLE IF EXISTS `ichatlarturkiye`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ichatlarturkiye`  AS SELECT `leg_instance`.`Flight_number` AS `Flight_number`, `leg_instance`.`Leg_number` AS `Leg_Number`, `leg_instance`.`Date` AS `Date`, `leg_instance`.`Depature_airport_code` AS `Depature_airport_code`, `leg_instance`.`Arrival_airport_code` AS `Arrival_airport_code`, `airport1`.`State` AS `State` FROM ((`leg_instance` join `airport` `airport1` on(`leg_instance`.`Depature_airport_code` = `airport1`.`Airport_code`)) join `airport` `airport2` on(`leg_instance`.`Arrival_airport_code` = `airport2`.`Airport_code`)) WHERE `airport1`.`State` = 'TUR' AND `airport2`.`State` = 'TUR' ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `supremecorpflights`
--
DROP TABLE IF EXISTS `supremecorpflights`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supremecorpflights`  AS SELECT `f`.`Company` AS `Company`, `f_leg`.`Flight_number` AS `Flight_number`, `f_leg`.`Leg_number` AS `Leg_number`, `f_leg`.`Departure_airport_code` AS `Departure_airport_code`, `f_leg`.`Arrival_airport_code` AS `Arrival_airport_code` FROM (`flight_leg` `f_leg` join `flight` `f` on(`f`.`Flight_number` = `f_leg`.`Flight_number`)) WHERE `f`.`Company` = 'Supreme Corp.' ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `turkyolcular`
--
DROP TABLE IF EXISTS `turkyolcular`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `turkyolcular`  AS SELECT `customer`.`Name` AS `Name`, `seat_reservation`.`Flight_number` AS `Flight_number`, `seat_reservation`.`Leg_number` AS `Leg_number`, `seat_reservation`.`Date` AS `Date`, `seat_reservation`.`Seat_number` AS `Seat_number` FROM (`seat_reservation` join `customer`) WHERE `seat_reservation`.`Customer_pass` = `customer`.`Passport_no` AND `customer`.`Country` = 'TUR' ;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`Airline_code`,`Company`),
  ADD KEY `Company_idx` (`Company`),
  ADD KEY `PK_Index` (`Airline_code`,`Company`);

--
-- Tablo için indeksler `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`Airplane_id`,`Company`),
  ADD KEY `airplane_ibfk_1` (`Company`),
  ADD KEY `type_FK` (`Airplane_type`);

--
-- Tablo için indeksler `airplane_type`
--
ALTER TABLE `airplane_type`
  ADD PRIMARY KEY (`Airplane_type_name`);

--
-- Tablo için indeksler `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`Airport_code`),
  ADD UNIQUE KEY `Name_UNIQUE` (`Name`);

--
-- Tablo için indeksler `can_land`
--
ALTER TABLE `can_land`
  ADD PRIMARY KEY (`Airplane_type_name`,`Airport_code`),
  ADD KEY `can_land_airport` (`Airport_code`);

--
-- Tablo için indeksler `check_in`
--
ALTER TABLE `check_in`
  ADD PRIMARY KEY (`Check_in_id`,`Customer_pass`,`Flight_number`,`Leg_number`,`Date`,`Seat_number`),
  ADD UNIQUE KEY `Check_in_id` (`Check_in_id`),
  ADD KEY `seat_FK` (`Customer_pass`,`Flight_number`,`Leg_number`,`Date`,`Seat_number`);

--
-- Tablo için indeksler `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_name`);

--
-- Tablo için indeksler `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Passport_no`);

--
-- Tablo için indeksler `fare`
--
ALTER TABLE `fare`
  ADD PRIMARY KEY (`Flight_number`,`Fare_code`),
  ADD UNIQUE KEY `Fare_code_UNIQUE` (`Fare_code`,`Flight_number`);

--
-- Tablo için indeksler `ff_customer`
--
ALTER TABLE `ff_customer`
  ADD PRIMARY KEY (`Cust_pass`,`Company`),
  ADD KEY `rank_FK` (`Company`,`Rank_no`);

--
-- Tablo için indeksler `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`Flight_number`),
  ADD KEY `airline_FK` (`Airline_code`,`Company`),
  ADD KEY `Flight_num` (`Flight_number`);

--
-- Tablo için indeksler `flight_leg`
--
ALTER TABLE `flight_leg`
  ADD PRIMARY KEY (`Flight_number`,`Leg_number`),
  ADD KEY `flight_airport_FK` (`Departure_airport_code`),
  ADD KEY `flight_airport_FK2` (`Arrival_airport_code`);

--
-- Tablo için indeksler `leg_instance`
--
ALTER TABLE `leg_instance`
  ADD PRIMARY KEY (`Flight_number`,`Leg_number`,`Date`),
  ADD KEY `leg_airport_FK_idx` (`Depature_airport_code`,`Arrival_airport_code`),
  ADD KEY `leg_ins_airplane_FK` (`Airplane_id`),
  ADD KEY `leg_ins_airport_FK2` (`Arrival_airport_code`);

--
-- Tablo için indeksler `rank`
--
ALTER TABLE `rank`
  ADD PRIMARY KEY (`Company`,`Rank_no`);

--
-- Tablo için indeksler `seat_reservation`
--
ALTER TABLE `seat_reservation`
  ADD PRIMARY KEY (`Customer_pass`,`Leg_number`,`Flight_number`,`Date`,`Seat_number`),
  ADD UNIQUE KEY `seat_number_index` (`Seat_number`,`Flight_number`,`Leg_number`),
  ADD KEY `seat_pk` (`Customer_pass`,`Flight_number`,`Leg_number`,`Date`,`Seat_number`),
  ADD KEY `FK` (`Flight_number`,`Leg_number`,`Date`);

--
-- Tablo için indeksler `t_record`
--
ALTER TABLE `t_record`
  ADD PRIMARY KEY (`Customer_pass`,`Company`),
  ADD KEY `company_record_FK` (`Company`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `check_in`
--
ALTER TABLE `check_in`
  MODIFY `Check_in_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `airline`
--
ALTER TABLE `airline`
  ADD CONSTRAINT `Company` FOREIGN KEY (`Company`) REFERENCES `company` (`company_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `airplane`
--
ALTER TABLE `airplane`
  ADD CONSTRAINT `airplane_ibfk_1` FOREIGN KEY (`Company`) REFERENCES `company` (`company_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `type_FK` FOREIGN KEY (`Airplane_type`) REFERENCES `airplane_type` (`Airplane_type_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `can_land`
--
ALTER TABLE `can_land`
  ADD CONSTRAINT `can_land_airport` FOREIGN KEY (`Airport_code`) REFERENCES `airport` (`Airport_code`),
  ADD CONSTRAINT `can_land_type` FOREIGN KEY (`Airplane_type_name`) REFERENCES `airplane_type` (`Airplane_type_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `check_in`
--
ALTER TABLE `check_in`
  ADD CONSTRAINT `seat_FK` FOREIGN KEY (`Customer_pass`,`Flight_number`,`Leg_number`,`Date`,`Seat_number`) REFERENCES `seat_reservation` (`Customer_pass`, `Flight_number`, `Leg_number`, `Date`, `Seat_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `fare`
--
ALTER TABLE `fare`
  ADD CONSTRAINT `fare_flight_fk` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ff_customer`
--
ALTER TABLE `ff_customer`
  ADD CONSTRAINT `ff_passport` FOREIGN KEY (`Cust_pass`) REFERENCES `customer` (`Passport_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `airline_FK` FOREIGN KEY (`Airline_code`,`Company`) REFERENCES `airline` (`Airline_code`, `Company`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `flight_leg`
--
ALTER TABLE `flight_leg`
  ADD CONSTRAINT `flight_airport_FK` FOREIGN KEY (`Departure_airport_code`) REFERENCES `airport` (`Airport_code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_airport_FK2` FOREIGN KEY (`Arrival_airport_code`) REFERENCES `airport` (`Airport_code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_number_FK` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`);

--
-- Tablo kısıtlamaları `leg_instance`
--
ALTER TABLE `leg_instance`
  ADD CONSTRAINT `leg_ins_airplane_FK` FOREIGN KEY (`Airplane_id`) REFERENCES `airplane` (`Airplane_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leg_ins_airport_FK` FOREIGN KEY (`Depature_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leg_ins_airport_FK2` FOREIGN KEY (`Arrival_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leg_ins_flight_FK` FOREIGN KEY (`Flight_number`,`Leg_number`) REFERENCES `flight_leg` (`Flight_number`, `Leg_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `rank`
--
ALTER TABLE `rank`
  ADD CONSTRAINT `company_FK` FOREIGN KEY (`Company`) REFERENCES `company` (`company_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `seat_reservation`
--
ALTER TABLE `seat_reservation`
  ADD CONSTRAINT `FK` FOREIGN KEY (`Flight_number`,`Leg_number`,`Date`) REFERENCES `leg_instance` (`Flight_number`, `Leg_number`, `Date`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seat_customer` FOREIGN KEY (`Customer_pass`) REFERENCES `customer` (`Passport_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `t_record`
--
ALTER TABLE `t_record`
  ADD CONSTRAINT `Customer_FK` FOREIGN KEY (`Customer_pass`) REFERENCES `customer` (`Passport_no`),
  ADD CONSTRAINT `company_record_FK` FOREIGN KEY (`Company`) REFERENCES `company` (`company_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/* TRIGGERS */

/* İlk triggerda hedef seat_reservation tablosundaki verileri check_in tablosuna 'check_in_flag' degerine gore aktarma iselmi yapmak. */

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_seatreservation_insert AFTER INSERT ON seat_reservation 
FOR EACH ROW 
BEGIN
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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_seatreservation_update AFTER UPDATE ON seat_reservation 
FOR EACH ROW 
BEGIN
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
END$$
DELIMITER ;

/* t_record tablosunu ilgilendiren udpate ve insert triggerları*/
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_trecord_insert AFTER INSERT ON t_record
FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_trecord_update AFTER UPDATE ON t_record
FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;

#T_RECORD SİLİNİRSE FF_CUSTOMER'DA SİLİNMELİ
DELIMITER $$
CREATE TRIGGER after_trecord_delete AFTER DELETE ON t_record
FOR EACH ROW
BEGIN
	DELETE FROM ff_customer WHERE Cust_pass = OLD.Customer_pass AND Company = OLD.Company;
	
END$$
DELIMITER ;

/* check_in insert updatten sonra */
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_checkin_insert AFTER INSERT ON check_in
FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER IF NOT EXISTS after_checkin_delete AFTER DELETE ON check_in
FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;



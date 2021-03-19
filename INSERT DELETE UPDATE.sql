/* INSERT STATEMENTS FOR 5 TABLES */
INSERT INTO airlinedb.airport (Airport_code, Name, City, State) 
VALUES ('JFK', 'John F. Kennedy International', 'New York', 'USA');

INSERT INTO airlinedb.airline (Airline_code, Company, Airline_name) 
VALUES ('252', 'Taysi A.S', 'Nallihan Airlines');

INSERT INTO airlinedb.flight (Flight_number, Airline_code, Company, Weekdays) 
VALUES ('1000', '252', 'Taysi A.S', 'Monday,Saturday,Sunday');

INSERT INTO airlinedb.flight_leg (Flight_number, Leg_number, Departure_airport_code, Scheduled_depature_time, Arrival_airport_code, Scheduled_arrival_time, Mileage_information) 
VALUES ('1000', '1', 'JFK', '13:15:00', 'ISL', '01:30:00', '5005');

INSERT INTO airlinedb.fare (Flight_number, Fare_code, Amount, Restrictions) 
VALUES ('1000', 'CH', '50', 'Child Fare'),('1000', 'F', '235', 'First Class'); /* Multiple Rows */

/* UPDATE STATMENTS FOR 5 TABLES */
UPDATE airlinedb.fare SET Amount = '45' 
WHERE (Flight_number = '4543') and (Fare_code = 'W');

UPDATE airlinedb.airplane SET Total_number_of__seats = '135' 
WHERE (Airplane_id = '113') and (Company = 'Airbus');

UPDATE airlinedb.rank SET Reward = '%20 Grocery discount for ABC Market' 
WHERE (Company = 'Supreme Corp.') and (Rank_no = '3');

UPDATE airlinedb.flight_leg SET Scheduled_depature_time = '18:15:00' 
WHERE (Flight_number = '6569') and (Leg_number = '1');

UPDATE airlinedb.check_in
SET Check_in_flag = '0';		/*Check_in_flag attribute set to 0 for all Columns. */

/* DELETE STATEMENTS FOR 5 TABLES */
DELETE FROM airlinedb.customer
WHERE Passport_no = '14867898';

DELETE FROM airlinedb.airplane
WHERE Airplane_id = '55';

DELETE FROM airlinedb.seat_reservation 
WHERE (Customer_pass = '90147895') and (Leg_number = '1') and (Flight_number = '4543') and (Date = '2020-07-08') and (Seat_number = '45');

DELETE FROM airlinedb.fare
Where Fare_code = 'CH' and Fare_code = 'F'
ORDER BY Amount
LIMIT 3;					/*Fare Code CH and F selected, then Ordered by Amount Descedingly, Deleted first 3 rows. */

DELETE FROM airlinedb.company;		/* This query will delete all existing Company rows */






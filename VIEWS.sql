# VIEWS

/*1. Supreme Corp. fimrasının uçuşlarını listeler */
CREATE VIEW SupremeCorpFlights AS 
SELECT f.Company,f_leg.Flight_number, Leg_number, Departure_airport_code, Arrival_airport_code
FROM flight_leg AS f_leg
JOIN flight AS f
ON f.Flight_number = f_leg.Flight_number
WHERE f.Company = "Supreme Corp.";

/*2. Türkiyedeki havalimanlarını listeler */
CREATE VIEW AirportsTurkey AS
SELECT * FROM airport
WHERE State = "TUR";

/*3. Türkiye için iç hatlar uçuşlarını ve tarihlerini gösterir */
CREATE VIEW IcHatlarTurkiye AS
SELECT Flight_number,Leg_Number, Date, Depature_airport_code, Arrival_airport_code, airport1.State
FROM leg_instance
INNER JOIN airport AS airport1 ON Depature_airport_code = airport1.Airport_code
INNER JOIN airport AS airport2 ON Arrival_airport_code = airport2.Airport_code
WHERE airport1.State = "TUR" AND airport2.State = "TUR";

/*4. Tüm tiplerde uçak inebilen havalanı kodları ve isimleri */
CREATE VIEW CokYonluHavaalanları AS
SELECT airport.airport_code, name
FROM airport, can_land
WHERE airport.airport_code = can_land.airport_code
GROUP BY airport.airport_code
HAVING COUNT(*) = 3;

/*5. Turk Pasaportuna Sahip Customer'ların yaptığı rezervasyonlar */
CREATE VIEW TurkYolcular AS
SELECT customer.Name,Flight_number, Leg_number, Date, Seat_number
FROM seat_reservation,customer
WHERE Customer_pass = customer.Passport_no AND customer.Country = "TUR";
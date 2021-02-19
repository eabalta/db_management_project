# 5.b.i

/*1. Şu anda database'e kayıtlı uçuşların verilerini alır ve fiyatı artan olarak sıralar */
SELECT fare.Flight_number,Airline_code,Fare_code,Amount
FROM airlinedb.flight,airlinedb.fare
WHERE fare.Flight_number=flight.Flight_number
ORDER BY Amount ASC;

/*2. Database'e kayıtlı uçakların tiplerine göre kaçar tane olduğunu belirler */
SELECT Airplane_type_name,COUNT(airplane.Airplane_type) as in_airplane
FROM airplane,airplane_type
WHERE airplane.Airplane_type = airplane_type.Airplane_type_name
GROUP BY Airplane_type_name; 

/*3. Tüm tiplerde uçak inebilen havaalanlarının kodları ve isimleri nedir? */
SELECT airport.airport_code, name
FROM airport, can_land
WHERE airport.airport_code = can_land.airport_code
GROUP BY airport.airport_code
HAVING COUNT(*) = 3;

# 5.b.ii

/*4. FRA - MAN Rotasında fare kodu W(Premium economy) uçuşların belirlenmesi */
SELECT flight1.Flight_number, flight1.Departure_airport_code, flight3.Arrival_airport_code, COUNT(*) AS count_leg, fare.Amount
FROM flight_leg flight1
INNER JOIN flight_leg flight2
    ON flight1.flight_number = flight2.flight_number
    AND flight2.departure_airport_code = "FRA"
INNER JOIN flight_leg flight3
    ON flight1.flight_number = flight3.flight_number
    AND flight3.arrival_airport_code = "MAN"
INNER JOIN fare 
    ON flight1.flight_number = fare.flight_number 
    AND fare.fare_code = "W"
GROUP BY flight_number;

/*5. FRA havalanının kalkış noktası olduğu, First Class tipinde uçuşları ve fiyatını belirler */ 
SELECT fare.Flight_number,Depature_airport_code,Arrival_airport_code,Date,Amount
FROM flight, fare,leg_instance
WHERE flight.Flight_number = fare.Flight_number  AND Fare_code= 'F' AND flight.Flight_number = leg_instance.Flight_number 
AND Depature_airport_code = 'FRA';

/*6. Belli tarihler arasında uçuç yapmak isteyen birisi için fiyat ve restrictions tablosu*/ 
SELECT leg_instance.Flight_number,leg_instance.Leg_number,(Restrictions),Amount FROM airlinedb.fare
inner join flight on fare.Flight_number=flight.Flight_number
inner join flight_leg on flight.Flight_number=flight_leg.Flight_number
inner join leg_instance on flight_leg.Flight_number=leg_instance.Flight_number and flight_leg.Leg_number=leg_instance.Leg_number
WHERE (leg_instance.Date BETWEEN '2020-07-07' AND '2020-07-08');

/*Sonradan ekle*/
/*7. arrival airport için şirketler*/
select airport.Name,airline.company from airport 
inner join flight_leg on airport.Airport_code=flight_leg.Arrival_airport_code
inner join flight on flight_leg.Flight_number=flight.Flight_number
inner join airline on flight.Airline_code=airline.Airline_code
and flight.Company=airline.Company;



/*FULL OUTER JOIN*/
SELECT *
FROM customer
RIGHT JOIN ff_customer ON customer.Passport_no = ff_customer.Cust_pass
UNION
SELECT *
FROM customer
LEFT JOIN ff_customer ON customer.Passport_no = ff_customer.Cust_pass;



#5.c

/*1. Bir müşterinin FFC olup olmadığını belirler, İsim bilgileri ve reward'ı yazdırır. */
SELECT customer.Name, Country, ff_customer.Company, ff_customer.Rank_no, rnk.Reward
FROM customer, ff_customer, airlinedb.rank AS rnk
WHERE rnk.Rank_no = ff_customer.Rank_no AND ff_customer.Company = rnk.Company AND (Passport_no) IN (SELECT Cust_pass
						FROM ff_customer);

/*2. Cuma ve Cumartesi uçuşu olan firmalar, uçuş kodlarının belirlenmesi ve ücretleri  */
SELECT fare.Flight_number, Amount, Restrictions
FROM fare 
WHERE (Flight_number) IN (SELECT Flight_number
						FROM flight
						WHERE Weekdays LIKE '%Friday%' OR Weekdays LIKE '%Saturday%');
                        
/*3. First Class uçuşların ortalamalarından daha büyük ücrete sahip uçuşlar listelenir */
SELECT Flight_number, Amount, Restrictions
FROM fare 
HAVING Amount >= all (SELECT AVG(Amount)
						   FROM fare
                           WHERE Fare_code = "F");
                           
/*4. Müşterilerin yaptığı check_in sayıları  */
SELECT Passport_no,check_num,Name, Country
FROM (SELECT Customer_pass, COUNT(*) as check_num
FROM check_in
GROUP BY Customer_pass) as total_check_in_per_customer, customer
WHERE total_check_in_per_customer.Customer_pass = customer.Passport_no
ORDER BY check_num DESC;

                        
/*LEFT JOIN*/
/* Atanmış ve atanmamış bütün uçakları listeler */
SELECT airplane.Airplane_id,airplane.Name,leg_instance.Flight_number,leg_instance.Leg_number,leg_instance.Date,leg_instance.Number_of_available_seats
From airplane
LEFT JOIN leg_instance ON airplane.Airplane_id= leg_instance.Airplane_id
ORDER by airplane.Airplane_id;

/*EXIST */
/* Eğer ISL'den kalkan bir uçağa kayıtlı müşteri varsa o uçuşun bilgilerini yazdırsın */
SELECT fl.Flight_number, Customer_pass, Departure_airport_code,Arrival_airport_code, Mileage_information
FROM flight_leg AS fl, seat_reservation AS sr
WHERE EXISTS (SELECT seat_reservation.Customer_pass as cust
			   FROM seat_reservation,leg_instance
               WHERE seat_reservation.Flight_number = leg_instance.Flight_number AND leg_instance.Depature_airport_code = "ISL") 
               AND Departure_airport_code="ISL" AND fl.Flight_number = sr.Flight_number;
/*EXIST */
SELECT customer.Passport_no,customer.Name,ff_customer.Company 
FROM customer,ff_customer 
WHERE EXISTS(SELECT ff_customer.Cust_pass 
FROM ff_customer 
WHERE customer.Passport_no = ff_customer.Cust_pass and ff_customer.Rank_no > 2);
/*NOT EXIST */
SELECT company.company_name 
FROM company 
WHERE NOT EXISTS(SELECT airplane.Airplane_id 
FROM airplane 
WHERE company.company_name = airplane.Company);

/*LEFT JOIN*/
SELECT airplane.Airplane_id,airplane.Name,leg_instance.Flight_number,leg_instance.Leg_number,leg_instance.Date,leg_instance.Number_of_available_seats
From airplane
LEFT JOIN leg_instance ON airplane.Airplane_id= leg_instance.Airplane_id
ORDER by airplane.Airplane_id;
/*RIGHT JOIN*/
SELECT airplane.Airplane_id,airplane.Name,can_land.Airplane_type_name,can_land.Airport_code,airport.Name,airport.City 
FROM airplane 
RIGHT JOIN can_land on can_land.Airplane_type_name = airplane.Airplane_type 
RIGHT JOIN airport on can_land.Airport_code = airport.Airport_code;






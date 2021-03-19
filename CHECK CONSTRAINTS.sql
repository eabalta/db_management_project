/* Herhangi bir sivil uçağın koltuk sayısı maksimum 800 olabilir */
ALTER TABLE airplane
ADD CONSTRAINT CHK_seat_num CHECK (Total_number_of__seats < 800);

/* Boş koltuk sayısı sıfırın altında olamaz */
ALTER TABLE leg_instance
ADD CONSTRAINT CHK_available_seat CHECK (Number_of_available_seats  >= 0);

/*Customer için Country Code 3 haneli olmalıdır */
ALTER TABLE customer
ADD CONSTRAINT CHK_countryCode CHECK (char_length(Country_code) = 3);

/* Ucret sıfırdan kucuk, 7000'den buyuk olamaz. 7000 tavan fiyat seçildi */
ALTER TABLE fare
ADD CONSTRAINT CHK_fare CHECK ( Amount < 7000 AND Amount> 0);

/* Dünya üzerindeki en kısa ve en uzun tek seferlik uçuş baz alınarak yapılmıştır */
ALTER TABLE flight_leg
ADD CONSTRAINT CHK_mileage_info CHECK ( Mileage_information > 1.7 AND Mileage_information < 9.534);
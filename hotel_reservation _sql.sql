/* CREATE AND IMPORT DATA */

CREATE DATABASE hotel_reservation_project;

USE hotel_reservation_project;

DROP TABLE IF EXISTS hotel;

CREATE TABLE hotel(
	Booking_ID	VARCHAR(20),
    no_of_adults INT,
    no_of_children	INT,
    no_of_weekend_nights INT,	
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(25),
    required_car_parking_space TINYINT,
    room_type_reserved VARCHAR(30),
    lead_time INT,
    arrival_year INT,
    arrival_month INT,
    arrival_date INT,	
    market_segment_type	VARCHAR(35),
    repeated_guest TINYINT,
    no_of_previous_cancellations INT,	
    no_of_previous_bookings_not_canceled INT,	
    avg_price_per_room	DECIMAL(10,2),
    no_of_special_requests	INT,
    booking_status VARCHAR(30)
);

LOAD DATA LOCAL INFILE "pathfile.csv"
INTO TABLE hotel_reservation_project.hotel
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM hotel
LIMIT 5;


/* 1. What is the total number of bookings received by the hotel?  */ 

SELECT COUNT(*) AS total_bookings
FROM hotel;

/* 2. What is the total revenue generated from confirmed(non-canceled)bookings? */

SELECT SUM(avg_price_per_room) AS total_revenue
FROM hotel
WHERE booking_status = 'Not_Canceled';

/* 3. What is average lead time?*/

SELECT AVG(lead_time) AS avg_lead_time
FROM hotel; 

/* 4. What is the overall booking cancellation rate? */

SELECT ROUND(SUM(booking_status = 'Canceled') / COUNT(*) * 100,2) AS cancellation_rate
FROM hotel;

/* 5. How many special requests were made across all bookings?  */

SELECT SUM(no_of_special_requests) AS total_special_requests
FROM hotel;

/* 6. How many guests are repeat customers? */

SELECT COUNT(repeated_guest) AS repeat_guest_count
FROM hotel
WHERE repeated_guest = 1;

/* 7. What is the average price paid per room across all bookings? */

SELECT ROUND(AVG(avg_price_per_room),2) AS avg_price_per_room
FROM hotel;

/* 8. How many bookings included a parking space?*/

SELECT COUNT(*) AS parking_booking
FROM hotel
WHERE required_car_parking_space = 1;

/* 9. What is the total number of weekend and weekday nights booked? */

SELECT SUM(no_of_weekend_nights) AS total_weekend_nights,
SUM(no_of_week_nights) AS total_week_nights
FROM hotel;

/* 10. What is the distribution of total guests (adults,children) per booking? */     

SELECT (no_of_adults + no_of_children) AS total_guests,
COUNT(*) AS booking_count
FROM hotel
GROUP BY total_guests
ORDER BY total_guests;

/* 11. How many adults and children arrived each month? */

SELECT arrival_month,SUM(no_of_adults) AS adults, SUM(no_of_children) AS childeren
FROM hotel
GROUP BY arrival_month
ORDER BY arrival_month;

/* 12. month wise weekend nights and week nights */

SELECT arrival_month,SUM(no_of_weekend_nights) AS weekend_nights,SUM(no_of_week_nights) AS week_nights
FROM hotel
GROUP BY arrival_month
ORDER BY arrival_month;

/* 13. How are the weekend and weekday nights distributed across different room types? */

SELECT room_type_reserved,SUM(no_of_weekend_nights) AS weekend_nights, SUM(no_of_week_nights) AS week_nights
FROM hotel
GROUP BY room_type_reserved
ORDER BY room_type_reserved;

/* 14. What types of meal plans are most commonly chosen by guests? */ 

SELECT type_of_meal_plan AS meal_type, COUNT(*) AS count
FROM hotel
GROUP BY 1;

/* 15. How many bookings required a car parking space? */ 

SELECT required_car_parking_space AS car_parking, COUNT(*) AS count
FROM hotel
GROUP BY 1;

/* 16. What is the distribution of room types reserved? */ 

SELECT room_type_reserved AS reserved_room, COUNT(*) AS count
FROM hotel
GROUP BY reserved_room;

/* 17. How do bookings vary by year and month? */ 

SELECT arrival_year, arrival_month, COUNT(*) AS count
FROM hotel
GROUP BY arrival_year,arrival_month
ORDER BY arrival_year,arrival_month;


/* 18. Which market segments are bringing in the most guests? */ 

SELECT market_segment_type, COUNT(*) AS count
FROM hotel
GROUP BY market_segment_type;

/* 19. What is the total revenue generated from each market segment (non-canceled bookings only)? */

SELECT market_segment_type, SUM(avg_price_per_room) AS price
FROM hotel
WHERE booking_status = 'Not_Canceled'
GROUP BY market_segment_type;

/* 20. What is the count of repeated vs non-repeated guests? (1-repeated guests , 0-non repeated guests) */  

SELECT repeated_guest , COUNT(*) AS count
FROM hotel
GROUP BY repeated_guest;

/* 21. What is the average room price per month? */ 

SELECT arrival_month AS months,ROUND(AVG(avg_price_per_room),2) AS avg_price
FROM hotel
GROUP BY months
ORDER BY months;

/* 22. How many special requests are made and how often? */ 

SELECT no_of_special_requests, COUNT(*) AS count
FROM hotel
GROUP BY 1;


/* 23. What is the count of canceled vs non canceled bookings? */ 

SELECT booking_status, COUNT(*) AS count
FROM hotel
GROUP BY booking_status;


/* 24. What is the total number of canceled bookings? */

SELECT COUNT(*) AS count
FROM hotel
WHERE booking_status = 'Canceled';

/* 25. How do bookings vary month by month */

SELECT arrival_month, COUNT(*) AS total_booking
FROM hotel
GROUP BY arrival_month
ORDER BY arrival_month;

/* 26.Average price by room type */

SELECT room_type_reserved, ROUND(AVG(avg_price_per_room),2) AS avg_price
FROM hotel
WHERE booking_status = 'Not_Canceled'
GROUP BY room_type_reserved
ORDER BY room_type_reserved;

/* 27. Month Booking Trend */

SELECT MONTHNAME(MAKEDATE(2000, arrival_month * 30)) AS month_name, COUNT(*) AS booking
FROM hotel
GROUP BY arrival_month
ORDER BY arrival_month; 

/* 28. Which room type is most frequently canceled? */

SELECT room_type_reserved, COUNT(booking_status) AS cancel_bookings
FROM hotel
WHERE booking_status = 'Canceled'
GROUP BY room_type_reserved;

/* 29. Which room type is booked the most */

SELECT room_type_reserved, COUNT(booking_status) AS most_booking
FROM hotel
WHERE booking_status = 'Not_Canceled'
GROUP BY room_type_reserved
ORDER BY room_type_reserved;

/* 30. Which market segment brings in the most revenue */

SELECT market_segment_type, SUM(avg_price_per_room) AS revenue
FROM hotel
WHERE booking_status = 'Not_Canceled'
GROUP BY market_segment_type
ORDER BY 2 DESC;









































































































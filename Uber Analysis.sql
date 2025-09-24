-- Create Database
CREATE DATABASE IF NOT EXISTS UBER;

-- Use the Database
USE UBER;

-- Drop Tables if they exist
DROP TABLE IF EXISTS Bookings;

-- --- Data exploration 
SELECT count(*) FROM Bookings;

-- --- Sample data 
SELECT * FROM Bookings LIMIT 10;

--  1. Retrieve all successful bookings:
CREATE VIEW Successful_Bookings AS
SELECT * FROM Bookings
WHERE Booking_Status ='Completed';

-- NO need to use write whole query instead use view option
SELECT * FROM Successful_Bookings;

--  2. Find the average ride distance for each vehicle type:
SELECT Vehicle_Type, ROUND(AVG(Ride_Distance),2) AS Avg_dist
FROM Bookings
GROUP BY Vehicle_Type;

--  3. Get the total number of cancelled rides by customers:
CREATE VIEW cancelled_Bookings AS
SELECT count(*) FROM Bookings
WHERE Booking_Status ='Cancelled by Customer';

SELECT * FROM cancelled_Bookings;


-- 4. List the top 5 customers who booked the highest number of rides:
SELECT Customer_ID, count(Booking_ID) AS Total_rides 
FROM Bookings
GROUP BY Customer_ID
ORDER BY Total_rides DESC LIMIT 5;


-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT Count(Cancelled_Rides_by_Driver) AS Rides_can_by_Driver
FROM Bookings
WHERE Driver_Cancellation_Reason ='Personal & Car related issues';


-- 6. Find the maximum and minimum driver ratings for Uber XL bookings:
SELECT MAX(Driver_Ratings) AS Max_ratings ,
MIN(Driver_Ratings) AS Min_ratings
FROM Bookings
WHERE Vehicle_Type = 'Uber XL';

-- 7. Retrieve all rides where payment was made using UPI:
SELECT * FROM Bookings
WHERE Booking_Status = 'Completed' AND Payment_Method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
SELECT Vehicle_Type,ROUND(AVG(Customer_Rating),2) AS Cust_rating
FROM Bookings
GROUP BY Vehicle_Type;

--  9. Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) AS Total_Booking_Value
FROM Bookings
WHERE Booking_Status = 'Completed';

--  10. List all incomplete rides along with the reason:
SELECT Booking_ID,Incomplete_Rides_Reason
FROM Bookings
WHERE Incomplete_Rides = 'Yes';

-- 11. What % of rides are paid using each payment method (Cash, UPI, Card):
SELECT Payment_Method,
(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Bookings)) AS percentage
FROM Bookings
GROUP BY payment_method;



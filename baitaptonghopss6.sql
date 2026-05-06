CREATE DATABASE IF NOT EXISTS top_user_vip_db;
USE top_user_vip_db;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY,
    star_rating INT
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    hotel_id INT,
    total_price DECIMAL(15,2),
    status VARCHAR(20)
);

INSERT INTO Users VALUES (1, 'Nguyễn Tấn Dư'), (2, 'Lê Tuấn');
INSERT INTO Hotels VALUES (101, 5), (102, 4), (103, 5);

INSERT INTO Bookings VALUES 
(1, 1, 101, 60000000, 'COMPLETED'),
(2, 1, 102, 55000000, 'COMPLETED'),
(3, 2, 101, 40000000, 'COMPLETED'),
(4, 1, 103, -2000000, 'COMPLETED'),
(5, 1, 101, 10000000, 'CANCELLED');

SELECT 
    u.full_name,
    h.star_rating,
    SUM(b.total_price) AS total_spent
FROM 
    Users u
JOIN 
    Bookings b ON u.user_id = b.user_id
JOIN 
    Hotels h ON b.hotel_id = h.hotel_id
WHERE 
    b.status = 'COMPLETED'
    AND b.total_price > 0
GROUP BY 
    u.user_id,
    u.full_name, 
    h.star_rating
HAVING 
    SUM(b.total_price) > 50000000
ORDER BY 
    h.star_rating DESC,
    total_spent DESC;
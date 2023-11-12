-- Kamisha Richardson & William Thomas 
-- INT499:Capstone for Information Technology 
-- University of Arizona Global Campus 
-- Prof. Austine Ohwobete 
-- 11/9/2023 

-- Database Creation
CREATE DATABASE IF NOT EXISTS EZTechMovieDB;
USE EZTechMovieDB;

-- Plans Table
CREATE TABLE IF NOT EXISTS Plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(255) NOT NULL,
    plan_type ENUM('Individual', 'Friendly', 'Family', 'DVD') NOT NULL,
    max_streams INT,
    max_dvds INT,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT
);

-- Insert sample data into the Plans Table
INSERT INTO Plans (plan_name, plan_type, max_streams, max_dvds, price, description) VALUES
('Individual Streaming', 'Individual', 1, NULL, 9.99, 'Streaming for one person. Customer can stream one movie to a single device at a time. This is the most common plan. Customers can cancel or change their plan for free at any time.'),
('Friendly Streaming', 'Friendly', 2, NULL, 19.99, 'Streaming for friends and family. Customers can stream movies to up to two devices simultaneously, in high definition (HD) if available. Customers can cancel or change their plan for free at any time.'),
('Family Streaming', 'Family', 4, NULL, 24.99, 'Streaming for the whole family. Customers can stream movies to up to four devices simultaneously, in ultra-high definition (UHD) if available. Customers can cancel or change their plan for free at any time.'),
('Individual DVD', 'DVD', NULL, 1, 4.99, 'One DVD at a time, once a month. No late fees. Free two-day shipping via USPS. Customers can cancel or change their plan for free at any time.'),
('Friendly DVD', 'DVD', NULL, 1, 7.99, 'One DVD at a time, unlimited times per month. No late fees. Free two-day shipping via USPS. Customers can cancel or change their plan for free at any time.'),
('Family DVD', 'DVD', NULL, 2, 11.99, 'Two DVDs at a time, unlimited times per month. No late fees. Free two-day shipping via USPS. Customers can cancel or change their plan for free at any time.');

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Ensure to use proper hashing methods for storing passwords
    plan_id INT,
    payment_method VARCHAR(50) NOT NULL,
    membership_start DATE NOT NULL,
    CONSTRAINT fk_plan FOREIGN KEY(plan_id) REFERENCES Plans(plan_id)
);

-- Insert sample data into the Customers Table
INSERT INTO Customers (customer_name, username, password, plan_id, payment_method, membership_start) VALUES
('John Doe', 'john_doe', 'hashed_password', 1, 'Credit Card', '2023-10-02'),
('Jane Smith', 'jane_smith', 'hashed_password', 2, 'PayPal', '2023-10-09'),
('Bob Johnson', 'bob_johnson', 'hashed_password', 3, 'Credit Card', '2023-10-16');

-- Movies Table
CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_name VARCHAR(255) NOT NULL,
    movie_rating VARCHAR(10) NOT NULL,
    description TEXT
);

-- Insert sample data into the Movies Table
INSERT INTO Movies (movie_name, movie_rating, description) VALUES
('Twister', 'PG-13', 'A thrilling action film about storm chasers pursuing tornadoes.'),
('The Day After Tomorrow', 'PG-13', 'A disaster film depicting extreme weather events and their global impact.'),
('2012', 'PG-13', 'A science fiction disaster film depicting the events surrounding the predicted end of the world in 2012.'),
('Into the Storm', 'PG-13', 'A found footage disaster film that chronicles the occurrence of a series of deadly tornadoes.'),
('San Andreas', 'PG-13', 'An action-adventure film about a massive earthquake hitting California.'),
('Dante''s Peak', 'PG-13', 'A disaster film about a volcanologist and a town facing the imminent eruption of a dormant volcano.');

-- Customer Movies Association Table
CREATE TABLE IF NOT EXISTS Customer_Movies (
    customer_movie_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    watch_date DATE NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id)
);

-- DVDs Table
CREATE TABLE IF NOT EXISTS DVDs (
    dvd_id INT AUTO_INCREMENT PRIMARY KEY,
    dvd_title VARCHAR(255) NOT NULL,
    description TEXT
);

-- Customer DVDs Association Table
CREATE TABLE IF NOT EXISTS Customer_DVDs (
    customer_dvd_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    dvd_id INT NOT NULL,
    rent_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY(dvd_id) REFERENCES DVDs(dvd_id)
);

-- Devices Table
CREATE TABLE IF NOT EXISTS Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    device_name VARCHAR(255) NOT NULL,
    last_used_date DATE NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

-- Print the contents of the Plans Table
SELECT * FROM Plans;

-- Print the contents of the Customers Table
SELECT * FROM Customers;

-- Print the contents of the Movies Table
SELECT * FROM Movies;

-- Print the contents of the Customer_Movies Association Table
SELECT * FROM Customer_Movies;

-- Print the contents of the DVDs Table
SELECT * FROM DVDs;

-- Print the contents of the Customer_DVDs Association Table
SELECT * FROM Customer_DVDs;

-- Print the contents of the Devices Table
SELECT * FROM Devices;

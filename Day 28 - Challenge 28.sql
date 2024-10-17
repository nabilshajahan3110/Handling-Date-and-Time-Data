
# DAY 28 - Challenge 28

# HANDLING DATE AND TIME DATA IN MySQL

CREATE DATABASE Next;
USE Next;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL
);

-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, customer_name, registration_date) VALUES
(101, 'John Doe', '2023-01-15'),
(102, 'Jane Smith', '2023-05-22'),
(103, 'Alice Johnson', '2023-03-10'),
(104, 'Robert Brown', '2023-07-04');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    ship_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert sample data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, ship_date, total_amount) VALUES
(1, 101, '2023-10-01 14:30:00', '2023-10-03 09:00:00', 250.50),
(2, 102, '2023-10-02 11:00:00', '2023-10-04 16:00:00', 130.00),
(3, 103, '2023-10-05 10:15:00', '2023-10-06 14:30:00', 75.25),
(4, 101, '2023-10-06 16:45:00', '2023-10-09 10:45:00', 200.00),
(5, 104, '2023-10-10 09:30:00', '2023-10-11 12:15:00', 500.00);


# 1. Retrieve the current date and time using MySQL functions.

SELECT NOW() AS current_datetime, CURDATE() AS present_date, CURTIME() AS present_time;

# 2. Get the year, month, and day from the order date of each order.

SELECT order_id, YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month, DAY(order_date) AS order_day
FROM Orders;

# 3. Calculate the number of days it took to ship each order.

SELECT order_id, DATEDIFF(ship_date, order_date) AS NoOfDaysToShip
FROM Orders;

# 4. Get the orders placed in the last 7 days.

SELECT * FROM Orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

# 5. Find the customers who have registered within the last 3 months.

SELECT customer_id, customer_name, registration_date
FROM Customers
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

# 6. Calculate the time difference in hours between the order and ship dates.

SELECT order_id, TIMESTAMPDIFF(HOUR, order_date, ship_date) AS Hours_To_Ship
FROM Orders;

# 7. Extract the day of the week for each order.

SELECT order_id, DAYOFWEEK(order_date) AS order_weekday
FROM Orders;
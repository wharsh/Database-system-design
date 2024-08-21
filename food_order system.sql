DROP DATABASE IF EXISTS food_order;
CREATE DATABASE food_order;
USE food_order;

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerName VARCHAR(100) NOT NULL,
  PhoneNumber VARCHAR(15) NOT NULL,
  CustomerAddress VARCHAR(255) NOT NULL,
  CustomerRating FLOAT DEFAULT 0
);
DROP TABLE IF EXISTS MenuItem;
CREATE TABLE MenuItem (
  MenuID INT AUTO_INCREMENT PRIMARY KEY,
  ItemDetails VARCHAR(255) NOT NULL,
  ItemPrice FLOAT NOT NULL
);
DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  PaymentType VARCHAR(50) NOT NULL,
  PaymentDetail VARCHAR(255),
  PaymentDate DATETIME NOT NULL,
  PaymentAmount FLOAT NOT NULL
);

DROP TABLE IF EXISTS DeliveryAgent;
CREATE TABLE DeliveryAgent (
  DriverID INT AUTO_INCREMENT PRIMARY KEY,
  DeliveryRate FLOAT NOT NULL,
  DeliveryRating FLOAT DEFAULT 0
);

DROP TABLE IF EXISTS Address;
CREATE TABLE Address (
  AddressID INT AUTO_INCREMENT PRIMARY KEY,
  HouseNo VARCHAR(50) ,
  streetNo VARCHAR(50) ,
  City VARCHAR(30) NOT NULL,
  Zipcode VARCHAR(10) NOT NULL,
  orderID INT NOT NULL
  );


DROP TABLE IF EXISTS Restaurant;
CREATE TABLE Restaurant (
  RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
  OperationTime VARCHAR(50) NOT NULL,
  DeliveryTime VARCHAR(50) NOT NULL,
  DeliveryFee FLOAT NOT NULL,
  RestaurantPromos VARCHAR(255),
  RestaurantComission FLOAT NOT NULL,
  RestaurantRating FLOAT DEFAULT 0,
  MenuID INT NOT NULL,
 FOREIGN KEY (MenuID) REFERENCES MenuItem(MenuID)
);


DROP TABLE IF EXISTS ordertable;
CREATE TABLE OrderTable (
  OrderID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  PaymentID INT NOT NULL,
  AddressID INT NOT NULL,
  DriverID INT NOT NULL,
  Date DATETIME NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
  FOREIGN KEY (DriverID) REFERENCES DeliveryAgent(DriverID)
);
DROP TABLE IF EXISTS OrderItem;
CREATE TABLE OrderItem (
  OrderID INT NOT NULL,
  MenuID INT NOT NULL,
  Qty INT NOT NULL,
  PRIMARY KEY (OrderID, MenuID),
  FOREIGN KEY (OrderID) REFERENCES ordertable (OrderID),
  FOREIGN KEY (MenuID) REFERENCES MenuItem(MenuID)
);


-- Insert values into the Customer table
INSERT INTO Customer (CustomerName, PhoneNumber, CustomerAddress, CustomerRating) VALUES
('John Smith', '123-456-7890', '123 Main St, Anytown USA', 4.5),
('Jane Doe', '555-555-5555', '555 Elm St, Anytown USA', 3.2),
('Sarah Lee', '987-654-3210', '456 Main St, Anytown USA', 4.8),
('David Kim', '111-222-3333', '789 Elm St, Anytown USA', 3.7),
('Karen Wong', '444-555-6666', '123 Maple St, Anytown USA', 4.2);

-- Insert values into the MenuItem table
INSERT INTO MenuItem (ItemDetails, ItemPrice) VALUES
('Hamburger', 8.99),
('French Fries', 3.49),
('Soda', 1.99),
('Cheeseburger', 9.99),
('Onion Rings', 4.99),
('Milkshake', 3.99),
('Salad', 7.99);

-- Insert values into the Payment table
INSERT INTO Payment (PaymentType, PaymentDetail, PaymentDate, PaymentAmount) VALUES
('Credit Card', '**** **** **** 1234', '2023-02-14 12:34:56', 15.47),
('PayPal', 'johndoe@example.com', '2023-02-13 10:20:30', 23.98),
('Cash', NULL, '2023-02-14 13:45:00', 20.00),
('Credit Card', '**** **** **** 5678', '2023-02-14 19:15:00', 13.23),
('Venmo', 'janedoe@example.com', '2023-02-14 20:30:00', 17.89);

-- Insert values into the DeliveryAgent table
INSERT INTO DeliveryAgent (DeliveryRate, DeliveryRating) VALUES
(0.25, 4.1),
(0.30, 3.8),
(0.35, 4.5),
(0.20, 3.2),
(0.40, 4.8);

-- Insert values into the Address table
INSERT INTO Address (HouseNo, streetNo, City, Zipcode, orderID) VALUES
('123', 'Main St', 'Anytown USA', '12345', 1),
('555', 'Elm St', 'Anytown USA', '12345', 2),
('456', 'Main St', 'Anytown USA', '12345', 3),
('789', 'Elm St', 'Anytown USA', '12345', 4),
('321', 'Oak St', 'Anytown USA', '12345', 5);

-- Insert values into the Restaurant table
INSERT INTO Restaurant (OperationTime, DeliveryTime, DeliveryFee, RestaurantPromos, RestaurantComission, RestaurantRating, MenuID) VALUES
('10:00 AM - 9:00 PM', '11:00 AM - 8:00 PM', 2.99, 'Free drink with purchase of burger and fries', 0.15, 4.2, 1),
('11:00 AM - 9:00 PM', '12:00 PM - 8:00 PM', 3.99, 'Free delivery on orders over $30', 0.20, 4.4, 2);

-- Insert values into the Order table
INSERT INTO OrderTable (CustomerID, PaymentID, AddressID, DriverID, Date) VALUES
(1, 2, 1, 1, '2023-02-14 17:30:00'),
(2, 1, 2, 2, '2023-02-14 18:45:00'),
(3, 3, 3, 1, '2023-02-14 19:30:00'),
(2, 2, 4, 3, '2023-02-14 20:15:00'),
(1, 1, 5, 2, '2023-02-14 21:00:00'),
(1, 2, 1, 1, '2023-02-14 12:00:00');

-- Insert values into the OrderItem table
INSERT INTO OrderItem (OrderID, MenuID, Qty) VALUES
(1, 1, 2),
(1, 2, 1),
(1, 3, 2),
(2, 1, 1),
(2, 2, 2),
(3, 1, 1),
(3, 2, 2),
(3, 3, 1),
(4, 3, 1),
(4, 4, 2),
(5, 2, 2),
(5, 3, 1),
(5, 4, 1),
(6, 2, 1), 
(6, 4, 3);

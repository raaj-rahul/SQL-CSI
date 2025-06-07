-- 1. Drop database if it exists
DROP DATABASE IF EXISTS adventureworkslite;

-- 2. Create fresh database
CREATE DATABASE adventureworkslite;
USE adventureworkslite;

-- 3. Create Customers table
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CompanyName VARCHAR(100),
    ContactName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    Fax VARCHAR(50)
);

-- 4. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    Discontinued BIT
);

-- 5. Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID VARCHAR(10),
    EmployeeID INT,
    OrderDate DATE,
    ShipCountry VARCHAR(50),
    ShipPostalCode VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 6. Create Order_Details table
CREATE TABLE Order_Details (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 7. Insert sample Customers
INSERT INTO Customers VALUES
('ALFK', 'Alfreds Futterkiste', 'Maria Anders', 'Berlin', 'Germany', '030-0076545'),
('ANAR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Mexico City', 'Mexico', NULL),
('CACT', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Buenos Aires', 'Argentina', '123456'),
('CENT', 'Centro comercial Moctezuma', 'Francisco Chang', 'London', 'UK', NULL);

-- 8. Insert sample Products
INSERT INTO Products VALUES
(1, 'Chai', 1, 1, 18.00, 39, 0, 0),
(2, 'Chang', 1, 1, 19.00, 17, 40, 0),
(3, 'Tofu', 2, 2, 23.25, 120, 0, 0),
(4, 'Aniseed Syrup', 1, 2, 10.00, 13, 70, 1);

-- 9. Insert sample Orders
INSERT INTO Orders VALUES
(10248, 'ALFK', 5, '1996-07-04', 'France', '75000'),
(10249, 'ANAR', 3, '1996-07-05', 'Germany', '68159'),
(10250, 'CACT', 4, '1996-07-08', 'Argentina', '1001'),
(10251, 'CENT', 5, '1996-07-08', 'UK', 'E17 3AA');

-- 10. Insert sample Order_Details
INSERT INTO Order_Details VALUES
(10248, 1, 18.00, 10),  -- Chai
(10248, 3, 23.25, 5),   -- Tofu
(10249, 2, 19.00, 15),  -- Chang
(10250, 3, 23.25, 12),  -- Tofu
(10251, 1, 18.00, 20),  -- Chai
(10251, 4, 10.00, 10);  -- Aniseed Syrup

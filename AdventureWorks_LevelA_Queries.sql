-- AdventureWorks Level A SQL Queries

-- 1. List of all customers
SELECT * FROM Customers;

-- 2. Customers where company name ends with 'N'
SELECT * FROM Customers WHERE CompanyName LIKE '%N';

-- 3. Customers in Berlin or London
SELECT * FROM Customers WHERE City IN ('Berlin', 'London');

-- 4. Customers in UK or USA
SELECT * FROM Customers WHERE Country IN ('UK', 'USA');

-- 5. All products sorted by name
SELECT * FROM Products ORDER BY ProductName;

-- 6. Products where name starts with 'A'
SELECT * FROM Products WHERE ProductName LIKE 'A%';

-- 7. Customers who placed an order
SELECT DISTINCT c.* 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 8. Customers in London who bought Chai
SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Order_Details od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.City = 'London' AND p.ProductName = 'Chai';

-- 9. Customers who never placed an order
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- 10. Customers who ordered Tofu
SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Order_Details od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Tofu';

-- 11. First order in the system
SELECT * FROM Orders ORDER BY OrderDate LIMIT 1;

-- 12. Most expensive order (by total)
SELECT o.OrderID, o.OrderDate, SUM(od.UnitPrice * od.Quantity) AS Total
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
ORDER BY Total DESC
LIMIT 1;

-- 13. Each order’s average quantity
SELECT OrderID, AVG(Quantity) AS AvgQty
FROM Order_Details
GROUP BY OrderID;

-- 14. Each order's min and max quantity
SELECT OrderID, MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Order_Details
GROUP BY OrderID;

-- 15. All managers and number of employees reporting to them
SELECT m.EmployeeID AS ManagerID, CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName, COUNT(e.EmployeeID) AS NumEmployees
FROM Employees m
LEFT JOIN Employees e ON m.EmployeeID = e.ReportsTo
GROUP BY m.EmployeeID;

-- 16. Orders with total quantity > 300
SELECT OrderID, SUM(Quantity) AS TotalQty
FROM Order_Details
GROUP BY OrderID
HAVING TotalQty > 300;

-- 17. Orders placed on or after 1996-12-31
SELECT * FROM Orders WHERE OrderDate >= '1996-12-31';

-- 18. Orders shipped to Canada
SELECT * FROM Orders WHERE ShipCountry = 'Canada';

-- 19. Orders with order total > 200
SELECT o.OrderID, SUM(od.UnitPrice * od.Quantity) AS Total
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING Total > 200;

-- 20. Countries and sales made in each country
SELECT ShipCountry, SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY ShipCountry;

-- 21. Customer contact names and number of orders
SELECT c.ContactName, COUNT(o.OrderID) AS NumOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

-- 22. Customers with more than 3 orders
SELECT c.ContactName, COUNT(o.OrderID) AS NumOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
HAVING NumOrders > 3;

-- 23. Discontinued products ordered between 1997-01-01 and 1998-01-01
SELECT DISTINCT p.*
FROM Products p
JOIN Order_Details od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.Discontinued = 1
  AND o.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

-- 24. Employees and their supervisors
SELECT e.EmployeeID, e.FirstName, e.LastName, m.FirstName AS ManagerFirstName, m.LastName AS ManagerLastName
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID;

-- 25. Employee sales total
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, 
       SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID;

-- 26. Employees whose first name contains 'a'
SELECT * FROM Employees WHERE FirstName LIKE '%a%';

-- 27. Managers with more than 4 employees reporting
SELECT m.EmployeeID, CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName, COUNT(e.EmployeeID) AS NumEmployees
FROM Employees m
JOIN Employees e ON m.EmployeeID = e.ReportsTo
GROUP BY m.EmployeeID
HAVING NumEmployees > 4;

-- 28. Orders and product names
SELECT o.OrderID, p.ProductName
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- 29. Orders placed by the best customer (highest total sales)
SELECT o.*
FROM Orders o
WHERE o.CustomerID = (
    SELECT CustomerID
    FROM Orders o2
    JOIN Order_Details od2 ON o2.OrderID = od2.OrderID
    GROUP BY CustomerID
    ORDER BY SUM(od2.UnitPrice * od2.Quantity) DESC
    LIMIT 1
);

-- 30. Orders by customers without Fax number
SELECT o.*
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Fax IS NULL;

-- 31. Postal codes where Tofu was shipped
SELECT DISTINCT o.ShipPostalCode
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Tofu';

-- 32. Product names shipped to France
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Order_Details od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.ShipCountry = 'France';

-- 33. Products and categories for supplier 'Specialty Biscuits, Ltd.'
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Specialty Biscuits, Ltd.';

-- 34. Products never ordered
SELECT * FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Order_Details);

-- 35. Products with UnitsInStock < 10 and UnitsOnOrder = 0
SELECT * FROM Products
WHERE UnitsInStock < 10 AND UnitsOnOrder = 0;

-- 36. Top 10 countries by sales
SELECT o.ShipCountry, SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY TotalSales DESC
LIMIT 10;

-- 37. Number of orders each employee has taken for customers with CustomerIDs between 'A' and 'AO'
SELECT e.EmployeeID, COUNT(o.OrderID) AS NumberOfOrders
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CustomerID BETWEEN 'A' AND 'AO'
GROUP BY e.EmployeeID;

-- 38. Order date of most expensive order
SELECT o.OrderDate
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
ORDER BY SUM(od.UnitPrice * od.Quantity) DESC
LIMIT 1;

-- 39. Product name and total revenue
SELECT p.ProductName, SUM(od.UnitPrice * od.Quantity) AS Revenue
FROM Products p
JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC;

-- 40. SupplierID and number of products offered
SELECT SupplierID, COUNT(ProductID) AS NumberOfProducts
FROM Products
GROUP BY SupplierID;

-- 41. Top 10 customers by total business
SELECT c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;

-- 42. Total revenue of the company
SELECT SUM(UnitPrice * Quantity) AS TotalRevenue
FROM Order_Details;

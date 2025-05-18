--What is the catalogue of all products along with their categories and unit price?
SELECT p.ProductName, c.CategoryName, p.UnitPrice
FROM dbo.Products p
JOIN dbo.Categories c
ON p.CategoryID = c.CategoryID;

--What were the top performing product categories by the total revenue generated?
SELECT c.CategoryName, SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM dbo.OrderDetails od
JOIN dbo.Products p ON od.ProductID = p.ProductID
JOIN dbo.Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC;

--Who were the top performing employees by the number of orders handled?
SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalOrders
FROM dbo.Orders o
JOIN dbo.Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalOrders DESC;

--Who are the top customers based on total amount spent?
SELECT c.CompanyName, SUM(od.UnitPrice * od.Quantity) AS TotalSpent
FROM dbo.Customers c
JOIN dbo.Orders o ON c.CustomerID = o.CustomerID
JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY TotalSpent DESC;

--Which products have the highest number of orders?
SELECT p.ProductName, COUNT(od.OrderID) AS NumberOfOrders
FROM dbo.OrderDetails od
JOIN dbo.Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY NumberOfOrders DESC;


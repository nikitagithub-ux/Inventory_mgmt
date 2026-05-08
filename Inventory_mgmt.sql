CREATE DATABASE IF NOT EXISTS Inventory_mgmt;
USE Inventory_mgmt;

CREATE TABLE Categories (
    CategoryID   INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    CategoryID  INT,
    Price       DECIMAL(10, 2),
    StockCount  INT,
    ExpiryDate  DATE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE SalesTransactions (
    TransactionID   INT PRIMARY KEY AUTO_INCREMENT,
    ProductID       INT,
    Quantity        INT,
    TransactionDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Categories (CategoryName) VALUES
    ('Dairy'),
    ('Snacks'),
    ('Beverages');

INSERT INTO Products (ProductName, CategoryID, Price, StockCount, ExpiryDate) VALUES
    ('Milk',   1, 50,  100, '2026-05-12'),
    ('Cheese', 1, 120, 60,  '2026-05-14'),
    ('Chips',  2, 20,  200, '2026-08-01'),
    ('Soda',   3, 40,  30,  '2026-05-20'),
    ('Juice',  3, 60,  80,  '2026-05-25');

INSERT INTO SalesTransactions (ProductID, Quantity, TransactionDate) VALUES
    (1, 10, '2026-05-01'),
    (2, 5,  '2026-05-02'),
    (1, 15, '2026-05-05'),
    (4, 8,  '2026-05-06'),
    (5, 12, '2026-05-07');

SELECT * FROM Products;

SELECT * FROM SalesTransactions;

SELECT * FROM Categories;

SELECT
    ProductName,
    StockCount,
    ExpiryDate,
    DATEDIFF(ExpiryDate, CURDATE()) AS DaysUntilExpiry
FROM Products
WHERE ExpiryDate <= CURDATE() + INTERVAL 7 DAY
  AND ExpiryDate >= CURDATE()
  AND StockCount > 50
ORDER BY ExpiryDate ASC;

SELECT
    p.ProductID,
    p.ProductName,
    p.StockCount,
    p.Price
FROM Products p
LEFT JOIN SalesTransactions s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.StockCount, p.Price
HAVING MAX(s.TransactionDate) < CURDATE() - INTERVAL 60 DAY
    OR MAX(s.TransactionDate) IS NULL;

SELECT
    c.CategoryName,
    SUM(p.Price * s.Quantity) AS MonthlyRevenue
FROM SalesTransactions s
JOIN Products   p ON s.ProductID  = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE s.TransactionDate >= '2026-05-01'
  AND s.TransactionDate <= '2026-05-31'
GROUP BY c.CategoryName
ORDER BY MonthlyRevenue DESC;

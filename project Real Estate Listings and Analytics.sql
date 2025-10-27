-- Create a new database
CREATE DATABASE RealEstateDB;
GO

USE RealEstateDB;
GO

-- Create Tables
CREATE TABLE Agents (
    AgentID INT IDENTITY(1,1) PRIMARY KEY,
    AgentName NVARCHAR(100) NOT NULL,
    ContactNumber NVARCHAR(15),
    Email NVARCHAR(100)
);

CREATE TABLE Buyers (
    BuyerID INT IDENTITY(1,1) PRIMARY KEY,
    BuyerName NVARCHAR(100),
    ContactNumber NVARCHAR(15),
    Email NVARCHAR(100)
);

CREATE TABLE Properties (
    PropertyID INT IDENTITY(1,1) PRIMARY KEY,
    AgentID INT,
    Region NVARCHAR(100),
    City NVARCHAR(100),
    PropertyType NVARCHAR(50),
    Price DECIMAL(18,2),
    ListedDate DATE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    PropertyID INT,
    BuyerID INT,
    SalePrice DECIMAL(18,2),
    SaleDate DATE,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (BuyerID) REFERENCES Buyers(BuyerID)
);



-- Insert Agents
INSERT INTO Agents (AgentName, ContactNumber, Email) VALUES
('Ravi Kumar', '9876543210', 'ravi@realestate.com'),
('Sneha Reddy', '9998887776', 'sneha@realestate.com'),
('John Mathew', '8887776665', 'john@realestate.com');

-- Insert Buyers
INSERT INTO Buyers (BuyerName, ContactNumber, Email) VALUES
('Anil Varma', '7776665554', 'anilv@gmail.com'),
('Priya Sharma', '6665554443', 'priya.s@gmail.com'),
('Rohan Das', '9991112223', 'rohan.d@gmail.com');

-- Insert Properties
INSERT INTO Properties (AgentID, Region, City, PropertyType, Price, ListedDate) VALUES
(1, 'South Zone', 'Hyderabad', 'Apartment', 5500000, '2025-01-12'),
(2, 'North Zone', 'Hyderabad', 'Villa', 12000000, '2025-02-08'),
(1, 'East Zone', 'Vijayawada', 'Apartment', 4500000, '2025-03-10'),
(3, 'West Zone', 'Chennai', 'Plot', 8000000, '2025-04-15'),
(2, 'South Zone', 'Hyderabad', 'Apartment', 6000000, '2025-05-20');

-- Insert Transactions
INSERT INTO Transactions (PropertyID, BuyerID, SalePrice, SaleDate) VALUES
(1, 1, 5300000, '2025-02-15'),
(2, 2, 11500000, '2025-03-12'),
(3, 3, 4400000, '2025-04-20');


-- Average property prices grouped by region
SELECT 
    Region,
    COUNT(*) AS Total_Properties,
    AVG(Price) AS Avg_Price
FROM Properties
GROUP BY Region
ORDER BY Avg_Price DESC;

-- Create a view for regions with average price > 6 million
CREATE VIEW vw_HighDemandAreas AS
SELECT 
    Region,
    COUNT(*) AS Total_Properties,
    AVG(Price) AS Avg_Price
FROM Properties
GROUP BY Region
HAVING AVG(Price) > 6000000;

-- View data
SELECT * FROM vw_HighDemandAreas;

-- Show price trend by city over time
SELECT 
    City,
    ListedDate,
    Price,
    AVG(Price) OVER (PARTITION BY City ORDER BY ListedDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvgPrice
FROM Properties
ORDER BY City, ListedDate;


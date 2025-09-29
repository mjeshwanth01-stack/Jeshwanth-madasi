CREATE TABLE Customer (
    CustomerID   INT PRIMARY KEY,
    FirstName    VARCHAR(50) NOT NULL,
    LastName     VARCHAR(50) NOT NULL,
    Email        VARCHAR(100) UNIQUE,
    City         VARCHAR(50)
    );
    INSERT INTO Customer (CustomerID, FirstName, LastName, Email, City) VALUES
  (1, 'Alice',   'Smith', 'alice.smith@example.com', 'Hyderabad'),
  (2, 'Bob',     'Jones', 'bob.jones@example.com',     'Delhi'),
  (3, 'Carol',   'Lee',   'carol.lee@example.com',     'Mumbai'),
  (4, 'David',   'Khan',  'david.khan@example.com',    'Chennai'),
  (5, 'Eve',     'Patel', 'eve.patel@example.com',     'Pune');
  select *from customer;


  CREATE TABLE Ord(
    OrdID     INT PRIMARY KEY,
    OrdDate   DATE NOT NULL,
    CustomerID  INT,
    TotalAmount DECIMAL(10,2),
    -- assuming there’s a Customer table with CustomerID as primary key
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


INSERT INTO Ord (OrdID, OrdDate, CustomerID, TotalAmount) VALUES
  (1, '2025-09-01', 1, 250.00),
  (2, '2025-09-03', 2, 300.50),
  (3, '2025-09-05', 3, 120.75),
  (4, '2025-09-07', 1, 89.99),
  (5, '2025-09-10', 4, 450.20);

  select *from ord;

  SELECT
  c.CustomerID, c.FirstName, c.LastName, c.City,
  o.OrdID, o.OrdDate, o.TotalAmount
FROM Customer c
INNER JOIN Ord o
  ON c.CustomerID = o.CustomerID;

  SELECT
  c.CustomerID, c.FirstName, c.LastName, c.City,
  o.OrdID, o.OrdDate, o.TotalAmount
FROM Customer c
LEFT JOIN Ord o
  ON c.CustomerID = o.CustomerID;

  SELECT
  c.CustomerID, c.FirstName, c.LastName, c.City,
  o.OrdID, o.OrdDate, o.TotalAmount
FROM Customer c
RIGHT JOIN Ord o
  ON c.CustomerID = o.CustomerID;

  SELECT
  c.CustomerID, c.FirstName, c.LastName, c.City,
  o.OrdID, o.OrdDate, o.TotalAmount
FROM Customer c
FULL OUTER JOIN Ord o
  ON c.CustomerID = o.CustomerID;



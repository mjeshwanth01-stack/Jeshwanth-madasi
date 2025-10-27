CREATE TABLE Countries (
  CountryID INT IDENTITY(1,1) PRIMARY KEY,
  CountryName VARCHAR(100) UNIQUE NOT NULL,
  Continent VARCHAR(50),
  ISO_Code VARCHAR(10)
);

CREATE TABLE Population (
  PopulationID INT IDENTITY(1,1) PRIMARY KEY,
  CountryID INT FOREIGN KEY REFERENCES Countries(CountryID),
  TotalPopulation BIGINT,
  UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Covid_Data (
  RecordID INT IDENTITY(1,1) PRIMARY KEY,
  CountryID INT FOREIGN KEY REFERENCES Countries(CountryID),
  ReportDate DATE,
  ConfirmedCases INT,
  Deaths INT,
  Recovered INT,
  TestsConducted INT,
  NewCases INT,
  NewDeaths INT,
  NewRecovered INT
);

CREATE TABLE Vaccinations (
  VaccinationID INT IDENTITY(1,1) PRIMARY KEY,
  CountryID INT FOREIGN KEY REFERENCES Countries(CountryID),
  ReportDate DATE,
  TotalVaccinations BIGINT,
  PeopleVaccinated BIGINT,
  PeopleFullyVaccinated BIGINT
);
UPDATE Covid_Data
SET ConfirmedCases = ISNULL(ConfirmedCases, 0),
    Deaths = ISNULL(Deaths, 0),
    Recovered = ISNULL(Recovered, 0),
    TestsConducted = ISNULL(TestsConducted, 0);


    INSERT INTO Countries (CountryName, Continent, ISO_Code)
VALUES ('India', 'Asia', 'IND'), ('USA', 'North America', 'USA'), ('Brazil', 'South America', 'BRA');

INSERT INTO Covid_Data (CountryID, ReportDate, ConfirmedCases, Deaths, Recovered, TestsConducted, NewCases, NewDeaths, NewRecovered)
VALUES
(1, '2021-05-01', 19000000, 200000, 18000000, 250000000, 300000, 3500, 280000),
(2, '2021-05-01', 33000000, 590000, 27000000, 450000000, 45000, 700, 39000),
(3, '2021-05-01', 15000000, 420000, 14000000, 200000000, 80000, 2500, 70000);

INSERT INTO Vaccinations (CountryID, ReportDate, TotalVaccinations, PeopleVaccinated, PeopleFullyVaccinated)
VALUES
(1, '2021-05-01', 150000000, 100000000, 50000000),
(2, '2021-05-01', 230000000, 160000000, 70000000),
(3, '2021-05-01', 120000000, 80000000, 40000000);

SELECT TOP 5 
    c.CountryName,
    SUM(cd.ConfirmedCases) AS TotalConfirmed
FROM Covid_Data cd
JOIN Countries c ON cd.CountryID = c.CountryID
GROUP BY c.CountryName
ORDER BY TotalConfirmed DESC;

SELECT 
    ReportDate,
    SUM(NewCases) AS DailyCases
FROM Covid_Data cd
JOIN Countries c ON cd.CountryID = c.CountryID
WHERE c.CountryName = 'India'
GROUP BY ReportDate
ORDER BY ReportDate;

SELECT 
    c.CountryName,
    SUM(cd.Deaths) * 100.0 / NULLIF(SUM(cd.ConfirmedCases), 0) AS CaseFatalityRate
FROM Covid_Data cd
JOIN Countries c ON cd.CountryID = c.CountryID
GROUP BY c.CountryName
ORDER BY CaseFatalityRate DESC;


SELECT 
    c.CountryName,
    v.TotalVaccinations,
    v.PeopleVaccinated,
    v.PeopleFullyVaccinated,
    (v.PeopleFullyVaccinated * 100.0 / p.TotalPopulation) AS PercentFullyVaccinated
FROM Vaccinations v
JOIN Countries c ON v.CountryID = c.CountryID
JOIN Population p ON v.CountryID = p.CountryID;

SELECT 
    c.CountryName,
    cd.ReportDate,
    cd.NewCases,
    AVG(cd.NewCases) OVER (PARTITION BY c.CountryName ORDER BY cd.ReportDate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS SevenDayAvg
FROM Covid_Data cd
JOIN Countries c ON cd.CountryID = c.CountryID;

CREATE VIEW v_CovidSummary AS
SELECT 
    c.CountryName,
    SUM(cd.ConfirmedCases) AS TotalCases,
    SUM(cd.Deaths) AS TotalDeaths,
    SUM(cd.Recovered) AS TotalRecovered,
    MAX(v.TotalVaccinations) AS TotalVaccinations
FROM Countries c
JOIN Covid_Data cd ON c.CountryID = cd.CountryID
LEFT JOIN Vaccinations v ON c.CountryID = v.CountryID
GROUP BY c.CountryName;





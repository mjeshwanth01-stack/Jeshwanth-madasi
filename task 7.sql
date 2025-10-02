CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(50),
    Country VARCHAR(30)
);

INSERT INTO Authors (AuthorID, AuthorName, Country)
VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'J.K. Rowling', 'United Kingdom'),
(3, 'Mark Twain', 'United States'),
(4, 'Chetan Bhagat', 'India'),
(5, 'Haruki Murakami', 'Japan');


select *from authors;

CREATE TABLE Actors (
    ActorID INT PRIMARY KEY,
    ActorName VARCHAR(50),
    BirthYear INT
    );

    INSERT INTO Actors (ActorID, ActorName, BirthYear)
VALUES
(1, 'Leonardo DiCaprio', 1974),
(2, 'Scarlett Johansson', 1984),
(3, 'Shah Rukh Khan', 1965),
(4, 'Tom Hanks', 1956),
(5, 'Priyanka Chopra', 1982);

select *from actors;


CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(100),
    ReleaseYear INT,
    ActorID INT,
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID)
);
INSERT INTO Movies (MovieID, MovieTitle, ReleaseYear, ActorID)
VALUES
(1, 'Inception', 2010, 1),
(2, 'Titanic', 1997, 1),
(3, 'Lucy', 2014, 2),
(4, 'Chak De India', 2007, 3),
(5, 'Forrest Gump', 1994, 4),
(6, 'Don', 2006, 3),
(7, 'Barfi', 2012, 5);




CREATE VIEW ActorMovieStats AS
SELECT 
    a.ActorID,
    a.ActorName,
    COUNT(m.MovieID) AS TotalMovies,
    MIN(m.ReleaseYear) AS FirstMovieYear,
    MAX(m.ReleaseYear) AS LatestMovieYear,
    CASE 
        WHEN COUNT(m.MovieID) >= 3 THEN 'Superstar'
        WHEN COUNT(m.MovieID) = 2 THEN 'Star'
        ELSE 'Newcomer'
    END AS ActorStatus
FROM Actors a
LEFT JOIN Movies m 
    ON a.ActorID = m.ActorID
GROUP BY a.ActorID, a.ActorName
HAVING COUNT(m.MovieID) >= 1
ORDER BY COUNT(m.MovieID) DESC;

CREATE VIEW ActorMovieStats_Secure AS
SELECT 
    a.ActorID,
    COUNT(m.MovieID) AS TotalMovies,
    MIN(m.ReleaseYear) AS FirstMovieYear,
    MAX(m.ReleaseYear) AS LatestMovieYear
FROM Actors a
LEFT JOIN Movies m ON a.ActorID = m.ActorID
GROUP BY a.ActorID
ORDER BY TotalMovies DESC;
GO


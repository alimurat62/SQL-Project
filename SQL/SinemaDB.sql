-- 1. Veritabaný oluþtur
CREATE DATABASE MovieDB 

-- 2. O veritabanýný kullan
USE MovieDB;

-- 3. Tablolarý oluþtur
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50),
    Description TEXT
);


CREATE TABLE Directors (
    DirectorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    Nationality VARCHAR(50),
    AwardsCount INT,
    Biography TEXT
);


CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(150),
    ReleaseYear INT,
    DurationMinutes INT,
    Language VARCHAR(50),
    Country VARCHAR(50),
    Budget DECIMAL(15,2),
    BoxOffice DECIMAL(15,2),
    Description TEXT,
    GenreID INT,
    DirectorID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (DirectorID) REFERENCES Directors(DirectorID)
);


CREATE TABLE Actors (
    ActorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    Nationality VARCHAR(50),
    AwardsCount INT,
    Biography TEXT
);


CREATE TABLE MovieActors (
    MovieID INT,
    ActorID INT,
    Role VARCHAR(100),
    IsMainCharacter BIT,
    PRIMARY KEY (MovieID, ActorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID)
);



CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50),
    Email VARCHAR(100),
    Gender VARCHAR(10),
    BirthDate DATE,
    Country VARCHAR(50),
    RegistrationDate DATE
);




CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    MovieID INT,
    UserID INT,
    RatingValue DECIMAL(2,1), -- 1.0 ile 10.0 arasý
    Comment TEXT,
    RatingDate DATE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

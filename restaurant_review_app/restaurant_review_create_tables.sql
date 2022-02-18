CREATE SCHEMA IF NOT EXISTS RestaurantApplication;
USE RestaurantApplication;

DROP TABLE IF EXISTS CreditCards;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Recommendations;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS SitDownRestaurant;
DROP TABLE IF EXISTS TakeOutRestaurant;
DROP TABLE IF EXISTS FoodCartRestaurant;

CREATE TABLE CreditCards (
  CardNumber INT,
  Expiration TIMESTAMP,
  UserName VARCHAR(255),
  CONSTRAINT pk_CreditCards_CardNumber 
	PRIMARY KEY (CardNumber),
  CONSTRAINT fk_CreditCards_UserName
    FOREIGN KEY (UserName)
    REFERENCES Users(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Users (
	UserName VARCHAR(225),
    Password INT,
    FirstName VARCHAR(225),
    LastName VARCHAR(225),
    Email VARCHAR(225),
    Phone INT,
    CONSTRAINT pk_Users_UserName 
		PRIMARY KEY (UserName)
);

CREATE TABLE Reviews (
	ReviewId INT,
    Created TIMESTAMP,
    Content VARCHAR(225),
    Rating DECIMAL,
    UserName VARCHAR(225),
    RestaurantId INT,
    CONSTRAINT pk_Reviews_ReviewId 
		PRIMARY KEY (ReviewId),
	CONSTRAINT fk_Reviews_UserName
		FOREIGN KEY (UserName)
		REFERENCES Users(UserName)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT fk_Reviews_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants(RestaurantId)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Recommendations (
	RecommendationId INT,
    UserName VARCHAR(225),
    RestaurantId INT,
    CONSTRAINT pk_Recommendations_RecommendationId
		PRIMARY KEY (RecommendationId),
	CONSTRAINT fk_Recommendations_UserName
		FOREIGN KEY (UserName)
        REFERENCES Users(UserName)
        ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT fk_Recommendations_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants(RestaurantId)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Restaurants (
	RestaurantId INT,
    Name VARCHAR(225),
    Description VARCHAR(225),
    Menu VARCHAR(225),
    Hours VARCHAR(225),
    Active BOOLEAN,
    Cuisine ENUM('AFRICAN', 'AMERICAN', 'ASIAN', 'EUROPEAN', 'HISPANIC'),
    Street1 VARCHAR(225),
    Street2 VARCHAR(225),
    City VARCHAR(225),
    State VARCHAR(225),
    Zip INT,
    CompanyName VARCHAR(225),
    CONSTRAINT pk_Restaurants_RestaurantId
		PRIMARY KEY (RestaurantId),
	CONSTRAINT fk_Restaurants_CompanyName
		FOREIGN KEY (CompanyName)
        REFERENCES Companies (CompanyName)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Companies (
	CompanyName VARCHAR(225),
    About VARCHAR(225),
    CONSTRAINT pk_Companies_CompanyName 
		PRIMARY KEY (CompanyName)
);

CREATE TABLE Reservations (
	ReservationId INT,
    Start TIMESTAMP,
    End TIMESTAMP,
    Size INT,
    UserName VARCHAR(225),
    RestaurantId INT,
    CONSTRAINT pk_Reservations_ReservationId
		PRIMARY KEY (ReservationId),
	CONSTRAINT fk_Reservations_UserName
		FOREIGN KEY (UserName)
        REFERENCES Users (UserName)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_Reservations_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants (RestaurantId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE SitDownRestaurant (
	RestaurantId INT,
    Capacity INT,
    CONSTRAINT pk_SitDownRestaurant_RestaurantId
		PRIMARY KEY (RestaurantId),
    CONSTRAINT fk_SitDownRestaurant_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants (RestaurantId)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE TakeOutRestaurant (
	RestaurantId INT,
    MaxWaitTime INT,
    CONSTRAINT pk_TakeOutRestaurant_RestaurantId
		PRIMARY KEY (RestaurantId),
    CONSTRAINT fk_TakeOutRestaurant_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants (RestaurantId)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE FoodCartRestaurant (
	RestaurantId INT,
    Licensed BOOLEAN,
    CONSTRAINT pk_FoodCartRestaurant_RestaurantId
		PRIMARY KEY (RestaurantId),
    CONSTRAINT fk_FoodCartRestaurant_RestaurantId
		FOREIGN KEY (RestaurantId)
        REFERENCES Restaurants (RestaurantId)
        ON UPDATE CASCADE ON DELETE SET NULL
);







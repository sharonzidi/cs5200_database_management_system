CREATE SCHEMA IF NOT EXISTS WineApplication;
USE WineApplication;

DROP TABLE IF EXISTS ProfessionalRatings;
DROP TABLE IF EXISTS ProfessionalReviews;
DROP TABLE IF EXISTS UserRatings;
DROP TABLE IF EXISTS UserReviews;
DROP TABLE IF EXISTS Variety;
DROP TABLE IF EXISTS Wines;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Winery;
DROP TABLE IF EXISTS Tasters;
DROP TABLE IF EXISTS Admins;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
  UserName VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  CONSTRAINT pk_Person_UserName PRIMARY KEY (UserName)
);

CREATE TABLE Users (
  UserName VARCHAR(255),
  Password VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  PhoneNum VARCHAR(255),
  CONSTRAINT pk_Users_UserName PRIMARY KEY (UserName),
  CONSTRAINT fk_Users_UserName foreign key (UserName)
	REFERENCES Person(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Admins (
  UserName VARCHAR(255),
  Password VARCHAR(255),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  LastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT pk_Admins_UserName PRIMARY KEY (UserName),
  CONSTRAINT fk_Admins_UserName foreign key (UserName)
	REFERENCES Users(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Tasters (
  TasterName VARCHAR(255),
  TasterId INT AUTO_INCREMENT,
  TasterTwitter VARCHAR(255),
  CONSTRAINT pk_Tasters_TasterName PRIMARY KEY (TasterName),
  unique(TasterId)
);

CREATE TABLE Winery (
  WineryName VARCHAR(255),
  WineryId INT AUTO_INCREMENT,
  CONSTRAINT pk_Winery_WineryName PRIMARY KEY (WineryName),
  unique(WineryId)
  
);

CREATE TABLE Locations (
  LocationId INT AUTO_INCREMENT,
  Country VARCHAR(255),
  Province VARCHAR(255),
  Regin1 VARCHAR(255),
  Regin2 VARCHAR(255),
  WineryName VARCHAR(255),
  CONSTRAINT pk_Locations_LocationId PRIMARY KEY (LocationId),
  CONSTRAINT fk_Locations_WineryName foreign key (WineryName)
	REFERENCES Winery(WineryName)
    ON UPDATE CASCADE ON DELETE SET NULL
  
);

CREATE TABLE Wines (
  WineTitle VARCHAR(255),
  WineId INT AUTO_INCREMENT,
  Country VARCHAR(255),
  Price double,
  Designation VARCHAR(255),
  WineryName VARCHAR(255),
  CONSTRAINT pk_Wines_WineTitle PRIMARY KEY (WineTitle),
  CONSTRAINT fk_Wines_WineryName foreign key (WineryName)
	REFERENCES Winery(WineryName)
    ON UPDATE CASCADE ON DELETE SET NULL,
    unique(WineId)
);

CREATE TABLE Variety (
  VarietyId INT AUTO_INCREMENT,
  WineryName VARCHAR(255),
  Type VARCHAR(255),
  CONSTRAINT pk_Variety_VarietyId PRIMARY KEY (VarietyId),
  CONSTRAINT fk_Variety_WineryName foreign key (WineryName)
	REFERENCES Wines(WineryName)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE UserReviews (
  UserReviewId INT AUTO_INCREMENT,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  Content VARCHAR(1024) NOT NULL,
  UserName VARCHAR(255),
  WineTitle varchar(255),
  CONSTRAINT pk_UserReviews_UserReviewId PRIMARY KEY (UserReviewId),
  CONSTRAINT fk_UserReviews_UserName FOREIGN KEY (UserName)
    REFERENCES Users(UserName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_UserReviews_WineTitle FOREIGN KEY (WineTitle)
    REFERENCES Wines(WineTitle)
    ON UPDATE CASCADE ON DELETE SET NULL
    
);

CREATE TABLE ProfessionalReviews (
  ProfessionalReviewsId INT AUTO_INCREMENT,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  Content VARCHAR(1024) NOT NULL,
  TasterName VARCHAR(255),
  WineTitle varchar(255),
  CONSTRAINT pk_ProfessionalReviews_ProfessionalReviewsId PRIMARY KEY (ProfessionalReviewsId),
  CONSTRAINT fk_ProfessionalReviews_TasterName FOREIGN KEY (TasterName)
    REFERENCES Tasters(TasterName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_ProfessionalReviews_WineTitle FOREIGN KEY (WineTitle)
    REFERENCES Wines(WineTitle)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE UserRatings (
  UserRatingsId INT AUTO_INCREMENT,
  WineTitle varchar(255),
  UserName VARCHAR(255),
  Points INT,
  
  CONSTRAINT pk_UserRatings_UserRatingsId PRIMARY KEY (UserRatingsId),
  CONSTRAINT fk_UserRatings_UserName FOREIGN KEY (UserName)
    REFERENCES Users(UserName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_UserRatings_WineId FOREIGN KEY (WineTitle)
    REFERENCES Wines(WineTitle)
    ON UPDATE CASCADE ON DELETE SET NULL
   
);

CREATE TABLE ProfessionalRatings (
  ProfessionalRatingsId INT AUTO_INCREMENT,
  WineTitle varchar(255),
  TasterName VARCHAR(255),
  Points INT,
  
  CONSTRAINT pk_ProfessionalRatings_ProfessionalRatingsId PRIMARY KEY (ProfessionalRatingsId),
  CONSTRAINT fk_ProfessionalRatings_TasterName FOREIGN KEY (TasterName)
    REFERENCES Tasters(TasterName)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_ProfessionalRatings_WineTitle FOREIGN KEY (WineTitle)
    REFERENCES Wines(WineTitle)
    ON UPDATE CASCADE ON DELETE SET NULL
   
);


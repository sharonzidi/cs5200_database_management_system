# Create the schema if necessary.
CREATE SCHEMA IF NOT EXISTS ReviewApplication;
USE ReviewApplication;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Recommendations;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS FoodCartRestaurant;
DROP TABLE IF EXISTS TakeOutRestaurant;
DROP TABLE IF EXISTS SitDownRestaurant;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS CreditCards;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
UserName VARCHAR(255),
Password VARCHAR(255) NOT NULL,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL,
Email VARCHAR(255) NOT NULL,
Phone VARCHAR(255),
CONSTRAINT pk_Users_UserName PRIMARY KEY (UserName)
);
CREATE TABLE CreditCards (
CardNumber BIGINT,
Expiration DATE NOT NULL,
UserName VARCHAR(255) NOT NULL,
CONSTRAINT pk_CreditCards_CardNumber PRIMARY KEY (CardNumber),
CONSTRAINT fk_CreditCards_Username FOREIGN KEY (UserName)
REFERENCES Users(UserName)
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Companies (
CompanyName VARCHAR(255),
About VARCHAR(1024),
CONSTRAINT pk_Companies_CompanyName PRIMARY KEY (CompanyName)
);

CREATE TABLE Restaurants (
RestaurantId INT AUTO_INCREMENT,
Name VARCHAR(255) NOT NULL,
Description VARCHAR(1024) NOT NULL,
Menu VARCHAR(1024) NOT NULL,
Hours VARCHAR(1024) NOT NULL,
Active BOOLEAN NOT NULL,
CuisineType ENUM('AFRICAN', 'AMERICAN', 'ASIAN', 'EUROPEAN', 'HISPANIC'),
Street1 VARCHAR(255) NOT NULL,
Street2 VARCHAR(255),
City VARCHAR(255) NOT NULL,
State VARCHAR(255) NOT NULL,
Zip INT NOT NULL, # NOTE: VARCHAR is acceptable too.
CompanyName VARCHAR(255),
CONSTRAINT pk_Restaurants_RestaurantId PRIMARY KEY (RestaurantId),
CONSTRAINT fk_Restaurants_CompanyName FOREIGN KEY (CompanyName)
REFERENCES Companies(CompanyName)
ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE SitDownRestaurant (
RestaurantId INT,
Capacity INT NOT NULL,
CONSTRAINT pk_SitDownRestaurant_RestaurantId PRIMARY KEY (RestaurantId),
CONSTRAINT fk_SitDownRestaurant_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES Restaurants(RestaurantId)
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE TakeOutRestaurant (
RestaurantId INT,
MaxWaitTime INT NOT NULL,
CONSTRAINT pk_TakeOutRestaurant_RestaurantId PRIMARY KEY (RestaurantId),
CONSTRAINT fk_TakeOutRestaurant_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES Restaurants(RestaurantId)
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE FoodCartRestaurant (
RestaurantId INT,
Licensed BOOLEAN NOT NULL,
CONSTRAINT pk_FoodCartRestaurant_RestaurantId PRIMARY KEY (RestaurantId),
CONSTRAINT fk_FoodCartRestaurant_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES Restaurants(RestaurantId)
ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Reviews (
ReviewId INT AUTO_INCREMENT,
Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
Content VARCHAR(1024) NOT NULL,
Rating DECIMAL(2,1) NOT NULL,
UserName VARCHAR(255),
RestaurantId INT,
CONSTRAINT pk_Reviews_ReviewId PRIMARY KEY (ReviewId),
CONSTRAINT uq_Reviews_Review UNIQUE (UserName,RestaurantId),
CONSTRAINT fk_Reviews_UserName FOREIGN KEY (UserName)
REFERENCES Users(UserName)
ON UPDATE CASCADE ON DELETE SET NULL,
CONSTRAINT fk_Reviews_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES Restaurants(RestaurantId)
ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE Recommendations (
RecommendationId INT AUTO_INCREMENT,
UserName VARCHAR(255),
RestaurantId INT,
CONSTRAINT pk_Recommendations_RecommendationId PRIMARY KEY (RecommendationId),
CONSTRAINT fk_Recommendations_UserName FOREIGN KEY (UserName)
REFERENCES Users(UserName)
ON UPDATE CASCADE ON DELETE SET NULL,
CONSTRAINT fk_Recommendations_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES Restaurants(RestaurantId)
ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE Reservations (
ReservationId INT AUTO_INCREMENT,
Start TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
End TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Size INT NOT NULL,
UserName VARCHAR(255),
RestaurantId INT,
CONSTRAINT pk_Reservations_ReservationId PRIMARY KEY (ReservationId),
CONSTRAINT fk_Reservations_UserName FOREIGN KEY (UserName)
REFERENCES Users(UserName)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_Reservations_RestaurantId FOREIGN KEY (RestaurantId)
REFERENCES SitDownRestaurant(RestaurantId)
ON UPDATE CASCADE ON DELETE CASCADE
);



USE ReviewApplication;
INSERT INTO Users(UserName,Password,FirstName,LastName,Email,Phone)
VALUES('Bruce','password','Bruce','C','bruce@mail.com','5555555');
INSERT INTO Users(UserName,Password,FirstName,LastName,Email,Phone)
VALUES('TT','password','Tony','D','tony@mail.com','5555555');
INSERT INTO Users(UserName,Password,FirstName,LastName,Email,Phone)
VALUES('DK','password','Daniel','K','dan@mail.com','5555555');
INSERT INTO Users(UserName,Password,FirstName,LastName,Email,Phone)
VALUES('James','password','James','M','james@mail.com','5555555');
INSERT INTO Users(UserName,Password,FirstName,LastName,Email,Phone)
VALUES('Steve','password','Steve','N','steve@mail.com','5555555');
INSERT INTO Companies(CompanyName,About)
VALUES('company1','about company1');
INSERT INTO Companies(CompanyName,About)
VALUES('company2','about company2');
INSERT INTO Companies(CompanyName,About)
VALUES('company3','about company3');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant1','about restaurant','menu','hours',TRUE,'AFRICAN','street1','street2','seattle','wa',98195,'company1');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant2','about restaurant','menu','hours',TRUE,'AMERICAN','street1','street2','seattle','wa',98195,'company1');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant3','about restaurant','menu','hours',TRUE,'ASIAN','street1','street2','seattle','wa',98195,'company1');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant4','about restaurant','menu','hours',TRUE,'EUROPEAN','street1','street2','seattle','wa',98195,'company1');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant5','about restaurant','menu','hours',TRUE,'HISPANIC','street1','street2','seattle','wa',98195,'company1');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant6','about restaurant','menu','hours',TRUE,'HISPANIC','street1','street2','bellevue','wa',98008,'company2');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant7','about restaurant','menu','hours',TRUE,'HISPANIC','street1','street2','bellevue','wa',98008,'company2');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant8','about restaurant','menu','hours',TRUE,'HISPANIC','street1','street2','bellevue','wa',98008,'company2');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant9','about restaurant','menu','hours',FALSE,'AMERICAN','street1','street2','bellevue','wa',98008,'company2');
INSERT INTO Restaurants(Name,Description,Menu,Hours,Active,CuisineType,Street1,Street2,City,State,Zip,CompanyName)
VALUES('restaurant10','about restaurant','menu','hours',TRUE,'AMERICAN','street1','street2','bellevue','wa',98008,'company3');
INSERT INTO SitDownRestaurant(RestaurantId,Capacity)
VALUES(1,100);
INSERT INTO SitDownRestaurant(RestaurantId,Capacity)
VALUES(2,200);
INSERT INTO SitDownRestaurant(RestaurantId,Capacity)
VALUES(3,200);
INSERT INTO TakeOutRestaurant(RestaurantId,MaxWaitTime)
VALUES(4,60);
INSERT INTO TakeOutRestaurant(RestaurantId,MaxWaitTime)
VALUES(5,90);
INSERT INTO FoodCartRestaurant(RestaurantId,Licensed)
VALUES(6,TRUE);
INSERT INTO FoodCartRestaurant(RestaurantId,Licensed)
VALUES(7,TRUE);
INSERT INTO FoodCartRestaurant(RestaurantId,Licensed)
VALUES(8,TRUE);
INSERT INTO FoodCartRestaurant(RestaurantId,Licensed)
VALUES(9,TRUE);
INSERT INTO FoodCartRestaurant(RestaurantId,Licensed)
VALUES(10,FALSE);
INSERT INTO Reviews(Content,Rating,UserName,RestaurantId)
VALUES('Delightful!',5.0,'Bruce',1);
INSERT INTO Reviews(Content,Rating,UserName,RestaurantId)
VALUES('Superb!',5.0,'Bruce',2);
INSERT INTO Reviews(Content,Rating,UserName,RestaurantId)
VALUES('Superb!',5.0,'Bruce',9);
INSERT INTO Reviews(Content,Rating,UserName,RestaurantId)
VALUES('Not good',1.0,'James',9);
INSERT INTO Reviews(Content,Rating,UserName,RestaurantId)
VALUES('Not good at all',1.0,'James',10);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('Bruce',1);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('Bruce',2);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('Bruce',3);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('Bruce',4);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('Bruce',5);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('DK',2);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('DK',3);
INSERT INTO Recommendations(UserName,RestaurantId)
VALUES('TT',3);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-09-05 18:30:00','2015-09-05 20:00:00',2,'Bruce',1);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-09-12 18:30:00','2015-09-12 20:00:00',2,'Bruce',1);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-09-19 18:30:00','2015-09-19 20:00:00',2,'Bruce',1);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-09-20 18:30:00','2015-09-20 20:00:00',2,'Bruce',2);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-09-21 18:30:00','2015-09-21 20:00:00',2,'Bruce',2);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-10-01 18:30:00','2015-10-01 20:00:00',2,'TT',3);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-10-02 18:30:00','2015-10-02 20:00:00',2,'TT',1);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-10-03 18:30:00','2015-10-03 20:00:00',2,'TT',3);
INSERT INTO Reservations(Start,End,Size,UserName,RestaurantId)
VALUES('2015-10-04 18:30:00','2015-10-04 20:00:00',2,'TT',3);


LOAD DATA INFILE '/Users/sharonxia/github/cs5200_database_management_system/restaurant_review_app/creditcards.csv' INTO TABLE CreditCards
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n';
  
  
# Fields are not quoted.
# FIELDS TERMINATED BY ','
# Windows platforms may need '\r\n'.# # Windows platforms may need '\r\n'.
# LINES TERMINATED BY '\n'
# IGNORE 1 LINES;
/**
Contents of creditcards.csv:
CardNumber,Expiration,UserName
3499432187650987,2018-10-01,Bruce
3488432187650987,2018-10-01,Bruce
3799432187650987,2018-10-01,Bruce
6011432187650987,2018-10-01,Bruce
6011432187650988,2018-10-01,Bruce
6441432187650987,2018-10-01,Bruce
6451432187650987,2018-10-01,Bruce
5199432187650987,2018-10-01,Bruce
5499432187650987,2018-10-01,Bruce
5499432187650988,2018-10-01,Bruce
5499432187650989,2018-10-01,Bruce
4499432187650987,2018-10-01,Bruce
4499432187650989,2018-10-01,Bruce
*/
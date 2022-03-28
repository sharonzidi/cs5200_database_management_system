# 2.1
CREATE SCHEMA IF NOT EXISTS DocumentApplication;
USE DocumentApplication;

DROP TABLE IF EXISTS EditMap;
DROP TABLE IF EXISTS Slides;
DROP TABLE IF EXISTS Spreadsheets;
DROP TABLE IF EXISTS Documents;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  UserName VARCHAR(255),
  First VARCHAR(255),
  Last VARCHAR(255),
  CONSTRAINT pk_Users_UserName 
	PRIMARY KEY (UserName)
);

CREATE TABLE Documents (
  FileName VARCHAR(255),
  Title VARCHAR(255) NOT NULL,
  Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT pk_Documents_FileName
	PRIMARY KEY (FileName)
);

CREATE TABLE Spreadsheets (
  FileName VARCHAR(255),
  RowCount INT DEFAULT 0 NOT NULL,
  ColumnCount INT DEFAULT 0 NOT NULL,
  CONSTRAINT pk_Spreadsheets_FileName 
	PRIMARY KEY (FileName),
  CONSTRAINT fk_Spreadsheets_FileName
    FOREIGN KEY (FileName)
    REFERENCES Documents(FileName)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Slides (
  FileName VARCHAR(255),
  SlideCount INT DEFAULT 0 NOT NULL,
  CONSTRAINT pk_Slides_FileName 
	PRIMARY KEY (FileName),
  CONSTRAINT fk_Slides_FileName
	FOREIGN KEY (FileName)
	REFERENCES Documents(FileName)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EditMap (
  EditId INT AUTO_INCREMENT,
  FileName VARCHAR(225),
  UserName VARCHAR(225),
  CONSTRAINT uq_EditMap
  UNIQUE (UserName, FileName),
  CONSTRAINT pk_EditMap_EditId
    PRIMARY KEY (EditId),
  CONSTRAINT fk_EditMap_FileName
    FOREIGN KEY (FileName)
    REFERENCES Documents(FileName)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_EditMap_UserName
    FOREIGN KEY (UserName)
	REFERENCES Users(UserName)
    ON UPDATE CASCADE ON DELETE CASCADE
);


#2.2.1
INSERT INTO Users (UserName, First, Last)
VALUES ('Jae', 'First1', 'Last1'), ('Lia', 'First2', 'Last2');

#2.2.2
INSERT INTO Documents(FileName,Title)
	VALUES('deck1','draft');
INSERT INTO Slides(FileName,SlideCount)
	VALUES('deck1','10');

#2.2.3
INSERT INTO EditMap (UserName, FileName)
VALUES ('Jae', 'deck1'), ('Lia', 'deck1');

#2.2.4
UPDATE Documents
	SET Title = "final"
	WHERE FileName = "deck1";

#2.2.5
LOAD DATA INFILE '/Users/sharonxia/github/cs5200_database_management_system/users.csv' INTO TABLE CreditCards
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';


#3.1
SELECT (Manufacturer, Model), COUNT(*) AS CNT
FROM Planes INNER JOIN ServiceHistory
   ON Planes.PlaneId = ServiceHistory.PlaneId
GROUP BY Planes.PlaneId
ORDER BY CNT DESC
LIMIT 10;


#3.2
SELECT Travelers.UserName 
FROM Travelers INNER JOIN
(SELECT UserName, sum(Flight.Distance) AS dis
FROM Flights INNER JOIN Reservations
	ON Reservations.FlightId = Flights.FlightId
WHERE Flights.ActualDeparture > "2015-01-01"
	AND Flights.Canceled = False
GROUP BY Reservations.UserName
ORDER BY dis DESC
LIMIT 10) AS A
ON Travelers.UserName = A.UserName;

 
 
 
#3.3
SELECT Planes.PlaneId, SUM(Flights.distance)
FROM Flights LEFT OUTER JOIN Planes 
ON Flights.Canceled = false
and Flights.ActualDeparture>=’2022-01-01’
and Flights.ActualDeparture<=’2022-01-31 
GROUP BY Planes.PlaneId;
    
    
#3.4
select A.cnt / P.FlightId * 100
From
(select FlightId from Flights) as P
 left join
(select count(distinct FlightId) as cnt
from Flights
where ActualArrival > ScheduledArrival
 or Canceled = True) as A;


#3.5
SELECT Travelers.UserName
FROM Travelers INNER JOIN Reservations ON Travelers.UserName = Reservations.UserName
GROUP BY Reservations.UserName
ORDER BY COUNT(ReservationId)
DESC LIMIT 10;

#3.6
SELECT Travelers.UserName, sum(InFlightPurchases.Amount)
FROM Travelers
LEFT JOIN 
InFlightPurchases ON Travelers.UserName = InFlightPurchases.UserName
GROUP BY Travelers.UserName

#3.7
Select UserName,avg(I.amount)  
from Reservations as r 
left join Travlers as t on r.UserName=t.UserName 
Left join InFlightPurchases as I on r.username =I.username



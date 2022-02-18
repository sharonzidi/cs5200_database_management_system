USE RestaurantApplication;

INSERT INTO Users(UserName, Password, FirstName, LastName, Email, Phone)
	VALUES('zx', 000, 'zidi', 'xia', 'zx@gmail.com', 000);
INSERT INTO Users(UserName, Password, FirstName, LastName, Email, Phone)
	VALUES('tg', 000, 'tx', 'gao', 'tg@gmail.com', 000);

INSERT INTO Companies(CompanyName, About)
		VALUES('xxx company', 'local company');
INSERT INTO Companies(CompanyName, About)
		VALUES('yyy company', 'local company');
    
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('Africa bbq', 'African bbq', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'xxx company');
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('Thai', 'Thai taste', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'yyy company');
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('KFC', 'burgers', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'yyy company');
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('Mexican garden', 'Mexican food', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'yyy company');
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('French Taste', 'French food', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'yyy company');
INSERT INTO Restaurants(Name, Description, Menu, Hours, Active, Street1, Street2, City, State, Zip, CompanyName)
	VALUES('Chinese Taste', 'Chinese food', 'xxx', '9am-7pm', TRUE, '1001', '5ave', 'Seattle', 'wa', '98000', 'yyy company');

INSERT INTO Reviews(Content, Rating, UserName, RestaurantId)
	VALUES('good', 6.6, 'zx', 1);
INSERT INTO Reviews(Content, Rating, UserName, RestaurantId)
	VALUES('good', 6.6, 'tg', 2);

INSERT INTO Recommendations(UserName, RestaurantId)
	VALUES('zx', '1');
INSERT INTO Recommendations(UserName, RestaurantId)
	VALUES('tg', '2');

INSERT INTO Reservations(Size, UserName, RestaurantId)
	VALUES(2, 'zx', 1);
INSERT INTO Reservations(Size, UserName, RestaurantId)
	VALUES(2, 'tg', 2);
    
INSERT INTO SitDownRestaurant(RestaurantId, Capacity)
	VALUES(1, 40);
INSERT INTO SitDownRestaurant(RestaurantId, Capacity)
	VALUES(2, 40);
    
INSERT INTO TakeOutRestaurant(RestaurantId, MaxWaitTime)
	VALUES(3, 40);
INSERT INTO TakeOutRestaurant(RestaurantId, MaxWaitTime)
	VALUES(4, 40);
    
INSERT INTO FoodCartRestaurant(RestaurantId, Licensed)
	VALUES(5, TRUE);
INSERT INTO FoodCartRestaurant(RestaurantId, Licensed)
	VALUES(6, TRUE);

LOAD DATA INFILE '/Users/sharonxia/github/cs5200_database_management_system/restaurant_review_app/creditcards.csv' INTO TABLE CreditCards
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n';

## 1. What are the top 10 average review ratings for restaurants? Include the restaurant ID, restaurant name, and average rating in the result set.
## limit is 10
SELECT Restaurants.RestaurantId, Restaurants.Name, AVG(Reviews.Rating) AS RATING
FROM Restaurants INNER JOIN Reviews
	ON Restaurants.RestaurantId = Reviews.ReviewId
GROUP BY Restaurants.RestaurantId, Restaurants.Name
ORDER BY RATING DESC
LIMIT 10;


## 2. How many users have created more than one review?
SELECT COUNT(*) AS CntTotalUser FROM(
SELECT UserName, COUNT(*) AS CNT
FROM Reviews
GROUP BY UserName
HAVING COUNT(*) > 1) AS TotalUser;


## 3. What day of the week is most popular for making a reservation? Use the DAYOFWEEK() function on the ‘Start’ column.
SELECT DAYOFWEEK(Start), COUNT(*) AS CNT
FROM Reservations
GROUP BY(DAYOFWEEK(Start))
ORDER BY CNT DESC
LIMIT 1;


## 4. What are the distinct UserNames for users that have made multiple reservations at any given SitDownRestaurant?
SELECT UserName 
FROM Reservations INNER JOIN SitDownRestaurant
	ON Reservations.ReservationId = SitDownRestaurant.RestaurantId
GROUP BY UserName
HAVING COUNT(DISTINCT ReservationId) > 1;


## 5. Identify the number of credit cards per provider. The credit card provider is determined by the leading digit(s) of the CardNumber. Use this mapping for card providers:
SELECT *
FROM(
SELECT COUNT(distinct CardNumber) AS AmericanExpress
FROM CreditCards
WHERE CardNumber like '34%' OR CardNumber like '37%')A,
# Discover
(SELECT COUNT(distinct CardNumber) AS Discover
FROM CreditCards
WHERE CardNumber like '6%')B,
# MasterCard
(SELECT COUNT(distinct CardNumber) AS MasterCard
FROM CreditCards
WHERE CardNumber like '51%'
 or CardNumber like '52%'
 or CardNumber like '53%'
    or CardNumber like '54%'
    or CardNumber like '55%') C,
# Visa 
(SELECT COUNT(distinct CardNumber) as Visa
FROM CreditCards
WHERE CardNumber like '4%') D,
# NA
(SELECT COUNT(distinct CardNumber) as NA
FROM CreditCards
WHERE not CardNumber like '3%' and 
 not CardNumber like '6%' 
    and not CardNumber like '5%' 
    and not CardNumber like '4%')E;


## 6. What is the total number of active restaurants for each type of restaurant (SitDownRestaurant, TakeOutRestaurant, FoodCartRestaurant)?
(SELECT COUNT(*) AS SCNT 
FROM Restaurants INNER JOIN SitDownRestaurant
	ON Restaurants.RestaurantId = SitDownRestaurant.RestaurantId
WHERE Active = True)
UNION
(SELECT COUNT(*) AS TCNT
FROM Restaurants INNER JOIN TakeOutRestaurant
	ON Restaurants.RestaurantId = TakeOutRestaurant.RestaurantId
WHERE Active = True)
UNION
(SELECT COUNT(*) AS FCNT
FROM Restaurants INNER JOIN FoodCartRestaurant
	ON Restaurants.RestaurantId = FoodCartRestaurant.RestaurantId
WHERE Active = True);


## 7. Which UserNames have not created a review, nor created a recommendation, nor created a reservation? In other words, users that have not created any of the following: reviews, recommendations, reservations.
SELECT Users.UserName
FROM Users
WHERE UserName NOT IN (SELECT UserName FROM Reviews)
AND UserName NOT IN (SELECT UserName FROM Recommendations)
AND UserName NOT IN (SELECT UserName FROM Reservations);


## 8. What is the ratio of the total number of recommendations to the total number of reviews?
SELECT(SELECT COUNT(*)
FROM Recommendations) / (SELECT COUNT(*)
FROM Reviews) AS RATIO;


## 9. Of all the users that have created a reservation at a SitDownRestaurant, what is the percentage that the same user has recommended the same SitDownRestaurant? To calculate this percentage, consider {UserName, RestaurantId} reservation tuples as the denominator and their intersecting {UserName, RestaurantId} recommendation tuples at the numerator.
SELECT(100.0*sum(IF(b.username IS NOT NULL, 1, 0))/count(*) ) AS percentage
FROM(SELECT UserName,RestaurantId
FROM Reservations 
GROUP BY UserName, RestaurantId) AS A LEFT JOIN (SELECT Recommendations.UserName,Recommendations.RestaurantId
FROM Recommendations INNER JOIN SitDownRestaurant
ON Recommendations.RestaurantId = SitDownRestaurant.RestaurantId
GROUP BY Recommendations.RestaurantId, Recommendations.UserName) AS b
ON A.UserName=B.UserName AND A.RestaurantId=B.RestaurantId;


## 10. Which UserNames have created more than twice the number of recommendations than number of reviews? Also take into account users that have not created recommendations or reviews -- if a user has created one recommendation but zero reviews, then that user should be included in the result set.
SELECT A.UserName
FROM(SELECT UserName, COUNT(*) AS RECCNT
FROM Recommendations
GROUP BY UserName) AS A
LEFT JOIN
(SELECT UserName, COUNT(*) AS REVCNT
FROM Reviews
GROUP BY UserName) AS B
ON A.RECCNT > B.REVCNT OR B.REVCNT = 0;



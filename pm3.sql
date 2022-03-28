# What is the average price of all wines in the United States?

# Top ten wines that have been reviewed by most tasters.
SELECT Wine.WineTitle, COUNT(A.ProfessionalReviewId) AS CNT FROM
(SELECT Wine.WineTitle FROM Wine 
INNER JOIN ProfessionalRating ON Wine.WineTitle = ProfessionalRating.WineTitle) AS A
GROUP BY Wine.WineTitle
ORDER BY CNT DESC
LIMIT 10

--Select the ranking of the average price of neighbourhood_cleansed by neighbourhood_group_cleansed with more than 10 appartement
with total_exp as (SELECT neighbourhood_group_cleansed,neighbourhood_cleansed,avg(price) as average, 
count(id) as count , rank() OVER(PARTITION BY neighbourhood_cleansed ORDER BY avg(price) DESC) as rank 
FROM listing GROUP BY neighbourhood_group_cleansed,neighbourhood_cleansed HAVING count(id)>10 
ORDER BY neighbourhood_group_cleansed,avg(price) DESC)
SELECT neighbourhood_group_cleansed,neighbourhood_cleansed, average from total_exp;

--Select the ranking of the average score of neighbourhood_cleansed by neighbourhood_group_cleansed with more than 10 appartement
SELECT neighbourhood_group_cleansed,neighbourhood_cleansed,avg(review_scores_rating) as average 
FROM listing GROUP BY neighbourhood_group_cleansed,neighbourhood_cleansed HAVING count(id)>10 
ORDER BY neighbourhood_group_cleansed,avg(review_scores_rating)ASC;

--Replacing 't' by True and 'f' by False in host_is_superhost column
UPDATE listing
SET host_is_superhost = REPLACE(host_is_superhost, 't', 'true')
WHERE host_is_superhost LIKE '%t%';
UPDATE listing
SET host_is_superhost = REPLACE(host_is_superhost, 'f', 'false')
WHERE host_is_superhost LIKE '%f%';

--Select the coordonate, price, score,number of bedrooms, is_wifi and is_super_host by neighbourhood--
SELECT latitude,longitude,id,price,review_scores_rating,bedrooms,is_wifi,host_is_superhost,neighbourhood_group_cleansed,neighbourhood_cleansed 
FROM listing; 

--Select average price per neighbourhood group
SELECT neighbourhood_group_cleansed,AVG(price) as average
FROM listing GROUP BY neighbourhood_group_cleansed;

--Select average rating per neighbourhood group
SELECT neighbourhood_group_cleansed,AVG(review_scores_rating) as average
FROM listing GROUP BY neighbourhood_group_cleansed;

--Select count of roomtype per neighbourhood group
SELECT neighbourhood_group_cleansed,room_type,count(1) FROM listing GROUP BY neighbourhood_group_cleansed,room_type
ORDER BY neighbourhood_group_cleansed;


Select host_id,(price) from listing where neighbourhood_cleansed='Embajadores' AND price>10000
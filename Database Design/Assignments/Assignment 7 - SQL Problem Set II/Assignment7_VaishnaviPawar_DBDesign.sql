#Vaishnavi Pawar Database Design Assignment 7

 USE z511s24vpawar5;

 #1 (Union) Write a query to find a list of grocery items that you can buy at Croger or A-Town International. (0.25 pt)
 
 SELECT itemname FROM croger
 UNION
 SELECT itemname FROM atown;
 
 #2 (Intersect) Write a query to find a list of grocery items that you can buy at both Croger and A-Town International. (0.25 pt)

 SELECT DISTINCT croger.itemname
 FROM croger
 JOIN atown ON croger.itemname = atown.itemname;

 #3 (Minus) Write a query to find a list of grocery items that you can buy only at A-Town International. (0.25 pt)
 
 SELECT atown.itemname
 FROM atown
 LEFT JOIN croger ON atown.itemname = croger.itemname
 WHERE croger.itemname IS NULL;
 
 #4 (CASE) Among five category values in the Croger table, we are particularly interested in dairy and vegetables. Write a query to show the two values as they are but convert the rest of the values into Other. (0.25 pt)

 SELECT itemname,
 CASE
 WHEN categoryname = 'Dairy' THEN 'Dairy'
 WHEN categoryname = 'Vegetables' THEN 'Vegetables'
 ELSE 'Other'
 END AS category
 FROM croger;

 #5. (CASE) Write a query to convert the month numbers in the monthnum column to corresponding month names.  (0.5 pt)
 
 SELECT city,
 CASE monthnum
 WHEN 1 THEN 'January'
 WHEN 2 THEN 'February'
 WHEN 3 THEN 'March'
 WHEN 4 THEN 'April'
 WHEN 5 THEN 'May'
 WHEN 6 THEN 'June'
 WHEN 7 THEN 'July'
 WHEN 8 THEN 'August'
 WHEN 9 THEN 'September'
 WHEN 10 THEN 'October'
 WHEN 11 THEN 'November'
 WHEN 12 THEN 'December'
 ELSE 'Invalid Month'
 END AS monthname, aqi
 FROM airpollution;
 
 #6. (CASE) Write a query to assign air quality scales based on the conversion chart below. (0.5 pt)
 
 SELECT city,
 monthnum,
 CASE
 WHEN aqi BETWEEN 0 AND 50 THEN 'Good'
 WHEN aqi BETWEEN 51 AND 100 THEN 'Moderate'
 WHEN aqi BETWEEN 101 AND 150 THEN 'Unhealthy for Sensitive Groups'
 WHEN aqi BETWEEN 151 AND 200 THEN 'Unhealthy'
 WHEN aqi BETWEEN 201 AND 300 THEN 'Very Unhealthy'
 WHEN aqi BETWEEN 301 AND 500 THEN 'Hazardous'
 ELSE 'Invalid AQI'
 END AS aqiscale
 FROM airpollution;
 
 #7. (CASE) Write a query to assign letter grades in the studentgrade table based on the grading system below. Please note that grades are not rounded. For example, 92.9% is not A but A-. (0.5 pt)
 
 SELECT studentid,
 gradepercentage,
 CASE
 WHEN gradepercentage >= 97 THEN 'A+'
 WHEN gradepercentage >= 93 AND gradepercentage < 97 THEN 'A'
 WHEN gradepercentage >= 90 AND gradepercentage < 93 THEN 'A-'
 WHEN gradepercentage >= 87 AND gradepercentage < 90 THEN 'B+'
 ELSE 'Grade not defined'
 END AS letter_grade
 FROM studentgrade;
# USE test1; 
USE z511s24vpawar3;

# Union
/* Q1: Retrieve all cities (only distinct values) of customers and branches
*/
# Tables: customer, branch
# Columns: city from customer, city from branch

SELECT city
FROM customer
UNION
SELECT city
FROM branch;


# Union All
/* Q2: Retrieve all cities (duplicate values also) of customers and branches
*/
# Tables: customer, branch
# Columns: city from customer, city from branch

SELECT city
FROM customer
UNION ALL 
SELECT city
FROM branch;


# Intersect
/* Q3: Retrieve all cities (only distinct values) that exist in both the customer and the branch table
*/
# Tables: customer, branch
# Columns: city from customer, city from branch

SELECT DISTINCT city
FROM customer
INNER JOIN branch USING(city);


# Minus
/* Q4: Retrieve all cities (only distinct values) that exist only in the customer table
*/
# Tables: customer, branch
# Columns: city from customer, city from branch

SELECT DISTINCT city
FROM customer
LEFT JOIN branch USING (city)
WHERE branch.city IS NULL;



# Union
/* Q5: Retrieve everything (only distinct values) you ate for breakfast and lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch

SELECT item
FROM breakfast
UNION 
SELECT item
FROM lunch;


# Union All
/* Q6: Retrieve everything (duplicate values also) you ate for breakfast and lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch

SELECT item
FROM breakfast
UNION ALL
SELECT item
FROM lunch;


# Intersect
/* Q7: Retrieve only the food that you ate at both meals
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch

SELECT DISTINCT item
FROM breakfast
INNER JOIN lunch USING (item);

# Minus
/* Q8: Retrieve all foods (only distinct values) you had for breakfast but not lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch

SELECT DISTINCT item
FROM breakfast
LEFT JOIN lunch using (item)
WHERE lunch.item IS NULL;


# Case
/* Q9: Group the values of the city column in the customer table into 'Wilmington' and 'Other' 
*/
# Tables: customer
# Columns: cust_id, city

SELECT cust_id,
  CASE
    WHEN city = 'Wilmington' THEN 'Wilmington'
    ELSE 'Other'
  END AS city2
FROM customer;


# Case
/* Q10: Write a query that classifies the available balance colunm into three categories:
'below 1000', '1000-10000', and 'over 10000'
*/
# Tables: account
# Columns: account_id, product_cd, cust_id, avail_balance

SELECT account_id, product_cd, cust_id, avail_balance,
  CASE
    WHEN avail_balance < 1000 THEN 'below 1000'
    WHEN avail_balance BETWEEN 1000 AND 10000 THEN '1000-10000'
    WHEN avail_balance > 10000 THEN 'over 10000' 
  END AS avail_balance_range
FROM account;


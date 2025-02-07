# USE test1; 



# Union
/* Q1: Retrieve all cities (only distinct values) of customers and branches
*/
# Tables: customer, branch
# Columns: city from customer, city from branch




# Union All
/* Q2: Retrieve all cities (duplicate values also) of customers and branches
*/
# Tables: customer, branch
# Columns: city from customer, city from branch





# Intersect
/* Q3: Retrieve all cities (only distinct values) that exist in both the customer and the branch table
*/
# Tables: customer, branch
# Columns: city from customer, city from branch




# Minus
/* Q4: Retrieve all cities (only distinct values) that exist only in the customer table
*/
# Tables: customer, branch
# Columns: city from customer, city from branch





# Union
/* Q5: Retrieve everything (only distinct values) you ate for breakfast and lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch




# Union All
/* Q6: Retrieve everything (duplicate values also) you ate for breakfast and lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch



# Intersect
/* Q7: Retrieve only the food that you ate at both meals
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch



# Minus
/* Q8: Retrieve all foods (only distinct values) you had for breakfast but not lunch
*/
# Tables: breakfast, lunch
# Columns: item from customer, item from branch



# Case
/* Q9: Group the values of the city column in the customer table into 'Wilmington' and 'Other' 
*/
# Tables: customer
# Columns: cust_id, city



# Case
/* Q10: Write a query that classifies the available balance colunm into three categories:
'below 1000', '1000-10000', and 'over 10000'
*/
# Tables: account
# Columns: account_id, product_cd, cust_id, avail_balance



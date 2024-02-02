#Vaishnavi Pawar Database Design Assignment 6 

USE z511s24vpawar4; 

#1 a Display the ProductID, ProductName, Product Price, VendorName, and CategoryName for all products. Sort the results by ProductID.

SELECT p.productid, p.productname, p.productprice, v.vendorname, c.categoryname
FROM product p
JOIN vendor v ON p.vendorid = v.vendorid
JOIN category c ON p.categoryid = c.categoryid
ORDER BY p.productid;


#1 b Display the ProductID, ProductName, and Product Price for products in the category whose CategoryName value is Camping. Sort the results by ProductID.

SELECT p.productid, p.productname, p.productprice
FROM product p
INNER JOIN category c ON p.categoryid = c.categoryid
WHERE c.categoryname = 'Camping'
ORDER BY p.productid;


#1 c Display the TID, CustomerName, and TDate for sales transactions involving a customer buying a product whose ProductName is Dura Boot.

SELECT s.tid, c.customername, s.tdate
FROM salestransaction s
INNER JOIN customer c ON s.customerid = c.customerid
INNER JOIN soldvia sv ON s.tid = sv.tid
INNER JOIN product p ON sv.productid = p.productid
WHERE p.productname = 'Dura Boot';



#1 d Display the RegionId, RegionName, and number of stores in the region for all regions.

SELECT r.regionid, r.regionname, COUNT(s.storeid) AS NumberOfStores
FROM region r
LEFT JOIN store s ON r.regionid = s.regionid
GROUP BY r.regionid, r.regionname;


#1 e For each product category, display the CategoryID, CategoryName, and average price of a product in the category.

SELECT c.categoryid, c.categoryname, AVG(p.productprice) AS AveragePrice
FROM category c
INNER JOIN product p ON c.categoryid = p.categoryid
GROUP BY c.categoryid, c.categoryname;


#1 f For each product category, display the CategoryID and the total number of items purchased in the category.

SELECT c.categoryid, SUM(sv.noofitems) AS TotalItemsPurchased
FROM category c
JOIN product p ON c.categoryid = p.categoryid
JOIN soldvia sv ON p.productid = sv.productid
GROUP BY c.categoryid;


#1 g Display the TID and the total number of items (of all products) sold within the transaction for all sales transactions whose total number of items (of all products) sold within the transaction is greater than five.

SELECT tid, SUM(noofitems) AS TotalItemsSold
FROM soldvia
GROUP BY tid
HAVING SUM(noofitems) > 5
ORDER BY tid;


#1 h Display the ProductID and ProductName of the cheapest product. 

SELECT productid, productname
FROM product
WHERE productprice = (SELECT MIN(productprice) FROM product);


#1 i Display the ProductID, ProductName, and VendorName for products whose price is below the average price of all products.

SELECT p.productid, p.productname, v.vendorname
FROM product p
INNER JOIN vendor v ON p.vendorid = v.vendorid
WHERE p.productprice < (SELECT AVG(productprice) FROM product);


#1 j Display the ProductID for the product that has been sold the most (i.e., that has been sold in the highest quantity.)

SELECT productid
FROM soldvia
GROUP BY productid
HAVING 
    SUM(noofitems) = (
        SELECT SUM(noofitems)
        FROM soldvia
        GROUP BY productid
        ORDER BY SUM(noofitems) DESC
        LIMIT 1
    );
    
#1 k Rewrite the following query using a join statement (no subqueries). (0.5)
/*
SELECT productid, productname, productprice
FROM product
WHERE productid IN 
                              (SELECT productid
                               FROM soldvia
                               GROUP BY productid
                               HAVING SUM(noofitems) > 3);
*/


SELECT p.productid, p.productname, p.productprice
FROM product p
JOIN soldvia sv ON p.productid = sv.productid
GROUP BY p.productid, p.productname, p.productprice
HAVING SUM(sv.noofitems) > 3;


#1 l Rewrite the following query using a join statement (no subqueries). (0.5)

/* 
SELECT productid, productname, productprice
FROM product
WHERE productid IN 
                              (SELECT productid
                               FROM soldvia
                               GROUP BY productid
                               HAVING COUNT(tid) > 1);
*/

SELECT p.productid, p.productname, p.productprice
FROM product p
JOIN soldvia sv ON p.productid = sv.productid
GROUP BY p.productid, p.productname, p.productprice
HAVING COUNT(DISTINCT sv.tid) > 1;




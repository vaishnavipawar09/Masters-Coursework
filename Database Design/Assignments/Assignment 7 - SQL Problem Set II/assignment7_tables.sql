USE test1;
SET FOREIGN_KEY_CHECKS = 0;
# delete all the tables in your database

# 

CREATE TABLE croger
(	itemname 		VARCHAR(50) 	NOT NULL,
    categoryname 	VARCHAR(25) 	NOT NULL);
    
CREATE TABLE atown
( 	itemname 	VARCHAR(50) 	NOT NULL);

CREATE TABLE airpollution
(	city	 	VARCHAR(25) 	NOT NULL,
	monthnum	int				NOT NULL,
    aqi			int				NOT NULL);

CREATE TABLE studentgrade
(	studentid	char(5)		 	NOT NULL,
    gradepercentage	decimal(5,2)		NOT NULL);
    
    

INSERT INTO croger	VALUES ('FAGE Greek Yogurt','Dairy');
INSERT INTO croger	VALUES ('Green Onion','Vegetables');
INSERT INTO croger	VALUES ('Japanese Sweet Potato','Vegetables');
INSERT INTO croger	VALUES ('Chinese Cabbage','Vegetables');
INSERT INTO croger	VALUES ('Simple Truth Organic Whole Milk','Dairy');
INSERT INTO croger	VALUES ('Blueberries','Fruits');
INSERT INTO croger	VALUES ('Plantain','Fruits');
INSERT INTO croger	VALUES ('Simple Truth Organic Mozzarella Shredded Cheese','Dairy');
INSERT INTO croger	VALUES ('Mother In Law''s Kimchi','International Cuisine');
INSERT INTO croger	VALUES ('Daffodil','Flowers');


INSERT INTO atown	VALUES ('Jongga Premium Kimchi');
INSERT INTO atown	VALUES ('Yogurt Ice');
INSERT INTO atown	VALUES ('Perilla Leaves');
INSERT INTO atown	VALUES ('Green Onion');
INSERT INTO atown	VALUES ('Japanese Sweet Potato');
INSERT INTO atown	VALUES ('Chinese Cabbage');

INSERT INTO airpollution VALUES ('city1', 1, 30);
INSERT INTO airpollution VALUES ('city1', 2, 45);
INSERT INTO airpollution VALUES ('city1', 3, 50);
INSERT INTO airpollution VALUES ('city1', 4, 31);
INSERT INTO airpollution VALUES ('city1', 5, 50);
INSERT INTO airpollution VALUES ('city1', 6, 20);

INSERT INTO airpollution VALUES ('city2', 1, 99);
INSERT INTO airpollution VALUES ('city2', 2, 110);
INSERT INTO airpollution VALUES ('city2', 3, 150);
INSERT INTO airpollution VALUES ('city2', 4, 205);
INSERT INTO airpollution VALUES ('city2', 5, 250);
INSERT INTO airpollution VALUES ('city2', 6, 140);

INSERT INTO airpollution VALUES ('city3', 1, 199);
INSERT INTO airpollution VALUES ('city3', 2, 210);
INSERT INTO airpollution VALUES ('city3', 3, 250);
INSERT INTO airpollution VALUES ('city3', 4, 305);
INSERT INTO airpollution VALUES ('city3', 5, 350);
INSERT INTO airpollution VALUES ('city3', 6, 240);

INSERT INTO studentgrade VALUES ('11111', 99.99);
INSERT INTO studentgrade VALUES ('11112', 98.99);
INSERT INTO studentgrade VALUES ('11113', 97.99);
INSERT INTO studentgrade VALUES ('11114', 96.99);
INSERT INTO studentgrade VALUES ('11115', 95.99);
INSERT INTO studentgrade VALUES ('11116', 94.99);
INSERT INTO studentgrade VALUES ('11117', 93);
INSERT INTO studentgrade VALUES ('11118', 91);
INSERT INTO studentgrade VALUES ('11119', 89);
INSERT INTO studentgrade VALUES ('11120', 88);






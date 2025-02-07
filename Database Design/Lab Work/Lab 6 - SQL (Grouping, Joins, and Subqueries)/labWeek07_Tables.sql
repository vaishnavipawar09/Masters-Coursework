USE z511s21choika9; #replace z511s21choika9 with your database name


CREATE TABLE area
(areaid		CHAR(1),
areaname	CHAR(10),
areahq 		CHAR(20),
PRIMARY KEY (areaid));


INSERT INTO area VALUES ('1', 'East',  'Boston');
INSERT INTO area VALUES ('2', 'West',  'San Francisco');
INSERT INTO area VALUES ('3', 'Central','Chicago');
INSERT INTO area VALUES ('4', 'South','Memphis');


CREATE TABLE agent
(agentid		CHAR(2),
agentname	CHAR(10),
agentarea 	CHAR(1),
agentrating	INT,
agentyearofhire	INT,
supervisedby	CHAR(2),
agentsalary	INT,
PRIMARY KEY (agentid),
FOREIGN KEY (agentarea) REFERENCES area(areaid),
FOREIGN KEY (supervisedby) REFERENCES agent(agentid));


INSERT INTO agent VALUES ('A1', 'Kate', '1', 101, 1990, null, 102000);
INSERT INTO agent VALUES ('A2', 'Amy', '2', 92, 2009, 'A1', 100000);
INSERT INTO agent VALUES ('A3', 'Luke', '2', 100, 1992, null, 101000);
INSERT INTO agent VALUES ('A4', 'James','3', 90, 2010, 'A3', 90000);
INSERT INTO agent VALUES ('A5', 'Salcedo','3', 100, 2018, 'A1', 80000);


CREATE TABLE client
(clientid			CHAR(4),
clientname		CHAR(10),
agentid	 		CHAR(2),
clientspousename 	CHAR(10),
clientincome		INT,
PRIMARY KEY (clientid),
FOREIGN KEY (agentid) REFERENCES agent(agentid));


INSERT INTO client VALUES ('C111', 'Tom', 'A1', 'Jenny', 102000);
INSERT INTO client VALUES ('C222', 'Karin', 'A1', 'Bill', 105000);
INSERT INTO client VALUES ('C333', 'Cole', 'A2', 'Amy', 80000);
INSERT INTO client VALUES ('C444', 'Dorothy', 'A2', null, 90000);
INSERT INTO client VALUES ('C555', 'Andy', 'A3', 'Amy', 70000);
INSERT INTO client VALUES ('C666', 'Tina', 'A4', 'Matt', 180000);
INSERT INTO client VALUES ('C777', 'Christina','A5', 'Mike', 200000);


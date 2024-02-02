USE z511s24vpawar2; #replace z511s21choika9 with your database name

#1 Write an SQL query for the HAPPY INSURANCE database that will list the agent ID and agent name for each agent hired before the year 2000.

SELECT agentid, agentname
FROM agent
WHERE agentyearofhire < 2000;

#2 Write an SQL query for the HAPPY INSURANCE database that will display the average rating for all agents.

SELECT AVG(agentrating)
FROM agent;

#3 Write an SQL query for the HAPPY INSURANCE database that will for each area that has agents display the area id and the number of agents in the area.

SELECT agentarea, COUNT(*)
FROM agent
GROUP BY agentarea;

#4 Write an SQL query for the HAPPY INSURANCE database that will for each for each agent that has clients display the agent id and the number of his/her clients.

SELECT agentid, COUNT(*)
FROM client
GROUP BY agentid;

#5 Write an SQL query for the HAPPY INSURANCE database that will, for each client of the agent named Amy, list the client's name and the name of the client's agent.

SELECT c.clientname, a.agentname
FROM client c INNER JOIN agent a ON c.agentid = a.agentid
WHERE agentname = 'Amy';

#6 Write an SQL query for the HAPPY INSURANCE database that will for each client list the client's name and the name of the area of his or her agent.

SELECT c.clientname, ar.areaname
FROM 
	client c
		INNER JOIN 
	agent a ON c.agentid = a.agentid
		INNER JOIN
	area ar ON ar.areaid = a.agentarea;

#7 Write an SQL query for the HAPPY INSURANCE database that will list the agent id and agent name of the agent (or agents) with the lowest agent rating.

SELECT agentid, agentname
FROM agent
WHERE agentrating = (SELECT MIN(agentrating) FROM agent);

#8 Write an SQL query for the HAPPY INSURANCE database that will display the name of each client of the agent with the highest agent rating in the company.

SELECT c.clientname
FROM client c INNER JOIN agent a ON c.agentid = a.agentid
WHERE a.agentrating = (SELECT MAX(agentrating) FROM agent);

#9 Write an SQL query for HAPPY INSURANCE database that will for each area display the area ID, area name, and average rating for all agents in the area.

SELECT areaid, areaname, AVG(agentrating)
FROM area INNER JOIN agent ON areaid = agentarea
GROUP BY areaid, areaname;

#10 Write an SQL query for the HAPPY INSURANCE database that will, for each area where the highest rated agent has a rating higher than 100, display the area ID, area name, and average rating for all agents in the area.

SELECT areaid, areaname, AVG(agentrating)
FROM area INNER JOIN agent ON areaid = agentarea
GROUP BY areaid, areaname
HAVING MAX(agentrating) > 100;

#11 Write the SQL query for the HAPPY INSURANCE database that will, for each area that has more than one agent, display the area id, area name, and the number agents in the area.

SELECT ar.areaid, ar.areaname, COUNT(*)
FROM area ar INNER JOIN agent ag ON ar.areaid = ag.agentarea
GROUP BY ar.areaid, ar.areaname
HAVING COUNT(*) > 1;

#12 Write an SQL query for the HAPPY INSURANCE database that will, for each agent that has a supervisor, retrieve the name of the agent and the name of his or her supervisor.

SELECT a.agentname aname, s.agentname sname
FROM agent a INNER JOIN agent s ON a.supervisedby = s.agentid;

#13 Write an SQL query for the HAPPY INSURANCE database that will, for each agent, retrieve the name of the agent and the name of his or her supervisor. (The name of the agent will be retrieved even if he or she has no supervisor.)

SELECT a.agentname aname, s.agentname sname
FROM agent a LEFT OUTER JOIN agent s ON a.supervisedby = s.agentid;

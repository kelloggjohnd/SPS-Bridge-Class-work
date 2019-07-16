/*1. Which destination in the flights database is the furthest distance away, based on information in the flights table.
Show the SQL query(s) that support your conclusion.
*/

SELECT FLIGHT, MAX(DISTANCE) FROM FLIGHTS 

/*ANSWER: Flight 1545 is the longest at 4983
*/

/*2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have the most number of seats? Show the SQL statement(s) that support your result.
*/

SELECT DISTINCT(ENGINES) From PLANES order by ENGINES asc

SELECT TAILNUM, YEAR, TYPE, manufacturer, model, ENGINES, MAX(SEATS), SPEED, ENGINE From PLANES 
Group BY ENGINES
ORDER BY ENGINES ASC

/*ANSWER Q1: There are 4 different engine numbers in the table. 1, 2, 3, and 4
ANSWER Q2: 
Tail Number N201AA has 16 seats and 1 engine
Tail Number N10156 has 400 seats and 2 engines
Tail Number N854NW has 379 seats and 3 engines
Tail Number N381AA has 450 seats and 4 engines
*/

/*3. Show the total number of flights.*/

SELECT COUNT(flight) from FLIGHTS

/*ANSWER: 327346
*/

/*4. Show the total number of flights by airline (carrier).
*/

SELECT AL.NAME, COUNT(FL.FLIGHT) 
from FLIGHTS FL
JOIN AIRLINES AL on AL.CARRIER = FL.CARRIER
GROUP BY AL.NAME
ORDER BY AL.NAME ASC

/*ANSWER
AirTran Airways Corporation	-3175
Alaska Airlines Inc. -709
American Airlines Inc.-31947
Delta Air Lines Inc.-47658
Endeavor Air Inc.-17294
Envoy Air-25037
ExpressJet Airlines Inc.-51108
Frontier Airlines Inc.-681
Hawaiian Airlines Inc.-342
JetBlue Airways-54049
Mesa Airlines Inc.-544
SkyWest Airlines Inc.-29
Southwest Airlines Co.-12044
United Air Lines Inc.-57782
US Airways Inc.-19831
Virgin America-5116 
*/

/*5. Show all of the airlines, ordered by number of flights in descending order.*/

SELECT AL.NAME, COUNT(FL.FLIGHT) 
from FLIGHTS FL
JOIN AIRLINES AL on AL.CARRIER = FL.CARRIER
GROUP BY AL.NAME
ORDER BY COUNT(FL.FLIGHT) DESC

/* ANSWER:
United Air Lines Inc.	57782
JetBlue Airways	54049
ExpressJet Airlines Inc.	51108
Delta Air Lines Inc.	47658
American Airlines Inc.	31947
Envoy Air	25037
US Airways Inc.	19831
Endeavor Air Inc.	17294
Southwest Airlines Co.	12044
Virgin America	5116
AirTran Airways Corporation	3175
Alaska Airlines Inc.	709
Frontier Airlines Inc.	681
Mesa Airlines Inc.	544
Hawaiian Airlines Inc.	342
SkyWest Airlines Inc.	29
*/

/*6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.*/

SELECT AL.NAME, COUNT(FL.FLIGHT) 
from FLIGHTS FL
JOIN AIRLINES AL on AL.CARRIER = FL.CARRIER
GROUP BY AL.NAME
ORDER BY COUNT(FL.FLIGHT) DESC limit 5

/* ANSWER:
United Air Lines Inc.	57782
JetBlue Airways	54049
ExpressJet Airlines Inc.	51108
Delta Air Lines Inc.	47658
American Airlines Inc.	31947
*/

/*7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.*/

SELECT AL.NAME, COUNT(FL.FLIGHT)
from FLIGHTS FL
JOIN AIRLINES AL on AL.CARRIER = FL.CARRIER
Where FL.DISTANCE > 1000
GROUP BY AL.NAME
ORDER BY COUNT(FL.FLIGHT) DESC limit 5

/* ANSWER:
United Air Lines Inc.	40608
JetBlue Airways	29719
Delta Air Lines Inc.	27850
American Airlines Inc.	23084
ExpressJet Airlines Inc.	5886
*/

/*8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question, and the query that answers the question.

What is the average flight distance by airline leaving from JFK?
*/

SELECT AL.NAME, CAST(Avg(DISTANCE) AS DECIMAL (10,2)) AS  'AVERAGE DISTANCE'
from FLIGHTS FL
JOIN AIRLINES AL on AL.CARRIER = FL.CARRIER
Where FL.origin = 'JFK'
GROUP BY AL.NAME
ORDER BY COUNT(FL.FLIGHT)

/* ANSWER:
Hawaiian Airlines Inc.	4983.00
ExpressJet Airlines Inc.	228.88
US Airways Inc.	1129.37
Virgin America	2495.02
United Air Lines Inc.	2535.51
Envoy Air	403.53
American Airlines Inc.	1662.10
Endeavor Air Inc.	506.00
Delta Air Lines Inc.	1689.51
JetBlue Airways	1114.70
*/
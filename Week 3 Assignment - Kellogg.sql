CREATE DATABASE IF NOT EXISTS key_card;
-- DROP DATABASE key_card

USE key_card;

/*There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group
“Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
“Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
rooms. Heidy is a new employee, who has not yet been assigned to any group.*/

CREATE TABLE IF NOT EXISTS user (
table_ID INT AUTO_INCREMENT,
user_ID INT NOT NULL,
user_name TEXT NOT NULL,
PRIMARY KEY (table_ID));

CREATE Table IF NOT EXISTS department ( -- I will be adding alias to all reports with department as "GROUP" is a defined function.  
table_id INT AUTO_INCREMENT,
dept_ID INT NULL,
dept_name TEXT NOT NULL,
PRIMARY KEY (table_ID));

CREATE TABLE IF NOT EXISTS room (
table_id INT AUTO_INCREMENT, 
room_ID INT NULL,
room_name TEXT NOT NULL,
PRIMARY KEY (table_ID));

CREATE TABLE IF NOT EXISTS user_department ( -- I am sure the Connection table(s) could be combined into one, however, for ease of use, updating and scripting I would keep them seperate.
user_ID INT REFERENCES users(user_ID),
dept_ID INT REFERENCES department(dept_ID),
CONSTRAINT pk_key_data PRIMARY KEY(user_ID, dept_ID)
); 

CREATE TABLE IF NOT EXISTS room_department (
dept_ID INT REFERENCES department(dept_ID),
room_ID INT REFERENCES room(room_ID),
CONSTRAINT pk_key_data PRIMARY KEY(dept_ID, room_ID)
); 

INSERT INTO user (user_ID, user_name)
Values
	(1,"Modesto"),
	(2,"Ayine"),
	(3,"Christopher"),
	(4,"Cheong Woo"),
	(5,"Saulat"),
	(6,"Heidy");
    
INSERT INTO room (room_ID, room_name)
VALUES
	(1,"101"),
	(2,"102"),
	(3,"Auditorium A"),
	(4,"Auditorium B");
    
INSERT INTO department (dept_ID, dept_name)  -- the Connection table could be combined into one, however, for ease of use, updating and scripting I would keep them seperate
VALUES
	(1,"I.T."),
	(2,"Sales"),
	(3,"Administration"),
	(4,"Operations");
    
INSERT INTO user_department (user_ID, dept_ID)
VALUES
	(1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,3),
	(6,0),
    (0,4);
    
INSERT INTO room_department (dept_ID, room_ID)
VALUES
	(1,1),
	(1,2),
	(2,2),
	(2,3),
	(3,0),
	(4,0),
	(0,4);

-- Simple select statement to ensure all data has been entered.    
SELECT * from USER;
SELECT * FROM department;
SELECT * FROM room;
SELECT * FROM user_department;
SELECT * FROM room_department;


-- Request 1. All groups, and the users in each group. A group should appear even if there are no users assigned to the group.

SELECT d.dept_name AS "GROUP", u.user_name
FROM department d
Right JOIN user_department UD on UD.dept_ID = d.dept_ID  -- this was not expressly said in the request, however, if I was building a report I would want to know groups with no people and users with no group
LEFT JOIN USER u on u.user_ID = UD.user_ID -- Left Join here pull all values from the "Left" table meaning the user table even if they are null
ORDER BY d.dept_name ASC, u.user_name ASC;

-- Request 2. All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.

SELECT r.room_name, d.dept_name AS "GROUP" 
FROM room r
RIGHT JOIN room_department RD on RD.room_ID = r.room_ID -- as with request 1, if I was writing this report for myself, I would want to know which values are NULL on both sides.
LEFT JOIN department d on d.dept_ID = RD.dept_ID
ORDER BY r.room_name ASC;

-- Request 3. A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room. 

SELECT u.user_name, d.dept_name AS "GROUP", r.room_name -- Due to the request, Auditorium B will not be listed below as it does not have any Users which have access.
FROM room r
RIGHT JOIN room_department RD on RD.room_ID = r.room_ID -- Administration does not have access to any room right join to pull all rooms even if NULL
JOIN department d on d.dept_ID = RD.dept_ID
JOIN user_department UD on d.dept_ID = UD.dept_ID
RIGHT JOIN user u on u.user_ID = UD.user_ID  -- Heidy is not part of any department, Right Join to pull all users
ORDER BY u.user_name ASC, d.dept_name DESC, r.room_name ASC; 

 


CREATE TABLE IF NOT EXISTS Videos (
ID INT AUTO_INCREMENT,
TITLE TEXT,
length_minutes INT, 
URL TEXT,
PRIMARY KEY (ID)
)

CREATE TABLE IF NOT EXISTS Reviewers(
table_ID INT AUTO_INCREMENT,
Reviewer_number INT,
Reviewer_name TEXT NOT NULL,
Rating INT,
Review TEXT, 
Video_ID INT NOT NULL,
PRIMARY KEY (table_ID)
)

INSERT INTO VIDEOS (Title, length_minutes, URL)
Values
('Pendant from Bamboo Spoon', 7, 'https://www.youtube.com/watch?v=hcThTMk3SFk'),
('A unicorn Dies', 1, 'https://www.youtube.com/watch?v=zEpIOAESsT0'),
('Art from 3,500+ COLORED Pencils', 15, 'https://www.youtube.com/watch?v=YWaA-RPi5Zw');
 
 Select * from Videos
 
INSERT INTO Reviewers (Reviewer_number, Reviewer_name, Rating, Review, Video_ID)
Values
(1,'Ross',5,'Awesome work dude!',1),
(1,'Ross',2,'Poor little guy',2),
(1,'Ross',4,'Finally the end of this piece',3),
(2,'Stace',4,'Looked pretty until you dropped it',3),
(3,'Leah',3,'what has Bobby done this time',2),
(4,'PotatoCake',5,'If the Dr. told me I had 32 seconds to live I would watch this',2),
(5,'Vincent',1,'POOR WEWD',3),
(2,'Stace',4,'spewn made from wewd',1),
(6,'Addison',	4.5,'I want that',1),
(3,'Leah',3,'what has Bobby done this time',2),
(4,'PotatoCake',5,'If the Dr. told me I had 32 seconds to live I would watch this',2),
(5,'Vincent',1,'POOR WEWD',3);

SELECT * from Reviewers

Select V.Title, V.URL, R.Reviewer_name, R.Rating, R.Review
from Videos V
JOIN Reviewers R on V.ID = R.Video_ID
WHERE R.Reviewer_Name = 'Ross'



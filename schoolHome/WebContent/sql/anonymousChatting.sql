CREATE TABLE anonymouschatting(
	chatName varchar2(20),
	chatContent varchar2(100),
	chatTime varchar2(20)
)
CREATE TABLE anonymouschatting(
	chatID INT PRIMARY KEY,
	chatName varchar2(20),
	chatContent varchar2(100),
	chatTime varchar2(20)
)
CREATE SEQUENCE anonymous_seq;

CREATE TABLE individualChatting(
	individualID INT PRIMARY KEY,
	fromID VARCHAR(20),
	toID VARCHAR(20),
	individualContent VARCHAR(1000),
	individualTime VARCHAR(20),
	individualRead INT
)

CREATE SEQUENCE individual_seq START WITH 1 INCREMENT BY 1;

SELECT * FROM individualChatting WHERE individualID IN (SELECT MAX(individualID) FROM individualChatting WHERE toID = 'blue' OR fromID = 'blue' GROUP BY fromID, toID);
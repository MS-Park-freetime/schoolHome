CREATE TABLE EVALUATION(
	evaluationID int PRIMARY KEY,
	userID varchar(20),
	lectureName varchar(50),
	professorName varchar(20),
	lectureYear int,
	semesterDivide varchar(20),
	lectureDivide varchar(20),
	evaluationTitle varchar(50),
	evaluationContent varchar(2048),
	totalScore varchar(5),
	creditScore varchar(5),
	lectureScore varchar(5),
	likeCount int
)

CREATE TABLE LIKEY(
	userID varchar(20),
	evaluationID int,
	userIP varchar(50)
)

ALTER TABLE LIKEY ADD PRIMARY KEY (userID, evaluationID)

SELECT A.* FROM (SELECT ROWNUM r, B.* FROM (SELECT * FROM EVALUATION WHERE lectureDivide LIKE '%' AND lectureName || professorName || evaluationTitle || evaluationContent LIKE '%' ORDER BY evaluationID DESC)B )A WHERE r BETWEEN 5 AND 9;

SELECT * FROM (SELECT * FROM EVALUATION WHERE lectureDivide LIKE '%' AND lectureName || professorName || evaluationTitle || evaluationContent LIKE '%' ORDER BY evaluationID DESC) WHERE ROWNUM BETWEEN 0 AND 4;

select A.* from(select rownum r, B.* from(select *  from evaluation order by evaluationID desc)B) A where r between 5 and 9;







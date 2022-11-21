CREATE TABLE LOGIN(
	userID VARCHAR(20) PRIMARY KEY,
	userPassword VARCHAR(20),
	userName VARCHAR(20),
	userGender VARCHAR(20),
	userEmail VARCHAR(50)
	)
	
INSERT INTO LOGIN VALUES('asd', '1234', '러므게', '남자', 'fniqw@naver.com')

SELECT * FROM LOGIN

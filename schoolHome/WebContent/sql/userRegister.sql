CREATE TABLE login(
	userID varchar(20) PRIMARY KEY,
	userPassword varchar(30),
	userName varchar(20),
	userAge int,
	userGender varchar(20),
	userEmail varchar(50),
	userEmailHash varchar(64),
	userEmailChecked char(5) CHECK(userEmailChecked IN('FALSE', 'TRUE'))
)
CREATE TABLE userLogin(
	userID varchar(20) PRIMARY KEY,
	userPassword varchar(30),
	userName varchar(20),
	userAge int,
	userGender varchar(20),
	userProfile varchar(50),
	userEmail varchar(50),
	userEmailHash varchar(64),
	userEmailChecked char(5) CHECK(userEmailChecked IN('FALSE', 'TRUE'))
)

ALTER TABLE login ADD userProfile varchar(50)
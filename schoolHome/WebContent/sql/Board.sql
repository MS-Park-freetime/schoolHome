create table boardtest(
num int not null primary key,
userID varchar(10) not null,
subject varchar(50) not null,
reg_date timestamp(6) not null,
readcount int default 0,
ref int not null,
re_step smallint not null,
re_level smallint not null,
content varchar2(4000) not null
);

CREATE SEQUENCE boardtest_seq;
CREATE SEQUENCE boardFile_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE boardFile(
	num int primary key,
	userID varchar2(10),
	boardTitle varchar2(50),
	boardContent varchar2(4000),
	boardDate varchar2(20),
	readcount int default 0,
	boardFile varchar2(100),
	boardRealFile varchar2(100),
	ref int,
	re_step smallint,
	re_level smallint
)

SELECT * FROM BOARDFILE;
INSERT INTO boardFile VALUES (userID = 'auto', NVL((SELECT MAX(num) + 1 FROM boardFile), 1), boardTitle = '안녕하세요', boardContent = '으람나ㅏ', boardDate = '2010-02-42', 0, ?, ?, NVL((SELECT MAX(ref) + 1 FROM boardFile), 0), 0, 0);
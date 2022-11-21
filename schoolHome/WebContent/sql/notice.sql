create table notice(
num int not null primary key,
userID varchar2(20),
subject varchar2(50),
content varchar2(4000),
reg_date varchar2(20),
readcount int default 0
);

CREATE SEQUENCE notice_seq;
CREATE SEQUENCE noticeReply_seq;

CREATE TABLE NOTICE_COMMENT(
  COMMENT_NUM int NOT NULL PRIMARY KEY,
  COMMENT_BOARD int,
  userID VARCHAR2(20),
  COMMENT_DATE VARCHAR2(20),
  COMMENT_PARENT NUMBER,
  COMMENT_CONTENT VARCHAR2(1000) NOT NULL,
  COMMENT_LEVEL int,
  CONSTRAINT FK_comment FOREIGN KEY(COMMENT_BOARD) REFERENCES notice(num)
)
CREATE TABLE notice_comment(
  comment_num int not null PRIMARY KEY,
  board_num int references notice(num),
  userID VARCHAR2(20),
  comment_content VARCHAR2(1000),
  comment_date VARCHAR2(20),
  comment_ref int
)
 
create sequence COMMENT_SEQ;



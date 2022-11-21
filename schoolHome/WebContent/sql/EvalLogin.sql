CREATE TABLE EVALOGIN(
	userID varchar(20) PRIMARY KEY,
	userPassword varchar(20),
	userName varchar(20),
	userGender varchar(20),
	userEmail varchar(50),
	userEmailHash varchar(64),
	userEmailChecked char(5) CHECK(userEmailChecked IN('FALSE', 'TRUE'))
)


create table cctest(
	checked char(5) check(checked in('FALSE', 'TRUE'))
)

select * from cctest
insert into cctest(checked) values('false')
insert into cctest(checked) values('FALSE')
insert into cctest(checked) values('coa')
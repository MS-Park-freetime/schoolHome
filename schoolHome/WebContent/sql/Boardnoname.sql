create table nonameboard(
num int not null primary key ,
writer varchar(10) not null,
subject varchar(50) not null,
passwd varchar(12) not null,
reg_date timestamp(6) not null,
readcount int default 0,
ref int not null,
re_step smallint not null,
re_level smallint not null,
content varchar2(4000) not null
);


create database postgres;
use postgres;

-- drop table users;
create table users (
	id bigint auto_increment,
    first_name varchar(30),
    last_name varchar(30),
    dob date,
    gender varchar(10),
    role varchar(20),
    email varchar(30),
    password varchar(20),
    primary key (id)
);

insert users
values(12312312, 'Bagaa', 'Erdene', '2001-05-22', 'male', 'admin', 'bagaa@sync.mn', 'pass'),
(12312313, 'Nymaa', 'Urtnasan', '2001-08-13', 'male', 'admin', 'nymaa@mail.mn', 'pass1'),
(12312314, 'Robo', 'Togtuun', '2001-02-08', 'male', 'admin', 'robo@mail.mn', 'pass2'),
(12312315, 'Lol', 'Hero', '2001-01-22', 'female', 'user', 'exe@mail.mn', 'pass3');

select*from users;
/*show all databases*/
show databases;

/*if not exist micro_wins DB, create micro_wins DB*/
-- drop database if exists micro_wins;
create database if not exists micro_wins;

/*select DB from system*/
use micro_wins;

/*create table section. Checked if not exists on all created table.*/

-- drop table if exists mw_user;  
create table if not exists mw_user(
    user_id integer auto_increment,
    device_id integer not null,
    user_name varchar(30) not null,
    user_status integer default 0,
    created_at timestamp default current_timestamp,
	updated_at timestamp,
    primary key (user_id) 
);
-- select * from mw_user;

-- drop table if exists mw_dict_type;
create table if not exists mw_dict_type(
	dt_typeno integer auto_increment,
    dt_typename varchar(20) not null,
    dt_engname varchar(20) not null,
    dt_typevalue varchar(30) not null,
	primary key (dt_typeno)
);

-- mw_dict_type table values:
insert into mw_dict_type (dt_typename, dt_engname, dt_typevalue) 
values('status', 'status', 'mw_dict_type.status'),
('user_status', 'user_status', 'mw_dict_type.user_status'),
('priority', 'priority', 'mw_dict_type.priority');
-- select * from mw_dict_type;

drop table if exists mw_dictionary;
create table if not exists mw_dictionary(
	dict_id integer auto_increment,
    dict_typeno integer not null,
	dict_name varchar(30) not null,
    dict_value integer not null,
    unique (dict_typeno, dict_value),
    primary key (dict_id),
    foreign key (dict_typeno) references mw_dict_type(dt_typeno)  on update cascade on delete cascade
);
-- mw_dictionary table values:
insert into mw_dictionary (dict_typeno, dict_name, dict_value)
values(1, 'open', 1),
(1, 'working', 2),
(1, 'postponed', 3),
(1, 'completed', 4),
(2, 'active', 1),
(2, 'inactive', 0),
(3, 'urgent', 1),
(3, 'high', 2),
(3, 'medium', 3),
(3, 'low', 4),
(4, 'easy', 1),
(4, 'medium', 2),
(4, 'hard', 3);
-- select * from mw_dictionary; 

drop table if exists mw_task;
create table if not exists mw_task (
	task_id integer auto_increment,
	task_title varchar(30) not null,
	task_definition varchar(200) null,
	task_priority integer,
	task_status integer, 
	task_category integer,
	task_start_date datetime,
	task_deadline datetime,
	task_user_id integer not null,
	created_at timestamp default current_timestamp,
    updated_at timestamp,
    primary key (task_id),
    foreign key (task_priority) references mw_dictionary(dict_id)  on update cascade on delete cascade,
	foreign key (task_status) references mw_dictionary(dict_id)  on update cascade on delete cascade,
    foreign key (task_category) references mw_dictionary(dict_id)  on update cascade on delete cascade,
    foreign key (task_user_id) references mw_user(user_id)  on update cascade on delete cascade
);
-- select * from mw_task;

-- drop table if exists mw_updated_task;
create table if not exists mw_updated_task(
	update_id integer auto_increment,
    task_id integer not null,
    updated_at timestamp default current_timestamp,
    primary key (update_id),
    foreign key (task_id) references mw_task(task_id) on update cascade on delete cascade
); 
-- select * from mw_updated_task;

-- drop table if exists mw_task_result;
create table if not exists mw_task_result(
	res_id integer auto_increment,
	task_id integer not null,
	task_completion_percent float4,
	task_completed_date datetime,
	created_at timestamp,
    primary key (res_id),
    foreign key (task_id) references mw_task(task_id) on update cascade on delete cascade
);
-- select * from mw_task_result

-- drop table if exists mw_project;
create table if not exists mw_project(
	pro_id integer auto_increment,
	pro_title varchar(30),
	pro_owner integer not null,
	pro_completion_percent float4,
	pro_description varchar(120),
	pro_status integer,
	pro_start_date datetime,
	pro_deadline datetime,
	created_at timestamp default current_timestamp,
    primary key (pro_id),
    foreign key (pro_owner) references mw_user(user_id) on update cascade on delete cascade
);
-- select * from mw_project

-- drop table if exists mw_project_member;
create table if not exists mw_project_member(
	pro_mem_id integer auto_increment,
	user_id integer not null,
	pro_id integer not null,
	user_role varchar(10),
	created_at timestamp default current_timestamp,
    primary key (pro_mem_id),
    foreign key (pro_id) references mw_project(pro_id) on update cascade on delete cascade,
	foreign key (user_id) references mw_user(user_id) on update cascade on delete cascade
);
-- select * from mw_project_member

-- drop table if exists mw_project_task;
create table if not exists mw_project_task(
	pro_task_id integer auto_increment,
	pro_id integer not null,
	handler_id integer,
	pro_owner integer not null,
	task_id integer not null,
    task_status integer not null,
	created_at timestamp default current_timestamp,
    primary key (pro_task_id),
    foreign key (pro_id) references mw_project(pro_id) on update cascade on delete cascade,
	foreign key (handler_id) references mw_user(user_id) on update cascade on delete cascade,
	foreign key (pro_owner) references mw_project(pro_owner) on update cascade on delete cascade,
	foreign key (task_id) references mw_task(task_id) on update cascade on delete cascade,
	foreign key (task_status) references mw_dictionary(dict_id) on update cascade on delete cascade
);
-- select * from mw_project_task

-- drop table if exists mw_project_activity;
create table if not exists mw_project_activity(
	pro_act_id integer auto_increment,
	pro_id integer not null,
	handler_id integer,
    pro_act_status integer,
	task_id integer not null,
	pro_act_comment varchar(200),
	created_at timestamp default current_timestamp,
    primary key (pro_act_id),
    foreign key (pro_id) references mw_project(pro_id) on update cascade on delete cascade,
	foreign key (handler_id) references mw_user(user_id) on update cascade on delete cascade,
	foreign key (task_id) references mw_task(task_id) on update cascade on delete cascade,
	foreign key (pro_act_status) references mw_dictionary(dict_id) on update cascade on delete cascade
);
-- select * from mw_project_activity
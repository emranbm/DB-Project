drop database if exists db_project;

create database db_project;
use db_project;

create table insurance(
name varchar(50) primary key);

create table patient(
id int(10) ,
password varchar(30),
name varchar(30) not null,
birthday date,
gender varchar(6) not null,
basic_insurance varchar(50),
secondary_insurance varchar(50),
degree varchar(20),
job varchar(50),
city varchar(20),
history_privilege bool default false,
primary key (id),
foreign key (basic_insurance) references insurance (name),
foreign key (secondary_insurance) references insurance (name)
);

create table illness(
type varchar(50) primary key,
security_level int(1) default 0);

create table doctor(
id int(10) primary key,
name varchar(30) not null,
expertise varchar(50),
is_drugstore_keeper bool not null default false);

create table confidence(
patient_id int(10),
doctor_id int(10),
primary key (patient_id, doctor_id),
foreign key (patient_id) references patient (id),
foreign key (doctor_id) references doctor (id)
);

create table coverage(
illness_type varchar(50),
insurance_name varchar(50),
coverage_percent int(3),
primary key (illness_type, insurance_name),
foreign key (illness_type) references illness (type),
foreign key (insurance_name) references insurance (name)
);

create table history(
id int(10) primary key auto_increment,
patient_id int(10),
doctor_id int(10),
illness_type varchar(50),
visit_date date,
medicine varchar(100),
medicine_purchased bool default false,
doctor_diagnosis text,
patient_description text,
foreign key (patient_id) references patient (id),
foreign key (doctor_id) references doctor (id),
foreign key (illness_type) references illness (type)
);

delimiter //

create procedure get_history()
begin
select id, doctor_id, illness_type, visit_date, medicine, medicine_purchased, doctor_diagnosis, patient_description
from history natural join patient natural join illness
where (history_privilege = 1) or (security_level = 0);
end//

delimiter ;
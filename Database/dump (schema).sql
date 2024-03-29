-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: db_project
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `city_distribution`
--

DROP TABLE IF EXISTS `city_distribution`;
/*!50001 DROP VIEW IF EXISTS `city_distribution`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `city_distribution` (
  `type` tinyint NOT NULL,
  `city` tinyint NOT NULL,
  `percent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `confidence`
--

DROP TABLE IF EXISTS `confidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confidence` (
  `patient_id` varchar(10) NOT NULL DEFAULT '',
  `doctor_id` varchar(10) NOT NULL DEFAULT '',
  `illness_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`patient_id`,`doctor_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `illness_type` (`illness_type`),
  CONSTRAINT `confidence_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `confidence_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `confidence_ibfk_3` FOREIGN KEY (`illness_type`) REFERENCES `illness` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger on_confidence_insert before insert on confidence
for each row
begin

declare user varchar(50);
select user() into user;
set user = substring(user, 1, position('@' IN user)-1);

if (user like "3%") then
	if (exists (select * from confidence where patient_id = user)) then
		call contact_your_doctor_to_add_record();
	elseif (new.patient_id <> user) then
		call you_can_not_add_a_record_for_another_users();
	end if;
elseif (user like "1%") then
		if (new.patient_id not in (select patient_id from confidence where doctor_id = user)) then
			call he_or_she_is_not_your_pateint_or_no_such_pateint();
		end if;
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `on_confidence_update` BEFORE UPDATE ON `confidence` FOR EACH ROW
begin

declare user varchar(50);
select user() into user;
set user = substring(user, 1, position('@' IN user)-1);

if (user like '3%') then
if (old.patient_id <> user or new.patient_id <> user) then
	call you_can_not_update_a_record_of_another_user();
end if;
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `on_confidence_delete` BEFORE DELETE ON `confidence` FOR EACH ROW
begin

declare user varchar(50);
select user() into user;
set user = substring(user, 1, position('@' IN user)-1);

if (user like '3%') then
if (old.patient_id <> user) then
	call you_can_not_delete_a_record_of_another_user();
end if;
end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `coverage`
--

DROP TABLE IF EXISTS `coverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coverage` (
  `illness_type` varchar(50) NOT NULL DEFAULT '',
  `insurance_name` varchar(50) NOT NULL DEFAULT '',
  `coverage_percent` int(3) DEFAULT NULL,
  PRIMARY KEY (`illness_type`,`insurance_name`),
  KEY `insurance_name` (`insurance_name`),
  CONSTRAINT `coverage_ibfk_1` FOREIGN KEY (`illness_type`) REFERENCES `illness` (`type`),
  CONSTRAINT `coverage_ibfk_2` FOREIGN KEY (`insurance_name`) REFERENCES `insurance` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `id` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `expertise` varchar(50) DEFAULT NULL,
  `is_drugstore_keeper` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `gender_distribution`
--

DROP TABLE IF EXISTS `gender_distribution`;
/*!50001 DROP VIEW IF EXISTS `gender_distribution`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `gender_distribution` (
  `type` tinyint NOT NULL,
  `gender` tinyint NOT NULL,
  `percent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(10) DEFAULT NULL,
  `doctor_id` varchar(10) DEFAULT NULL,
  `illness_type` varchar(50) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `medicine` varchar(100) DEFAULT NULL,
  `medicine_purchased` tinyint(1) DEFAULT '0',
  `doctor_diagnosis` text,
  `patient_description` text,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `illness_type` (`illness_type`),
  CONSTRAINT `history_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `history_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `history_ibfk_3` FOREIGN KEY (`illness_type`) REFERENCES `illness` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `on_history_insert` BEFORE INSERT ON `history` FOR EACH ROW
begin
declare user varchar(50);
select user() into user;
set user = substring(user,1,position('@' IN user)-1);
if( user <> 'root' )then
if (new.patient_id not in (select patient_id from confidence where doctor_id = user)) then
	call you_can_only_add_a_prescription_for_your_patient();
end if;
if( new.doctor_id <> user )then
	call you_can_not_add_a_prescription_as_a_another_doctor() ;
end if ;
if( new.illness_type not in (select illness_type from confidence where patient_id = new.patient_id and doctor_id = new.doctor_id ) and not exists (select illness_type from confidence where patient_id = new.patient_id and doctor_id = new.doctor_id and illness_type is null))then
	call no_confidence_on_this_illness() ;
end if ;
end if ;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `on_history_update` BEFORE UPDATE ON `history` FOR EACH ROW
begin
declare user varchar(50);
select user() into user;
set user = substring(user,1,position('@' IN user)-1);
if( user <> 'root') then
if (user like '1%') then
	if (new.patient_id not in (select patient_id from confidence where doctor_id = user)) then
		call you_can_only_update_a_prescription_for_your_patient();
	end if;
	if( new.doctor_id <> user )then
		call you_can_not_update_a_prescription_as_a_another_doctor() ;
	end if ;
	if( new.illness_type not in (select illness_type from confidence where patient_id = new.patient_id and doctor_id = new.doctor_id ) and not exists (select illness_type from confidence where patient_id = new.patient_id and doctor_id = new.doctor_id and illness_type is null))then
		call no_confidence_on_this_illness() ;
	end if ;
elseif (user like '2%') then
	if (new.patient_id <> old.patient_id or new.doctor_id <> old.doctor_id or new.illness_type <> old.illness_type or new.visit_date <> old.visit_date or new.medicine <> old.medicine or new.doctor_diagnosis <> old.doctor_diagnosis or new.patient_description <> old.patient_description) then
		call you_can_not_edit_prescription();
	end if;
end if;
end if ;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `illness`
--

DROP TABLE IF EXISTS `illness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `illness` (
  `type` varchar(50) NOT NULL,
  `security_level` int(1) DEFAULT '0',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `job_distribution`
--

DROP TABLE IF EXISTS `job_distribution`;
/*!50001 DROP VIEW IF EXISTS `job_distribution`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `job_distribution` (
  `type` tinyint NOT NULL,
  `job` tinyint NOT NULL,
  `percent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `my_history`
--

DROP TABLE IF EXISTS `my_history`;
/*!50001 DROP VIEW IF EXISTS `my_history`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `my_history` (
  `id` tinyint NOT NULL,
  `patient_id` tinyint NOT NULL,
  `doctor_id` tinyint NOT NULL,
  `illness_type` tinyint NOT NULL,
  `visit_date` tinyint NOT NULL,
  `medicine` tinyint NOT NULL,
  `medicine_purchased` tinyint NOT NULL,
  `doctor_diagnosis` tinyint NOT NULL,
  `patient_description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `id` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(30) NOT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(6) NOT NULL,
  `basic_insurance` varchar(50) DEFAULT NULL,
  `secondary_insurance` varchar(50) DEFAULT NULL,
  `degree` varchar(20) DEFAULT NULL,
  `job` varchar(50) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `history_privilege` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `basic_insurance` (`basic_insurance`),
  KEY `secondary_insurance` (`secondary_insurance`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`basic_insurance`) REFERENCES `insurance` (`name`),
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`secondary_insurance`) REFERENCES `insurance` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!50001 DROP VIEW IF EXISTS `prescription`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `prescription` (
  `patient_id` tinyint NOT NULL,
  `patient_name` tinyint NOT NULL,
  `birthday` tinyint NOT NULL,
  `gender` tinyint NOT NULL,
  `doctor_id` tinyint NOT NULL,
  `doctor_name` tinyint NOT NULL,
  `expertise` tinyint NOT NULL,
  `illness_type` tinyint NOT NULL,
  `medicine` tinyint NOT NULL,
  `visit_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'db_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_doctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_doctor`(id varchar(9), password varchar(30), name varchar(30), expertise varchar(50))
begin
declare complete_id varchar(10);
set complete_id =  concat("1",id);

if (not exists (select id from doctor as d where d.id = complete_id)) then

insert into doctor values (complete_id, name, expertise, 0);

call grant_doctor_privileges(complete_id, password);

else

call User_exists();

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_drugstore_keeper` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_drugstore_keeper`(id varchar(9), password varchar(30), name varchar(30))
begin
declare complete_id varchar(10);
set complete_id = concat('2', id);

if (not exists (select id from doctor as d where d.id = complete_id)) then

insert into doctor values (complete_id, name, "darusazi", 1);

call grant_drugstore_keeper_privileges(complete_id, password);

else

call User_exists();

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_patient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_patient`(id varchar(9), password varchar(30), name varchar(30), birthday date, gender varchar(6), basic_insurance varchar(50), secondary_insurance varchar(50), degree varchar(20), job varchar(50), city varchar(20), history_privilege bool)
begin
declare complete_id varchar(10);
set complete_id = concat("3", id);

if (not exists (select id from patient as d where d.id = complete_id)) then

insert into patient values (complete_id, name, birthday, gender, basic_insurance, secondary_insurance, degree, job, city, history_privilege);

call grant_patient_privileges(complete_id, password);

else

call User_exists();

end if;

end ;;
DELIMITER ;
/*!50003 DROP PROCEDURE IF EXISTS `add_doctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_doctor`(id varchar(9), password varchar(30), name varchar(30), expertise varchar(50))
begin
declare complete_id varchar(10);
set complete_id =  concat("1",id);

if (not exists (select id from doctor as d where d.id = complete_id)) then

insert into doctor values (complete_id, name, expertise, 0);

call grant_doctor_privileges(complete_id, password);

else

call User_exists();

end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_history_for_scholar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_history_for_scholar`()
begin
select id, doctor_id, illness_type, visit_date, medicine, medicine_purchased, doctor_diagnosis, patient_description
from history natural join patient natural join illness
where (history_privilege = 1) or (security_level = 0);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_patients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patients`()
begin
declare user varchar(50);
select user() into user;
set user = substring(user,1,position('@' IN user)-1);
select * from patient where id in (select patient_id from confidence where doctor_id = user);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grant_doctor_privileges` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `grant_doctor_privileges`(id varchar(10), password varchar(30))
begin
SET @query = CONCAT("create user '", id, "'@localhost identified by '", password, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant all privileges on ', 'db_project.*' , " TO '", id , "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('revoke all privileges on ', 'db_project.*' , " FROM '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant insert, update on ', 'db_project.history' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select, insert on ', 'db_project.confidence' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.doctor' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.my_history' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant execute on procedure ', 'db_project.get_patients' , " TO '", id, "'@localhost");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grant_drugstore_keeper_privileges` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `grant_drugstore_keeper_privileges`(id varchar(10), password varchar(30))
begin

SET @query = CONCAT("create user '", id, "'@localhost identified by '", password, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant all privileges on ', 'db_project.*' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('revoke all privileges on ', 'db_project.*' , " FROM '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.doctor' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.illness' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.prescription' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant update on ', 'db_project.history' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `grant_patient_privileges` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `grant_patient_privileges`(id varchar(10), password varchar(30))
begin
SET @query = CONCAT("create user '", id, "'@localhost identified by '", password, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant all privileges on ', 'db_project.*' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('revoke all privileges on ', 'db_project.*' , " FROM '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant select on ', 'db_project.my_history' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @query = CONCAT('grant insert, update, delete on ', 'db_project.confidence' , " TO '", id, "'");
PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `city_distribution`
--

/*!50001 DROP TABLE IF EXISTS `city_distribution`*/;
/*!50001 DROP VIEW IF EXISTS `city_distribution`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `city_distribution` AS (select `history`.`illness_type` AS `type`,`patient`.`city` AS `city`,((count(0) / (select count(0) from `history` where (`history`.`illness_type` = `history`.`illness_type`))) * 100) AS `percent` from (`patient` join `history` on((`patient`.`id` = `history`.`patient_id`))) group by `history`.`illness_type`,`patient`.`city`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `gender_distribution`
--

/*!50001 DROP TABLE IF EXISTS `gender_distribution`*/;
/*!50001 DROP VIEW IF EXISTS `gender_distribution`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `gender_distribution` AS (select `history`.`illness_type` AS `type`,`patient`.`gender` AS `gender`,((count(0) / (select count(0) from `history` where (`history`.`illness_type` = `history`.`illness_type`))) * 100) AS `percent` from (`patient` join `history` on((`patient`.`id` = `history`.`patient_id`))) group by `history`.`illness_type`,`patient`.`gender`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `job_distribution`
--

/*!50001 DROP TABLE IF EXISTS `job_distribution`*/;
/*!50001 DROP VIEW IF EXISTS `job_distribution`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `job_distribution` AS (select `history`.`illness_type` AS `type`,`patient`.`job` AS `job`,((count(0) / (select count(0) from `history` where (`history`.`illness_type` = `history`.`illness_type`))) * 100) AS `percent` from (`patient` join `history` on((`patient`.`id` = `history`.`patient_id`))) group by `history`.`illness_type`,`patient`.`job`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `my_history`
--

/*!50001 DROP TABLE IF EXISTS `my_history`*/;
/*!50001 DROP VIEW IF EXISTS `my_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `my_history` AS (select `history`.`id` AS `id`,`history`.`patient_id` AS `patient_id`,`history`.`doctor_id` AS `doctor_id`,`history`.`illness_type` AS `illness_type`,`history`.`visit_date` AS `visit_date`,`history`.`medicine` AS `medicine`,`history`.`medicine_purchased` AS `medicine_purchased`,`history`.`doctor_diagnosis` AS `doctor_diagnosis`,`history`.`patient_description` AS `patient_description` from `history` where ((`history`.`patient_id` = convert(substr(user(),1,(locate('@',user()) - 1)) using latin1)) or (`history`.`doctor_id` = convert(substr(user(),1,(locate('@',user()) - 1)) using latin1)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prescription`
--

/*!50001 DROP TABLE IF EXISTS `prescription`*/;
/*!50001 DROP VIEW IF EXISTS `prescription`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prescription` AS (select `h`.`patient_id` AS `patient_id`,`p`.`name` AS `patient_name`,`p`.`birthday` AS `birthday`,`p`.`gender` AS `gender`,`h`.`doctor_id` AS `doctor_id`,`d`.`name` AS `doctor_name`,`d`.`expertise` AS `expertise`,`h`.`illness_type` AS `illness_type`,`h`.`medicine` AS `medicine`,`h`.`visit_date` AS `visit_date` from ((`patient` `p` join `history` `h` on((`p`.`id` = `h`.`id`))) join `doctor` `d` on(((`p`.`id` = `d`.`id`) and (`p`.`name` = `d`.`name`)))) where (`h`.`medicine_purchased` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-24 19:09:23

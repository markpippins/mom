-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mildred
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB-1ubuntu0.14.04.1
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `matcher_field`
--
DROP TABLE IF EXISTS `matcher_field`;
DROP TABLE IF EXISTS `matcher`;
DROP TABLE IF EXISTS `directory`;
DROP TABLE IF EXISTS `directory_amelioration`;
DROP TABLE IF EXISTS `directory_attribute`;
DROP TABLE IF EXISTS `directory_constant`;
DROP TABLE IF EXISTS `document_category`;
DROP TABLE IF EXISTS `path_hierarchy`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;


CREATE TABLE `path_hierarchy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned,
  `path` varchar(256) NOT NULL,
  `index_name` varchar(1024) CHARACTER SET utf8 NOT NULL,
  `hexadecimal_key` varchar(640) DEFAULT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_path_hierarchy` (`index_name`,`hexadecimal_key`),
  KEY `fk_path_hierarchy_parent` (`parent_id`),
  CONSTRAINT `fk_path_hierarchy_parent` FOREIGN KEY (`parent_id`) REFERENCES `path_hierarchy` (`id`)
);

CREATE TRIGGER `path_hierarchy_effective_dt` BEFORE INSERT ON  `path_hierarchy` 
FOR EACH ROW SET NEW.effective_dt = IFNULL(NEW.effective_dt, NOW());

CREATE TABLE `directory` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(1024) CHARACTER SET utf8 NOT NULL,
  `name` varchar(256) NOT NULL,
  `file_type` varchar(8) DEFAULT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);

INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (118,'media','/media/removable/Audio/music/live recordings [wav]','wav','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (119,'media','/media/removable/Audio/music/albums','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (120,'media','/media/removable/Audio/music/albums [ape]','ape','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (121,'media','/media/removable/Audio/music/albums [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (122,'media','/media/removable/Audio/music/albums [iso]','iso','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (123,'media','/media/removable/Audio/music/albums [mpc]','mpc','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (124,'media','/media/removable/Audio/music/albums [ogg]','ogg','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (125,'media','/media/removable/Audio/music/albums [wav]','wav','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (127,'media','/media/removable/Audio/music/compilations','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (128,'media','/media/removable/Audio/music/compilations [aac]','aac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (129,'media','/media/removable/Audio/music/compilations [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (130,'media','/media/removable/Audio/music/compilations [iso]','iso','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (131,'media','/media/removable/Audio/music/compilations [ogg]','ogg','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (132,'media','/media/removable/Audio/music/compilations [wav]','wav','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (134,'media','/media/removable/Audio/music/random compilations','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (135,'media','/media/removable/Audio/music/random tracks','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (136,'media','/media/removable/Audio/music/recently downloaded albums','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (137,'media','/media/removable/Audio/music/recently downloaded albums [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (138,'media','/media/removable/Audio/music/recently downloaded albums [wav]','wav','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (139,'media','/media/removable/Audio/music/recently downloaded compilations','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (140,'media','/media/removable/Audio/music/recently downloaded compilations [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (141,'media','/media/removable/Audio/music/recently downloaded discographies','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (142,'media','/media/removable/Audio/music/recently downloaded discographies [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (144,'media','/media/removable/Audio/music/webcasts and custom mixes','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (145,'media','/media/removable/Audio/music/live recordings','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (146,'media','/media/removable/Audio/music/live recordings [flac]','flac','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (147,'media','/media/removable/Audio/music/temp','*','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (148,'media','/media/removable/SG932/media/music/incoming/complete','*','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (149,'media','/media/removable/SG932/media/music/mp3','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (150,'media','/media/removable/SG932/media/music/shared','*','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (151,'media','/media/removable/SG932/media/radio','*','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (152,'media','/media/removable/Audio/music/incoming','*','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (153,'media','/media/removable/Audio/music [noscan]/albums','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (154,'media','/media/removable/SG932/media/music [iTunes]','mp3','2016-11-16 07:23:58','9999-12-31 23:59:59');
INSERT INTO `directory` (`id`, `index_name`, `name`, `file_type`, `effective_dt`, `expiration_dt`) VALUES (155,'media','/media/removable/SG932/media/spoken word','','2016-11-16 07:23:58','9999-12-31 23:59:59');

CREATE TABLE `directory_amelioration` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `index_name` varchar(1024) CHARACTER SET utf8 NOT NULL,
  `use_tag_flag` tinyint(1) DEFAULT '0',
  `replacement_tag` varchar(32) DEFAULT NULL,
  `use_parent_folder_flag` tinyint(1) DEFAULT '1',
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);

INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (1,'cd1','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (2,'cd2','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (3,'cd3','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (4,'cd4','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (5,'cd5','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (6,'cd6','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (7,'cd7','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (8,'cd8','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (9,'cd9','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (10,'cd10','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (11,'cd11','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (12,'cd12','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (13,'cd13','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (14,'cd14','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (15,'cd15','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (16,'cd16','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (17,'cd17','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (18,'cd18','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (19,'cd19','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (20,'cd20','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (21,'cd21','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (22,'cd22','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (23,'cd23','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (24,'cd24','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (25,'cd01','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (26,'cd02','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (27,'cd03','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (28,'cd04','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (29,'cd05','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (30,'cd06','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (31,'cd07','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (32,'cd08','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (33,'cd09','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (34,'cd-1','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (35,'cd-2','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (36,'cd-3','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (37,'cd-4','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (38,'cd-5','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (39,'cd-6','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (40,'cd-7','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (41,'cd-8','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (42,'cd-9','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (43,'cd-10','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (44,'cd-11','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (45,'cd-12','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (46,'cd-13','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (47,'cd-14','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (48,'cd-15','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (49,'cd-16','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (50,'cd-17','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (51,'cd-18','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (52,'cd-19','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (53,'cd-20','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (54,'cd-21','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (55,'cd-22','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (56,'cd-23','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (57,'cd-24','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (58,'cd-01','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (59,'cd-02','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (60,'cd-03','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (61,'cd-04','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (62,'cd-05','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (63,'cd-06','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (64,'cd-07','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (65,'cd-08','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (66,'cd-09','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (67,'disk 1','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (68,'disk 2','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (69,'disk 3','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (70,'disk 4','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (71,'disk 5','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (72,'disk 6','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (73,'disk 7','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (74,'disk 8','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (75,'disk 9','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (76,'disk 10','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (77,'disk 11','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (78,'disk 12','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (79,'disk 13','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (80,'disk 14','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (81,'disk 15','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (82,'disk 16','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (83,'disk 17','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (84,'disk 18','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (85,'disk 19','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (86,'disk 20','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (87,'disk 21','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (88,'disk 22','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (89,'disk 23','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (90,'disk 24','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (91,'disk 01','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (92,'disk 02','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (93,'disk 03','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (94,'disk 04','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (95,'disk 05','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (96,'disk 06','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (97,'disk 07','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (98,'disk 08','media',0,NULL,1,NULL,'9999-12-31 23:59:59');
INSERT INTO `directory_amelioration` (`id`, `name`, `index_name`, `use_tag_flag`, `replacement_tag`, `use_parent_folder_flag`, `effective_dt`, `expiration_dt`) VALUES (99,'disk 09','media',0,NULL,1,NULL,'9999-12-31 23:59:59');

CREATE TABLE `directory_attribute` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(128) NOT NULL,
  `directory_id` int(11) NOT NULL,
  `attribute_name` varchar(256) NOT NULL,
  `attribute_value` varchar(512) DEFAULT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);

CREATE TABLE `directory_constant` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(1024) CHARACTER SET utf8 NOT NULL,
  `pattern` varchar(256) NOT NULL,
  `location_type` varchar(64) NOT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);

INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (1,'media','/compilations','compilation','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (2,'media','compilations/','compilation','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (3,'media','/various','compilation','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (4,'media','/bak/','ignore','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (5,'media','/webcasts and custom mixes','extended','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (6,'media','/downloading','incomplete','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (7,'media','/live','live_recording','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (8,'media','/slsk/','new','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (9,'media','/incoming/','new','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (10,'media','/random','random','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (11,'media','/recently','recent','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (12,'media','/unsorted','unsorted','2016-11-16 07:36:52','9999-12-31 23:59:59');
INSERT INTO `directory_constant` (`id`, `index_name`, `pattern`, `location_type`, `effective_dt`, `expiration_dt`) VALUES (13,'media','[...]','side_projects','2016-11-16 07:36:52','9999-12-31 23:59:59');

CREATE TABLE `document_category` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(1024) CHARACTER SET utf8 NOT NULL,
  `name` varchar(256) NOT NULL,
  `doc_type` varchar(128) CHARACTER SET utf8 NOT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);


INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (1,'media','dark classical','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (2,'media','funk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (3,'media','mash-ups','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (4,'media','rap','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (5,'media','acid jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (6,'media','afro-beat','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (7,'media','ambi-sonic','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (8,'media','ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (9,'media','ambient noise','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (10,'media','ambient soundscapes','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (11,'media','art punk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (12,'media','art rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (13,'media','avant-garde','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (14,'media','black metal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (15,'media','blues','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (16,'media','chamber goth','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (17,'media','classic rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (18,'media','classical','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (19,'media','classics','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (20,'media','contemporary classical','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (21,'media','country','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (22,'media','dark ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (23,'media','deathrock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (24,'media','deep ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (25,'media','disco','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (26,'media','doom jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (27,'media','drum & bass','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (28,'media','dubstep','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (29,'media','electroclash','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (30,'media','electronic','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (31,'media','electronic [abstract hip-hop, illbient]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (32,'media','electronic [ambient groove]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (33,'media','electronic [armchair techno, emo-glitch]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (34,'media','electronic [minimal]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (35,'media','ethnoambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (36,'media','experimental','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (37,'media','folk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (38,'media','folk-horror','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (39,'media','garage rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (40,'media','goth metal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (41,'media','gothic','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (42,'media','grime','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (43,'media','gun rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (44,'media','hardcore','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (45,'media','hip-hop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (46,'media','hip-hop (old school)','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (47,'media','hip-hop [chopped & screwed]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (48,'media','house','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (49,'media','idm','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (50,'media','incidental','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (51,'media','indie','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (52,'media','industrial','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (53,'media','industrial rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (54,'media','industrial [soundscapes]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (55,'media','jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (56,'media','krautrock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (57,'media','martial ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (58,'media','martial folk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (59,'media','martial industrial','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (60,'media','modern rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (61,'media','neo-folk, neo-classical','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (62,'media','new age','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (63,'media','new soul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (64,'media','new wave, synthpop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (65,'media','noise, powernoise','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (66,'media','oldies','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (67,'media','pop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (68,'media','post-pop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (69,'media','post-rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (70,'media','powernoise','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (71,'media','psychedelic rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (72,'media','punk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (73,'media','punk [american]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (74,'media','rap (chopped & screwed)','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (75,'media','rap (old school)','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (76,'media','reggae','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (77,'media','ritual ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (78,'media','ritual industrial','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (79,'media','rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (80,'media','roots rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (81,'media','russian hip-hop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (82,'media','ska','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (83,'media','soul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (84,'media','soundtracks','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (85,'media','surf rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (86,'media','synthpunk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (87,'media','trip-hop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (88,'media','urban','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (89,'media','visual kei','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (90,'media','world fusion','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (91,'media','world musics','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (92,'media','alternative','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (93,'media','atmospheric','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (94,'media','new wave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (95,'media','noise','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (96,'media','synthpop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (97,'media','unsorted','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (98,'media','coldwave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (99,'media','film music','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (100,'media','garage punk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (101,'media','goth','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (102,'media','mash-up','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (103,'media','minimal techno','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (104,'media','mixed','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (105,'media','nu jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (106,'media','post-punk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (107,'media','psytrance','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (108,'media','ragga soca','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (109,'media','reggaeton','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (110,'media','ritual','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (111,'media','rockabilly','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (112,'media','smooth jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (113,'media','techno','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (114,'media','tributes','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (115,'media','various','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (116,'media','celebrational','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (117,'media','classic ambient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (118,'media','electronic rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (119,'media','electrosoul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (120,'media','fusion','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (121,'media','glitch','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (122,'media','go-go','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (123,'media','hellbilly','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (124,'media','illbient','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (125,'media','industrial [rare]','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (126,'media','jpop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (127,'media','mashup','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (128,'media','minimal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (129,'media','modern soul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (130,'media','neo soul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (131,'media','neo-folk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (132,'media','new beat','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (133,'media','satire','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (134,'media','dark jazz','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (135,'media','classic hip-hop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (136,'media','electronic dance','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (137,'media','minimal house','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (138,'media','minimal wave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (139,'media','afrobeat','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (140,'media','heavy metal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (141,'media','new wave, goth, synthpop, alternative','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (142,'media','ska, reggae','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (143,'media','soul & funk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (144,'media','psychedelia','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (145,'media','americana','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (146,'media','dance','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (147,'media','glam','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (148,'media','gothic & new wave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (149,'media','punk & new wave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (150,'media','random','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (151,'media','rock, metal, pop','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (152,'media','sound track','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (153,'media','soundtrack','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (154,'media','spacerock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (155,'media','tribute','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (156,'media','unclassifiable','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (157,'media','unknown','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (158,'media','weird','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (159,'media','darkwave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (160,'media','experimental-noise','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (161,'media','general alternative','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (162,'media','girl group','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (163,'media','gospel & religious','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (164,'media','alternative & punk','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (165,'media','bass','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (166,'media','beat','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (167,'media','black rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (168,'media','classic','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (169,'media','japanese','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (170,'media','kanine','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (171,'media','metal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (172,'media','moderne','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (173,'media','noise rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (174,'media','other','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (175,'media','post-punk & minimal wave','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (176,'media','progressive rock','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (177,'media','psychic tv','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (178,'media','punk & oi','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (179,'media','radio','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (180,'media','rock\'n\'soul','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (181,'media','spoken word','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (182,'media','temp','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (183,'media','trance','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (184,'media','vocal','directory',NULL,'9999-12-31 23:59:59');
INSERT INTO `document_category` (`id`, `index_name`, `name`, `doc_type`, `effective_dt`, `expiration_dt`) VALUES (185,'media','world','directory',NULL,'9999-12-31 23:59:59');

CREATE TABLE `matcher` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `query_type` varchar(64) NOT NULL,
  `max_score_percentage` float NOT NULL DEFAULT '0',
  `applies_to_file_type` varchar(6) CHARACTER SET utf8 NOT NULL DEFAULT '*',
  `active_flag` tinyint(1) NOT NULL DEFAULT '0',
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`)
);

INSERT INTO `matcher` (`id`, `index_name`, `name`, `query_type`, `max_score_percentage`, `active_flag`, `applies_to_file_type`) VALUES (1,'media','filename_match_matcher','match',75,1,'*');
INSERT INTO `matcher` (`id`, `index_name`, `name`, `query_type`, `max_score_percentage`, `active_flag`, `applies_to_file_type`) VALUES (2,'media','tag_term_matcher_artist_album_song','term',0,0,'*');
INSERT INTO `matcher` (`id`, `index_name`, `name`, `query_type`, `max_score_percentage`, `active_flag`, `applies_to_file_type`) VALUES (3,'media','filesize_term_matcher','term',0,0,'flac');
INSERT INTO `matcher` (`id`, `index_name`, `name`, `query_type`, `max_score_percentage`, `active_flag`, `applies_to_file_type`) VALUES (4,'media','artist_matcher','term',0,0,'*');
INSERT INTO `matcher` (`id`, `index_name`, `name`, `query_type`, `max_score_percentage`, `active_flag`, `applies_to_file_type`) VALUES (5,'media','match_artist_album_song','match',75,1,'*');

CREATE TABLE `matcher_field` (
  `id` int(11) unsigned NOT NULL,
  `index_name` varchar(128) NOT NULL,
  `document_type` varchar(64) NOT NULL DEFAULT 'media_file',
  `matcher_id` int(11) unsigned NOT NULL,
  `field_name` varchar(128) NOT NULL,
  `boost` float NOT NULL DEFAULT '0',
  `bool` varchar(16) DEFAULT NULL,
  `operator` varchar(16) DEFAULT NULL,
  `minimum_should_match` float NOT NULL DEFAULT '0',
  `analyzer` varchar(64) DEFAULT NULL,
  `query_section` varchar(128) CHARACTER SET utf8 DEFAULT 'should',
  `default_value` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `effective_dt` datetime DEFAULT NULL,
  `expiration_dt` datetime DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`id`),
  KEY `fk_matcher_field_matcher` (`matcher_id`),
  CONSTRAINT `fk_matcher_field_matcher` FOREIGN KEY (`matcher_id`) REFERENCES `matcher` (`id`)
);

INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (1,'media','media_file','TPE1',5,NULL,NULL,0,NULL,'should',NULL,2);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (2,'media','media_file','TIT2',7,NULL,NULL,0,NULL,'should',NULL,2);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (3,'media','media_file','TALB',3,NULL,NULL,0,NULL,'should',NULL,2);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (4,'media','media_file','file_name',0,NULL,NULL,0,NULL,'should',NULL,1);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (5,'media','media_file','deleted',0,NULL,NULL,0,NULL,'should',NULL,2);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (6,'media','media_file','file_size',3,NULL,NULL,0,NULL,'should',NULL,3);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (7,'media','media_file','TPE1',3,NULL,NULL,0,NULL,'should',NULL,4);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (8,'media','media_file','TPE1',0,NULL,NULL,0,NULL,'must',NULL,5);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (9,'media','media_file','TIT2',5,NULL,NULL,0,NULL,'should',NULL,5);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (10,'media','media_file','TALB',0,NULL,NULL,0,NULL,'should',NULL,5);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (11,'media','media_file','deleted',0,NULL,NULL,0,NULL,'must_not','true',5);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (12,'media','media_file','TRCK',0,NULL,NULL,0,NULL,'should','',5);
INSERT INTO `matcher_field` (`id`, `index_name`, `document_type`, `field_name`, `boost`, `bool`, `operator`, `minimum_should_match`, `analyzer`, `query_section`, `default_value`, `matcher_id`) VALUES (13,'media','media_file','TPE2',0,NULL,NULL,0,NULL,'','should',5);

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

/*!40101 SET character_set_client = @saved_cs_client */;


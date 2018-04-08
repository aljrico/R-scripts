# Data Analysis at Social Point - Test

/* ##### CREATE TABLES ###### */

use sp_test;

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
	`user` varchar(30) NOT NULL,
	`date` datetime,
	`session_id` varchar(30) NOT NULL,
	`platform` varchar(30) NOT NULL,
	`country` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `transaction`;

CREATE TABLE `transaction` (
	`user` varchar(30) NOT NULL,
	`date` datetime,
	`dollar_net` varchar(30) NOT NULL,
	`session_id` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOAD DATA INFILE 'data/file.csv'
INTO TALBE table_name;

######## NUMBER OF ACTIVE USERS SPLITTED BY COUNTRY & DAY

SELECT country, DATE(date), count(distinct(user))
FROM session
GROUP BY country, user, DATE(date);

############################################################

######### DARPPU (daily average revenue per payer) by day

SELECT DATE(date), AVG(dollar_net)
FROM transaction
GROUP BY DATE(date);

###################################################################

######## DARPU (daily average revenues per active user) by day

# Work in Progress...







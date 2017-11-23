# Data Analysis at Social Point - Test


# Number of active users (users with one or more sessions) splitted by country & day

/* ##### CREATE TABLES ###### */

use sp_test;

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
	`user` varchar(30) NOT NULL,
	`date` smalldatetime,
	`session_id` varchar(30) NOT NULL,
	`platform` varchar(30) NOT NULL,
	`country` varchar(30) NOT NULL,
	PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `session` WRITE:

INSERT INTO `session` values('1234678245064', '2015-02-01 13:00:00', '1001', 'ios', 'ES'),('23487948795876', '2015-02-01 13:05:00', '1042', 'ios', 'US'), ('23487948795876', '2015-02-01 18:05:00', '1043', 'ios', 'US'), ('23487298574875', '2015-02-01 13:06:00', '1003', 'ios', 'AU')

UNLOCK TABLES;




######## NUMBER OF ACTIVE USERS SPLITTED BY COUNTRY & DAY

SELECT Country, CONVERT(`Date and time`, getdate()), count(*)
FROM Session_Table
GROUP BY Country, User_id;

############################################################

######### DARPPU (daily average revenue per payer) by day

SELECT User_id, CONVERT(`Date and time`, getdate()), AVG(dollar_net)
FROM Transaction_Table
GROUP BY User_id;

###################################################################

######## DARPU (daily average revenues per active user) by day

SELECT




SELECT Country, count(*)
FROM
(
SELECT CASE WHEN SUM(exptId = 1) > 0 THEN 'ES'
WHEN SUM(exptId = 2) > 0 THEN 'US'
WHEN SUM(exptId = 3) > 0 THEN 'AU'
ELSE 'Other'
END AS exptId
FROM Data
GROUP BY affyId
)
statuses GROUP BY exptId;

SELECT *
(
SELECT exptId, count(*) AS 'num'
FROM Data
GROUP BY affyId
)
GROUP BY exptId
;

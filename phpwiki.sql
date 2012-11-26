-- $Id: mysql-initialize.sql 7117 2009-09-15 08:02:20Z rurban $

CREATE TABLE page (
	id              INT NOT NULL AUTO_INCREMENT,
-- for mysql => 4.1 define the charset here
-- this is esp. needed for mysql 4.1.0 up to 4.1.6. 
-- not yet confirmed, at least since 4.1.8 it's okay with binary.
--      pagename        VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
-- otherwise use the old syntax to do case-sensitive comparison
        pagename        VARCHAR(100) BINARY NOT NULL,
	hits            INT NOT NULL DEFAULT 0,
        pagedata        MEDIUMTEXT NOT NULL DEFAULT '',
-- dont add that by hand, better let action=upgrade convert your data
	cached_html 	MEDIUMBLOB,
        PRIMARY KEY (id),
	UNIQUE KEY (pagename)
);

CREATE TABLE version (
	id              INT NOT NULL,
        version         INT NOT NULL,
	mtime           INT NOT NULL,
	minor_edit      TINYINT DEFAULT 0,
        content         MEDIUMTEXT NOT NULL DEFAULT '',
        versiondata     MEDIUMTEXT NOT NULL DEFAULT '',
        PRIMARY KEY (id,version),
	INDEX (mtime)
);

CREATE TABLE recent (
	id              INT NOT NULL,
	latestversion   INT,
	latestmajor     INT,
	latestminor     INT,
        PRIMARY KEY (id)
);

CREATE TABLE nonempty (
	id              INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE link (
	linkfrom        INT NOT NULL,
        linkto          INT NOT NULL,
        relation        INT DEFAULT 0,
	INDEX (linkfrom),
        INDEX (linkto),
        INDEX (relation)
);

CREATE TABLE session (
    	sess_id 	CHAR(32) NOT NULL DEFAULT '',
    	sess_data 	BLOB NOT NULL,
    	sess_date 	INT UNSIGNED NOT NULL,
    	sess_ip 	CHAR(40) NOT NULL,
    	PRIMARY KEY (sess_id),
	INDEX (sess_date)
);

-- upgrade to 1.3.8: (see lib/upgrade.php)
-- ALTER TABLE session ADD sess_ip CHAR(15) NOT NULL;
-- CREATE INDEX sess_date on session (sess_date);
-- update to 1.3.10: (see lib/upgrade.php)
-- ALTER TABLE page CHANGE id id INT NOT NULL AUTO_INCREMENT;
-- update to 1.3.11: (see lib/upgrade.php)
-- ALTER TABLE page ADD cached_html MEDIUMBLOB;
-- ALTER TABLE session CHANGE sess_ip sess_ip CHAR(40) NOT NULL;

-- Optional DB Auth and Prefs
-- For these tables below the default table prefix must be used 
-- in the DBAuthParam SQL statements also.

CREATE TABLE pref (
  	userid 	VARCHAR(48) BINARY NOT NULL UNIQUE,
  	prefs  	TEXT NULL DEFAULT '',
  	passwd 	VARCHAR(48) BINARY DEFAULT '',
	groupname VARCHAR(48) BINARY DEFAULT 'users',
  	PRIMARY KEY (userid)
);

-- update to 1.3.12: (see lib/upgrade.php)

-- ALTER TABLE pref ADD passwd 	CHAR(48) BINARY DEFAULT '';
-- ALTER TABLE pref ADD groupname CHAR(48) BINARY DEFAULT 'users';

-- deprecated since 1.3.12. only useful for seperate databases.
-- better use the extra pref table where such users can be created easily 
-- without password.

-- CREATE TABLE user (
--  	userid 	CHAR(48) BINARY NOT NULL UNIQUE,
--  	passwd 	CHAR(48) BINARY DEFAULT '',
--	prefs  	TEXT NULL DEFAULT '',
--	groupname CHAR(48) BINARY DEFAULT 'users',
--  	PRIMARY KEY (userid)
-- );

-- Use the member table, if you need it for n:m user-group relations,
-- and adjust your DBAUTH_AUTH_ SQL statements.

CREATE TABLE member (
	userid    CHAR(48) BINARY NOT NULL,
   	groupname CHAR(48) BINARY NOT NULL DEFAULT 'users',
   	INDEX (userid),
   	INDEX (groupname)
);

-- only if you plan to use the wikilens theme
CREATE TABLE rating (
        dimension INT(4) NOT NULL,
        raterpage INT(11) NOT NULL,
        rateepage INT(11) NOT NULL,
        ratingvalue FLOAT NOT NULL,
        rateeversion INT(11) NOT NULL,
        tstamp TIMESTAMP,
-- before:
--      tstamp TIMESTAMP(14) NOT NULL,
-- since mysql 5.1 better use:
--      tstamp TIMESTAMP DEFAULT 0,
        PRIMARY KEY (dimension, raterpage, rateepage)
);
-- for empty dimensions use extra indices. see lib/wikilens/RatingsDb.php
CREATE INDEX rating_dimension ON rating (dimension);
CREATE INDEX rating_raterpage ON rating (raterpage);
CREATE INDEX rating_rateepage ON rating (rateepage);

-- if ACCESS_LOG_SQL > 0
-- only if you need fast log-analysis (spam prevention, recent referrers)
-- see http://www.outoforder.cc/projects/apache/mod_log_sql/docs-2.0/#id2756178
CREATE TABLE accesslog (
        time_stamp    INT UNSIGNED,
	remote_host   VARCHAR(100),
	remote_user   VARCHAR(50),
        request_method VARCHAR(10),
	request_line  VARCHAR(255),
	request_args  VARCHAR(255),
	request_file  VARCHAR(255),
	request_uri   VARCHAR(255),
	request_time  CHAR(28),
	status 	      SMALLINT UNSIGNED,
	bytes_sent    SMALLINT UNSIGNED,
        referer       VARCHAR(255), 
	agent         VARCHAR(255),
	request_duration FLOAT
);
CREATE INDEX log_time ON accesslog (time_stamp);
CREATE INDEX log_host ON accesslog (remote_host);
-- create extra indices on demand (usually referer. see plugin/AccessLogSql)

-- upgrade to 1.3.13: ( forgotten in lib/upgrade.php! )
-- ALTER TABLE accesslog CHANGE remote_host VARCHAR(100);

-- ALTER TABLE link ADD relation INT DEFAULT 0;
-- CREATE INDEX link_relation ON link (relation);

/*
SQLyog Community Edition- MySQL GUI v7.02 
MySQL - 5.0.51b-community-nt : Database - classicmodels
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`classicmodels` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `classicmodels`;

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customerNumber` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) default NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) default NULL,
  `postalCode` varchar(15) default NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int(11) default NULL,
  `creditLimit` double default NULL,
  PRIMARY KEY  (`customerNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `customers` */


/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) default NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY  (`employeeNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `employees` */


/*Table structure for table `offices` */

DROP TABLE IF EXISTS `offices`;

CREATE TABLE `offices` (
  `officeCode` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) default NULL,
  `state` varchar(50) default NULL,
  `country` varchar(50) NOT NULL,
  `postalCode` varchar(15) NOT NULL,
  `territory` varchar(10) NOT NULL,
  PRIMARY KEY  (`officeCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `offices` */


/*Table structure for table `orderdetails` */

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `orderNumber` int(11) NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int(11) NOT NULL,
  `priceEach` double NOT NULL,
  `orderLineNumber` smallint(6) NOT NULL,
  PRIMARY KEY  (`orderNumber`,`productCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `orderdetails` */


/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `orderNumber` int(11) NOT NULL,
  `orderDate` datetime NOT NULL,
  `requiredDate` datetime NOT NULL,
  `shippedDate` datetime default NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `customerNumber` int(11) NOT NULL,
  PRIMARY KEY  (`orderNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `orders` */


/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `customerNumber` int(11) NOT NULL,
  `checkNumber` varchar(50) NOT NULL,
  `paymentDate` datetime NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY  (`customerNumber`,`checkNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `payments` */


/*Table structure for table `productlines` */

DROP TABLE IF EXISTS `productlines`;

CREATE TABLE `productlines` (
  `productLine` varchar(50) NOT NULL,
  `textDescription` varchar(4000) default NULL,
  `htmlDescription` mediumtext,
  `image` mediumblob,
  PRIMARY KEY  (`productLine`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `productlines` */


/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` double NOT NULL,
  `MSRP` double NOT NULL,
  PRIMARY KEY  (`productCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `products` */


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

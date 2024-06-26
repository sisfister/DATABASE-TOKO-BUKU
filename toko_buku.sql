/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.28-MariaDB : Database - toko_buku
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`toko_buku` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `toko_buku`;

/*Table structure for table `buku` */

DROP TABLE IF EXISTS `buku`;

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(100) NOT NULL,
  `penulis` varchar(100) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`id_buku`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `buku` */

LOCK TABLES `buku` WRITE;

insert  into `buku`(`id_buku`,`judul`,`penulis`,`harga`,`stok`) values 
(1,'Harry Potter','J.K. Rowling',150000.00,50),
(2,'Pemrograman Python','John Doe',200000.00,30);

UNLOCK TABLES;

/*Table structure for table `detail_pesanan` */

DROP TABLE IF EXISTS `detail_pesanan`;

CREATE TABLE `detail_pesanan` (
  `id_detail` int(11) NOT NULL AUTO_INCREMENT,
  `id_pesanan` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `id_pesanan` (`id_pesanan`),
  KEY `id_buku` (`id_buku`),
  CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`),
  CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detail_pesanan` */

LOCK TABLES `detail_pesanan` WRITE;

insert  into `detail_pesanan`(`id_detail`,`id_pesanan`,`id_buku`,`jumlah`,`harga`) values 
(1,1,1,2,300000.00),
(2,2,2,1,150000.00);

UNLOCK TABLES;

/*Table structure for table `pesanan` */

DROP TABLE IF EXISTS `pesanan`;

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `status` enum('pending','diproses','selesai') NOT NULL,
  PRIMARY KEY (`id_pesanan`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pesanan` */

LOCK TABLES `pesanan` WRITE;

insert  into `pesanan`(`id_pesanan`,`tanggal`,`total_harga`,`status`) values 
(1,'2024-06-01',300000.00,'selesai'),
(2,'2024-06-02',150000.00,'pending');

UNLOCK TABLES;

/* Trigger structure for table `detail_pesanan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `after_insert_pesanan` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `after_insert_pesanan` AFTER INSERT ON `detail_pesanan` FOR EACH ROW 
BEGIN
    UPDATE buku
    SET stok = stok - NEW.jumlah
    WHERE id_buku = NEW.id_buku;
END */$$


DELIMITER ;

/*Table structure for table `total_penjualan_harian` */

DROP TABLE IF EXISTS `total_penjualan_harian`;

/*!50001 DROP VIEW IF EXISTS `total_penjualan_harian` */;
/*!50001 DROP TABLE IF EXISTS `total_penjualan_harian` */;

/*!50001 CREATE TABLE  `total_penjualan_harian`(
 `tanggal` date ,
 `total_penjualan` decimal(32,2) 
)*/;

/*View structure for view total_penjualan_harian */

/*!50001 DROP TABLE IF EXISTS `total_penjualan_harian` */;
/*!50001 DROP VIEW IF EXISTS `total_penjualan_harian` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total_penjualan_harian` AS select `pesanan`.`tanggal` AS `tanggal`,sum(`pesanan`.`total_harga`) AS `total_penjualan` from `pesanan` where `pesanan`.`status` = 'selesai' group by `pesanan`.`tanggal` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

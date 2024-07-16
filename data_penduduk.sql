-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2024 at 07:15 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data_penduduk`
--

-- --------------------------------------------------------

--
-- Table structure for table `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id` int(11) NOT NULL,
  `nama_kecamatan` varchar(50) NOT NULL,
  `status_kecamatan` tinyint(1) NOT NULL DEFAULT 1,
  `fk_kota_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kecamatan`
--

INSERT INTO `kecamatan` (`id`, `nama_kecamatan`, `status_kecamatan`, `fk_kota_id`) VALUES
(4, 'Blimbing', 1, 1),
(5, 'Argomulyo', 1, 2),
(6, 'Margadana', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `kota`
--

CREATE TABLE `kota` (
  `id` int(11) NOT NULL,
  `nama_kota` varchar(50) NOT NULL,
  `status_kota` tinyint(1) NOT NULL DEFAULT 1,
  `fk_provinsi_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kota`
--

INSERT INTO `kota` (`id`, `nama_kota`, `status_kota`, `fk_provinsi_id`) VALUES
(1, 'Malang', 1, 1),
(2, 'Salatiga', 1, 2),
(3, 'Tegal', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `provinsi`
--

CREATE TABLE `provinsi` (
  `id` int(11) NOT NULL,
  `nama_provinsi` varchar(50) NOT NULL,
  `status_provinsi` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `provinsi`
--

INSERT INTO `provinsi` (`id`, `nama_provinsi`, `status_provinsi`) VALUES
(1, 'Jawa Timur', 1),
(2, 'Jawa Tengah', 1),
(3, 'Jawa Barat', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipeuser`
--

CREATE TABLE `tipeuser` (
  `id` int(11) NOT NULL,
  `nama_tipeuser` varchar(50) NOT NULL,
  `status_tipeuser` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipeuser`
--

INSERT INTO `tipeuser` (`id`, `nama_tipeuser`, `status_tipeuser`) VALUES
(1, 'Super Admin', 1),
(2, 'Admin', 1),
(3, 'Guest', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `status_user` tinyint(4) NOT NULL DEFAULT 1,
  `fk_tipeuser_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `status_user`, `fk_tipeuser_id`) VALUES
(3, 'ahnaf@gmail.com', '$2y$10$5IxrPLOpc6ArGHzmZwHzJeFAhFTiY0GAPQ9WtUFbjUZ', 1, 1),
(4, 'who@gmail.com', '$2y$10$zEVWLrefWzW4FKfG6TQAW.963rkVqfyYd5EXqCzzKLH', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `userprofile`
--

CREATE TABLE `userprofile` (
  `id` int(11) NOT NULL,
  `name_userprofile` varchar(255) NOT NULL,
  `alamat_userprofile` varchar(255) NOT NULL,
  `status_userprofile` tinyint(1) NOT NULL DEFAULT 1,
  `fk_provinsi_id` int(11) NOT NULL,
  `fk_kota_id` int(11) NOT NULL,
  `fk_kecamatan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userprofile`
--

INSERT INTO `userprofile` (`id`, `name_userprofile`, `alamat_userprofile`, `status_userprofile`, `fk_provinsi_id`, `fk_kota_id`, `fk_kecamatan_id`) VALUES
(1, 'ahnaf', '', 1, 1, 1, 4),
(2, 'ahnaf', '', 1, 1, 1, 4),
(3, 'ahnaf tsaqif', '', 1, 1, 1, 4),
(4, 'who is your name', '', 1, 1, 1, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_kota_id` (`fk_kota_id`);

--
-- Indexes for table `kota`
--
ALTER TABLE `kota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_provinsi_id` (`fk_provinsi_id`);

--
-- Indexes for table `provinsi`
--
ALTER TABLE `provinsi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipeuser`
--
ALTER TABLE `tipeuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_tipeuser_id` (`fk_tipeuser_id`);

--
-- Indexes for table `userprofile`
--
ALTER TABLE `userprofile`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kecamatan`
--
ALTER TABLE `kecamatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kota`
--
ALTER TABLE `kota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `provinsi`
--
ALTER TABLE `provinsi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipeuser`
--
ALTER TABLE `tipeuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `userprofile`
--
ALTER TABLE `userprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD CONSTRAINT `fk_kota_id` FOREIGN KEY (`fk_kota_id`) REFERENCES `kota` (`id`);

--
-- Constraints for table `kota`
--
ALTER TABLE `kota`
  ADD CONSTRAINT `fk_provinsi_id` FOREIGN KEY (`fk_provinsi_id`) REFERENCES `provinsi` (`id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_tipeuser_id` FOREIGN KEY (`fk_tipeuser_id`) REFERENCES `tipeuser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

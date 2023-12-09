-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2023 at 06:09 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vegan_cakes`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `Id` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `Address_Line1` varchar(100) NOT NULL,
  `Address_Line2` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `PostalCode` int(10) NOT NULL,
  `Country` varchar(20) NOT NULL,
  `Telephone` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`Id`, `User`, `Address_Line1`, `Address_Line2`, `City`, `PostalCode`, `Country`, `Telephone`, `CreatedDate`, `ModifiedDate`) VALUES
(2, 7, 'test', 'test', 'Himmatnagar one', 383001, 'India', 1234567890, '2023-11-19 12:07:11', '2023-11-19 12:07:11');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `Id` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `Product` int(11) NOT NULL,
  `QTY` int(5) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`Id`, `User`, `Product`, `QTY`, `CreatedDate`, `ModifiedDate`) VALUES
(14, 7, 23, 1, '2023-11-26 18:17:46', '2023-11-26 18:17:46'),
(15, 7, 32, 1, '2023-11-30 22:31:13', '2023-11-30 22:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Path` varchar(255) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`Id`, `Name`, `Path`, `CreatedDate`, `ModifiedDate`) VALUES
(10, 'Butterscotch', '207.png', '2023-11-26 18:02:17', '2023-11-26 18:02:17'),
(11, 'Danish-Pastries', '206.png', '2023-11-30 22:16:34', '2023-11-30 22:16:34'),
(12, 'Chocolate-Cakes', '202.png', '2023-11-30 22:16:51', '2023-11-30 22:16:51'),
(13, 'Croissants', '205.png', '2023-11-30 22:17:23', '2023-11-30 22:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Id` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `Total` int(10) NOT NULL,
  `Payment Id` varchar(50) NOT NULL,
  `Status` enum('Pending','Deliverd','','') NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `Id` int(11) NOT NULL,
  `Order` int(11) NOT NULL,
  `Product` int(11) NOT NULL,
  `QTY` int(5) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`Id`, `Order`, `Product`, `QTY`, `CreatedDate`, `ModifiedDate`) VALUES
(1, 2, 22, 3, '2023-11-19 13:00:21', '2023-11-19 13:00:21'),
(2, 2, 29, 2, '2023-11-19 13:00:21', '2023-11-19 13:00:21'),
(3, 3, 22, 1, '2023-11-19 13:24:04', '2023-11-19 13:24:04'),
(4, 4, 22, 4, '2023-11-20 16:07:57', '2023-11-20 16:07:57'),
(5, 5, 22, 2, '2023-11-21 20:30:13', '2023-11-21 20:30:13'),
(6, 5, 29, 3, '2023-11-21 20:30:13', '2023-11-21 20:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Id` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Description` varchar(300) NOT NULL,
  `Category` int(11) NOT NULL,
  `Price` int(10) NOT NULL,
  `Path` varchar(255) NOT NULL,
  `Stock` int(10) NOT NULL,
  `Active` tinyint(1) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Name`, `Description`, `Category`, `Price`, `Path`, `Stock`, `Active`, `CreatedDate`, `ModifiedDate`) VALUES
(23, 'Chocolate Chips', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ', 8, 550, '202.png', 5, 1, '2023-11-18 20:54:07', '2023-11-18'),
(24, 'Caramel Pastry 3pcs', '100gb each', 6, 350, '203.png', 35, 1, '2023-11-18 20:55:25', '2023-11-18'),
(26, 'Pineapple Pastry 2pcs', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 6, 250, '207.png', 50, 1, '2023-11-18 20:58:36', '2023-11-18'),
(27, 'Butterscotch', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 7, 450, '204.png', 50, 1, '2023-11-18 20:59:36', '2023-11-18'),
(28, 'Orange', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 9, 500, '203.png', 10, 1, '2023-11-18 21:00:16', '2023-11-18'),
(29, 'Kiwi', '500gb', 9, 500, '207.png', 2, 1, '2023-11-18 21:01:02', '2023-11-18'),
(30, 'Test', 'Testest', 6, 150, '101.jpg', 100, 1, '2023-11-26 17:01:20', '2023-11-26'),
(31, 'Chocolate-Cakes', '2pc', 12, 150, '103.jpeg', 100, 1, '2023-11-30 22:17:56', '2023-11-30'),
(32, 'Pineapple Pastry 2pcs', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 11, 480, '207.png', 100, 1, '2023-11-30 22:18:14', '2023-11-30'),
(33, 'Eggless Cake', '500gbLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 10, 500, '205.png', 1000, 1, '2023-11-30 22:18:37', '2023-11-30'),
(34, 'Caramel Pastry 3pcs', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 13, 120, '204.png', 100, 1, '2023-11-30 22:19:12', '2023-11-30'),
(35, 'Cakes', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 10, 220, '101.jpg', 20, 1, '2023-11-30 22:19:29', '2023-11-30'),
(36, 'Kiwi', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', 11, 150, '207.png', 100, 1, '2023-11-30 22:20:15', '2023-11-30');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Id` int(11) NOT NULL,
  `Firstname` varchar(50) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Mobile` varchar(11) NOT NULL,
  `Type` enum('Admin','Staff','Customer','') NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `ModifiedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `Firstname`, `Lastname`, `Email`, `Password`, `Mobile`, `Type`, `CreatedDate`, `ModifiedDate`) VALUES
(7, 'Ravi', 'Panchal', 'ravi@gmail.com', 'ravi', '1234567890', 'Customer', '2023-11-18 13:21:11', '2023-11-18 13:21:11'),
(8, 'Admin', 'A', 'admin@gmail.com', 'admin', '1234567890', 'Admin', '2023-11-18 13:21:57', '2023-11-18 13:21:57'),
(9, 'Staff', '101', 'staff101@gmail.com', 'staff101', '1234567890', 'Staff', '2023-11-18 13:23:21', '2023-11-18 13:23:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

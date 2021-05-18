-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 18, 2021 at 10:12 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coding`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `Name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_no` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `Name`, `email`, `phone_no`, `message`, `date`) VALUES
(22, 'Ayush purohit', 'aayupurohit151@gmail.com', '9058609750', 'Hello this is ayush purohit', '2021-05-14 13:13:49'),
(23, 'Renu Lotani', 'renulotani@gmail.com', '9756908745', 'Hello, This is Renu Lotani.', '2021-05-14 13:14:19'),
(24, 'ayush', 'ayush.purohit.56829', '1233444', 'Hello this is my first flask app...', '2021-05-14 15:30:59'),
(25, 'Renu Lotani', 'renulotani@gmail.com', '9756908745', 'Hello, This is Renu Lotani.', '2021-05-14 15:39:45'),
(26, 'Ayush purohit', 'aayupurohit151@gmail.com', '323443', 'dd', '2021-05-15 12:28:21'),
(27, 'Ayush purohit', 'aayupurohit151@gmail.com', '323443', 'dd', '2021-05-15 12:29:49'),
(28, 'Coding bot', 'ayushpurohit750@gmail.com', '9058609750', 'dd', '2021-05-15 12:31:21'),
(29, 'Ayush purohit', 'aayupurohit151@gmail.com', '323443', 'dd', '2021-05-15 12:33:03'),
(30, 'Ayush purohit', 'ayushpurohit750@gmail.com', '9058609750', 'dd', '2021-05-15 12:52:42'),
(31, 'Ayush purohit', 'aayupurohit151@gmail.com', '9058609750', 'Hello this is my number contact me', '2021-05-15 13:27:48'),
(32, 'Coding bot', 'ayush.purohit.56829', '1233444', 'sfsafd', '2021-05-16 15:07:40');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'All you need to know about Stocks.', 'This is edited post', 'first_post', 'Stock (also capital stock) is all of the shares into which ownership of a corporation is divided.[1] In American English, the shares are collectively known as \"stock\".[1] A single share of the stock represents fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the stockholder to that fraction of the company\'s earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt),[2] or voting power, often dividing these up in proportion to the amount of money each stockholder has invested. Not all stock is necessarily equal, as certain classes of stock may be issued for example without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.\"', 'post-bg.jpg', '2021-05-16 15:33:03'),
(3, 'This is second post', 'Best post ever', 'second_post', 'Note that, in Python, else blocks are executed whenever the corresponding loop did not break. Since Jinja loops cannot break anyway, a slightly different behavior of the else keyword was chosen.\r\n\r\nIt is also possible to use loops recursively. This is useful if you are dealing with recursive data such as sitemaps or RDFa. To use loops recursively, you basically have to add the recursive modifier to the loop definition and call the loop variable with the new iterable where you want to recurse.', 'about-bg.jpg', '2021-05-01 13:39:45'),
(4, 'Third post', 'best tagline', 'third_post', 'The loop variable always refers to the closest (innermost) loop. If we have more than one level of loops, we can rebind the variable loop by writing {% set outer_loop = loop %} after the loop that we want to use recursively. Then, we can call it using {{ outer_loop(…) }}', 'about-bg.jpg', '2021-05-11 13:40:06'),
(5, 'fourth post', 'best tag', 'fourth_post', 'The loop variable always refers to the closest (innermost) loop. If we have more than one level of loops, we can rebind the variable loop by writing {% set outer_loop = loop %} after the loop that we want to use recursively. Then, we can call it using {{ outer_loop(…) }}', 'about-bg.jpg', '2021-05-04 13:40:06'),
(10, 'Web app using flask', 'web app', 'web_app', 'so i finally made a web app using flask', 'about-bg.jpg', '2021-05-16 17:06:59'),
(11, 'Web app using flask', 'web app', 'web_app', 'I have made a blog website using flask', 'about-bg.jpg', '2021-05-16 17:26:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

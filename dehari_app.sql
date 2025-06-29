-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2025 at 12:54 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dehari_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `booked_services`
--

CREATE TABLE `booked_services` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `service_provider_id` int(11) NOT NULL,
  `service_provider_name` varchar(100) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booked_services`
--

INSERT INTO `booked_services` (`id`, `user_id`, `user_name`, `service_provider_id`, `service_provider_name`, `service_name`, `price`, `booking_date`) VALUES
(2, 0, 'abdul', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-09 14:12:38'),
(3, 0, 'abdul', 8, 'Usman Ghani', 'Carpenter', '500.00', '2025-06-09 14:13:18'),
(4, 0, 'abdul', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-09 14:17:09'),
(5, 3, 'abdul', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-09 14:25:54'),
(6, 3, 'abdul', 8, 'Usman Ghani', 'Carpenter', '500.00', '2025-06-09 14:40:20'),
(7, 3, 'abdul', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-10 08:19:46'),
(8, 3, 'abdul', 8, 'Usman Ghani', 'Carpenter', '500.00', '2025-06-10 08:55:47'),
(9, 3, 'abdul', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-10 09:01:18'),
(10, 3, 'Abdul Rehman', 6, 'Ali Raza', 'Electrician', '500.00', '2025-06-10 16:11:52'),
(11, 3, 'Abdul Rehman', 43, 'Junaid Shah', 'Plumber', '500.00', '2025-06-10 23:30:57'),
(12, 3, 'Abdul Rehman', 61, 'Faraz Qureshi', 'Welder', '500.00', '2025-06-10 23:37:52'),
(13, 3, 'Abdul Rehman', 10, 'Mohsin Javed', 'Roofer', '500.00', '2025-06-11 00:10:44'),
(14, 3, 'Abdul Rehman', 122, 'Waqas Ahmed', 'Tile Setter', '500.00', '2025-06-11 00:10:51'),
(15, 3, 'Abdul Rehman', 49, 'Noman Siddiqui', 'Electrician', '500.00', '2025-06-11 04:50:47'),
(16, 3, 'Abdul Rehman', 7, 'Ahmed Khan', 'Plumber', '500.00', '2025-06-11 04:53:03'),
(17, 3, 'Abdul Rehman', 14, 'Umar Khan', 'Carpenter', '500.00', '2025-06-11 07:21:06'),
(18, 3, 'Abdul Rehman', 36, 'Bilal Ahmed', 'Carpenter', '500.00', '2025-06-11 07:33:20'),
(19, 3, 'Abdul Rehman', 87, 'Junaid Khan', 'Mechanic', '500.00', '2025-06-11 07:34:08');

-- --------------------------------------------------------

--
-- Table structure for table `service_providers`
--

CREATE TABLE `service_providers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `service_type` varchar(50) DEFAULT NULL,
  `experience_years` int(11) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reviews` text DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service_providers`
--

INSERT INTO `service_providers` (`id`, `user_id`, `full_name`, `email`, `password`, `contact_number`, `address`, `city`, `state`, `postal_code`, `country`, `service_type`, `experience_years`, `skills`, `profile_picture`, `description`, `created_at`, `updated_at`, `reviews`, `rating`) VALUES
(21, 6, 'Ali Raza', 'ali.raza@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03001234567', 'Nazimabad Block 4', 'Karachi', 'Sindh', '74600', 'Pakistan', 'Electrician', 6, 'Wiring, Solar panels, Circuit breakers', '/dehari/resources/image/electrician.png', 'Expert electrician with over 5 years of experience in residential and commercial projects.', '2025-06-06 14:41:46', '2025-06-10 23:10:25', 'Reliable and professional. Highly recommended!', '4.60'),
(22, 7, 'Ahmed Khan', 'ahmed.khan@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03022334455', 'Gulshan-e-Iqbal Block 10', 'Karachi', 'Sindh', '75300', 'Pakistan', 'Plumber', 3, 'Leak fixing, Pipe installation, Sanitary fittings', '/dehari/resources/image/plumber.png', 'Affordable plumber available 24/7 for emergency and scheduled work.', '2025-06-06 14:41:46', '2025-06-10 23:05:53', 'Fixed my kitchen sink quickly. Great service.', '4.30'),
(23, 8, 'Usman Ghani', 'usman.ghani@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03112223344', 'Defence Phase 5', 'Karachi', 'Sindh', '75500', 'Pakistan', 'Carpenter', 6, 'Furniture making, Wardrobe installation, Wood finishing', '/dehari/resources/image/carpenter.png', 'High-quality custom woodwork tailored to your needs.', '2025-06-06 14:41:46', '2025-06-10 23:12:20', 'Made a beautiful dining table for us.', '4.70'),
(25, 10, 'Mohsin Javed', 'mohsin.javed@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03044556677', 'PECHS Block 2', 'Karachi', 'Sindh', '75400', 'Pakistan', 'Roofer', 4, 'Roof repairs, Leak sealing, Waterproofing', '/dehari/resources/image/roofer.png', 'Reliable roofer with quick and effective service.', '2025-06-06 14:41:46', '2025-06-10 23:15:26', 'Fixed my leaking roof perfectly.', '4.40'),
(27, 12, 'Bilal Hussain', 'bilal.hussain@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03066778899', 'North Nazimabad Block 3', 'Karachi', 'Sindh', '74700', 'Pakistan', 'Electrician', 6, 'Home wiring, Panel upgrades, Lighting installation', '/dehari/resources/image/electrician.png', 'Skilled electrician with attention to safety and detail.', '2025-06-06 14:41:46', '2025-06-10 23:11:16', 'Quick and efficient electrician.', '4.60'),
(29, 14, 'Umar Khan', 'umar.khan@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03088990011', 'Malir Cantt', 'Karachi', 'Sindh', '75100', 'Pakistan', 'Carpenter', 5, 'Door installation, Window frames, Cabinet making', '/dehari/resources/image/carpenter.png', 'Dedicated carpenter with excellent craftsmanship.', '2025-06-06 14:41:46', '2025-06-10 23:12:25', 'Strong, well-built furniture.', '4.50'),
(31, 16, 'Hassan Nawaz', 'hassan.nawaz@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03010111213', 'Saddar', 'Karachi', 'Sindh', '74000', 'Pakistan', 'Roofer', 3, 'Roof maintenance, Leak repairs', '/dehari/resources/image/roofer.png', 'Trusted roofer with affordable prices.', '2025-06-06 14:41:46', '2025-06-10 23:15:23', 'Good quality roof repair.', '4.30'),
(33, 18, 'Jawad Ali', 'jawad.ali@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03015161718', 'Korangi', 'Karachi', 'Sindh', '74920', 'Pakistan', 'Electrician', 6, 'Lighting, Wiring, Repairs', '/dehari/resources/image/electrician.png', 'Reliable electrician with professional approach.', '2025-06-06 14:41:46', '2025-06-10 23:11:29', 'Handled electrical work expertly.', '4.60'),
(35, 20, 'Farhan Ahmed', 'farhan.ahmed@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03022232425', 'North Karachi', 'Karachi', 'Sindh', '74750', 'Pakistan', 'Carpenter', 5, 'Furniture repair, Custom carpentry', '/dehari/resources/image/carpenter.png', 'Experienced carpenter delivering quality work.', '2025-06-06 14:41:46', '2025-06-10 23:12:29', 'Very satisfied with the furniture made.', '4.50'),
(37, 22, 'Saeed Shaikh', 'saeed.shaikh@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03028293031', 'Malir', 'Karachi', 'Sindh', '75110', 'Pakistan', 'Roofer', 4, 'Roof inspection, Leak sealing', '/dehari/resources/image/roofer.png', 'Experienced roofer with attention to detail.', '2025-06-06 14:41:46', '2025-06-10 23:15:18', 'Reliable roof repair.', '4.40'),
(38, 23, 'Noor Aziz', 'noor.aziz@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03132333435', 'Gulshan-e-Hadeed', 'Karachi', 'Sindh', '75360', 'Pakistan', 'Mechanic', 7, 'Car repair, Engine diagnostics', '/dehari/resources/image/mechanic.png', 'Skilled mechanic for all car models.', '2025-06-06 14:41:46', '2025-06-10 23:16:40', 'Great mechanic, honest service.', '4.60'),
(39, 24, 'Rashid Ali', 'rashid.ali@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '03036373839', 'Gulberg Town', 'Karachi', 'Sindh', '75420', 'Pakistan', 'Electrician', 5, 'Residential wiring, Lighting installation', '/dehari/resources/image/electrician.png', 'Dependable electrician with good reviews.', '2025-06-06 14:41:46', '2025-06-10 23:11:35', 'Professional and timely.', '4.50'),
(52, 27, 'Ahmed Raza', 'ahmed.raza@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03001234567', 'House No 24, Street 8', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Carpenter', 7, 'Wood cutting, Furniture fitting, Door installation', '/dehari/resources/image/carpenter.png', 'Experienced in home furniture and wood work.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.60'),
(53, 28, 'Usman Khalid', 'usman.khalid@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03121234567', 'Block C, Gulshan', 'Karachi', 'Sindh', '75300', 'Pakistan', 'Carpenter', 10, 'Cabinet making, Polishing, Repairs', '/dehari/resources/image/carpenter.png', 'Over 10 years of field experience.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.80'),
(54, 29, 'Fahad Ali', 'fahad.ali@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03211234567', 'Street 11, Sector G', 'Islamabad', 'Capital Territory', '44000', 'Pakistan', 'Carpenter', 5, 'Frame assembling, Carpenter tools expert', '/dehari/resources/image/carpenter.png', 'Detail-oriented carpenter.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.40'),
(55, 30, 'Imran Shafiq', 'imran.shafiq@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03451234567', 'Township Block 5', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Carpenter', 8, 'Home renovation, Wooden flooring', '/dehari/resources/image/carpenter.png', 'Specialist in wooden interiors.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.90'),
(56, 31, 'Noman Javed', 'noman.javed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03091234567', 'New Karachi', 'Karachi', 'Sindh', '75850', 'Pakistan', 'Carpenter', 3, 'Minor repairs, Furniture fitting', '/dehari/resources/image/carpenter.png', 'Reliable and affordable carpenter.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.10'),
(57, 32, 'Waqas Zafar', 'waqas.zafar@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03331234567', 'Near Saddar Market', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Carpenter', 12, 'Expert joiner, Custom furniture', '/dehari/resources/image/carpenter.png', '12 years of professional carpentry work.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '5.00'),
(58, 33, 'Hassan Qureshi', 'hassan.qureshi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03421234567', 'Sector 15, Korangi', 'Karachi', 'Sindh', '74900', 'Pakistan', 'Carpenter', 6, 'Wardrobe fixing, Table repair', '/dehari/resources/image/carpenter.png', 'Quick and quality service.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.30'),
(59, 34, 'Tariq Mehmood', 'tariq.mehmood@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03061234567', 'Opposite Mall Road', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Carpenter', 15, 'Custom designs, Office furniture', '/dehari/resources/image/carpenter.png', 'Master carpenter with 15 years of service.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.70'),
(60, 35, 'Zeeshan Arif', 'zeeshan.arif@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03151234567', 'Street 4, Cantt Area', 'Multan', 'Punjab', '60000', 'Pakistan', 'Carpenter', 4, 'General carpentry, Polishing', '/dehari/resources/image/carpenter.png', 'Dedicated and passionate worker.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.20'),
(61, 36, 'Bilal Ahmed', 'bilal.ahmed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03501234567', 'Model Town', 'Gujranwala', 'Punjab', '52250', 'Pakistan', 'Carpenter', 9, 'Furniture assembling, Wooden partitioning', '/dehari/resources/image/carpenter.png', 'Hardworking and experienced carpenter.', '2025-06-10 23:26:25', '2025-06-10 23:26:25', NULL, '4.50'),
(62, 37, 'Ahsan Iqbal', 'ahsan.plumber@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03011234560', 'Model Town, Lahore', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Plumber', 5, 'Pipe installation, Leak repair, Bathroom fittings', '/dehari/resources/image/plumber.png', 'Experienced plumber with 5 years in residential plumbing.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(63, 38, 'Bilal Khan', 'bilal.khan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03021234561', 'North Karachi', 'Karachi', 'Sindh', '75850', 'Pakistan', 'Plumber', 4, 'Kitchen plumbing, Sanitary maintenance', '/dehari/resources/image/plumber.png', 'Skilled plumber offering reliable services.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(64, 39, 'Danish Ahmed', 'danish.ahmed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03031234562', 'Gulshan-e-Iqbal, Karachi', 'Karachi', 'Sindh', '75300', 'Pakistan', 'Plumber', 6, 'PVC piping, Water tank installation', '/dehari/resources/image/plumber.png', 'Dedicated to solving all your plumbing needs.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(65, 40, 'Faisal Raza', 'faisal.raza@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03041234563', 'Sector G-10, Islamabad', 'Islamabad', 'Capital', '44000', 'Pakistan', 'Plumber', 7, 'New construction plumbing, Pipe replacement', '/dehari/resources/image/plumber.png', 'Efficient and detail-oriented plumber.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(66, 41, 'Hassan Javed', 'hassan.javed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03051234564', 'Satellite Town, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Plumber', 3, 'Drain cleaning, Valve repair', '/dehari/resources/image/plumber.png', 'Quick response and quality work guaranteed.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(67, 42, 'Irfan Qureshi', 'irfan.qureshi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03061234565', 'Peoples Colony, Faisalabad', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Plumber', 4, 'Shower installation, Pipe insulation', '/dehari/resources/image/plumber.png', 'Trusted by hundreds for home plumbing jobs.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(68, 43, 'Junaid Shah', 'junaid.shah@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03071234566', 'Cantt Area, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Plumber', 5, 'Old pipe replacement, Basement waterproofing', '/dehari/resources/image/plumber.png', 'Strong reputation in emergency plumbing.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(69, 44, 'Kamran Mehmood', 'kamran.mehmood@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03081234567', 'Wapda Town, Multan', 'Multan', 'Punjab', '60000', 'Pakistan', 'Plumber', 6, 'Kitchen fitting, High-pressure pipes', '/dehari/resources/image/plumber.png', 'Clean, safe, and affordable plumbing services.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(70, 45, 'Nabeel Abbasi', 'nabeel.abbasi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03091234568', 'Civil Lines, Hyderabad', 'Hyderabad', 'Sindh', '71000', 'Pakistan', 'Plumber', 2, 'Tap fixing, Water heater repair', '/dehari/resources/image/plumber.png', 'Young and passionate plumber, great with tools.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(71, 46, 'Sajid Butt', 'sajid.butt@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03101234569', 'Main Bazar, Sialkot', 'Sialkot', 'Punjab', '51310', 'Pakistan', 'Plumber', 5, 'Toilet installation, Pipe soldering', '/dehari/resources/image/plumber.png', 'Reliable plumbing service for homes and offices.', '2025-06-10 23:30:19', '2025-06-10 23:30:19', NULL, NULL),
(72, 47, 'Usman Farooq', 'usman.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234510', 'Gulistan-e-Johar, Karachi', 'Karachi', 'Sindh', '75290', 'Pakistan', 'Electrician', 5, 'Wiring, Load Management, Circuit Testing', '/dehari/resources/image/electrician.png', 'Reliable and experienced electrician.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(73, 48, 'Zahid Mehmood', 'zahid.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234511', 'Township, Lahore', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Electrician', 4, 'Home Wiring, Circuit Breakers', '/dehari/resources/image/electrician.png', 'Skilled in residential installations.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(74, 49, 'Noman Siddiqui', 'noman.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234512', 'Blue Area, Islamabad', 'Islamabad', 'Islamabad', '44000', 'Pakistan', 'Electrician', 6, 'Power Distribution, Panel Wiring', '/dehari/resources/image/electrician.png', 'Certified technician with years of experience.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(75, 50, 'Sohail Ahmed', 'sohail.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234513', 'Peoples Colony, Faisalabad', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Electrician', 3, 'Sockets, Switches, Voltage Testing', '/dehari/resources/image/electrician.png', 'Offering affordable services with quality.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(76, 51, 'Atif Iqbal', 'atif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234514', 'Cantt, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Electrician', 7, 'Power Backup, Load Calculation', '/dehari/resources/image/electrician.png', 'Professional electrician for all needs.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(77, 52, 'Junaid Rasheed', 'junaid.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234515', 'Latifabad, Hyderabad', 'Hyderabad', 'Sindh', '71000', 'Pakistan', 'Electrician', 5, 'Fan Repair, Appliance Connections', '/dehari/resources/image/electrician.png', 'Trusted by local clients.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(78, 53, 'Kashif Ali', 'kashif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234516', 'Samungli Road, Quetta', 'Quetta', 'Balochistan', '87300', 'Pakistan', 'Electrician', 6, 'CCTV, Power Points', '/dehari/resources/image/electrician.png', 'Neat and clean work guaranteed.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(79, 54, 'Asif Shah', 'asif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234517', 'University Road, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Electrician', 4, 'Meter Installation, Wiring Repair', '/dehari/resources/image/electrician.png', 'Quick response and service.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(80, 55, 'Waqar Hussain', 'waqar.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234518', 'Model Town, Sialkot', 'Sialkot', 'Punjab', '51310', 'Pakistan', 'Electrician', 3, 'UPS, Stabilizer Setup', '/dehari/resources/image/electrician.png', 'Your local solution for electrical issues.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(81, 56, 'Fahad Raza', 'fahad.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111234519', 'New Multan Colony, Multan', 'Multan', 'Punjab', '60000', 'Pakistan', 'Electrician', 5, 'Short Circuit Fix, Fuse Installation', '/dehari/resources/image/electrician.png', 'Serving with dedication and skill.', '2025-06-10 23:33:33', '2025-06-10 23:33:33', NULL, NULL),
(82, 57, 'Usman Khan', 'usman.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345010', 'Korangi, Karachi', 'Karachi', 'Sindh', '74900', 'Pakistan', 'Welder', 5, 'Welding, Iron Works, Steel Fabrication', '/dehari/resources/image/welder.png', 'Experienced in metal welding and fabrication.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(83, 58, 'Kamran Yousuf', 'kamran.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345011', 'Ferozepur Road, Lahore', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Welder', 4, 'Pipe Welding, MIG, TIG', '/dehari/resources/image/welder.png', 'Skilled in welding pipes and metal structures.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(84, 59, 'Mansoor Ali', 'mansoor.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345012', 'G-9, Islamabad', 'Islamabad', 'Capital Territory', '44000', 'Pakistan', 'Welder', 6, 'TIG Welding, Metal Art', '/dehari/resources/image/welder.png', 'Specialist in TIG and artistic welding.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(85, 60, 'Nadeem Bhatti', 'nadeem.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345013', 'Samnabad, Faisalabad', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Welder', 3, 'Arc Welding, Gate Welding', '/dehari/resources/image/welder.png', 'Reliable welder for residential and commercial projects.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(86, 61, 'Faraz Qureshi', 'faraz.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345014', 'Saddar, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Welder', 5, 'Grills, Metal Doors, Cutting', '/dehari/resources/image/welder.png', 'Expert in steel structures and repair.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(87, 62, 'Irfan Malik', 'irfan.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345015', 'Qasimabad, Hyderabad', 'Hyderabad', 'Sindh', '71000', 'Pakistan', 'Welder', 7, 'Structural Welding, Inverter Welding', '/dehari/resources/image/welder.png', 'Certified welder for industrial jobs.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(88, 63, 'Tariq Mehmood', 'tariq.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345016', 'Jinnah Road, Quetta', 'Quetta', 'Balochistan', '87300', 'Pakistan', 'Welder', 4, 'Arc Welding, Heavy Welding', '/dehari/resources/image/welder.png', 'Capable of handling large metal structures.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(89, 64, 'Sami Ullah', 'sami.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345017', 'Hayatabad, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Welder', 6, 'MIG, TIG, Gas Welding', '/dehari/resources/image/welder.png', 'Technically sound and detail-oriented welder.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(90, 65, 'Basit Raza', 'basit.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345018', 'Daska Road, Sialkot', 'Sialkot', 'Punjab', '51310', 'Pakistan', 'Welder', 3, 'MIG Welding, Fence Fabrication', '/dehari/resources/image/welder.png', 'Efficient in small-to-medium fabrication work.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(91, 66, 'Rizwan Haider', 'rizwan.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111345019', 'Bosan Road, Multan', 'Multan', 'Punjab', '60000', 'Pakistan', 'Welder', 5, 'Roof Welding, Tank Welding', '/dehari/resources/image/welder.png', 'Versatile welder with solid reputation.', '2025-06-10 23:36:55', '2025-06-10 23:36:55', NULL, NULL),
(92, 67, 'Atif Bashir', 'atif.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444001', 'Nazimabad, Karachi', 'Karachi', 'Sindh', '75300', 'Pakistan', 'Roofer', 5, 'Roof installation, Water proofing, Roof repair', '/dehari/resources/image/roofer.png', 'Experienced roofer with expertise in waterproofing and structural repair.', '2025-06-10 23:40:44', '2025-06-10 23:42:45', NULL, NULL),
(93, 68, 'Waqar Javed', 'waqar.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444002', 'Township, Lahore', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Roofer', 6, 'Shingle roofing, Maintenance, Tiling', '/dehari/resources/image/roofer.png', 'Providing durable and long-lasting roofing services.', '2025-06-10 23:40:44', '2025-06-10 23:42:48', NULL, NULL),
(94, 69, 'Ahsan Raza', 'ahsan.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444003', 'F-10, Islamabad', 'Islamabad', 'Capital Territory', '44000', 'Pakistan', 'Roofer', 4, 'Steel roofing, Installation, Repairing', '/dehari/resources/image/roofer.png', 'Affordable and efficient roofing specialist.', '2025-06-10 23:40:44', '2025-06-10 23:42:51', NULL, NULL),
(95, 70, 'Rashid Anwar', 'rashid.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444004', 'Peoples Colony, Faisalabad', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Roofer', 8, 'Concrete roofs, Repairs, Restoration', '/dehari/resources/image/roofer.png', '8 years of hands-on roofing experience.', '2025-06-10 23:40:44', '2025-06-10 23:42:54', NULL, NULL),
(96, 71, 'Zubair Akhtar', 'zubair.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444005', 'Satellite Town, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Roofer', 7, 'Roof framing, Installation, Finishing', '/dehari/resources/image/roofer.png', 'Detailed-oriented roofer ensuring long-term performance.', '2025-06-10 23:40:44', '2025-06-10 23:42:59', NULL, NULL),
(97, 72, 'Imran Latif', 'imran.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444006', 'Latifabad, Hyderabad', 'Hyderabad', 'Sindh', '71000', 'Pakistan', 'Roofer', 6, 'Roof tiles, Bitumen sealing', '/dehari/resources/image/roofer.png', 'Serving Hyderabad rooftops for over 6 years.', '2025-06-10 23:40:44', '2025-06-10 23:43:02', NULL, NULL),
(98, 73, 'Zahid Iqbal', 'zahid.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444007', 'Sariab Road, Quetta', 'Quetta', 'Balochistan', '87300', 'Pakistan', 'Roofer', 5, 'Brick roofing, Leakage fixing', '/dehari/resources/image/roofer.png', 'Specialist in rural and urban roofing needs.', '2025-06-10 23:40:44', '2025-06-10 23:43:04', NULL, NULL),
(99, 74, 'Faisal Nazir', 'faisal.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444008', 'University Road, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Roofer', 6, 'Sheet roofing, Gutter management', '/dehari/resources/image/roofer.png', 'Reliable roofer for homes and businesses.', '2025-06-10 23:40:44', '2025-06-10 23:43:07', NULL, NULL),
(100, 75, 'Saqlain Shah', 'saqlain.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444009', 'Cantt, Sialkot', 'Sialkot', 'Punjab', '51310', 'Pakistan', 'Roofer', 3, 'Tiling, Layering, Sealant use', '/dehari/resources/image/roofer.png', 'Specializing in small-scale and residential roofing.', '2025-06-10 23:40:44', '2025-06-10 23:43:12', NULL, NULL),
(101, 76, 'Asif Nawaz', 'asif.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03111444010', 'Mumtazabad, Multan', 'Multan', 'Punjab', '60000', 'Pakistan', 'Roofer', 7, 'All-weather roofing, Roof insulation', '/dehari/resources/image/roofer.png', 'Professional roofing services for all seasons.', '2025-06-10 23:40:44', '2025-06-10 23:43:14', NULL, NULL),
(102, 87, 'Junaid Khan', 'junaid.khan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0301-2345678', 'Liaquatabad, Karachi', 'Karachi', 'Sindh', '75900', 'Pakistan', 'Mechanic', 5, 'Engine Repair, Brake Service', '/dehari/resources/image/mechanic.png', 'Experienced mechanic with 5 years of hands-on vehicle repair.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(103, 88, 'Ali Haider', 'ali.haider@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0321-8765432', 'Saddar, Karachi', 'Karachi', 'Sindh', '75500', 'Pakistan', 'Mechanic', 4, 'Oil Change, Battery Replacement', '/dehari/resources/image/mechanic.png', 'Skilled in quick diagnostics and battery replacement.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(104, 89, 'Usman Ghani', 'usman.ghani@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0332-1122334', 'Faisal Town, Lahore', 'Lahore', 'Punjab', '54600', 'Pakistan', 'Mechanic', 6, 'AC Repair, Suspension Work', '/dehari/resources/image/mechanic.png', 'Specialist in AC systems and suspension repair.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(105, 90, 'Asad Abbas', 'asad.abbas@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0302-5566778', 'Johar Town, Lahore', 'Lahore', 'Punjab', '54782', 'Pakistan', 'Mechanic', 3, 'Tyre Fitting, Alignment', '/dehari/resources/image/mechanic.png', 'Efficient and reliable service for tyres and wheel alignment.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(106, 91, 'Zeeshan Ali', 'zeeshan.ali@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0345-7788990', 'Pindi Road, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Mechanic', 7, 'Engine Overhaul, Clutch Repair', '/dehari/resources/image/mechanic.png', 'Over 7 years of experience in complex engine jobs.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(107, 92, 'Noman Shah', 'noman.shah@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0311-2233445', 'Kohati Gate, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Mechanic', 5, 'Starter Motor Repair, Radiator Issues', '/dehari/resources/image/mechanic.png', 'Trusted by locals for engine startup and cooling fixes.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(108, 93, 'Atif Hussain', 'atif.hussain@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0303-9988776', 'Nazimabad, Karachi', 'Karachi', 'Sindh', '74600', 'Pakistan', 'Mechanic', 2, 'Carburetor Tuning, Basic Repairs', '/dehari/resources/image/mechanic.png', 'Young but skilled in fuel systems and tuning.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(109, 94, 'Sajid Bashir', 'sajid.bashir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0340-6677885', 'Gulberg, Lahore', 'Lahore', 'Punjab', '54660', 'Pakistan', 'Mechanic', 6, 'Electrical Work, Wiring Fixes', '/dehari/resources/image/mechanic.png', 'Handles all auto-electrical systems with care.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(110, 95, 'Farhan Qadir', 'farhan.qadir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0312-3344556', 'Cantt, Multan', 'Multan', 'Punjab', '60000', 'Pakistan', 'Mechanic', 4, 'Brake Service, Belt Changes', '/dehari/resources/image/mechanic.png', 'Brake and belt expert with 4 years of shop work.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(111, 96, 'Bilal Nazir', 'bilal.nazir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0333-4455667', 'Satellite Town, Quetta', 'Quetta', 'Balochistan', '87300', 'Pakistan', 'Mechanic', 5, 'General Maintenance, Oil Filter', '/dehari/resources/image/mechanic.png', 'Reliable general maintenance with attention to detail.', '2025-06-10 23:54:56', '2025-06-10 23:54:56', NULL, NULL),
(112, 107, 'Rashid Glazier', 'glazier.rashid@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0302-1122334', 'Korangi, Karachi', 'Karachi', 'Sindh', '75190', 'Pakistan', 'Glazier', 5, 'Glass cutting, Frame installation, Window glazing', '/dehari/resources/image/glazier.png', 'Experienced glazier available for home and office projects.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(113, 108, 'Nadeem Glazier', 'glazier.nadeem@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0341-5566778', 'Gulshan, Karachi', 'Karachi', 'Sindh', '75300', 'Pakistan', 'Glazier', 6, 'Tempered glass fitting, Shower enclosures, Custom mirrors', '/dehari/resources/image/glazier.png', 'Reliable and professional glazier with years of experience.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(114, 109, 'Fahad Glazier', 'glazier.fahad@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0315-4433221', 'Model Town, Lahore', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Glazier', 4, 'Window installation, Safety glass, Mirror design', '/dehari/resources/image/glazier.png', 'Quality glass solutions for residential and commercial needs.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(115, 110, 'Waqar Glazier', 'glazier.waqar@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0333-9988776', 'Cantt, Lahore', 'Lahore', 'Punjab', '54810', 'Pakistan', 'Glazier', 7, 'Glass partitions, Doors fitting, Caulking', '/dehari/resources/image/glazier.png', 'Committed to precision and customer satisfaction.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(116, 111, 'Saad Glazier', 'glazier.saad@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0321-6655443', 'Satellite Town, Rawalpindi', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Glazier', 3, 'Window tinting, Sealant work, Custom shapes', '/dehari/resources/image/glazier.png', 'Skilled glazier offering fast and affordable services.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(117, 112, 'Ahsan Glazier', 'glazier.ahsan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0340-8899007', 'Allama Iqbal Town, Lahore', 'Lahore', 'Punjab', '54570', 'Pakistan', 'Glazier', 5, 'Glass repairs, Shopfront glazing, Putty work', '/dehari/resources/image/glazier.png', 'Delivering clean and precise glass solutions.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(118, 113, 'Kamran Glazier', 'glazier.kamran@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0309-2233557', 'Saddar, Peshawar', 'Peshawar', 'KPK', '25000', 'Pakistan', 'Glazier', 8, 'Custom doors, Facade glass, Polishing', '/dehari/resources/image/glazier.png', 'Expert in glasswork for buildings and homes.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(119, 114, 'Bilal Glazier', 'glazier.bilal@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0300-4445566', 'Sargodha Road, Faisalabad', 'Faisalabad', 'Punjab', '38000', 'Pakistan', 'Glazier', 6, 'Safety glass, Design cuts, Installation services', '/dehari/resources/image/glazier.png', 'Trusted glazier with a focus on safety and aesthetics.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(120, 115, 'Usman Glazier', 'glazier.usman@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0312-3344556', 'Gulberg, Lahore', 'Lahore', 'Punjab', '54660', 'Pakistan', 'Glazier', 4, 'Double glazing, Glass balcony, Etching', '/dehari/resources/image/glazier.png', 'Creative solutions for decorative and utility glass.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(121, 116, 'Arif Glazier', 'glazier.arif@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '0342-1112233', 'I.I Chundrigar Road, Karachi', 'Karachi', 'Sindh', '74000', 'Pakistan', 'Glazier', 9, 'Storefronts, Skylight repair, Glass paneling', '/dehari/resources/image/glazier.png', 'Providing reliable glazier services in your area.', '2025-06-11 00:03:44', '2025-06-11 00:03:44', NULL, NULL),
(122, 117, 'Imran Shah', 'imranshah117@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03011234567', 'Street 12, Sector B', 'Karachi', 'Sindh', '75010', 'Pakistan', 'Tile Setter', 5, 'Floor tiling, Wall tiling, Grouting', '/dehari/resources/image/tilesetter.png', 'Skilled tile setter with 5 years of experience in commercial and residential projects.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(123, 118, 'Asad Mehmood', 'asad.mehmood118@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03121234568', 'House 45, Block C', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Tile Setter', 3, 'Ceramic tiles, Marble cutting, Leveling', '/dehari/resources/image/tilesetter.png', 'Reliable tile setter focused on precision and detail.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(124, 119, 'Shahbaz Ali', 'shahbaz.ali119@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03231234569', 'Plot 9, Gulberg Town', 'Islamabad', 'ICT', '44000', 'Pakistan', 'Tile Setter', 6, 'Wall & floor tiling, Polish finishing', '/dehari/resources/image/tilesetter.png', 'Experienced in custom designs and tile renovations.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(125, 120, 'Rashid Khan', 'rashid.khan120@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03341234560', 'Street 4, Johar Town', 'Lahore', 'Punjab', '54000', 'Pakistan', 'Tile Setter', 4, 'Mosaic tiles, Concrete surface prep', '/dehari/resources/image/tilesetter.png', 'Detail-oriented and committed to perfection.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(126, 121, 'Adnan Javed', 'adnan.javed121@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03451234561', 'Flat 3A, PECHS', 'Karachi', 'Sindh', '75010', 'Pakistan', 'Tile Setter', 2, 'Small repair jobs, Tile cutting', '/dehari/resources/image/tilesetter.png', 'Affordable and quick tile fixing services.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(127, 122, 'Waqas Ahmed', 'waqas.ahmed122@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03011234562', 'Bungalow 23, DHA Phase 2', 'Karachi', 'Sindh', '75500', 'Pakistan', 'Tile Setter', 7, 'Marble, Granite, Layout planning', '/dehari/resources/image/tilesetter.png', 'Professional tile setter for high-end homes.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(128, 123, 'Kashif Raza', 'kashif.raza123@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03121234563', 'House 11, Model Town', 'Multan', 'Punjab', '60000', 'Pakistan', 'Tile Setter', 4, 'Tile installation, Waterproofing', '/dehari/resources/image/tilesetter.png', 'Dedicated to clean and strong tile work.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(129, 124, 'Faisal Zubair', 'faisal.zubair124@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03231234564', 'Shop 8, Furniture Market', 'Rawalpindi', 'Punjab', '46000', 'Pakistan', 'Tile Setter', 5, 'Porcelain, Outdoor tiling', '/dehari/resources/image/tilesetter.png', 'Works with contractors and home owners.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(130, 125, 'Ali Nawaz', 'ali.nawaz125@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03341234565', 'Area 7, Korangi', 'Karachi', 'Sindh', '75190', 'Pakistan', 'Tile Setter', 6, 'Stair tiles, Skirting', '/dehari/resources/image/tilesetter.png', 'Available for urgent or weekend work.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL),
(131, 126, 'Zeeshan Malik', 'zeeshan.malik126@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', '03451234566', 'Plot 100, Satellite Town', 'Quetta', 'Balochistan', '87300', 'Pakistan', 'Tile Setter', 3, 'Demolition, Clean installation', '/dehari/resources/image/tilesetter.png', 'Trusted locally with positive feedback.', '2025-06-11 00:09:09', '2025-06-11 00:09:09', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `admin` text NOT NULL,
  `usertype` enum('admin','user','provider') NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','inactive','banned') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `address`, `profile_picture`, `admin`, `usertype`, `created_at`, `updated_at`, `status`) VALUES
(1, 'AbdulRehman', 'rehmanabdul1445@gmail.com', '7729727efe4ea07963c8bf8976a4ba6225110c9811c28f9181d6ff8114e9b69b', 'abdul rehman', '03157550272', 'karachi', NULL, 'yes', 'admin', '2025-06-10 14:05:13', '2025-06-10 21:44:33', 'active'),
(2, 'AbdulRehman', 'rehmanabdull1445@gmail.com', '30e21c6058852f42e9e2464b3cfeaeac8a1785118bc19afb28b494e45432145b', NULL, NULL, NULL, NULL, 'no', '', '2025-06-10 14:05:13', '2025-06-10 14:05:13', 'active'),
(3, 'abdul', 'hello@gmail.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Abdul Rehman', '03406886905', 'Gulistan Society, Karachi', 'resource/image/1749549662740_2nd.PNG', 'yes', 'admin', '2025-06-10 14:05:13', '2025-06-11 12:35:10', 'active'),
(5, 'admin', 'admin@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'yes', 'user', '2025-06-10 14:05:13', '2025-06-10 14:05:13', 'active'),
(6, 'ali.raza', 'ali.raza@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:05:54', 'active'),
(7, 'ahmed.khan', 'ahmed.khan@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(8, 'usman.ghani', 'usman.ghani@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(10, 'mohsin.javed', 'mohsin.javed@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(12, 'bilal.hussain', 'bilal.hussain@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(14, 'umar.khan', 'umar.khan@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(16, 'hassan.nawaz', 'hassan.nawaz@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(18, 'jawad.ali', 'jawad.ali@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(20, 'farhan.ahmed', 'farhan.ahmed@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(22, 'saeed.shaikh', 'saeed.shaikh@yahoo.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(23, 'noor.aziz', 'noor.aziz@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(24, 'rashid.ali', 'rashid.ali@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', NULL, NULL, NULL, NULL, 'no', 'provider', '2025-06-10 14:05:13', '2025-06-10 14:10:56', 'active'),
(27, 'ahmedraza', 'ahmed.raza@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Ahmed Raza', '03001234567', 'House No 24, Street 8, Lahore', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:43', 'active'),
(28, 'usmankhalid', 'usman.khalid@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Usman Khalid', '03121234567', 'Block C, Gulshan, Karachi', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:46', 'active'),
(29, 'fahadali', 'fahad.ali@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Fahad Ali', '03211234567', 'Street 11, Sector G, Islamabad', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:49', 'active'),
(30, 'imranshafiq', 'imran.shafiq@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Imran Shafiq', '03451234567', 'Township Block 5, Lahore', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:52', 'active'),
(31, 'nomanjaved', 'noman.javed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Noman Javed', '03091234567', 'New Karachi, Karachi', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:55', 'active'),
(32, 'waqaszafar', 'waqas.zafar@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Waqas Zafar', '03331234567', 'Near Saddar Market, Rawalpindi', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:21:58', 'active'),
(33, 'hassanqureshi', 'hassan.qureshi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Hassan Qureshi', '03421234567', 'Sector 15, Korangi, Karachi', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:22:00', 'active'),
(34, 'tariqmehmood', 'tariq.mehmood@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Tariq Mehmood', '03061234567', 'Opposite Mall Road, Faisalabad', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:22:03', 'active'),
(35, 'zeeshanarif', 'zeeshan.arif@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Zeeshan Arif', '03151234567', 'Street 4, Cantt Area, Multan', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:22:06', 'active'),
(36, 'bilalahmed', 'bilal.ahmed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Bilal Ahmed', '03501234567', 'Model Town, Gujranwala', '/dehari/resources/image/carpenter.png', 'no', 'provider', '2025-06-11 04:20:59', '2025-06-11 04:23:43', 'active'),
(37, 'plumber.ahsan', 'ahsan.plumber@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Ahsan Iqbal', '03011234560', 'Model Town, Lahore', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(38, 'plumber.bilal', 'bilal.khan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Bilal Khan', '03021234561', 'North Karachi', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(39, 'plumber.danish', 'danish.ahmed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Danish Ahmed', '03031234562', 'Gulshan-e-Iqbal, Karachi', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(40, 'plumber.faisal', 'faisal.raza@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Faisal Raza', '03041234563', 'Sector G-10, Islamabad', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(41, 'plumber.hassan', 'hassan.javed@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Hassan Javed', '03051234564', 'Satellite Town, Rawalpindi', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(42, 'plumber.irfan', 'irfan.qureshi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Irfan Qureshi', '03061234565', 'Peoples Colony, Faisalabad', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(43, 'plumber.junaid', 'junaid.shah@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Junaid Shah', '03071234566', 'Cantt Area, Peshawar', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(44, 'plumber.kamran', 'kamran.mehmood@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Kamran Mehmood', '03081234567', 'Wapda Town, Multan', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(45, 'plumber.nabeel', 'nabeel.abbasi@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Nabeel Abbasi', '03091234568', 'Civil Lines, Hyderabad', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(46, 'plumber.sajid', 'sajid.butt@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Sajid Butt', '03101234569', 'Main Bazar, Sialkot', '/dehari/resources/image/plumber.png', 'no', 'provider', '2025-06-11 04:28:37', '2025-06-11 04:28:37', 'active'),
(47, 'usman_elec', 'usman.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Usman Farooq', '03111234510', 'Gulistan-e-Johar, Karachi', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(48, 'zahid_elec', 'zahid.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Zahid Mehmood', '03111234511', 'Township, Lahore', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(49, 'noman_elec', 'noman.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Noman Siddiqui', '03111234512', 'Blue Area, Islamabad', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(50, 'sohail_elec', 'sohail.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Sohail Ahmed', '03111234513', 'Peoples Colony, Faisalabad', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(51, 'atif_elec', 'atif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Atif Iqbal', '03111234514', 'Cantt, Rawalpindi', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(52, 'junaid_elec', 'junaid.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Junaid Rasheed', '03111234515', 'Latifabad, Hyderabad', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(53, 'kashif_elec', 'kashif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Kashif Ali', '03111234516', 'Samungli Road, Quetta', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(54, 'asif_elec', 'asif.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Asif Shah', '03111234517', 'University Road, Peshawar', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(55, 'waqar_elec', 'waqar.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Waqar Hussain', '03111234518', 'Model Town, Sialkot', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(56, 'fahad_elec', 'fahad.electrician@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Fahad Raza', '03111234519', 'New Multan Colony, Multan', '/dehari/resources/image/electrician.png', '', 'provider', '2025-06-11 04:32:21', '2025-06-11 04:32:21', 'active'),
(57, 'welder.usman', 'usman.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Usman Khan', '03111345010', 'Korangi, Karachi', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(58, 'welder.kamran', 'kamran.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Kamran Yousuf', '03111345011', 'Ferozepur Road, Lahore', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(59, 'welder.mansoor', 'mansoor.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Mansoor Ali', '03111345012', 'G-9, Islamabad', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(60, 'welder.nadeem', 'nadeem.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Nadeem Bhatti', '03111345013', 'Samnabad, Faisalabad', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(61, 'welder.faraz', 'faraz.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Faraz Qureshi', '03111345014', 'Saddar, Rawalpindi', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(62, 'welder.irfan', 'irfan.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Irfan Malik', '03111345015', 'Qasimabad, Hyderabad', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(63, 'welder.tariq', 'tariq.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Tariq Mehmood', '03111345016', 'Jinnah Road, Quetta', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(64, 'welder.sami', 'sami.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Sami Ullah', '03111345017', 'Hayatabad, Peshawar', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(65, 'welder.basit', 'basit.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Basit Raza', '03111345018', 'Daska Road, Sialkot', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(66, 'welder.rizwan', 'rizwan.welder@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Rizwan Haider', '03111345019', 'Bosan Road, Multan', '/dehari/resources/image/welder.png', '', 'provider', '2025-06-11 04:35:19', '2025-06-11 04:35:19', 'active'),
(67, 'atif.roofer', 'atif.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Atif Bashir', '03111444001', 'Nazimabad, Karachi', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:41:53', 'active'),
(68, 'waqar.roofer', 'waqar.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Waqar Javed', '03111444002', 'Township, Lahore', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:41:57', 'active'),
(69, 'ahsan.roofer', 'ahsan.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Ahsan Raza', '03111444003', 'F-10, Islamabad', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:00', 'active'),
(70, 'rashid.roofer', 'rashid.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Rashid Anwar', '03111444004', 'Peoples Colony, Faisalabad', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:03', 'active'),
(71, 'zubair.roofer', 'zubair.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Zubair Akhtar', '03111444005', 'Satellite Town, Rawalpindi', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:06', 'active'),
(72, 'imran.roofer', 'imran.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Imran Latif', '03111444006', 'Latifabad, Hyderabad', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:10', 'active'),
(73, 'zahid.roofer', 'zahid.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Zahid Iqbal', '03111444007', 'Sariab Road, Quetta', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:12', 'active'),
(74, 'faisal.roofer', 'faisal.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Faisal Nazir', '03111444008', 'University Road, Peshawar', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:15', 'active'),
(75, 'saqlain.roofer', 'saqlain.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Saqlain Shah', '03111444009', 'Cantt, Sialkot', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:18', 'active'),
(76, 'asif.roofer', 'asif.roofer@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Asif Nawaz', '03111444010', 'Mumtazabad, Multan', '/dehari/resources/image/roofer.png', '', 'provider', '2025-06-11 04:39:36', '2025-06-11 04:42:20', 'active'),
(87, 'junaid_khan', 'junaid.khan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Junaid Khan', '0301-2345678', 'Liaquatabad, Karachi', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(88, 'ali_haider', 'ali.haider@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Ali Haider', '0321-8765432', 'Saddar, Karachi', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(89, 'usman_ghani', 'usman.ghani@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Usman Ghani', '0332-1122334', 'Faisal Town, Lahore', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(90, 'asad_abbas', 'asad.abbas@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Asad Abbas', '0302-5566778', 'Johar Town, Lahore', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(91, 'zeeshan_ali', 'zeeshan.ali@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Zeeshan Ali', '0345-7788990', 'Pindi Road, Rawalpindi', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(92, 'noman_shah', 'noman.shah@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Noman Shah', '0311-2233445', 'Kohati Gate, Peshawar', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(93, 'atif_hussain', 'atif.hussain@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Atif Hussain', '0303-9988776', 'Nazimabad, Karachi', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(94, 'sajid_bashir', 'sajid.bashir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Sajid Bashir', '0340-6677885', 'Gulberg, Lahore', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(95, 'farhan_qadir', 'farhan.qadir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Farhan Qadir', '0312-3344556', 'Cantt, Multan', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(96, 'bilal_nazir', 'bilal.nazir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Bilal Nazir', '0333-4455667', 'Satellite Town, Quetta', '/dehari/resources/image/mechanic.png', '0', 'provider', '2025-06-11 04:53:20', '2025-06-11 04:53:20', 'active'),
(107, 'rashid.mehmood', 'rashid.mehmood@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Rashid Mehmood', '0302-1234567', 'Korangi, Karachi', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(108, 'irfan.qureshi', 'irfan.qureshii@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Irfan Qureshi', '0311-2233445', 'Model Town, Lahore', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(109, 'shahid.nawaz', 'shahid.nawaz@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Shahid Nawaz', '0341-5678910', 'Satellite Town, Rawalpindi', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(110, 'waqas.jameel', 'waqas.jameel@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Waqas Jameel', '0333-1122334', 'University Road, Peshawar', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(111, 'azeem.khan', 'azeem.khan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Azeem Khan', '0322-9876543', 'Jinnah Road, Quetta', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(112, 'kamran.aziz', 'kamran.aziz@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Kamran Aziz', '0340-1122112', 'Gulshan-e-Iqbal, Karachi', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(113, 'tariq.nadeem', 'tariq.nadeem@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Tariq Nadeem', '0315-6677889', 'Faisal Colony, Hyderabad', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(114, 'haroon.bashir', 'haroon.bashir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Haroon Bashir', '0301-4455667', 'DHA, Lahore', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(115, 'sarmad.ali', 'sarmad.ali@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Sarmad Ali', '0334-2211223', 'Shah Rukn-e-Alam, Multan', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(116, 'furqan.yousuf', 'furqan.yousuf@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Furqan Yousuf', '0321-5566778', 'Cantt, Faisalabad', '/dehari/resources/image/glazier.png', '0', 'user', '2025-06-11 05:00:23', '2025-06-11 05:00:23', 'active'),
(117, 'tilesetter.yasir', 'tilesetter.yasir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Yasir TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(118, 'tilesetter.irfan', 'tilesetter.irfan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Irfan TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(119, 'tilesetter.shahid', 'tilesetter.shahid@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Shahid TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(120, 'tilesetter.jameel', 'tilesetter.jameel@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Jameel TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(121, 'tilesetter.aslam', 'tilesetter.aslam@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Aslam TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(122, 'tilesetter.amjad', 'tilesetter.amjad@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Amjad TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(123, 'tilesetter.bashir', 'tilesetter.bashir@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Bashir TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(124, 'tilesetter.waqas', 'tilesetter.waqas@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Waqas TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(125, 'tilesetter.riaz', 'tilesetter.riaz@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Riaz TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(126, 'tilesetter.farhan', 'tilesetter.farhan@example.com', '65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58ee02337c5', 'Farhan TileSetter', NULL, NULL, '/dehari/resources/image/tilesetter.png', 'no', 'provider', '2025-06-11 05:06:24', '2025-06-11 05:06:24', 'active'),
(127, 'faizalam', 'faizalam@gmail.com', '423ffd55a48405355cc8e11540ae873b7033d4d5de450bdfe801c0f01832dc85', NULL, NULL, NULL, NULL, 'no', 'user', '2025-06-11 12:39:07', '2025-06-11 12:39:07', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booked_services`
--
ALTER TABLE `booked_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_providers`
--
ALTER TABLE `service_providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booked_services`
--
ALTER TABLE `booked_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `service_providers`
--
ALTER TABLE `service_providers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `service_providers`
--
ALTER TABLE `service_providers`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

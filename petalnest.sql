-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2026 at 04:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petalnest`
--

-- --------------------------------------------------------

--
-- Table structure for table `care_reminders`
--

CREATE TABLE `care_reminders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `reminder_type` enum('watering','fertilizing','pruning','repotting') NOT NULL,
  `reminder_date` date NOT NULL,
  `frequency` int(11) DEFAULT 7,
  `is_completed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `care_reminders`
--

INSERT INTO `care_reminders` (`id`, `user_id`, `product_id`, `reminder_type`, `reminder_date`, `frequency`, `is_completed`) VALUES
(1, 6, 2, 'pruning', '2025-07-31', 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscribers`
--

CREATE TABLE `newsletter_subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `newsletter_subscribers`
--

INSERT INTO `newsletter_subscribers` (`id`, `email`, `subscribed_at`) VALUES
(1, 'admin@gmail.com', '2025-08-29 22:50:39'),
(3, 'shahi@gmail.com', '2025-08-29 22:56:22'),
(5, 'admin1@gmail.com', '2025-08-30 06:14:46'),
(6, 'maha@gmail.com', '2025-08-30 07:08:42'),
(8, 'admin2@gmail.com', '2025-08-31 07:14:57'),
(9, 'admin3@gmail.com', '2025-08-31 07:17:15'),
(10, 'admin5@gmail.com', '2025-08-31 17:05:13'),
(12, 'sumaiya@gmail.com', '2025-12-08 08:44:19');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `status` enum('Pending','Processing','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
  `tracking_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `email`, `address`, `phone`, `payment_method`, `total`, `status`, `tracking_number`, `created_at`) VALUES
(1, NULL, 'T H Mahi', 'admin@gmail.com', 'Bangladesh', '01234567890', 'Bkash', 38.98, 'Pending', NULL, '2025-08-29 23:05:31'),
(2, 5, 'T H Mahi', 'admin@gmail.com', 'Bangaladesh', '01234567890', 'Nagad', 130.92, 'Pending', NULL, '2025-08-30 06:56:16'),
(3, 6, 'T H Mahi', 'admin@gmail.com', 'Bangladesh', '01234567890', 'Bkash', 38.97, 'Pending', NULL, '2025-08-30 07:32:53'),
(4, NULL, 'T H Mahi', 'admin@gmail.com', 'Bangladesh', '01234567890', 'Nagad', 63.96, 'Pending', NULL, '2025-08-30 09:21:37'),
(5, NULL, 'T H Mahi', 'admin@gmail.com', 'Bangladesh', '01234567890', 'Nagad', 25.98, 'Pending', NULL, '2025-08-30 12:28:37'),
(6, 6, 'T H Mahi', 'admin@gmail.com', 'Airport', '01234567890', 'Nagad', 105.94, 'Pending', NULL, '2025-08-31 07:43:20'),
(7, 6, 'T H Mahi', 'admin@gmail.com', 'bangladesh', '01234567890', 'Nagad', 103.92, 'Pending', NULL, '2025-08-31 17:26:04'),
(8, 6, 'T H Mahi', 'admin@gmail.com', 'bangaldesh', '01234567890', 'Nagad', 64.95, 'Pending', NULL, '2025-08-31 17:28:35'),
(9, 6, 'T H Mahi', 'admin@gmail.com', 'bangladesh', '01234567890', 'Nagad', 77.94, 'Pending', NULL, '2025-08-31 17:31:09'),
(10, 6, 'T H Mahi', 'admin@gmail.com', 'bangladesh', '01234567890', 'Nagad', 64.95, 'Pending', NULL, '2025-08-31 17:32:30'),
(11, NULL, 'T H Mahi', 'admin@gmail.com', 'Airport', '01234567890', 'Nagad', 131.91, 'Pending', NULL, '2025-09-01 15:11:20'),
(12, 8, 'Sumaiya Islam', 'sumaiya@gmail.com', 'Ashkona1231, Dhaka', '01234567890', 'Nagad', 164.88, 'Pending', NULL, '2025-12-08 08:49:56');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 2, 1, 12.99),
(2, 1, 4, 1, 25.99),
(3, 2, 1, 5, 15.99),
(4, 2, 2, 1, 12.99),
(5, 2, 3, 2, 18.99),
(6, 3, 2, 3, 12.99),
(7, 4, 1, 4, 15.99),
(8, 5, 2, 2, 12.99),
(9, 6, 1, 5, 15.99),
(10, 6, 4, 1, 25.99),
(11, 7, 2, 8, 12.99),
(12, 8, 2, 5, 12.99),
(13, 9, 2, 6, 12.99),
(14, 10, 2, 5, 12.99),
(15, 11, 1, 5, 15.99),
(16, 11, 2, 4, 12.99),
(17, 12, 1, 1, 15.99),
(18, 12, 2, 10, 12.99),
(19, 12, 3, 1, 18.99);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 1,
  `image` varchar(255) DEFAULT NULL,
  `category` enum('flower','plant') NOT NULL,
  `badge` enum('new','seasonal','bestseller','out_of_stock','premium','') DEFAULT NULL,
  `tips` text DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT 0.00,
  `discount_percent` decimal(5,2) DEFAULT 0.00,
  `featured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `image`, `category`, `badge`, `tips`, `rating`, `discount_percent`, `featured`, `created_at`) VALUES
(1, 'Red Rose Bouquet', 'Beautiful red roses for special occasions', 15.99, 10, 'assets/images/rose.jpg', 'flower', 'bestseller', 'Keep in water and change every 2 days', 4.50, 0.00, 1, '2025-08-29 20:47:21'),
(2, 'White Tulip', 'Elegant white tulips', 12.99, 15, 'assets/images/tulip.jpg', 'flower', 'new', 'Avoid direct sunlight', 4.20, 0.00, 1, '2025-08-29 20:47:21'),
(3, 'Pink Lily', 'Fresh pink lilies with sweet fragrance', 18.99, 8, 'assets/images/lily.jpg', 'flower', '', 'Remove pollen to extend life', 4.70, 0.00, 0, '2025-08-29 20:47:21'),
(4, 'Purple Orchid', 'Exotic purple orchids', 25.99, 5, 'assets/images/orchid.jpg', 'flower', 'premium', 'Mist leaves regularly', 4.80, 0.00, 1, '2025-08-29 20:47:21'),
(5, 'Sunflower', 'Bright and cheerful sunflowers', 10.99, 20, 'assets/images/sunflower.jpg', 'flower', 'seasonal', 'Needs plenty of sunlight', 4.30, 0.00, 0, '2025-08-29 20:47:21'),
(6, 'Bonsai Tree', 'Miniature bonsai tree for indoor decoration', 45.99, 5, 'assets/images/bonsai.jpg', 'plant', 'bestseller', 'Prune regularly to maintain shape', 4.90, 0.00, 1, '2025-08-29 20:47:21'),
(7, 'Snake Plant', 'Low maintenance air-purifying plant', 22.99, 12, 'assets/images/snake-plant.jpg', 'plant', 'new', 'Water sparingly', 4.60, 0.00, 0, '2025-08-29 20:47:21'),
(8, 'Money Plant', 'Brings prosperity and good luck', 18.99, 0, 'assets/images/money-plant.jpg', 'plant', 'out_of_stock', 'Prefers indirect sunlight', 4.40, 0.00, 0, '2025-08-29 20:47:21');

-- --------------------------------------------------------

--
-- Table structure for table `product_views`
--

CREATE TABLE `product_views` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `viewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `dislikes` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL DEFAULT 1,
  `site_name` varchar(100) DEFAULT NULL,
  `admin_email` varchar(100) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `meta_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `site_name`, `admin_email`, `currency`, `meta_description`) VALUES
(1, 'PetalNest', 'admin@petalnest.com', '$', 'Your one-stop shop for fresh flowers and plants');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `plan_type` enum('weekly','monthly','quarterly') NOT NULL,
  `start_date` date NOT NULL,
  `next_delivery_date` date NOT NULL,
  `status` enum('active','paused','cancelled') DEFAULT 'active',
  `preferences` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `profile_pic` varchar(255) DEFAULT 'assets/images/default-user.png',
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('customer','admin') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `otp` varchar(6) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `email_verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `profile_pic`, `phone`, `address`, `role`, `created_at`, `otp`, `verified`, `email_verified`) VALUES
(5, 'Lota', 'lota@gmail.com', '$2y$10$vB1BDku0HXLDRNBO0pRHaeQSUn6caiLJAZJqiq7L6zCdg4wPykZdu', 'assets/images/default-user.png', NULL, NULL, 'customer', '2025-08-30 06:17:54', NULL, 0, 0),
(6, 'Maha', 'maha@gmail.com', '$2y$10$qve9FOYJii2atvi1K9zROOLJQtWjr97hukszNYaHO6/tfr7/L/6iq', 'assets/images/default-user.png', '', '', 'customer', '2025-08-30 07:08:08', NULL, 0, 0),
(8, 'Sumaiya Islam', 'sumaiya@gmail.com', '$2y$10$RL4Dq3.iD85PhJH0fjAxweeivUJ0U8EzL1CmMIwjqJFmElKm.tN66', 'assets/images/default-user.png', NULL, NULL, 'customer', '2025-12-08 08:43:06', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `virtual_arrangements`
--

CREATE TABLE `virtual_arrangements` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `arrangement_data` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `care_reminders`
--
ALTER TABLE `care_reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_views`
--
ALTER TABLE `product_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `virtual_arrangements`
--
ALTER TABLE `virtual_arrangements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `care_reminders`
--
ALTER TABLE `care_reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_views`
--
ALTER TABLE `product_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `virtual_arrangements`
--
ALTER TABLE `virtual_arrangements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `care_reminders`
--
ALTER TABLE `care_reminders`
  ADD CONSTRAINT `care_reminders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `care_reminders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_views`
--
ALTER TABLE `product_views`
  ADD CONSTRAINT `product_views_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `product_views_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `virtual_arrangements`
--
ALTER TABLE `virtual_arrangements`
  ADD CONSTRAINT `virtual_arrangements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `wishlists_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

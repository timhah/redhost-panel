-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 02. Apr 2021 um 02:11
-- Server-Version: 10.1.48-MariaDB-0+deb9u2
-- PHP-Version: 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `admin_redhost_panel`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dedicated`
--

CREATE TABLE `dedicated` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `price` double(12,2) NOT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `locked` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL DEFAULT 'order',
  `created_at` date NOT NULL DEFAULT current_timestamp(),
  `expire_at` date NOT NULL,
  `deleted_at` date DEFAULT NULL,
  `days` int(11) NOT NULL DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes für die Tabelle `dedicated`
--

ALTER TABLE `dedicated`
  ADD PRIMARY KEY (`id`);
  
--
-- AUTO_INCREMENT für Tabelle `dedicated`
--

ALTER TABLE `dedicated`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cashbox_clicks`
--

CREATE TABLE `cashbox_clicks` (
  `id` int(11) NOT NULL,
  `box_id` varchar(255) NOT NULL,
  `ip_addr` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ip_addresses`
--

CREATE TABLE `ip_addresses` (
  `id` int(110) NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `service_type` enum('VPS') DEFAULT NULL,
  `node_id` varchar(512) DEFAULT NULL,
  `ip` varchar(255) NOT NULL,
  `cidr` int(11) NOT NULL,
  `gateway` varchar(255) NOT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `rdns` varchar(512) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_addr` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `show` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_info` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Daten für Tabelle `products`
--

INSERT INTO `products` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'PROXMOX_LXC', '2020-06-17 23:38:25', '2020-11-03 12:27:47'),
(2, 'PROXMOX_KVM', '2020-06-17 23:38:25', '2020-11-03 12:27:36'),
(3, 'GAMESERVER_MC', '2020-06-17 23:38:25', '2020-11-03 12:27:36');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product_options`
--

CREATE TABLE `product_options` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Daten für Tabelle `product_options`
--

INSERT INTO `product_options` (`id`, `product_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'LXC_CORES', '2020-05-01 01:36:26', '2020-06-23 05:13:20'),
(2, 1, 'LXC_MEMORY', '2020-05-01 01:36:26', '2020-06-23 05:13:21'),
(3, 1, 'LXC_DISK', '2020-05-01 01:36:26', '2020-06-23 05:13:22'),
(4, 1, 'LXC_ADDRESSES', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(5, 2, 'KVM_CORES', '2020-05-01 01:36:26', '2020-11-03 12:27:51'),
(6, 2, 'KVM_MEMORY', '2020-05-01 01:36:26', '2020-06-23 05:13:21'),
(7, 2, 'KVM_DISK', '2020-05-01 01:36:26', '2020-06-23 05:13:22'),
(8, 2, 'KVM_ADDRESSES', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(9, 3, 'MC_MEMORY', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(10, 3, 'MC_CORES', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(11, 3, 'MC_DISK', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(12, 1, 'LXC_NETWORK', '2020-05-01 01:36:26', '2020-06-23 05:13:23'),
(14, 3, 'MC_DATABASES', '2021-03-15 04:42:08', '2021-03-15 04:42:08'),
(50, 50, 'PLESK_LICENSE', '2021-01-26 20:36:49', '2021-01-26 21:23:03'),
(51, 51, 'TEKBASE_LICENSE', '2021-01-31 19:26:32', '2021-01-31 19:26:32'),
(52, 52, 'TEKBASE_CMS', '2021-01-31 19:28:03', '2021-01-31 19:28:03'),
(53, 53, 'TEKBASE_SHOP', '2021-01-31 19:28:14', '2021-01-31 19:28:14'),
(100, 100, 'TLD', '2021-02-09 21:56:28', '2021-02-09 22:22:20');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product_option_entries`
--

CREATE TABLE `product_option_entries` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `price` decimal(43,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Daten für Tabelle `product_option_entries`
--

INSERT INTO `product_option_entries` (`id`, `option_id`, `name`, `value`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, '1 Kern', '1', '0.90', '2020-06-23 14:08:43', '2021-02-21 10:40:10'),
(2, 1, '2 Kerne', '2', '1.80', '2020-06-23 14:08:43', '2021-03-01 00:20:56'),
(3, 1, '3 Kerne', '3', '2.70', '2020-06-23 14:08:43', '2021-03-01 00:21:21'),
(4, 1, '4 Kerne', '4', '3.60', '2020-06-23 14:08:43', '2021-03-01 00:21:28'),
(5, 1, '5 Kerne', '5', '4.50', '2020-06-23 14:08:43', '2021-03-01 00:21:34'),
(6, 1, '6 Kerne', '6', '5.40', '2020-06-23 14:08:43', '2021-03-01 00:21:39'),
(7, 1, '7 Kerne', '7', '6.30', '2020-06-23 14:08:43', '2021-03-01 01:46:33'),
(8, 1, '8 Kerne', '8', '7.20', '2020-06-23 14:08:43', '2021-03-01 01:46:36'),
(9, 1, '9 Kerne', '9', '8.10', '2021-03-01 01:46:09', '2021-03-01 01:46:25'),
(10, 1, '10 Kerne', '10', '9.00', '2021-03-01 01:46:09', '2021-03-01 01:46:28'),
(12, 12, 'bis 500MBit/s', '30', '0.00', '2021-02-21 10:39:03', '2021-02-21 10:39:30'),
(19, 2, '1GB RAM', '1024', '0.60', '2020-06-23 14:08:43', '2021-02-21 10:42:54'),
(21, 2, '2GB RAM', '2048', '1.20', '2020-06-23 14:08:43', '2021-03-01 00:24:02'),
(22, 2, '3GB RAM', '3072', '1.80', '2020-06-23 14:08:43', '2021-03-01 00:24:08'),
(23, 2, '4GB RAM', '4096', '2.40', '2020-06-23 14:08:43', '2021-03-01 00:25:14'),
(24, 2, '5GB RAM', '5120', '3.00', '2020-06-23 14:08:43', '2021-03-01 00:25:19'),
(25, 2, '6GB RAM', '6144', '3.60', '2020-06-23 14:08:43', '2021-03-01 00:25:22'),
(26, 2, '7GB RAM', '7168', '4.20', '2020-06-23 14:08:43', '2021-03-01 00:26:48'),
(27, 2, '8GB RAM', '8192', '4.80', '2021-03-01 00:28:10', '2021-03-01 00:28:10'),
(28, 2, '9GB RAM', '9216', '5.40', '2020-06-23 14:08:43', '2021-03-01 00:28:20'),
(29, 2, '10GB RAM', '10240', '6.00', '2021-03-01 00:30:11', '2021-03-01 00:30:11'),
(30, 2, '11GB RAM', '11264', '6.40', '2021-03-01 00:30:37', '2021-03-01 00:30:37'),
(31, 2, '12GB RAM', '12288', '7.00', '2020-06-23 14:08:43', '2021-03-01 00:30:49'),
(32, 2, '13GB RAM', '13312', '7.60', '2021-03-01 00:31:18', '2021-03-01 00:31:18'),
(33, 2, '14 GB RAM', '14336', '8.20', '2020-06-23 14:08:43', '2021-03-01 00:32:17'),
(34, 2, '15 GB RAM', '15360', '8.80', '2020-06-23 14:08:43', '2021-03-01 00:32:26'),
(35, 2, '16 GB RAM', '16384', '9.40', '2020-06-23 14:08:43', '2021-03-01 00:32:31'),
(40, 3, '10 GB SSD', '10', '0.50', '2020-06-23 14:08:43', '2021-02-06 08:48:46'),
(41, 3, '20 GB SSD', '20', '1.00', '2020-06-23 14:08:43', '2021-02-06 08:48:53'),
(42, 3, '30 GB SSD', '30', '1.50', '2020-06-23 14:08:43', '2021-03-01 00:34:34'),
(43, 3, '40 GB SSD', '40', '2.00', '2020-06-23 14:08:43', '2021-03-01 00:34:37'),
(44, 3, '50 GB SSD', '50', '2.50', '2020-06-23 14:08:43', '2021-03-01 00:34:41'),
(45, 3, '60 GB SSD', '60', '3.00', '2020-06-23 14:08:43', '2021-03-01 00:34:46'),
(46, 3, '70 GB SSD', '70', '3.50', '2020-06-23 14:08:43', '2021-03-01 00:34:51'),
(47, 3, '80 GB SSD', '80', '4.00', '2020-06-23 14:08:43', '2021-03-01 00:34:55'),
(48, 3, '90 GB SSD', '90', '4.50', '2020-06-23 14:08:43', '2021-03-01 00:34:58'),
(49, 3, '100 GB SSD', '100', '5.00', '2020-06-23 14:08:43', '2021-03-01 00:35:00'),
(60, 4, '1 IPv4 Adresse', '1', '1.00', '2020-06-23 14:08:43', '2021-02-21 10:41:48'),
(90, 5, '1 Kern', '1', '1.50', '2021-12-29 13:15:01', '2021-12-29 13:28:38'),
(110, 6, '1 GB RAM', '1024', '1.00', '2020-06-23 14:08:43', '2021-12-29 13:24:09'),
(181, 7, '10 GB SSD', '10', '1.00', '2020-06-23 14:08:43', '2021-03-01 01:30:37'),
(210, 8, '1 IPv4 Adresse', '1', '1.00', '2020-06-23 14:08:43', '2020-12-24 08:32:23'),
(215, 10, '1 Kern', '1', '1.20', '2020-06-23 14:08:43', '2020-12-24 07:48:07'),
(220, 9, '1 GB RAM', '1024', '1.00', '2020-06-23 14:08:43', '2020-12-24 07:46:16'),
(250, 11, '10 GB SSD', '10240', '0.50', '2020-06-23 14:08:43', '2021-03-15 03:27:11'),
(300, 50, 'Plesk Admin Lizenz (VPS)', 'PLSK_12_ADMIN_VPS', '7.90', '2021-01-26 20:38:20', '2021-02-02 04:55:02'),
(301, 50, 'Plesk Pro Lizenz (VPS)', 'PLSK_12_PRO_VPS', '10.90', '2021-01-26 20:55:42', '2021-02-02 04:54:59'),
(302, 50, 'Plesk Host-Lizenz (VPS)', 'PLSK_12_HOST_VPS', '13.90', '2021-01-26 23:08:43', '2021-02-28 01:01:15'),
(303, 60, 'Plesk Admin-Lizenz (Dediziert)', 'PLSK_12_ADMIN', '15.00', '2021-02-02 04:58:22', '2021-02-28 01:01:17'),
(304, 60, 'Plesk Pro-Lizenz (Dediziert)', 'PLSK_12_PRO', '20.00', '2021-02-02 04:58:43', '2021-02-28 01:01:19'),
(305, 60, 'Plesk Host-Edition (Dediziert)', 'PLSK_12_HOST', '30.00', '2021-02-02 04:59:03', '2021-02-28 01:01:21'),
(500, 51, 'Mietversion', '0', '1.00', '2021-01-31 19:27:27', '2021-01-31 22:37:04'),
(501, 51, 'Kaufversion', '1', '10.00', '2021-01-31 19:29:24', '2021-01-31 22:37:07'),
(502, 51, 'Gewerbliche Version mit Rechnungssystem', 'adv', '15.00', '2021-01-31 19:29:58', '2021-01-31 19:30:09'),
(503, 52, 'Nein', '0', '0.00', '2021-01-31 19:32:47', '2021-01-31 19:32:47'),
(504, 52, 'Ja', '1', '1.00', '2021-01-31 19:33:00', '2021-01-31 19:33:00'),
(505, 53, 'Nein', '0', '0.00', '2021-01-31 19:33:09', '2021-01-31 19:33:09'),
(506, 53, 'Ja', '1', '10.00', '2021-01-31 19:33:18', '2021-01-31 19:33:18'),
(1000, 100, '.de', 'de', '4.90', '2021-02-09 21:57:00', '2021-02-26 18:38:43'),
(1001, 100, '.eu', 'eu', '3.90', '2021-02-09 21:57:52', '2021-02-26 18:38:58'),
(1002, 100, '.net', 'net', '12.90', '2021-02-09 21:58:13', '2021-02-09 22:22:16'),
(1003, 100, '.com', 'com', '9.90', '2021-02-09 21:58:33', '2021-02-09 22:22:17'),
(1004, 100, '.at', 'at', '10.90', '2021-02-26 15:32:46', '2021-02-26 15:32:52'),
(1005, 100, '.business', 'business', '8.49', '2021-02-26 15:33:54', '2021-02-26 15:33:54'),
(1007, 100, '.cc', 'cc', '12.90', '2021-02-26 15:34:32', '2021-02-26 15:34:32'),
(1008, 100, '.dev', 'dev', '15.00', '2021-02-26 15:35:19', '2021-02-26 15:35:19'),
(1009, 100, '.help', 'help', '16.00', '2021-02-26 15:35:48', '2021-02-26 18:41:16'),
(1010, 100, '.gratis', 'gratis', '16.19', '2021-02-26 15:36:04', '2021-02-26 15:36:04'),
(1011, 100, '.group', 'group', '12.19', '2021-02-26 15:36:26', '2021-02-26 15:36:26'),
(1012, 100, '.icu', 'icu', '8.49', '2021-02-26 15:36:52', '2021-02-26 15:36:52'),
(1013, 100, '.info', 'info', '16.00', '2021-02-26 15:37:18', '2021-02-26 15:37:18'),
(1014, 100, '.live', 'live', '6.50', '2021-02-26 15:37:51', '2021-02-26 15:37:51'),
(1016, 100, '.me', 'me', '12.19', '2021-02-26 15:38:13', '2021-02-26 15:38:13'),
(1018, 100, '.nl', 'nl', '7.19', '2021-02-26 15:38:41', '2021-02-26 15:38:41'),
(1019, 100, '.org', 'org', '12.90', '2021-02-26 15:39:04', '2021-02-26 15:39:04'),
(1020, 100, '.support', 'support', '10.80', '2021-02-26 15:39:41', '2021-02-26 15:39:41'),
(1021, 100, '.systems', 'systems', '9.90', '2021-02-26 15:39:51', '2021-02-26 15:41:50'),
(1022, 100, '.world', 'world', '6.50', '2021-02-26 15:40:20', '2021-02-26 15:40:20'),
(1023, 100, '.work', 'work', '9.90', '2021-02-26 15:40:37', '2021-02-26 15:40:37'),
(1024, 100, '.wtf', 'wtf', '7.20', '2021-02-26 15:40:52', '2021-02-26 15:40:52'),
(1025, 100, '.xyz', 'xyz', '13.90', '2021-02-26 15:41:08', '2021-02-26 15:41:08'),
(1026, 5, '2 Kerne', '2', '3.00', '2021-03-01 00:36:51', '2021-12-29 13:28:48'),
(1027, 5, '3 Kerne', '3', '4.50', '2021-12-29 13:16:12', '2021-12-29 13:29:05'),
(1028, 5, '4 Kerne', '4', '6.00', '2021-03-01 00:37:40', '2021-12-29 13:29:44'),
(1029, 5, '5 Kerne', '3', '7.50', '2021-12-29 13:26:19', '2021-12-29 13:32:04'),
(1030, 5, '6 Kerne', '6', '9.00', '2021-03-01 00:38:33', '2021-12-29 13:32:16'),
(1031, 5, '7 Kerne', '7', '10.50', '2021-03-01 00:38:41', '2021-12-29 13:32:26'),
(1032, 5, '8 Kerne', '8', '12.00', '2021-03-01 00:38:56', '2021-12-29 13:30:32'),
(1033, 5, '9 Kerne', '9', '13.50', '2021-03-01 00:39:03', '2021-12-29 13:33:28'),
(1034, 5, '10 Kerne', '10', '15.00', '2021-03-01 00:39:12', '2021-12-29 13:33:42'),
(1035, 5, '11 Kerne', '11', '16.50', '2021-03-01 00:39:23', '2021-12-29 13:34:26'),
(1036, 5, '12 Kerne', '12', '18.00', '2021-03-01 00:39:32', '2021-12-29 13:34:37'),
(1037, 5, '13 Kerne', '13', '19.50', '2021-03-01 00:39:40', '2021-12-29 13:34:49'),
(1038, 5, '14 Kerne', '14', '21.00', '2021-03-01 00:39:55', '2021-12-29 13:35:01'),
(1039, 5, '15 Kerne', '15', '22.50', '2021-03-01 00:40:04', '2021-12-29 13:35:13'),
(1040, 5, '16 Kerne', '16', '24.00', '2021-03-01 00:40:13', '2021-12-29 13:35:23'),
(1041, 6, '2GB RAM', '2048', '2.10', '2021-03-01 00:41:24', '2021-03-01 00:41:24'),
(1042, 6, '3GB RAM', '3072', '3.10', '2021-03-01 00:41:44', '2021-03-01 00:41:44'),
(1043, 6, '4GB RAM', '4096', '4.10', '2021-03-01 00:42:00', '2021-03-01 01:42:51'),
(1044, 6, '5GB RAM', '5120', '5.10', '2021-03-01 00:42:53', '2021-03-01 00:42:53'),
(1045, 6, '6GB RAM', '6144', '6.10', '2021-03-01 00:43:07', '2021-03-01 00:43:07'),
(1046, 6, '7GB RAM', '7168', '7.10', '2021-03-01 00:43:20', '2021-03-01 00:43:20'),
(1047, 6, '8GB RAM', '8192', '8.10', '2021-03-01 00:43:31', '2021-03-01 00:43:31'),
(1048, 6, '9GB RAM', '9216', '9.10', '2021-03-01 00:43:43', '2021-03-01 00:43:43'),
(1049, 6, '10GB RAM', '10240', '10.10', '2021-03-01 00:43:55', '2021-03-01 00:43:55'),
(1050, 6, '11GB RAM', '11264', '11.10', '2021-03-01 00:44:17', '2021-03-01 00:44:17'),
(1051, 6, '12GB RAM', '12288', '12.10', '2021-03-01 00:44:30', '2021-03-01 00:44:30'),
(1052, 6, '13GB RAM', '13312', '13.10', '2021-03-01 00:44:44', '2021-03-01 00:44:44'),
(1053, 6, '14GB RAM', '14336', '14.10', '2021-03-01 00:44:55', '2021-03-01 00:44:55'),
(1054, 6, '15GB RAM', '15360', '15.10', '2021-03-01 00:45:09', '2021-03-01 00:45:09'),
(1055, 6, '16GB RAM', '16384', '16.10', '2021-03-01 00:45:39', '2021-03-01 00:45:39'),
(1056, 6, '17GB RAM', '17408', '17.10', '2021-03-01 00:45:57', '2021-03-01 00:45:57'),
(1057, 6, '18GB RAM', '18432', '18.10', '2021-03-01 00:46:18', '2021-03-01 00:46:18'),
(1058, 6, '19GB RAM', '19456', '19.10', '2021-03-01 00:46:32', '2021-03-01 00:46:32'),
(1059, 6, '20GB RAM', '20480', '20.10', '2021-03-01 00:46:44', '2021-03-01 00:46:44'),
(1060, 6, '21GB RAM', '21504', '21.10', '2021-03-01 00:51:48', '2021-03-01 00:51:48'),
(1061, 6, '22GB RAM', '22528', '22.10', '2021-03-01 00:52:00', '2021-03-01 00:52:00'),
(1062, 6, '23GB RAM', '23552', '23.10', '2021-03-01 00:52:12', '2021-03-01 00:52:12'),
(1063, 6, '24GB RAM', '24576', '24.10', '2021-03-01 00:53:37', '2021-03-01 00:53:37'),
(1064, 6, '25GB RAM', '25600', '25.10', '2021-03-01 00:53:51', '2021-03-01 00:53:51'),
(1065, 6, '26GB RAM', '26624', '26.10', '2021-03-01 00:54:01', '2021-03-01 00:54:01'),
(1066, 6, '27GB RAM', '27648', '27.10', '2021-03-01 00:54:46', '2021-03-01 00:54:46'),
(1067, 6, '28GB RAM', '28672', '28.10', '2021-03-01 00:54:56', '2021-03-01 00:54:56'),
(1068, 6, '29GB RAM', '29696', '29.10', '2021-03-01 00:55:10', '2021-03-01 00:55:10'),
(1069, 6, '30GB RAM', '30720', '30.10', '2021-03-01 00:55:21', '2021-03-01 00:55:21'),
(1070, 6, '31GB RAM', '31744', '31.10', '2021-03-01 00:55:36', '2021-03-01 00:55:36'),
(1071, 6, '32GB RAM', '32768', '32.10', '2021-03-01 00:55:50', '2021-03-01 00:55:50'),
(1072, 6, '33GB RAM', '33792', '33.10', '2021-03-01 00:56:01', '2021-03-01 00:56:01'),
(1073, 6, '34GB RAM', '34816', '34.10', '2021-03-01 01:18:00', '2021-03-01 01:18:00'),
(1074, 6, '35GB RAM', '35840', '35.10', '2021-03-01 01:18:20', '2021-03-01 01:18:20'),
(1075, 6, '36GB RAM', '36864', '36.10', '2021-03-01 01:18:32', '2021-03-01 01:18:32'),
(1076, 6, '37GB RAM', '37888', '37.10', '2021-03-01 01:18:44', '2021-03-01 01:18:44'),
(1077, 6, '38GB RAM', '38912', '38.10', '2021-03-01 01:18:57', '2021-03-01 01:18:57'),
(1078, 6, '39GB RAM', '39936', '39.10', '2021-03-01 01:19:12', '2021-03-01 01:19:12'),
(1079, 6, '40GB RAM', '40960', '40.10', '2021-03-01 01:19:25', '2021-03-01 01:19:25'),
(1080, 6, '41GB RAM', '41984', '41.10', '2021-03-01 01:19:38', '2021-03-01 01:19:38'),
(1081, 6, '42GB RAM', '43008', '42.10', '2021-03-01 01:19:59', '2021-03-01 01:19:59'),
(1082, 6, '43GB RAM', '44032', '43.10', '2021-03-01 01:20:11', '2021-03-01 01:20:11'),
(1083, 6, '44GB RAM', '45056', '44.10', '2021-03-01 01:20:26', '2021-03-01 01:20:26'),
(1084, 6, '45GB RAM', '46080', '45.10', '2021-03-01 01:20:38', '2021-03-01 01:20:38'),
(1085, 6, '46GB RAM', '47104', '46.10', '2021-03-01 01:20:52', '2021-03-01 01:20:52'),
(1086, 6, '47GB RAM', '48128', '47.10', '2021-03-01 01:21:05', '2021-03-01 01:21:05'),
(1087, 6, '48GB RAM', '49152', '48.10', '2021-03-01 01:21:18', '2021-03-01 01:21:18'),
(1088, 6, '49GB RAM', '50176', '49.10', '2021-03-01 01:21:30', '2021-03-01 01:21:30'),
(1089, 6, '50GB RAM', '51200', '50.10', '2021-03-01 01:21:48', '2021-03-01 01:21:48'),
(1090, 6, '51GB RAM', '52224', '51.10', '2021-03-01 01:22:01', '2021-03-01 01:22:01'),
(1091, 6, '52GB RAM', '53248', '52.10', '2021-03-01 01:22:14', '2021-03-01 01:22:14'),
(1092, 6, '53GB RAM', '54272', '53.10', '2021-03-01 01:22:29', '2021-03-01 01:22:29'),
(1093, 6, '54GB RAM', '55296', '54.10', '2021-03-01 01:22:42', '2021-03-01 01:22:42'),
(1094, 6, '55GB RAM', '56320', '55.10', '2021-03-01 01:22:55', '2021-03-01 01:22:55'),
(1095, 6, '56GB RAM', '57344', '56.10', '2021-03-01 01:23:06', '2021-03-01 01:23:06'),
(1096, 6, '57GB RAM', '58368', '57.10', '2021-03-01 01:23:21', '2021-03-01 01:23:21'),
(1097, 6, '58GB RAM', '59392', '58.10', '2021-03-01 01:23:45', '2021-03-01 01:23:45'),
(1098, 6, '59GB RAM', '60416', '59.10', '2021-03-01 01:24:02', '2021-03-01 01:24:02'),
(1099, 6, '60GB RAM', '61440', '60.10', '2021-03-01 01:24:15', '2021-03-01 01:24:15'),
(1100, 6, '61GB RAM', '62464', '61.10', '2021-03-01 01:24:35', '2021-03-01 01:24:35'),
(1101, 6, '62GB RAM', '63488', '62.10', '2021-03-01 01:24:46', '2021-03-01 01:24:46'),
(1102, 6, '63GB RAM', '64512', '63.10', '2021-03-01 01:24:58', '2021-03-01 01:24:58'),
(1103, 6, '64GB RAM', '65536', '64.10', '2021-03-01 01:25:12', '2021-03-01 01:25:12'),
(1104, 8, '2 IPv4 Adressen', '2', '2.00', '2021-03-01 01:29:24', '2021-03-01 01:29:44'),
(1105, 8, '3 IPv4 Adressen', '3', '3.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1106, 7, '20GB SSD', '20', '2.00', '2021-03-01 01:31:10', '2021-03-01 01:31:10'),
(1107, 7, '30GB SSD', '30', '3.00', '2021-03-01 01:31:21', '2021-03-01 01:31:21'),
(1108, 7, '40GB SSD', '40', '4.00', '2021-03-01 01:31:28', '2021-03-01 01:31:28'),
(1109, 7, '50GB SSD', '50', '5.00', '2021-03-01 01:31:36', '2021-03-01 01:31:36'),
(1110, 7, '60GB SSD', '60', '6.00', '2021-03-01 01:31:43', '2021-03-01 01:31:43'),
(1111, 7, '70GB SSD', '70', '7.00', '2021-03-01 01:31:59', '2021-03-01 01:31:59'),
(1112, 7, '80GB SSD', '80', '8.00', '2021-03-01 01:32:11', '2021-03-01 01:32:11'),
(1113, 7, '90GB SSD', '90', '9.00', '2021-03-01 01:32:18', '2021-03-01 01:32:18'),
(1114, 7, '100GB SSD', '100', '10.00', '2021-03-01 01:32:26', '2021-03-01 01:32:26'),
(1115, 7, '110GB SSD', '110', '11.00', '2021-03-01 01:32:35', '2021-03-01 01:32:35'),
(1116, 7, '120GB SSD', '120', '12.00', '2021-03-01 01:33:12', '2021-03-01 01:33:12'),
(1117, 7, '130GB SSD', '130', '13.00', '2021-03-01 01:33:19', '2021-03-01 01:33:19'),
(1118, 7, '140GB SSD', '140', '14.00', '2021-03-01 01:33:26', '2021-03-01 01:33:26'),
(1119, 7, '150GB SSD', '150', '15.00', '2021-03-01 01:33:34', '2021-03-01 01:33:34'),
(1120, 7, '160GB SSD', '160', '16.00', '2021-03-01 01:33:46', '2021-03-01 01:33:46'),
(1121, 7, '170GB SSD', '170', '17.00', '2021-03-01 01:33:54', '2021-03-01 01:33:54'),
(1122, 7, '180GB SSD', '180', '18.00', '2021-03-01 01:34:02', '2021-03-01 01:34:02'),
(1123, 7, '190GB SSD', '190', '19.00', '2021-03-01 01:34:21', '2021-03-01 01:34:21'),
(1124, 7, '200GB SSD', '200', '20.00', '2021-03-01 01:34:33', '2021-03-01 01:34:33'),
(1125, 7, '210GB SSD', '210', '21.00', '2021-03-01 01:34:42', '2021-03-01 01:34:42'),
(1126, 7, '220GB SSD', '220', '22.00', '2021-03-01 01:34:51', '2021-03-01 01:34:51'),
(1127, 7, '230GB SSD', '230', '23.00', '2021-03-01 01:34:59', '2021-03-01 01:34:59'),
(1128, 7, '240GB SSD', '240', '24.00', '2021-03-01 01:35:19', '2021-03-01 01:35:19'),
(1129, 7, '250GB SSD', '250', '25.00', '2021-03-01 01:35:27', '2021-03-01 01:35:27'),
(1130, 1, '11 Kerne', '11', '9.90', '2021-03-01 01:47:16', '2021-03-01 01:47:16'),
(1131, 1, '12 Kerne', '10.80', '0.00', '2021-03-01 01:47:16', '2021-03-01 01:47:16'),
(1132, 1, '11 Kerne', '11', '9.90', '2021-03-01 01:47:32', '2021-03-01 01:47:32'),
(1133, 1, '12 Kerne', '11', '10.80', '2021-03-01 01:47:32', '2021-03-01 01:47:32'),
(1134, 2, '17GB RAM', '17408', '10.00', '2021-03-01 01:48:52', '2021-03-01 01:48:52'),
(1135, 2, '18GB RAM', '18432', '10.60', '2021-03-01 01:48:52', '2021-03-01 01:48:52'),
(1136, 2, '19GB RAM', '19456', '11.20', '2021-03-01 01:49:55', '2021-03-01 01:49:55'),
(1137, 2, '20GB RAM', '20480', '11.80', '2021-03-01 01:49:55', '2021-03-01 01:49:55'),
(1138, 2, '21GB RAM', '21504', '12.40', '2021-03-01 01:50:33', '2021-03-01 01:50:33'),
(1139, 2, '22GB RAM', '22528', '13.00', '2021-03-01 01:50:33', '2021-03-01 01:50:33'),
(1140, 2, '23GB RAM', '23552', '13.60', '2021-03-01 01:51:09', '2021-03-01 01:51:09'),
(1141, 2, '24GB RAM', '24576', '14.20', '2021-03-01 01:51:09', '2021-03-01 01:51:09'),
(1142, 2, '25GB RAM', '25600', '14.80', '2021-03-01 01:51:53', '2021-03-01 01:51:53'),
(1143, 2, '26GB RAM', '26624', '15.40', '2021-03-01 01:51:53', '2021-03-01 01:51:53'),
(1144, 2, '27GB RAM', '27648', '16.00', '2021-03-01 01:52:31', '2021-03-01 01:52:31'),
(1145, 2, '28GB RAM', '28672', '16.60', '2021-03-01 01:52:31', '2021-03-01 01:52:31'),
(1146, 2, '29GB RAM', '29696', '17.20', '2021-03-01 01:53:09', '2021-03-01 01:53:09'),
(1147, 2, '30GB RAM', '30720', '17.80', '2021-03-01 01:53:09', '2021-03-01 01:53:09'),
(1148, 2, '31GB RAM', '31744', '18.40', '2021-03-01 01:53:46', '2021-03-01 01:53:46'),
(1149, 2, '32GB RAM', '32768', '19.00', '2021-03-01 01:53:46', '2021-03-01 01:53:46'),
(1150, 9, '2GB RAM', '2048', '2.00', '2021-03-15 03:36:18', '2021-03-15 03:36:18'),
(1151, 9, '3GB RAM', '3072', '3.00', '2021-03-15 03:28:31', '2021-03-15 03:28:31'),
(1152, 9, '4GB RAM', '4096', '4.00', '2021-03-15 03:28:54', '2021-03-15 03:28:54'),
(1153, 9, '5GB RAM', '5120', '5.00', '2021-03-15 03:28:54', '2021-03-15 04:43:30'),
(1154, 9, '6GB RAM', '6144', '6.00', '2021-03-15 03:29:22', '2021-03-15 03:29:22'),
(1155, 9, '7GB RAM', '7168', '7.00', '2021-03-15 03:29:22', '2021-03-15 03:29:22'),
(1156, 9, '8GB RAM', '8192', '8.00', '2021-03-15 03:29:52', '2021-03-15 03:29:52'),
(1157, 9, '9GB RAM', '9216', '9.00', '2021-03-15 03:29:52', '2021-03-15 03:29:52'),
(1158, 9, '10GB RAM', '10240', '10.00', '2021-03-15 03:30:20', '2021-03-15 03:30:20'),
(1159, 9, '11GB RAM', '11264', '11.00', '2021-03-15 03:30:20', '2021-03-15 03:30:20'),
(1160, 9, '12GB RAM', '12288', '12.00', '2021-03-15 03:30:48', '2021-03-15 03:30:48'),
(1161, 9, '13GB RAM', '13312', '13.00', '2021-03-15 03:30:48', '2021-03-15 03:30:48'),
(1162, 9, '14GB RAM', '14336', '14.00', '2021-03-15 03:31:19', '2021-03-15 03:31:19'),
(1163, 9, '15GB RAM', '15360', '15.00', '2021-03-15 03:31:19', '2021-03-15 03:31:19'),
(1164, 9, '16GB RAM', '16384', '16.00', '2021-03-15 03:31:41', '2021-03-15 03:31:41'),
(1165, 9, '17GB RAM', '17408', '17.00', '2021-03-15 03:31:41', '2021-03-15 03:31:41'),
(1166, 9, '18GB RAM', '18432', '18.00', '2021-03-15 03:32:08', '2021-03-15 03:32:08'),
(1167, 9, '19GB RAM', '19456', '19.00', '2021-03-15 03:32:08', '2021-03-15 03:32:08'),
(1168, 9, '20GB RAM', '20480', '20.00', '2021-03-15 03:32:28', '2021-03-15 03:32:28'),
(1169, 9, '21GB RAM', '21504', '21.00', '2021-03-15 03:32:28', '2021-03-15 03:32:28'),
(1170, 9, '22GB RAM', '22528', '22.00', '2021-03-15 03:32:53', '2021-03-15 03:32:53'),
(1171, 9, '23GB RAM', '23552', '23.00', '2021-03-15 03:32:53', '2021-03-15 03:32:53'),
(1172, 9, '24GB RAM', '24576', '24.00', '2021-03-15 03:33:16', '2021-03-15 03:33:16'),
(1173, 9, '25GB RAM', '25600', '25.00', '2021-03-15 03:33:16', '2021-03-15 03:33:16'),
(1174, 9, '26GB RAM', '26624', '26.00', '2021-03-15 03:33:38', '2021-03-15 03:33:38'),
(1175, 9, '27GB RAM', '27648', '27.00', '2021-03-15 03:33:38', '2021-03-15 03:33:38'),
(1176, 9, '28GB RAM', '28672', '28.00', '2021-03-15 03:33:59', '2021-03-15 03:33:59'),
(1177, 9, '29GB RAM', '29696', '29.00', '2021-03-15 03:33:59', '2021-03-15 03:33:59'),
(1178, 9, '30GB RAM', '30720', '30.00', '2021-03-15 03:34:24', '2021-03-15 03:34:24'),
(1179, 9, '31GB RAM', '31744', '31.00', '2021-03-15 03:34:24', '2021-03-15 03:34:24'),
(1180, 9, '32GB RAM', '32768', '32.00', '2021-03-15 03:34:37', '2021-03-15 03:34:37'),
(1181, 11, '20GB SSD', '20480', '1.00', '2021-03-15 03:36:54', '2021-03-15 03:36:54'),
(1182, 11, '30GB SSD', '30720', '1.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1183, 11, '40GB SSD', '40960', '2.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1184, 11, '50GB SSD', '51200', '2.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1185, 11, '60GB SSD', '61440', '3.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1186, 11, '70GB SSD', '71680', '3.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1187, 11, '80GB SSD', '81920', '4.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1188, 11, '90GB SSD', '92160', '4.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1189, 11, '100GB SSD', '102400', '5.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1190, 11, '110GB SSD', '112640', '5.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1191, 11, '120GB SSD', '122880', '6.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1192, 11, '130GB SSD', '133120', '6.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1193, 11, '140GB SSD', '143360', '7.00', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1194, 11, '150GB SSD', '153600', '7.50', '2021-03-15 03:39:51', '2021-03-15 03:39:51'),
(1195, 10, '2 Kerne', '2', '2.40', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1196, 10, '3 Kerne', '3', '3.60', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1197, 10, '4 Kerne', '4', '4.80', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1198, 10, '5 Kerne', '5', '6.00', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1199, 10, '6 Kerne', '6', '7.20', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1200, 10, '7 Kerne', '7', '8.40', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1201, 10, '8 Kerne', '8', '9.60', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1202, 10, '9 Kerne', '9', '10.80', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1203, 10, '10 Kerne', '10', '12.00', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1204, 10, '11 Kerne', '11', '13.20', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1205, 10, '12 Kerne', '12', '14.40', '2021-03-15 03:42:51', '2021-03-15 03:42:51'),
(1206, 14, 'Ja, zwei Inklusive', '0', '0.00', '2021-03-15 04:42:44', '2021-03-15 04:42:44'),
(1209, 8, '4 IPv4 Adressen', '4', '4.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1210, 8, '5 IPv4 Adressen', '5', '5.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1211, 8, '6 IPv4 Adressen', '6', '6.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1212, 8, '7 IPv4 Adressen', '7', '7.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1213, 8, '8 IPv4 Adressen', '8', '8.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1214, 8, '9 IPv4 Adressen', '9', '9.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56'),
(1215, 8, '10 IPv4 Adressen', '10', '10.00', '2021-03-01 01:29:56', '2021-03-01 01:29:56');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product_prices`
--

CREATE TABLE `product_prices` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updadted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pterodactyl_servers`
--

CREATE TABLE `pterodactyl_servers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `state` enum('active','suspended','deleted') NOT NULL,
  `memory` int(255) NOT NULL,
  `cpu` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `allocation_id` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `locked` text,
  `custom_name` text,
  `expire_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `queue`
--

CREATE TABLE `queue` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `payload` longtext,
  `retries` int(11) NOT NULL DEFAULT '0',
  `error_log` longtext,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `settings`
--

CREATE TABLE `settings` (
  `login` int(11) NOT NULL DEFAULT '1',
  `register` int(11) NOT NULL DEFAULT '1',
  `webspace` int(11) NOT NULL DEFAULT '1',
  `teamspeak` int(11) NOT NULL DEFAULT '1',
  `vps` int(11) NOT NULL DEFAULT '1',
  `psc_fees` int(5) NOT NULL DEFAULT '0',
  `default_traffic_limit` int(11) NOT NULL DEFAULT '1000',
  `rootserver` enum('own','venocix') NOT NULL DEFAULT 'venocix'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `settings` (`login`, `register`, `webspace`, `teamspeak`, `vps`, `psc_fees`, `default_traffic_limit`, `rootserver`) VALUES
(1, 1, 1, 1, 1, 0, 1000, 'venocix');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teamspeaks`
--

CREATE TABLE `teamspeaks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `slots` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `teamspeak_ip` varchar(255) NOT NULL,
  `teamspeak_port` varchar(255) NOT NULL,
  `sid` int(11) NOT NULL,
  `expire_at` datetime NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `state` enum('ACTIVE','SUSPENDED','DELETED') NOT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `locked` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teamspeak_backups`
--

CREATE TABLE `teamspeak_backups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `teamspeak_id` int(11) NOT NULL,
  `files` longtext NOT NULL,
  `desc` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teamspeak_hosts`
--

CREATE TABLE `teamspeak_hosts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `login_ip` varchar(255) NOT NULL,
  `login_port` varchar(255) NOT NULL,
  `login_name` varchar(255) NOT NULL,
  `login_passwort` varchar(255) NOT NULL,
  `status` enum('ACTIVE','DISABLED') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `categorie` enum('ALLGEMEIN','TECHNIK','BUCHHALTUNG','PARTNER','FEEDBACK','AUSFALL','BUGS') NOT NULL,
  `priority` enum('NIEDRIG','MITTEL','HOCH') NOT NULL,
  `title` varchar(255) NOT NULL,
  `state` enum('OPEN','CLOSED') NOT NULL,
  `last_msg` enum('CUSTOMER','SUPPORT') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_message`
--

CREATE TABLE `ticket_message` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `writer_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `gateway` varchar(255) NOT NULL,
  `state` enum('pending','success','abort') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `tid` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `state` enum('pending','active','banned') NOT NULL,
  `role` enum('customer','support','admin') NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `session_token` varchar(255) DEFAULT NULL,
  `verify_code` varchar(255) DEFAULT NULL,
  `user_addr` varchar(255) DEFAULT NULL,
  `plesk_uid` varchar(255) DEFAULT NULL,
  `plesk_password` varchar(255) DEFAULT NULL,
  `s_pin` varchar(255) DEFAULT NULL,
  `datasavingmode` int(11) NOT NULL DEFAULT '0',
  `darkmode` int(11) NOT NULL DEFAULT '1',
  `notes` longtext,
  `livechat` int(11) NOT NULL DEFAULT '1',
  `preloader` int(11) NOT NULL DEFAULT '1',
  `legal_accepted` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `discord_id` varchar(255) DEFAULT NULL,
  `cashbox` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `projectname` varchar(512) DEFAULT NULL,
  `projectlogo` varchar(512) DEFAULT NULL,
  `mail_ticket` int(11) NOT NULL DEFAULT '1',
  `mail_runtime` int(11) NOT NULL DEFAULT '1',
  `mail_suspend` int(11) NOT NULL DEFAULT '1',
  `mail_order` int(11) NOT NULL DEFAULT '1',
  `pterodactyl_id` varchar(255) DEFAULT NULL,
  `pterodactyl_password` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_transactions`
--

CREATE TABLE `user_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_host_nodes`
--

CREATE TABLE `vm_host_nodes` (
  `id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `root_password` varchar(512) DEFAULT NULL,
  `realm` varchar(255) NOT NULL,
  `state` enum('ACTIVE','DISABLED') NOT NULL,
  `disc_name` varchar(255) NOT NULL,
  `disc_type` enum('ssd','hdd') NOT NULL,
  `api_name` enum('NO_API','PLOCIC','VENOCIX','GAME') NOT NULL,
  `active` enum('yes','no') NOT NULL,
  `type` enum('LXC','KVM') NOT NULL DEFAULT 'LXC',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_servers`
--

CREATE TABLE `vm_servers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `template_id` varchar(512) NOT NULL,
  `node_id` int(11) NOT NULL,
  `cores` int(11) NOT NULL,
  `memory` int(11) NOT NULL,
  `disc` int(11) NOT NULL,
  `addresses` int(11) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `price` decimal(43,2) NOT NULL,
  `state` enum('ACTIVE','DISABLED','SUSPENDED','DELETED','PENDING') NOT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `locked` text,
  `expire_at` datetime NOT NULL,
  `disc_name` varchar(255) DEFAULT NULL,
  `traffic` int(11) DEFAULT NULL,
  `curr_traffic` varchar(255) DEFAULT NULL,
  `api_name` enum('NO_API','PLOCIC','VENOCIX','GAME') DEFAULT NULL,
  `pack_name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `type` enum('LXC','KVM') NOT NULL DEFAULT 'LXC',
  `notes` text,
  `job_id` int(11) DEFAULT NULL,
  `venocix_id` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_server_command_presets`
--

CREATE TABLE `vm_server_command_presets` (
  `id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `desc` text NOT NULL,
  `command` text NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_server_os`
--

CREATE TABLE `vm_server_os` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `type` enum('LXC','KVM','VENOCIX') NOT NULL DEFAULT 'LXC',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `vm_server_os`
--

INSERT INTO `vm_server_os` (`id`, `name`, `template`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Ubuntu 18.04', 'Ubuntu18.04', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(2, 'Ubuntu 20.04', 'Ubuntu 20.04', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(3, 'Debian 9.4', 'Debian9.4', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(4, 'Debian 10.0', 'Debian10.0', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(5, 'Debian 8.0', 'Debian8.0', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(6, 'CentOS 7.6', 'CentOS7.6', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(7, 'Ubuntu 21.04', 'Ubuntu21.04', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(8, 'Debian 11.0', 'Debian11.0', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14'),
(9, 'Windows Server 2019 eval', 'Windows2019.eval', 'VENOCIX', '2021-12-25 23:16:45', '2021-12-27 22:53:14');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_server_packs`
--

CREATE TABLE `vm_server_packs` (
  `id` int(11) NOT NULL,
  `type` enum('normal','game') NOT NULL DEFAULT 'normal',
  `name` varchar(255) NOT NULL,
  `cores` varchar(255) NOT NULL,
  `memory` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_software`
--

CREATE TABLE `vm_software` (
  `id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `file_name` varchar(512) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_software_tasks`
--

CREATE TABLE `vm_software_tasks` (
  `id` int(11) NOT NULL,
  `vm_id` int(11) NOT NULL,
  `type` varchar(512) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vm_tasks`
--

CREATE TABLE `vm_tasks` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `task` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `webspace`
--

CREATE TABLE `webspace` (
  `id` int(11) NOT NULL,
  `plan_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ftp_name` varchar(255) NOT NULL,
  `ftp_password` varchar(255) NOT NULL,
  `domainName` varchar(255) NOT NULL,
  `webspace_id` int(11) NOT NULL,
  `state` enum('active','suspended','deleted') NOT NULL,
  `expire_at` datetime NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `locked` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `webspace_host`
--

CREATE TABLE `webspace_host` (
  `id` int(11) NOT NULL,
  `domainName` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `state` enum('offline','online') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `webspace_packs`
--

CREATE TABLE `webspace_packs` (
  `id` int(11) NOT NULL,
  `plesk_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `desc` text,
  `price` decimal(12,2) NOT NULL,
  `disc` varchar(255) NOT NULL,
  `domains` varchar(255) NOT NULL,
  `subdomains` varchar(255) NOT NULL,
  `databases` varchar(255) NOT NULL,
  `ftp_accounts` varchar(255) NOT NULL,
  `emails` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `cashbox_clicks`
--
ALTER TABLE `cashbox_clicks`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ip_addresses`
--
ALTER TABLE `ip_addresses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mac` (`mac_address`);

--
-- Indizes für die Tabelle `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `product_options`
--
ALTER TABLE `product_options`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `product_option_entries`
--
ALTER TABLE `product_option_entries`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `product_prices`
--
ALTER TABLE `product_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `pterodactyl_servers`
--
ALTER TABLE `pterodactyl_servers`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `queue`
--
ALTER TABLE `queue`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `teamspeaks`
--
ALTER TABLE `teamspeaks`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `teamspeak_backups`
--
ALTER TABLE `teamspeak_backups`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `teamspeak_hosts`
--
ALTER TABLE `teamspeak_hosts`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `ticket_message`
--
ALTER TABLE `ticket_message`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `user_transactions`
--
ALTER TABLE `user_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_host_nodes`
--
ALTER TABLE `vm_host_nodes`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_servers`
--
ALTER TABLE `vm_servers`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_server_command_presets`
--
ALTER TABLE `vm_server_command_presets`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_server_os`
--
ALTER TABLE `vm_server_os`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_server_packs`
--
ALTER TABLE `vm_server_packs`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_software`
--
ALTER TABLE `vm_software`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_software_tasks`
--
ALTER TABLE `vm_software_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `vm_tasks`
--
ALTER TABLE `vm_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `webspace`
--
ALTER TABLE `webspace`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `webspace_host`
--
ALTER TABLE `webspace_host`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `webspace_packs`
--
ALTER TABLE `webspace_packs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `cashbox_clicks`
--
ALTER TABLE `cashbox_clicks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ip_addresses`
--
ALTER TABLE `ip_addresses`
  MODIFY `id` int(110) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `product_options`
--
ALTER TABLE `product_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `product_option_entries`
--
ALTER TABLE `product_option_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `product_prices`
--
ALTER TABLE `product_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pterodactyl_servers`
--
ALTER TABLE `pterodactyl_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `queue`
--
ALTER TABLE `queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `teamspeaks`
--
ALTER TABLE `teamspeaks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `teamspeak_backups`
--
ALTER TABLE `teamspeak_backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `teamspeak_hosts`
--
ALTER TABLE `teamspeak_hosts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ticket_message`
--
ALTER TABLE `ticket_message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `user_transactions`
--
ALTER TABLE `user_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_host_nodes`
--
ALTER TABLE `vm_host_nodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_servers`
--
ALTER TABLE `vm_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_server_command_presets`
--
ALTER TABLE `vm_server_command_presets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_server_os`
--
ALTER TABLE `vm_server_os`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_server_packs`
--
ALTER TABLE `vm_server_packs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_software`
--
ALTER TABLE `vm_software`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_software_tasks`
--
ALTER TABLE `vm_software_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vm_tasks`
--
ALTER TABLE `vm_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `webspace`
--
ALTER TABLE `webspace`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `webspace_host`
--
ALTER TABLE `webspace_host`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `webspace_packs`
--
ALTER TABLE `webspace_packs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

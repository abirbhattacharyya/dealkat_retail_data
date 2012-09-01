-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jul 17, 2009 at 05:00 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `dealkat_retail_data`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `graphs`
-- 

DROP TABLE IF EXISTS `graphs`;
CREATE TABLE `graphs` (
  `id` int(11) NOT NULL auto_increment,
  `chart_type` varchar(255) default NULL,
  `url` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `graphs`
-- 

INSERT INTO `graphs` (`id`, `chart_type`, `url`, `created_at`, `updated_at`) VALUES 
(1, 'Median Margin by Category', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:14,26,16,23,19,0&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12'),
(2, 'Median Promotional Price by Category', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:29,46,7,16,0,0&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12'),
(3, 'Median Margin by Product Class', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:22,25,20,14,16,0&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12'),
(4, 'Median Promotional Price by Product Class', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:31,9,18,28,12,0&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12'),
(5, 'Median Margin by Product Sub Class', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:21,18,15,10,20,13&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12'),
(6, 'Median Promotional Price by Product Sub Class', 'http://chart.apis.google.com/chart?cht=bvg&chs=495x199&chd=t:26,1,33,19,16,0&chco=006699,FF9933,006699,116699,226699,336699,446699', '2009-07-17 11:16:12', '2009-07-17 11:16:12');

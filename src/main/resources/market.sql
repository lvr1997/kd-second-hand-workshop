/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50647
 Source Host           : localhost:3306
 Source Schema         : market

 Target Server Type    : MySQL
 Target Server Version : 50647
 File Encoding         : 65001

 Date: 14/04/2020 21:15:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `recv_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_zip` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `recv_tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_default` int(11) DEFAULT NULL,
  `created_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `modified_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `modified_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, '西瓜', '23', '01', '09', '黑龙江省哈尔滨市松北区', '黑龙江科技大学9#421', '15124680346', '', '150022', '宿舍', 1, NULL, NULL, NULL, NULL);
INSERT INTO `address` VALUES (2, 3, 'lr', '23', '01', '09', '黑龙江省哈尔滨市松北区', '宿舍', '17645653758', '', '150022', '宿舍', 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `descript` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of carousel
-- ----------------------------
INSERT INTO `carousel` VALUES (1, '毕业季', '2019-05-23', 1, '毕业季，二手随心发', '#', 'banner1.png');
INSERT INTO `carousel` VALUES (2, '新概念图书', '2019-05-23', 1, '欢迎各位发布一些闲置的书籍', '#', 'banner1.jpg');
INSERT INTO `carousel` VALUES (3, '毕业季毕业季', '2019-05-23', 1, '毕业季', '#', 'banner2.png');

-- ----------------------------
-- Table structure for catelog
-- ----------------------------
DROP TABLE IF EXISTS `catelog`;
CREATE TABLE `catelog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `number` int(11) NOT NULL,
  `status` tinyint(4) DEFAULT 1 COMMENT '1是可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of catelog
-- ----------------------------
INSERT INTO `catelog` VALUES (1, '电子数码', 2, 1);
INSERT INTO `catelog` VALUES (2, '棋牌休闲', 0, 1);
INSERT INTO `catelog` VALUES (3, '服装衣物', 0, 1);
INSERT INTO `catelog` VALUES (4, '书籍刊物', 0, 1);
INSERT INTO `catelog` VALUES (5, '其他', 0, 1);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 1, 1, '2019-05-19', '图片不足，稍后上传');
INSERT INTO `comments` VALUES (2, 1, 1, '2019-05-19', '图片不足稍后上传');

-- ----------------------------
-- Table structure for dict_areas
-- ----------------------------
DROP TABLE IF EXISTS `dict_areas`;
CREATE TABLE `dict_areas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dict_areas
-- ----------------------------
INSERT INTO `dict_areas` VALUES (1, '01', '09', '松北区');

-- ----------------------------
-- Table structure for dict_cities
-- ----------------------------
DROP TABLE IF EXISTS `dict_cities`;
CREATE TABLE `dict_cities`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dict_cities
-- ----------------------------
INSERT INTO `dict_cities` VALUES (1, '23', '01', '哈尔滨市');

-- ----------------------------
-- Table structure for dict_provinces
-- ----------------------------
DROP TABLE IF EXISTS `dict_provinces`;
CREATE TABLE `dict_provinces`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `province_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dict_provinces
-- ----------------------------
INSERT INTO `dict_provinces` VALUES (1, '23', '黑龙江省');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catelog_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double NOT NULL,
  `real_price` double DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `polish_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `end_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `commet_num` int(11) DEFAULT NULL,
  `phone_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `qq_number` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `wx_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `good_city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `good_buy_method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `good_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `viewCount` int(11) DEFAULT NULL,
  `describle` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 1, 1, 'Lenovo笔记本', 1000, 3999, '2019-05-19', '2019-05-20', NULL, 2, '15124680346', '1399321915', '15124680346', '1', '3', '9舍', 9, 'Lenovo笔记本  固态硬盘128', 1);
INSERT INTO `goods` VALUES (2, 1, 3, 'oppor9s手机', 800, 1399, '2019-05-23', '2019-05-23', NULL, 0, '13019711506', '993830821', '', '1', '3', '学生公寓', 8, 'oppor9s手机，用了一年', 3);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (1, 1, '14dad59a-4ff8-4ad9-a556-bb92ffecb90b.png');
INSERT INTO `image` VALUES (2, 2, '17f7fb26-e785-4a5b-b82a-6c7d2c8d345f.jpg');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `context` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `good_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `pay_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_at` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '20190528172406559', 1, 2, 1, '20190528172308624', '2019-05-28', 1);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `atuser_id` int(11) DEFAULT NULL,
  `commet_id` int(11) DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `good_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `QQ` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_at` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `goods_num` int(11) DEFAULT NULL,
  `power` tinyint(4) DEFAULT NULL,
  `last_login` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `residence` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `signature` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15124680346', 'AASAD', '900150983CD24FB0D6963F7D28E17F72', NULL, '2019-05-19', 1, 10, '2019-06-03', NULL, '', '女', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', '', '');
INSERT INTO `user` VALUES (2, '17611056916', '17611056916', '47BCE5C74F589F4867DBD57E9CA9F808', NULL, '2019-05-19', 0, 60, '2019-05-19', NULL, '2019-05-19', '男', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', NULL, NULL);
INSERT INTO `user` VALUES (3, '13019711506', '西瓜是咸的', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, '2019-05-23', 1, 10, '2019-05-23', NULL, '1989-05-26', '男', '73a35a75-35ab-4f04-9916-17dbd17c22df.png', '黑龙江-哈尔滨市-松北区', '');
INSERT INTO `user` VALUES (4, '15232103749', 'you', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, '2020-04-14', 0, 10, '2020-04-14', NULL, '1998-04-09', '男', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', '黑龙江-哈尔滨市-南岗区', '');

-- ----------------------------
-- Table structure for wanted
-- ----------------------------
DROP TABLE IF EXISTS `wanted`;
CREATE TABLE `wanted`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `good_id` int(11) DEFAULT NULL,
  `create_at` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

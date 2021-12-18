/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : market

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 18/12/2021 18:06:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `recv_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_district` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_addr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_zip` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recv_tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_default` int(11) NULL DEFAULT NULL,
  `created_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modified_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, '西瓜', '23', '01', '09', '黑龙江省哈尔滨市松北区', '黑龙江科技大学9#421', '15124680346', '', '150022', '宿舍', 1, NULL, NULL, NULL, NULL);
INSERT INTO `address` VALUES (2, 3, 'lr', '23', '01', '09', '黑龙江省哈尔滨市松北区', '宿舍', '17645653758', '', '150022', '宿舍', 1, NULL, NULL, NULL, NULL);
INSERT INTO `address` VALUES (3, 3, '西瓜', '23', '01', '09', '黑龙江省哈尔滨市松北区', '学生公寓', '13019711506', '', '', '宿舍', 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL,
  `descript` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
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
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1是可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of catelog
-- ----------------------------
INSERT INTO `catelog` VALUES (1, '电子数码', 6, 1);
INSERT INTO `catelog` VALUES (2, '棋牌休闲', 0, 1);
INSERT INTO `catelog` VALUES (3, '服装衣物', 0, 1);
INSERT INTO `catelog` VALUES (4, '书籍刊物', 1, 1);
INSERT INTO `catelog` VALUES (5, '其他', 0, 1);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
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
  `real_price` double NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `polish_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `end_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `commet_num` int(11) NULL DEFAULT NULL,
  `phone_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qq_number` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wx_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `good_city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `good_buy_method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `good_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `viewCount` int(11) NULL DEFAULT NULL,
  `describle` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (3, 1, 4, '数码相机', 2000, 2999, '2021-12-18', '2021-12-18', NULL, 0, '15232103749', '1009328863', '', '1', '3', '学生公寓10舍', 5, '数码相机一台，没用过几次呢，需要的联系我', 3);
INSERT INTO `goods` VALUES (4, 1, 4, 'thinkpad笔记本电脑', 4500, 5999, '2021-12-18', '2021-12-18', NULL, 0, '15232103749', '', '', '1', '2', '学生公寓10舍', 1, 'thinkpad笔记本电脑，win7系统，cpu性能杠杠的！', 1);
INSERT INTO `goods` VALUES (5, 1, 3, '耳机', 19, 29, '2021-12-18', '2021-12-18', NULL, 0, '13019711506', '', '', '1', '2', '学生公寓6舍自取', 2, '入耳式线圈耳机，没用过几次，自己用不惯，需要的朋友联系我把', 1);
INSERT INTO `goods` VALUES (6, 1, 3, '笔记本电脑', 2500, 3999, '2021-12-18', '2021-12-18', NULL, 0, '13019711506', '', '', '1', '2', '学生公寓6舍', 1, '出售闲置笔记本一台，win7系统，运行没问题', 1);
INSERT INTO `goods` VALUES (7, 4, 3, '水墨西行小说', 15, 38, '2021-12-18', '2021-12-18', NULL, 0, '13019711506', '', '', '1', '2', '学生公寓6舍自取', 2, '自己都看完了，整本书都背下来了，想要的和我联系吧', 1);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (1, 1, '14dad59a-4ff8-4ad9-a556-bb92ffecb90b.png');
INSERT INTO `image` VALUES (2, 2, '17f7fb26-e785-4a5b-b82a-6c7d2c8d345f.jpg');
INSERT INTO `image` VALUES (3, 3, '13b9f66e-be30-4cd6-a042-8303bc8611b3.png');
INSERT INTO `image` VALUES (4, 3, '28d538da-5330-4471-a14e-b1498551308c.png');
INSERT INTO `image` VALUES (5, 4, '22882dc7-ca21-4ccf-9ad0-593ab34e9768.png');
INSERT INTO `image` VALUES (6, 5, '8ee01560-146f-4ad7-8c41-0ec0ad7ca9d2.jpg');
INSERT INTO `image` VALUES (7, 5, '598561c5-0fc3-4054-aa6d-4589840c1d51.jpg');
INSERT INTO `image` VALUES (8, 5, 'ce253121-b2b3-45e4-8aaf-6bfeaa1e26da.jpg');
INSERT INTO `image` VALUES (9, 6, 'e93f2883-ef55-492f-bded-eabb63566a78.png');
INSERT INTO `image` VALUES (10, 6, '4b33eb52-0804-45b7-9d8f-3740a464b961.png');
INSERT INTO `image` VALUES (11, 6, '57254242-3f15-41ad-b4d6-0402d272f60c.png');
INSERT INTO `image` VALUES (12, 7, '0fe2532e-9fdd-4fcd-b4f6-e4e9d6d5396c.jpg');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `context` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of notice
-- ----------------------------

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
  `create_at` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '20190528172406559', 1, 2, 1, '20190528172308624', '2019-05-28', 1);
INSERT INTO `orders` VALUES (2, '20211218180226154', 1, 3, 1, '20211218180004780', '2021-12-18', 1);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int(11) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `atuser_id` int(11) NULL DEFAULT NULL,
  `commet_id` int(11) NULL DEFAULT NULL,
  `create_at` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of reply
-- ----------------------------

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `good_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of report
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `QQ` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_at` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_num` int(11) NULL DEFAULT NULL,
  `power` tinyint(4) NULL DEFAULT NULL,
  `last_login` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `residence` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `signature` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15124680346', 'AASAD', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, '2019-05-19', 1, 10, '2021-12-18', NULL, '', '女', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', '', '');
INSERT INTO `user` VALUES (2, '17611056916', '17611056916', '47BCE5C74F589F4867DBD57E9CA9F808', NULL, '2019-05-19', 0, 100, '2020-10-12', NULL, '2019-05-19', '男', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', NULL, NULL);
INSERT INTO `user` VALUES (3, '13019711506', '西瓜是咸的', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, '2019-05-23', 4, 10, '2021-12-18', NULL, '1989-05-26', '男', '73a35a75-35ab-4f04-9916-17dbd17c22df.png', '黑龙江-哈尔滨市-松北区', '');
INSERT INTO `user` VALUES (4, '15232103749', 'you', 'E10ADC3949BA59ABBE56E057F20F883E', NULL, '2020-04-14', 2, 10, '2021-12-18', NULL, '1998-04-09', '男', 'b78c6caa-0175-4610-a591-c6aa2917c3aa.png', '黑龙江-哈尔滨市-南岗区', '');

-- ----------------------------
-- Table structure for wanted
-- ----------------------------
DROP TABLE IF EXISTS `wanted`;
CREATE TABLE `wanted`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `good_id` int(11) NULL DEFAULT NULL,
  `create_at` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wanted
-- ----------------------------
INSERT INTO `wanted` VALUES (1, 4, 1, '2020-09-20');
INSERT INTO `wanted` VALUES (2, 3, 7, '2021-12-18');
INSERT INTO `wanted` VALUES (3, 1, 5, '2021-12-18');
INSERT INTO `wanted` VALUES (4, 1, 4, '2021-12-18');

SET FOREIGN_KEY_CHECKS = 1;

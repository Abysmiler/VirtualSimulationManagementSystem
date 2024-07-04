/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50737 (5.7.37)
 Source Host           : localhost:3306
 Source Schema         : mybatis-1

 Target Server Type    : MySQL
 Target Server Version : 50737 (5.7.37)
 File Encoding         : 65001

 Date: 02/07/2024 16:29:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '实训课程ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实训课程名称',
  `instructor_id` int(11) NULL DEFAULT NULL COMMENT '授课教师的用户ID',
  `resource_id` int(11) NULL DEFAULT NULL COMMENT '使用的实训资源ID',
  `schedule` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程时间表',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '实训课程描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `instructor_id`(`instructor_id`) USING BTREE,
  INDEX `resource_id`(`resource_id`) USING BTREE,
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES (1, '12', 1, 1, '16', '2024-07-01 15:23:23', '2024-07-01 17:05:57', '1');

-- ----------------------------
-- Table structure for devices
-- ----------------------------
DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '仿真设备ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仿真设备名称',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仿真设备类型',
  `lab_id` int(11) NULL DEFAULT NULL COMMENT '设备所在的实验室ID',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态（如：可用、维修中等）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '仿真设备描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `devices_ibfk_1`(`lab_id`) USING BTREE,
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`lab_id`) REFERENCES `labs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of devices
-- ----------------------------
INSERT INTO `devices` VALUES (1, '1', '化学', 6, '良好', '2024-07-01 09:33:07', '2024-07-01 11:17:06', '1');
INSERT INTO `devices` VALUES (2, '2', '物理', 2, '良好', '2024-07-01 14:14:20', '2024-07-01 14:14:26', NULL);
INSERT INTO `devices` VALUES (3, '3', '物理', 3, '良好', '2024-07-01 14:14:43', '2024-07-01 14:16:11', NULL);
INSERT INTO `devices` VALUES (4, '3', '物理', 3, '良好', '2024-07-01 14:16:25', '2024-07-01 14:16:25', NULL);

-- ----------------------------
-- Table structure for labs
-- ----------------------------
DROP TABLE IF EXISTS `labs`;
CREATE TABLE `labs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '实验室ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实验室名称',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实验室位置',
  `capacity` int(11) NULL DEFAULT NULL COMMENT '实验室容量',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '实验室描述',
  `manager` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `labs_users_admin`(`manager`) USING BTREE,
  CONSTRAINT `labs_users_admin` FOREIGN KEY (`manager`) REFERENCES `users` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of labs
-- ----------------------------
INSERT INTO `labs` VALUES (1, '12', '1', 1, '2024-06-29 10:32:59', '2024-07-01 09:37:05', 'nihao', '17');
INSERT INTO `labs` VALUES (2, '1', '1', 1, '2024-06-29 15:40:49', '2024-07-01 09:37:07', NULL, '17');
INSERT INTO `labs` VALUES (3, '3', '3', 3, '2024-06-29 15:44:39', '2024-07-01 09:37:08', NULL, '17');
INSERT INTO `labs` VALUES (4, '3', '3', 5, '2024-06-29 15:48:24', '2024-07-01 09:37:08', NULL, '17');
INSERT INTO `labs` VALUES (5, '5', '5', 5, '2024-06-29 18:11:02', '2024-07-01 09:37:09', NULL, '17');
INSERT INTO `labs` VALUES (6, '6', '6', 6, '2024-06-29 18:10:55', '2024-07-01 14:04:44', NULL, '17');
INSERT INTO `labs` VALUES (7, '7', '7', 7, '2024-07-01 14:04:27', '2024-07-01 14:04:26', NULL, '17');

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '实训资源ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实训资源名称',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实训资源类型（如：文档、视频等）',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '实训资源内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '实训资源描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES (1, '12', '音频', '1', '2024-07-01 15:00:58', '2024-07-01 17:11:15', '1');
INSERT INTO `resources` VALUES (2, '22', '视频', NULL, '2024-07-01 17:26:54', '2024-07-01 17:26:53', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `intro` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '介绍，简介',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住址',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '11', '111', '123456', '111@qq.com', NULL, '13587644861', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (2, '12', '112', '123456', '112@qq.com', NULL, '13587644862', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (3, '13', '113', '123456', '113@qq.com', NULL, '13587644863', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (4, '14', '114', '123456', '114@qq.com', NULL, '13587644864', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (5, '15', '115', '123456', '115@qq.com', NULL, '13587644865', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (6, '16', '116', '123456', '116@qq.com', NULL, '13587644866', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (7, '17', '117', '123456', '117@qq.com', NULL, '13587644860', '2024-06-17 15:32:58', NULL, '管理员', '11-17', '女', 23);
INSERT INTO `users` VALUES (8, '18', '118', '123456', '118@qq.com', NULL, '13587644868', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (9, '19', '119', '123456', '119@qq.com', NULL, '13587644869', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (10, '110', '1110', '123456', '1110@qq.com', NULL, '13587644811', '2024-06-17 15:32:58', NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (11, '111', '1111', '123456', '1111@qq.com', NULL, '13587644812', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (12, '112', '1112', '123456', '1112@qq.com', NULL, '13587644813', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (13, '113', '1113', '123456', '1113@qq.com', NULL, '13587644814', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (14, '114', '1114', '123456', '1114@qq.com', NULL, '13587644815', '2024-06-17 15:32:58', NULL, '超级管理员', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;

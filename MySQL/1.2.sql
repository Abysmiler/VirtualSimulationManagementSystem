/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : virtualsimulationmanagementsystem

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 04/07/2024 15:37:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '实训课程ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '实训课程名称',
  `instructor_id` int NULL DEFAULT NULL COMMENT '授课教师的用户ID',
  `resource_id` int NULL DEFAULT NULL COMMENT '使用的实训资源ID',
  `credit_hour` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学时',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '实训课程描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `instructor_id`(`instructor_id` ASC) USING BTREE,
  INDEX `resource_id`(`resource_id` ASC) USING BTREE,
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES (1, '12', 1, 1, '18', '2024-07-01 15:23:23', '2024-07-04 10:16:50', '1');

-- ----------------------------
-- Table structure for devices
-- ----------------------------
DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '仿真设备ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '仿真设备名称',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '仿真设备类型',
  `lab_id` int NULL DEFAULT NULL COMMENT '设备所在的实验室ID',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '设备状态（如：可用、维修中等）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '仿真设备描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `devices_ibfk_1`(`lab_id` ASC) USING BTREE,
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`lab_id`) REFERENCES `labs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of devices
-- ----------------------------
INSERT INTO `devices` VALUES (1, '123', '123', 1, '123', '2024-07-04 14:31:42', '2024-07-04 14:31:42', '123');

-- ----------------------------
-- Table structure for labs
-- ----------------------------
DROP TABLE IF EXISTS `labs`;
CREATE TABLE `labs`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '实验室ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '实验室名称',
  `location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '实验室位置',
  `capacity` int NULL DEFAULT NULL COMMENT '实验室容量',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '实验室描述',
  `manager` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '管理员',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `labs_users_admin`(`manager` ASC) USING BTREE,
  CONSTRAINT `labs_users_admin` FOREIGN KEY (`manager`) REFERENCES `users` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of labs
-- ----------------------------
INSERT INTO `labs` VALUES (1, '123', '123', 123, '2024-07-04 14:24:45', '2024-07-04 14:24:45', '123', '123');

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '实训资源ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '实训资源名称',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '实训资源类型（如：文档、视频等）',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '实训资源内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '实训资源描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `intro` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '介绍，简介',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户类型',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '住址',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '张三', '111', '123456', '111@qq.com', NULL, '13587644861', '2024-06-17 15:32:58', NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (3, '134', '113', '1234567', '2932458551@qq.com', NULL, '13587644863', '2024-06-17 15:32:58', NULL, '学生', '重庆邮电大学崇文路2号', '男', 13);
INSERT INTO `users` VALUES (4, '14', '114', '123456', '114@qq.com', NULL, '13587644864', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (5, '15', '115', '123456', '115@qq.com', NULL, '13587644865', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (6, '16', '116', '123456', '116@qq.com', NULL, '13587644866', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (7, '17', '117', '123456', '117@qq.com', NULL, '13587644860', '2024-06-17 15:32:58', NULL, '管理员', '11-17', '女', 23);
INSERT INTO `users` VALUES (8, '18', '118', '123456', '118@qq.com', NULL, '13587644868', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (9, '19', '119', '123456', '119@qq.com', NULL, '13587644869', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (10, '110', '1110', '123456', '1110@qq.com', NULL, '13587644811', '2024-06-17 15:32:58', NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (12, '112', '1112', '123456', '1112@qq.com', NULL, '13587644813', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (14, '114', '1114', '123456', '1114@qq.com', NULL, '13587644815', '2024-06-17 15:32:58', NULL, '超级管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (15, '123', '123', '123456', '1322@qq.com', NULL, '15555555555', NULL, NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (16, '123456', '123456', '123456', '2932418555@qq.com', NULL, '18875058888', '2024-07-04 15:16:57', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (17, '456546', '45345', '123456', 'abysmiler@163.com', NULL, '18875058555', '2024-07-04 15:20:18', NULL, '管理员', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;

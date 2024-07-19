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

 Date: 08/07/2024 19:12:24
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
) ENGINE = InnoDB AUTO_INCREMENT = 1233 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES (1, '计算机网络实验', 14, 1, '18', '2024-07-01 15:23:23', '2024-07-04 22:06:26', '计算机网络实训');
INSERT INTO `courses` VALUES (2, '编程基础', 15, 2, '20', '2024-07-04 22:03:06', '2024-07-04 22:07:01', '编程基实训');
INSERT INTO `courses` VALUES (3, '计算机原理', 16, 3, '20', '2024-07-04 22:07:54', '2024-07-04 22:07:54', '计算机原理课程实验');
INSERT INTO `courses` VALUES (4, 'python实训', 15, 5, '20', '2024-07-04 22:08:25', '2024-07-04 22:08:25', 'python基础实验');
INSERT INTO `courses` VALUES (5, 'c++实训', 23, 6, '20', '2024-07-04 22:08:49', '2024-07-04 22:09:05', 'c++实训');
INSERT INTO `courses` VALUES (6, '数据结构实验', 19, 8, '10', '2024-07-04 22:09:48', '2024-07-04 22:09:48', '数据结构实验');
INSERT INTO `courses` VALUES (7, '数据库基础实验', 21, 10, '20', '2024-07-04 22:10:48', '2024-07-04 22:10:48', '数据库基础实验');
INSERT INTO `courses` VALUES (8, '深入理解计算机系统', 20, 11, '15', '2024-07-04 22:10:52', '2024-07-04 22:15:52', '深入理解计算机系统实验');
INSERT INTO `courses` VALUES (9, 'java实训', 21, 7, '30', '2024-07-04 22:12:42', '2024-07-04 22:15:55', 'java实训实验');
INSERT INTO `courses` VALUES (10, '自动化实训', 4, 13, '50', '2024-07-04 22:15:47', '2024-07-04 22:16:09', '自动化专业实训');
INSERT INTO `courses` VALUES (11, '通讯实训', 6, 14, '40', '2024-07-04 22:17:58', '2024-07-04 22:17:58', '通讯专业的课程实训');
INSERT INTO `courses` VALUES (12, '数字媒体实训', 9, 15, '30', '2024-07-04 22:19:07', '2024-07-04 22:19:30', '数字媒体基础实训课程');
INSERT INTO `courses` VALUES (123, '123', 1, 123, '0', '2024-07-08 17:13:30', '2024-07-08 17:13:29', NULL);
INSERT INTO `courses` VALUES (1232, '123', 4, 1, '6', '2024-07-08 17:18:52', '2024-07-08 17:18:52', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 12313 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of devices
-- ----------------------------
INSERT INTO `devices` VALUES (1, '网络模拟器', '虚拟网络设备', 1, '可用', '2020-01-01 14:31:42', '2024-07-04 17:11:33', '用于模拟复杂网络拓扑和网络性能测试');
INSERT INTO `devices` VALUES (2, '电力系统仿真软件', '软件模拟器', 2, '维修中', '2024-07-03 17:05:23', '2024-07-04 17:05:29', ' 用于电力系统稳定性和负荷分析的软件仿真工具');
INSERT INTO `devices` VALUES (3, '汽车碰撞模拟器', '物理仿真设备', 3, ' 可用', '2024-07-03 17:07:51', '2024-07-04 17:11:31', '用于模拟汽车碰撞及安全性能测试的物理设备');
INSERT INTO `devices` VALUES (4, '机器人仿真平台', '机器人控制仿真', 4, '可用', '2024-07-03 17:08:26', '2024-07-04 17:11:29', '提供各类机器人运动控制仿真及算法验证环境');
INSERT INTO `devices` VALUES (5, '飞行模拟器', '航空模拟设备', 5, '可用', '2024-06-24 17:09:17', '2024-07-04 17:11:26', '用于飞行员培训和飞行器件性能评估的飞行模拟设备');
INSERT INTO `devices` VALUES (6, '3D打印机模拟器', '3D打印模拟器', 6, '可用', '2024-05-27 17:10:19', '2024-07-04 17:11:21', '用于模拟3D打印过程，优化打印参数及打印质量分析');
INSERT INTO `devices` VALUES (7, '焊接仿真机器人', '焊接机器人仿真', 7, '可用', '2024-03-25 17:12:12', '2024-07-04 17:12:17', '用于焊接过程的虚拟仿真和工艺优化');
INSERT INTO `devices` VALUES (8, '化学反应器模拟器', '化学反应器仿真', 8, '维修中', '2024-03-25 17:12:51', '2024-07-02 17:12:57', '用于模拟化学反应过程的虚拟设备，分析反应动力学和产物分布');
INSERT INTO `devices` VALUES (9, '太阳能电池模拟器', '太阳能电池模拟器', 8, '可用', '2024-02-20 17:13:29', '2024-07-04 21:29:18', '用于模拟太阳能电池的性能和发电效率');
INSERT INTO `devices` VALUES (10, '生物反应器模拟软件', '生物工程仿真软件', 10, '可用', '2020-07-04 17:14:09', '2024-07-04 17:14:18', '用于模拟生物反应器内生物过程及反应条件的软件');
INSERT INTO `devices` VALUES (11, '123', '虚拟网络设备', 1, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (12, '123', '软件模拟器', 2, '维修中', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (13, '123', '物理仿真设备', 3, ' 可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (14, '123', '机器人控制仿真', 4, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (15, '123', '航空模拟设备', 5, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (16, '123', '3D打印模拟器', 6, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (17, '123', '焊接机器人仿真', 7, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (18, '123', '化学反应器仿真', 8, '维修中', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (19, '123', '太阳能电池模拟器', 8, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (20, '123', '生物工程仿真软件', 10, '可用', '2024-07-08 19:07:36', '2024-07-08 19:07:36', NULL);
INSERT INTO `devices` VALUES (12312, '123', '物理', 1, '可用', '2024-07-08 17:19:26', '2024-07-08 17:19:26', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of labs
-- ----------------------------
INSERT INTO `labs` VALUES (1, '计算机网络实验室', '3号楼305室', 20, '2024-06-24 14:24:45', '2024-07-04 20:54:01', '提供计算机网络配置、测试和仿真的实验环境', '玲玲');
INSERT INTO `labs` VALUES (2, '电力系统实验室', '4号楼402室', 30, '2024-03-25 17:06:26', '2024-07-04 21:25:06', '用于电力系统稳定性和负荷分析的实验设施', '王五');
INSERT INTO `labs` VALUES (3, '汽车工程实验室', '5号楼507室', 25, '2024-02-27 17:07:15', '2024-07-04 21:25:11', '提供汽车动力学安全性能测试等实验服务', '王五');
INSERT INTO `labs` VALUES (4, '机器人控制实验室', '6号楼601室', 18, '2024-07-04 17:07:18', '2024-07-04 21:18:02', '用于开发和测试各类机器人控制算法和系统', '玲玲');
INSERT INTO `labs` VALUES (5, '飞行模拟实验室', '7号楼703室', 10, '2024-07-04 17:07:19', '2024-07-04 21:25:23', ' 提供飞行员培训和飞行器件性能评估的仿真环境', '杨一');
INSERT INTO `labs` VALUES (6, ' 3D打印实验室', '8号楼801室', 15, '2024-07-04 17:07:22', '2024-07-04 21:24:44', '提供高精度3D打印和材料研发的实验环境', '杨一');
INSERT INTO `labs` VALUES (7, '自动化控制实验室', '9号楼901室', NULL, '2024-07-04 17:07:23', '2024-07-04 21:26:48', '开展自动化控制系统设计和性能测试的实验室', '杨一');
INSERT INTO `labs` VALUES (8, '化学实验室', '4号楼508室', NULL, '2024-07-04 17:07:24', '2024-07-04 21:31:56', '用于模拟化学反应过程的虚拟设备，分析反应动力学和产物分布', '玲玲');
INSERT INTO `labs` VALUES (9, '生物实验室', '5号楼202室', NULL, '2024-07-04 17:07:25', '2024-07-04 21:34:07', '用于模拟生物反应器内生物过程及反应条件', '杨一');
INSERT INTO `labs` VALUES (10, '医药实验室', '4号楼505室', NULL, '2024-07-04 17:07:30', '2024-07-04 21:32:25', '用于模拟医学影像处理和分析的虚拟平台', '王五');
INSERT INTO `labs` VALUES (11, '物理热力实验室', '4号楼202室', NULL, '2024-07-04 17:07:31', '2024-07-04 21:34:17', '用于模拟热力系统和能量传输过程', '王五');
INSERT INTO `labs` VALUES (12, '环境模拟实验室', '7号楼502室', NULL, '2024-07-04 17:07:32', '2024-07-04 21:34:24', '用于模拟环境污染源及分布', '玲玲');

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
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注（资源时间戳）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12345655 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES (1, '计算机网络教学资源', '视频', '计算机网络实训视频', '2024-07-01 15:00:58', '2024-07-08 10:49:56', '计算机网络的实训需完成内容', '123');
INSERT INTO `resources` VALUES (2, '编程实训视频', '视频', '编程实训视频', '2024-07-01 17:26:54', '2024-07-08 14:55:10', '编程实训需完成内容', '1720421706852');
INSERT INTO `resources` VALUES (3, '计算机原理PPT', 'PPT', '计算机组成原理课件PPT', '2024-07-04 21:49:42', '2024-07-08 14:56:31', '计算机原理的课程PPT', '1720421784190');
INSERT INTO `resources` VALUES (4, '软件项目管理附件', 'word', '软件项目管理的课程word', '2024-07-04 21:52:24', '2024-07-08 15:07:34', '软件项目管理的课程报告word', '1720422433107');
INSERT INTO `resources` VALUES (5, 'python学习视频', '音频', 'python基础内容视频', '2024-07-04 21:53:08', '2024-07-08 15:12:46', 'python基础内容的学习视频', '1720422765856');
INSERT INTO `resources` VALUES (6, 'c++基础视频', '视频', 'c++基础内容', '2024-07-04 21:53:54', '2024-07-08 14:30:05', 'c++基础内容视频', NULL);
INSERT INTO `resources` VALUES (7, 'java基础视频', '视频', 'java基础学习', '2024-07-04 21:54:53', '2024-07-04 21:54:53', 'java基础内容视频', NULL);
INSERT INTO `resources` VALUES (8, '数据结构原版电子书', 'PDF', '数据结构电子书', '2024-07-04 21:56:00', '2024-07-04 21:56:00', '包含数据结构的基础内容PDF', NULL);
INSERT INTO `resources` VALUES (9, '数据结构学习视频', '视频', '数据结构基础学习视频', '2024-07-04 21:57:42', '2024-07-08 14:34:22', '数据结构基础学习视频', '1720420461976');
INSERT INTO `resources` VALUES (10, '数据库系统概论PDF', 'PDF', '数据库原书PDF', '2024-07-04 21:58:38', '2024-07-08 14:34:10', '数据结构电子书PDF', '1720420449726');
INSERT INTO `resources` VALUES (11, '深入理解计算机系统', '视频', '深入理解计算机系统学习视频', '2024-07-04 21:59:35', '2024-07-04 21:59:35', '深入理解计算机系统基础学习视频', NULL);
INSERT INTO `resources` VALUES (12, '软件工程导论电子书', 'PDF', '软件工程导论电子书PDF', '2024-07-04 22:02:19', '2024-07-04 22:02:19', '软件工程导论原书PDF', NULL);
INSERT INTO `resources` VALUES (13, '自动化学习视频', '视频', '自动化相关内容学习视频', '2024-07-04 22:15:34', '2024-07-04 22:15:34', '自动化相关内容学习视频', NULL);
INSERT INTO `resources` VALUES (14, '通讯实训手册', 'word', '通讯专业的实训内容', '2024-07-04 22:17:10', '2024-07-04 22:17:13', '通讯专业的实训手册', NULL);
INSERT INTO `resources` VALUES (15, '数媒基础视频', '视频', '数字媒体技术基础学习视频', '2024-07-04 22:18:39', '2024-07-04 22:18:39', '数字媒体技术基础学习视频', NULL);
INSERT INTO `resources` VALUES (16, '123', '音频', NULL, '2024-07-08 14:03:03', '2024-07-08 14:03:02', NULL, NULL);
INSERT INTO `resources` VALUES (17, '1234', '音频', NULL, '2024-07-08 14:05:50', '2024-07-08 14:05:49', NULL, NULL);
INSERT INTO `resources` VALUES (123, '123', '音频', NULL, '2024-07-08 14:19:04', '2024-07-08 14:19:03', NULL, NULL);
INSERT INTO `resources` VALUES (1234, '1346', '音频', NULL, '2024-07-08 14:14:47', '2024-07-08 14:14:47', NULL, NULL);
INSERT INTO `resources` VALUES (12345654, '123132', '音频', NULL, '2024-07-08 17:19:03', '2024-07-08 17:19:02', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '张三', '111', '123456', '111@qq.com', NULL, '13587644861', '2024-06-17 15:32:58', NULL, '超级管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (3, '李四', '113', '1234567', '2932458551@qq.com', NULL, '13587644863', '2024-06-17 15:32:58', NULL, '学生', '重庆邮电大学崇文路2号', '男', 13);
INSERT INTO `users` VALUES (4, '王五', '114', '123456', '114@qq.com', NULL, '13587644864', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (5, '李留', '115', '123456', '115@qq.com', NULL, '13587644865', '2024-06-17 15:32:58', NULL, '学生', '123', NULL, 0);
INSERT INTO `users` VALUES (6, '杨一', '116', '123456', '116@qq.com', NULL, '13587644866', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (7, '赵六', '117', '123456', '117@qq.com', NULL, '13587644860', '2024-06-17 15:32:58', NULL, '学生', '11-17', '女', 23);
INSERT INTO `users` VALUES (8, '钱钱', '118', '123456', '118@qq.com', NULL, '13587644868', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (9, '盛盛', '119', '123456', '119@qq.com', NULL, '13587644869', '2024-06-17 15:32:58', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (10, '耀耀', '1110', '123456', '1110@qq.com', NULL, '13587644811', '2024-06-17 15:32:58', NULL, '管理员', '123', NULL, 0);
INSERT INTO `users` VALUES (12, '鹤鹤', '1112', '123456', '1112@qq.com', NULL, '13587644813', '2024-06-17 15:32:58', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (14, '巧巧', '1114', '123456', '1114@qq.com', NULL, '13587644815', '2024-06-17 15:32:58', NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (15, '覃琴', '123', '123456', '1322@qq.com', NULL, '15555555555', '2024-06-24 17:27:32', NULL, '管理员', NULL, NULL, NULL);
INSERT INTO `users` VALUES (16, '玲玲', '123456', '123456', '2932418555@qq.com', NULL, '18875058888', '2024-07-04 15:16:57', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (17, '俊俊', '45345', '123456', 'abysmiler@163.com', NULL, '18875058555', '2024-07-04 15:20:18', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (18, '浩浩', '1234', '123456', '457815@qq.com', NULL, '15489456465', '2024-05-27 21:38:50', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (19, '杨洋', '15545', '123456', '156156@qq.com', NULL, '15948923565', '2024-04-29 21:39:36', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (20, '盛世', '1261156', '123456', '1256156@qq.com', NULL, '15615645655', '2024-02-14 21:40:23', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (21, '韩克', '152456', '123456', '1564489@qq.com', NULL, '15954651654', '2024-01-18 21:41:04', NULL, '教师', NULL, NULL, NULL);
INSERT INTO `users` VALUES (22, '汪柳', '959', '123456', '566579@qq.com', NULL, '13489444445', '2020-02-20 21:41:55', NULL, '学生', NULL, NULL, NULL);
INSERT INTO `users` VALUES (23, '王柳', '785426', '123465', 'dwasda@qq.com', NULL, '15845646645', '2024-01-24 21:42:50', NULL, '教师', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;

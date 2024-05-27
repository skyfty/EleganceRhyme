/*
 Navicat Premium Data Transfer

 Source Server         : elegance
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : elegance

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 26/03/2024 10:04:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
INSERT INTO `fa_admin` VALUES (1, 'admin', 'Admin', '1a8a808d7fc6cd36988ff3ca37a7b3c1', 'b59475', 'http://localhost:190/assets/img/avatar.png', 'admin@admin.com', '', 0, 1711346408, '0.0.0.0', 1491635035, 1711346408, '8727b12a-e656-442f-b5b3-a6f34c389729', 'normal');

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------
INSERT INTO `fa_admin_log` VALUES (1, 1, 'admin', '/ZUjGpgkWDP.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"FBAX\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346408);
INSERT INTO `fa_admin_log` VALUES (2, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346463);
INSERT INTO `fa_admin_log` VALUES (3, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346491);
INSERT INTO `fa_admin_log` VALUES (4, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346591);
INSERT INTO `fa_admin_log` VALUES (5, 1, 'admin', '/ZUjGpgkWDP.php/addon/install', '插件管理', '{\"name\":\"command\",\"force\":\"0\",\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.1.1\",\"faversion\":\"1.4.0.20230711\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346599);
INSERT INTO `fa_admin_log` VALUES (6, 1, 'admin', '/ZUjGpgkWDP.php/addon/state', '插件管理 / 禁用启用', '{\"name\":\"command\",\"action\":\"enable\",\"force\":\"0\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346600);
INSERT INTO `fa_admin_log` VALUES (7, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346631);
INSERT INTO `fa_admin_log` VALUES (8, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346953);
INSERT INTO `fa_admin_log` VALUES (9, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711346973);
INSERT INTO `fa_admin_log` VALUES (10, 1, 'admin', '/ZUjGpgkWDP.php/addon/local', '插件管理', '{\"uid\":\"77631\",\"token\":\"***\",\"version\":\"1.4.0.20230711\",\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347090);
INSERT INTO `fa_admin_log` VALUES (11, 1, 'admin', '/ZUjGpgkWDP.php/addon/state', '插件管理 / 禁用启用', '{\"name\":\"cms\",\"action\":\"enable\",\"force\":\"0\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347091);
INSERT INTO `fa_admin_log` VALUES (12, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"channel.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"channel.html\",\"searchField\":[\"name\"],\"type\":\"channel\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347247);
INSERT INTO `fa_admin_log` VALUES (13, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"list.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"list.html\",\"searchField\":[\"name\"],\"type\":\"list\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347247);
INSERT INTO `fa_admin_log` VALUES (14, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"show.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"show.html\",\"searchField\":[\"name\"],\"type\":\"show\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347248);
INSERT INTO `fa_admin_log` VALUES (15, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"L\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347251);
INSERT INTO `fa_admin_log` VALUES (16, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"Li\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347251);
INSERT INTO `fa_admin_log` VALUES (17, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"Lis\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347251);
INSERT INTO `fa_admin_log` VALUES (18, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"List\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347252);
INSERT INTO `fa_admin_log` VALUES (19, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"List\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347252);
INSERT INTO `fa_admin_log` VALUES (20, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"List\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347253);
INSERT INTO `fa_admin_log` VALUES (21, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"ListB\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347255);
INSERT INTO `fa_admin_log` VALUES (22, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"ListBoo\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347255);
INSERT INTO `fa_admin_log` VALUES (23, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"ListBook\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347256);
INSERT INTO `fa_admin_log` VALUES (24, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"ListBooks\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347256);
INSERT INTO `fa_admin_log` VALUES (25, 1, 'admin', '/ZUjGpgkWDP.php/cms/modelx/add?dialog=1', 'CMS管理 / 模型管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"ListBooks\",\"table\":\"ListBooks\",\"channeltpl\":\"channel.html\",\"listtpl\":\"list.html\",\"showtpl\":\"show.html\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347263);
INSERT INTO `fa_admin_log` VALUES (26, 1, 'admin', '/ZUjGpgkWDP.php/cms/modelx/add?dialog=1', 'CMS管理 / 模型管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"ListBooks\",\"table\":\"list_books\",\"channeltpl\":\"channel.html\",\"listtpl\":\"list.html\",\"showtpl\":\"show.html\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347284);
INSERT INTO `fa_admin_log` VALUES (27, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"book_name\",\"title\":\"书名\",\"type\":\"string\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347510);
INSERT INTO `fa_admin_log` VALUES (28, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"image\",\"title\":\"封面图片\",\"type\":\"image\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347592);
INSERT INTO `fa_admin_log` VALUES (29, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"images\",\"title\":\"封面图片\",\"type\":\"image\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347598);
INSERT INTO `fa_admin_log` VALUES (30, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"book_image\",\"title\":\"封面图片\",\"type\":\"image\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347613);
INSERT INTO `fa_admin_log` VALUES (31, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/del/source/model/source_id/1', 'CMS管理 / 字段管理 / 删除', '{\"action\":\"del\",\"ids\":\"2\",\"params\":\"\",\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347648);
INSERT INTO `fa_admin_log` VALUES (32, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"sound_file\",\"title\":\"系统录音\",\"type\":\"file\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347697);
INSERT INTO `fa_admin_log` VALUES (33, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"book_file\",\"title\":\"书籍文件\",\"type\":\"file\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347762);
INSERT INTO `fa_admin_log` VALUES (34, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"channel.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"channel.html\",\"searchField\":[\"name\"],\"type\":\"channel\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347789);
INSERT INTO `fa_admin_log` VALUES (35, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"list.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"list.html\",\"searchField\":[\"name\"],\"type\":\"list\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347789);
INSERT INTO `fa_admin_log` VALUES (36, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_template_list', 'CMS管理', '{\"searchTable\":\"tbl\",\"searchKey\":\"name\",\"searchValue\":\"show.html\",\"orderBy\":[[\"name\",\"ASC\"]],\"showField\":\"name\",\"keyField\":\"name\",\"keyValue\":\"show.html\",\"searchField\":[\"name\"],\"type\":\"show\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347790);
INSERT INTO `fa_admin_log` VALUES (37, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"b\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347793);
INSERT INTO `fa_admin_log` VALUES (38, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"bo\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347794);
INSERT INTO `fa_admin_log` VALUES (39, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"bok\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347794);
INSERT INTO `fa_admin_log` VALUES (40, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"bo\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347795);
INSERT INTO `fa_admin_log` VALUES (41, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"boo\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347796);
INSERT INTO `fa_admin_log` VALUES (42, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347796);
INSERT INTO `fa_admin_log` VALUES (43, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347797);
INSERT INTO `fa_admin_log` VALUES (44, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347797);
INSERT INTO `fa_admin_log` VALUES (45, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book_\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347798);
INSERT INTO `fa_admin_log` VALUES (46, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book_sh\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347800);
INSERT INTO `fa_admin_log` VALUES (47, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book_she\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347800);
INSERT INTO `fa_admin_log` VALUES (48, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book_shel\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347800);
INSERT INTO `fa_admin_log` VALUES (49, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"book_shelf\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347801);
INSERT INTO `fa_admin_log` VALUES (50, 1, 'admin', '/ZUjGpgkWDP.php/cms/ajax/get_title_pinyin', 'CMS管理', '{\"title\":\"bookshelf\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347812);
INSERT INTO `fa_admin_log` VALUES (51, 1, 'admin', '/ZUjGpgkWDP.php/cms/modelx/add?dialog=1', 'CMS管理 / 模型管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"name\":\"bookshelf\",\"table\":\"book_shelf\",\"channeltpl\":\"channel.html\",\"listtpl\":\"list.html\",\"showtpl\":\"show.html\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347823);
INSERT INTO `fa_admin_log` VALUES (52, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/2?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"2\",\"name\":\"book_name\",\"title\":\"书名\",\"type\":\"string\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"2\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347870);
INSERT INTO `fa_admin_log` VALUES (53, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/2?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"2\",\"name\":\"book_image\",\"title\":\"封面图片\",\"type\":\"image\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"2\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711347968);
INSERT INTO `fa_admin_log` VALUES (54, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/2?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"2\",\"name\":\"book_file\",\"title\":\"书籍文件\",\"type\":\"file\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"2\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348196);
INSERT INTO `fa_admin_log` VALUES (55, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/1?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"1\",\"name\":\"book_image\",\"title\":\"封面图片\",\"type\":\"image\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"1\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348558);
INSERT INTO `fa_admin_log` VALUES (56, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/2?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"2\",\"name\":\"time_shelf\",\"title\":\"上架时间\",\"type\":\"time\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"2\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348685);
INSERT INTO `fa_admin_log` VALUES (57, 1, 'admin', '/ZUjGpgkWDP.php/cms/fields/add/source/model/source_id/2?dialog=1', 'CMS管理 / 字段管理 / 添加', '{\"dialog\":\"1\",\"row\":{\"source\":\"model\",\"source_id\":\"2\",\"name\":\"sound_file\",\"title\":\"系统录音\",\"type\":\"file\",\"decimals\":\"0\",\"minimum\":\"\",\"maximum\":\"\",\"setting\":{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"},\"content\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"isfilter\":\"0\",\"filterlist\":\"{&quot;value1&quot;:&quot;title1&quot;,&quot;value2&quot;:&quot;title2&quot;}\",\"defaultvalue\":\"\",\"rule\":\"\",\"msg\":\"\",\"ok\":\"\",\"tip\":\"\",\"length\":\"255\",\"isorder\":\"0\",\"iscontribute\":\"0\",\"extend\":\"\",\"status\":\"normal\"},\"source\":\"model\",\"source_id\":\"2\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348912);
INSERT INTO `fa_admin_log` VALUES (58, 1, 'admin', '/ZUjGpgkWDP.php/command/get_field_list', '在线命令管理', '{\"table\":\"fa_admin\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348961);
INSERT INTO `fa_admin_log` VALUES (59, 1, 'admin', '/ZUjGpgkWDP.php/command/get_field_list', '在线命令管理', '{\"table\":\"fa_list_books\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711348991);
INSERT INTO `fa_admin_log` VALUES (60, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/command', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"fa_list_books\",\"controller\":\"background\\/bookbank\\/bookList\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"tagsuffix\":\"\",\"jsonsuffix\":\"\",\"fixedcolumns\":\"\",\"action\":\"command\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349101);
INSERT INTO `fa_admin_log` VALUES (61, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/execute', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"fa_list_books\",\"controller\":\"background\\/bookbank\\/bookList\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"tagsuffix\":\"\",\"jsonsuffix\":\"\",\"fixedcolumns\":\"\",\"action\":\"execute\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349102);
INSERT INTO `fa_admin_log` VALUES (62, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349106);
INSERT INTO `fa_admin_log` VALUES (63, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349109);
INSERT INTO `fa_admin_log` VALUES (64, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/command', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"background\\/bookbank\\/BookList.php\",\"action\":\"command\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349111);
INSERT INTO `fa_admin_log` VALUES (65, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/execute', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"background\\/bookbank\\/BookList.php\",\"action\":\"execute\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349113);
INSERT INTO `fa_admin_log` VALUES (66, 1, 'admin', '/ZUjGpgkWDP.php/command/get_field_list', '在线命令管理', '{\"table\":\"fa_book_shelf\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349198);
INSERT INTO `fa_admin_log` VALUES (67, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/command', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"fa_book_shelf\",\"controller\":\"bookshelf\\/bookbank\\/booklist\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"tagsuffix\":\"\",\"jsonsuffix\":\"\",\"fixedcolumns\":\"\",\"action\":\"command\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349295);
INSERT INTO `fa_admin_log` VALUES (68, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/execute', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"table\":\"fa_book_shelf\",\"controller\":\"bookshelf\\/bookbank\\/booklist\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"tagsuffix\":\"\",\"jsonsuffix\":\"\",\"fixedcolumns\":\"\",\"action\":\"execute\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349296);
INSERT INTO `fa_admin_log` VALUES (69, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349301);
INSERT INTO `fa_admin_log` VALUES (70, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"b\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"b\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349304);
INSERT INTO `fa_admin_log` VALUES (71, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"boo\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"boo\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349305);
INSERT INTO `fa_admin_log` VALUES (72, 1, 'admin', '/ZUjGpgkWDP.php/command/get_controller_list', '在线命令管理', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"OR \",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349308);
INSERT INTO `fa_admin_log` VALUES (73, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/command', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"bookshelf\\/bookbank\\/Booklist.php\",\"action\":\"command\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349310);
INSERT INTO `fa_admin_log` VALUES (74, 1, 'admin', '/ZUjGpgkWDP.php/command/command/action/execute', '在线命令管理 / 生成并执行命令', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"bookshelf\\/bookbank\\/Booklist.php\",\"action\":\"execute\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349313);
INSERT INTO `fa_admin_log` VALUES (75, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/209?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"background\",\"title\":\"书籍管理\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"209\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349383);
INSERT INTO `fa_admin_log` VALUES (76, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/217?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"bookshelf\",\"title\":\"上架书籍\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"217\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349426);
INSERT INTO `fa_admin_log` VALUES (77, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/218?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"217\",\"name\":\"bookshelf\\/bookbank\",\"title\":\"书籍管理\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"218\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349467);
INSERT INTO `fa_admin_log` VALUES (78, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/219?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"218\",\"name\":\"bookshelf\\/bookbank\\/booklist\",\"title\":\"上架列表\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"219\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349489);
INSERT INTO `fa_admin_log` VALUES (79, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/210?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"209\",\"name\":\"background\\/bookbank\",\"title\":\"书籍管理\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"210\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349514);
INSERT INTO `fa_admin_log` VALUES (80, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/211?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"210\",\"name\":\"background\\/bookbank\\/book_list\",\"title\":\"录入列表\",\"url\":\"\",\"icon\":\"fa fa-circle-o\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"211\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349541);
INSERT INTO `fa_admin_log` VALUES (81, 1, 'admin', '/ZUjGpgkWDP.php/auth/rule/edit/ids/209?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"background\",\"title\":\"录入管理\",\"url\":\"\",\"icon\":\"fa fa-list\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"209\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711349726);
INSERT INTO `fa_admin_log` VALUES (82, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711350834);
INSERT INTO `fa_admin_log` VALUES (83, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711351050);
INSERT INTO `fa_admin_log` VALUES (84, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711351084);
INSERT INTO `fa_admin_log` VALUES (85, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711351090);
INSERT INTO `fa_admin_log` VALUES (86, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711351097);
INSERT INTO `fa_admin_log` VALUES (87, 1, 'admin', '/ZUjGpgkWDP.php/background/bookbank/book_list/add?dialog=1', '录入管理 / 书籍管理 / 录入列表 / 添加', '{\"dialog\":\"1\",\"row\":{\"content\":\"琵琶行简介\",\"book_name\":\"琵琶行\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\",\"book_file\":\"\\/uploads\\/20240325\\/a45621b0cb68c09d8c1fa681dded8342.pdf\",\"book_image\":\"\\/uploads\\/20240325\\/40aaab2834f0e697b1364762f2a8b26a.jpg\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711351099);
INSERT INTO `fa_admin_log` VALUES (88, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352023);
INSERT INTO `fa_admin_log` VALUES (89, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352044);
INSERT INTO `fa_admin_log` VALUES (90, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352064);
INSERT INTO `fa_admin_log` VALUES (91, 1, 'admin', '/ZUjGpgkWDP.php/bookshelf/bookbank/booklist/add?dialog=1', '上架书籍 / 书籍管理 / 上架列表 / 添加', '{\"dialog\":\"1\",\"row\":{\"content\":\"琵琶行简介\",\"book_name\":\"琵琶行\",\"book_image\":\"\\/uploads\\/20240325\\/40aaab2834f0e697b1364762f2a8b26a.jpg\",\"book_file\":\"\\/uploads\\/20240325\\/a45621b0cb68c09d8c1fa681dded8342.pdf\",\"time_shelf\":\"15:33:17\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352067);
INSERT INTO `fa_admin_log` VALUES (92, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352100);
INSERT INTO `fa_admin_log` VALUES (93, 1, 'admin', '/ZUjGpgkWDP.php/bookshelf/bookbank/booklist/edit/ids/0?dialog=1', '上架书籍 / 书籍管理 / 上架列表 / 编辑', '{\"dialog\":\"1\",\"row\":{\"content\":\"琵琶行简介\",\"book_name\":\"琵琶行\",\"book_image\":\"\\/uploads\\/20240325\\/40aaab2834f0e697b1364762f2a8b26a.jpg\",\"book_file\":\"\\/uploads\\/20240325\\/4bd7ec31591064a1c8913b5905c8be4e.pdf\",\"time_shelf\":\"15:33:17\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\"},\"ids\":\"0\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352102);
INSERT INTO `fa_admin_log` VALUES (94, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352131);
INSERT INTO `fa_admin_log` VALUES (95, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352137);
INSERT INTO `fa_admin_log` VALUES (96, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352147);
INSERT INTO `fa_admin_log` VALUES (97, 1, 'admin', '/ZUjGpgkWDP.php/bookshelf/bookbank/booklist/add?dialog=1', '上架书籍 / 书籍管理 / 上架列表 / 添加', '{\"dialog\":\"1\",\"row\":{\"content\":\"将进酒简介\",\"book_name\":\"将进酒\",\"book_image\":\"\\/uploads\\/20240325\\/3f7b9349f85712fe0192335604339962.jpg\",\"book_file\":\"\\/uploads\\/20240325\\/a45621b0cb68c09d8c1fa681dded8342.pdf\",\"time_shelf\":\"15:35:05\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352160);
INSERT INTO `fa_admin_log` VALUES (98, 1, 'admin', '/ZUjGpgkWDP.php/bookshelf/bookbank/booklist/add?dialog=1', '上架书籍 / 书籍管理 / 上架列表 / 添加', '{\"dialog\":\"1\",\"row\":{\"content\":\"将进酒简介\",\"book_name\":\"将进酒\",\"book_image\":\"\\/uploads\\/20240325\\/3f7b9349f85712fe0192335604339962.jpg\",\"book_file\":\"\\/uploads\\/20240325\\/a45621b0cb68c09d8c1fa681dded8342.pdf\",\"time_shelf\":\"15:35:05\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352190);
INSERT INTO `fa_admin_log` VALUES (99, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352308);
INSERT INTO `fa_admin_log` VALUES (100, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352314);
INSERT INTO `fa_admin_log` VALUES (101, 1, 'admin', '/ZUjGpgkWDP.php/ajax/upload', '', '{\"category\":\"\"}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352321);
INSERT INTO `fa_admin_log` VALUES (102, 1, 'admin', '/ZUjGpgkWDP.php/background/bookbank/book_list/add?dialog=1', '录入管理 / 书籍管理 / 录入列表 / 添加', '{\"dialog\":\"1\",\"row\":{\"content\":\"将进酒简介\",\"book_name\":\"将进酒\",\"sound_file\":\"\\/uploads\\/20240325\\/b783da9278f15e633cf9d1a7435c945a.wav\",\"book_file\":\"\\/uploads\\/20240325\\/a45621b0cb68c09d8c1fa681dded8342.pdf\",\"book_image\":\"\\/uploads\\/20240325\\/3f7b9349f85712fe0192335604339962.jpg\"}}', '0.0.0.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0', 1711352323);

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_area
-- ----------------------------

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
INSERT INTO `fa_attachment` VALUES (1, '', 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `fa_attachment` VALUES (2, '', 1, 0, '/uploads/20240325/b783da9278f15e633cf9d1a7435c945a.wav', '', '', 'wav', 0, 'recording_66012418513ab.wav', 163244, 'audio/wav', '', 1711350833, 1711350833, 1711350833, 'local', '11f99c151135e10c5d5311b1014ae7b6aea791b5');
INSERT INTO `fa_attachment` VALUES (3, '', 1, 0, '/uploads/20240325/40aaab2834f0e697b1364762f2a8b26a.jpg', '701', '900', 'jpg', 0, '2.jpg', 72371, 'image/jpeg', '', 1711351050, 1711351050, 1711351050, 'local', '965495dd514dee114f6ec0b08449f5e20ad2cc04');
INSERT INTO `fa_attachment` VALUES (4, '', 1, 0, '/uploads/20240325/a45621b0cb68c09d8c1fa681dded8342.pdf', '', '', 'pdf', 0, '1.pdf', 74281, 'application/pdf', '', 1711351090, 1711351090, 1711351090, 'local', 'dc975141e476d1cefb3692d4cfa5f2cbb2f082d6');
INSERT INTO `fa_attachment` VALUES (5, '', 1, 0, '/uploads/20240325/4bd7ec31591064a1c8913b5905c8be4e.pdf', '', '', 'pdf', 0, '2.pdf', 98214, 'application/pdf', '', 1711352100, 1711352100, 1711352100, 'local', '7802b7a11231b2e6e3b88411a66238bdc4ae2624');
INSERT INTO `fa_attachment` VALUES (6, '', 1, 0, '/uploads/20240325/3f7b9349f85712fe0192335604339962.jpg', '701', '900', 'jpg', 0, '1.jpg', 255294, 'image/jpeg', '', 1711352131, 1711352131, 1711352131, 'local', 'df599fa34602937ff26eb4c4bc54c88e3cca7a4d');

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
INSERT INTO `fa_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
INSERT INTO `fa_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 225 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
INSERT INTO `fa_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1491635035, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', 1, NULL, '', 'cjgl', 'chajianguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', 1, NULL, '', 'jsz', 'juesezu', 1491635035, 1491635035, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `fa_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `fa_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `fa_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `fa_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (85, 'file', 0, 'command', '在线命令管理', 'fa fa-terminal', '', '', '', 1, NULL, '', 'zxmlgl', 'zaixianminglingguanli', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (86, 'file', 85, 'command/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (87, 'file', 85, 'command/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (88, 'file', 85, 'command/detail', '详情', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xq', 'xiangqing', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (89, 'file', 85, 'command/command', '生成并执行命令', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'scbzxml', 'shengchengbingzhixingmingling', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (90, 'file', 85, 'command/execute', '再次执行命令', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zczxml', 'zaicizhixingmingling', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (91, 'file', 85, 'command/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (92, 'file', 85, 'command/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711346599, 1711346599, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (93, 'file', 0, 'cms', 'CMS管理', 'fa fa-file-text', '', '', '', 1, NULL, '', 'Cgl', 'CMSguanli', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (94, 'file', 93, 'cms/config', '站点配置', 'fa fa-gears', '', '', '', 1, NULL, '', 'zdpz', 'zhandianpeizhi', 1711347089, 1711347089, 22, 'normal');
INSERT INTO `fa_auth_rule` VALUES (95, 'file', 94, 'cms/config/index', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (96, 'file', 93, 'cms/statistics', '统计控制台', 'fa fa-bar-chart', '', '', '', 1, NULL, '', 'tjkzt', 'tongjikongzhitai', 1711347089, 1711347089, 21, 'normal');
INSERT INTO `fa_auth_rule` VALUES (97, 'file', 96, 'cms/statistics/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (98, 'file', 93, 'cms/channel', '栏目管理', 'fa fa-list', '', '', '用于管理网站的分类、设置导航分类', 1, NULL, '', 'lmgl', 'lanmuguanli', 1711347089, 1711347089, 20, 'normal');
INSERT INTO `fa_auth_rule` VALUES (99, 'file', 98, 'cms/channel/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (100, 'file', 98, 'cms/channel/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (101, 'file', 98, 'cms/channel/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (102, 'file', 98, 'cms/channel/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (103, 'file', 98, 'cms/channel/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (104, 'file', 98, 'cms/channel/admin', '栏目授权', 'fa fa-circle-o', '', '', '分配管理员可管理的栏目数据，此功能需要先开启站点配置栏目授权开关', 0, NULL, '', 'lmsq', 'lanmushouquan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (105, 'file', 93, 'cms/archives', '内容管理', 'fa fa-file-text-o', '', '', '', 1, NULL, '', 'nrgl', 'neirongguanli', 1711347089, 1711347089, 19, 'normal');
INSERT INTO `fa_auth_rule` VALUES (106, 'file', 105, 'cms/archives/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (107, 'file', 105, 'cms/archives/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (108, 'file', 105, 'cms/archives/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (109, 'file', 105, 'cms/archives/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (110, 'file', 105, 'cms/archives/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (111, 'file', 105, 'cms/archives/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (112, 'file', 105, 'cms/archives/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (113, 'file', 105, 'cms/archives/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (114, 'file', 93, 'cms/modelx', '模型管理', 'fa fa-th', '', '', '在线添加修改删除模型，管理模型字段', 1, NULL, '', 'mxgl', 'moxingguanli', 1711347089, 1711347089, 18, 'normal');
INSERT INTO `fa_auth_rule` VALUES (115, 'file', 114, 'cms/modelx/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (116, 'file', 114, 'cms/modelx/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (117, 'file', 114, 'cms/modelx/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (118, 'file', 114, 'cms/modelx/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (119, 'file', 114, 'cms/modelx/duplicate', '复制', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'fz', 'fuzhi', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (120, 'file', 114, 'cms/modelx/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (121, 'file', 93, 'cms/fields', '字段管理', 'fa fa-fields', '', '', '用于管理模型或表单的字段，灰色为主表字段无法删除', 0, NULL, '', 'zdgl', 'ziduanguanli', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (122, 'file', 121, 'cms/fields/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (123, 'file', 121, 'cms/fields/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (124, 'file', 121, 'cms/fields/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (125, 'file', 121, 'cms/fields/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (126, 'file', 121, 'cms/fields/duplicate', '复制', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'fz', 'fuzhi', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (127, 'file', 121, 'cms/fields/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (128, 'file', 93, 'cms/tag', '标签管理', 'fa fa-tags', '', '', '用于管理文章关联的标签,标签的添加在添加文章时自动维护,无需手动添加标签', 1, NULL, '', 'bqgl', 'biaoqianguanli', 1711347089, 1711347089, 17, 'normal');
INSERT INTO `fa_auth_rule` VALUES (129, 'file', 128, 'cms/tag/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (130, 'file', 128, 'cms/tag/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (131, 'file', 128, 'cms/tag/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (132, 'file', 128, 'cms/tag/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (133, 'file', 128, 'cms/tag/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (134, 'file', 93, 'cms/block', '区块管理', 'fa fa-th-large', '', '', '用于管理站点的自定义区块内容，常用于广告、JS脚本、焦点图、片段代码等', 1, NULL, '', 'qkgl', 'qukuaiguanli', 1711347089, 1711347089, 16, 'normal');
INSERT INTO `fa_auth_rule` VALUES (135, 'file', 134, 'cms/block/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (136, 'file', 134, 'cms/block/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (137, 'file', 134, 'cms/block/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (138, 'file', 134, 'cms/block/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (139, 'file', 134, 'cms/block/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (140, 'file', 93, 'cms/page', '单页管理', 'fa fa-file', '', '', '用于管理网站的单页面', 1, NULL, '', 'dygl', 'danyeguanli', 1711347089, 1711347089, 15, 'normal');
INSERT INTO `fa_auth_rule` VALUES (141, 'file', 140, 'cms/page/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (142, 'file', 140, 'cms/page/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (143, 'file', 140, 'cms/page/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (144, 'file', 140, 'cms/page/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (145, 'file', 140, 'cms/page/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (146, 'file', 140, 'cms/page/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (147, 'file', 140, 'cms/page/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (148, 'file', 140, 'cms/page/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (149, 'file', 93, 'cms/search_log', '搜索记录管理', 'fa fa-history', '', '', '用于管理网站的搜索记录日志', 1, NULL, '', 'ssjlgl', 'sousuojiluguanli', 1711347089, 1711347089, 15, 'normal');
INSERT INTO `fa_auth_rule` VALUES (150, 'file', 149, 'cms/search_log/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (151, 'file', 149, 'cms/search_log/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (152, 'file', 149, 'cms/search_log/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (153, 'file', 149, 'cms/search_log/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (154, 'file', 149, 'cms/search_log/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (155, 'file', 93, 'cms/comment', '评论管理', 'fa fa-comment', '', '', '用于管理用户在网站上发表的评论', 1, NULL, '', 'plgl', 'pinglunguanli', 1711347089, 1711347089, 14, 'normal');
INSERT INTO `fa_auth_rule` VALUES (156, 'file', 155, 'cms/comment/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (157, 'file', 155, 'cms/comment/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (158, 'file', 155, 'cms/comment/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (159, 'file', 155, 'cms/comment/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (160, 'file', 155, 'cms/comment/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (161, 'file', 155, 'cms/comment/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (162, 'file', 155, 'cms/comment/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (163, 'file', 155, 'cms/comment/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (164, 'file', 93, 'cms/diyform', '自定义表单管理', 'fa fa-list', '', '', '可在线创建自定义表单，管理表单字段和数据列表', 1, NULL, '', 'zdybdgl', 'zidingyibiaodanguanli', 1711347089, 1711347089, 13, 'normal');
INSERT INTO `fa_auth_rule` VALUES (165, 'file', 164, 'cms/diyform/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (166, 'file', 164, 'cms/diyform/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (167, 'file', 164, 'cms/diyform/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (168, 'file', 164, 'cms/diyform/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (169, 'file', 164, 'cms/diyform/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (170, 'file', 93, 'cms/diydata', '自定义表单数据管理', 'fa fa-list', '', '', '可在线管理自定义表单的数据列表', 0, NULL, '', 'zdybdsjgl', 'zidingyibiaodanshujuguanli', 1711347089, 1711347089, 12, 'normal');
INSERT INTO `fa_auth_rule` VALUES (171, 'file', 170, 'cms/diydata/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (172, 'file', 170, 'cms/diydata/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (173, 'file', 170, 'cms/diydata/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (174, 'file', 170, 'cms/diydata/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (175, 'file', 170, 'cms/diydata/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (176, 'file', 170, 'cms/diydata/import', '导入', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'dr', 'daoru', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (177, 'file', 93, 'cms/order', '订单管理', 'fa fa-cny', '', '', '可在线管理付费查看所产生的订单', 1, NULL, '', 'ddgl', 'dingdanguanli', 1711347089, 1711347089, 11, 'normal');
INSERT INTO `fa_auth_rule` VALUES (178, 'file', 177, 'cms/order/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (179, 'file', 177, 'cms/order/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (180, 'file', 177, 'cms/order/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (181, 'file', 177, 'cms/order/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (182, 'file', 177, 'cms/order/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (183, 'file', 93, 'cms/special', '专题管理', 'fa fa-newspaper-o', '', '', '可在线管理专题列表', 1, NULL, '', 'ztgl', 'zhuantiguanli', 1711347089, 1711347089, 10, 'normal');
INSERT INTO `fa_auth_rule` VALUES (184, 'file', 183, 'cms/special/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (185, 'file', 183, 'cms/special/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (186, 'file', 183, 'cms/special/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (187, 'file', 183, 'cms/special/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (188, 'file', 183, 'cms/special/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (189, 'file', 183, 'cms/special/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (190, 'file', 183, 'cms/special/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (191, 'file', 183, 'cms/special/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (192, 'file', 93, 'cms/builder', '标签生成器', 'fa fa-code', '', '', '可在线生成模板标签并进行渲染标签', 1, NULL, '', 'bqscq', 'biaoqianshengchengqi', 1711347089, 1711347089, 10, 'normal');
INSERT INTO `fa_auth_rule` VALUES (193, 'file', 192, 'cms/builder/index', '生成', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shengcheng', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (194, 'file', 192, 'cms/builder/parse', '解析', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'jx', 'jiexi', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (195, 'file', 93, 'cms/autolink', '自动链接管理', 'fa fa-link', '', '', '管理文章正文内文本自动链接', 1, NULL, '', 'zdljgl', 'zidonglianjieguanli', 1711347089, 1711347089, 11, 'normal');
INSERT INTO `fa_auth_rule` VALUES (196, 'file', 195, 'cms/autolink/index', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (197, 'file', 195, 'cms/autolink/add', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (198, 'file', 195, 'cms/autolink/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (199, 'file', 195, 'cms/autolink/del', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (200, 'file', 195, 'cms/autolink/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (201, 'file', 93, 'cms/spider_log', '搜索引擎来访管理', 'fa fa-search', '', '', '可在线管理搜索引擎蜘蛛来访记录', 1, NULL, '', 'ssyqlfgl', 'sousuoyinqinglaifangguanli', 1711347089, 1711347089, 14, 'normal');
INSERT INTO `fa_auth_rule` VALUES (202, 'file', 201, 'cms/spider_log/index', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (203, 'file', 201, 'cms/spider_log/add', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (204, 'file', 201, 'cms/spider_log/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (205, 'file', 201, 'cms/spider_log/del', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (206, 'file', 201, 'cms/spider_log/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (207, 'file', 93, 'cms/theme', '移动端样式管理', 'fa fa-magic', '', '', '在线对移动端、H5、小程序的样式和导航栏进行调整', 1, NULL, '', 'yddysgl', 'yidongduanyangshiguanli', 1711347089, 1711347089, 11, 'normal');
INSERT INTO `fa_auth_rule` VALUES (208, 'file', 207, 'cms/theme/index', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711347089, 1711347089, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (209, 'file', 0, 'background', '录入管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'lrgl', 'luruguanli', 1711349113, 1711349726, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (210, 'file', 209, 'background/bookbank', '书籍管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'sjgl', 'shujiguanli', 1711349113, 1711349514, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (211, 'file', 210, 'background/bookbank/book_list', '录入列表', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'lrlb', 'luruliebiao', 1711349113, 1711349541, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (212, 'file', 211, 'background/bookbank/book_list/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711349113, 1711349113, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (213, 'file', 211, 'background/bookbank/book_list/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711349113, 1711349113, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (214, 'file', 211, 'background/bookbank/book_list/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711349113, 1711349113, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (215, 'file', 211, 'background/bookbank/book_list/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711349113, 1711349113, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (216, 'file', 211, 'background/bookbank/book_list/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711349113, 1711349113, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (217, 'file', 0, 'bookshelf', '上架书籍', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'sjsj', 'shangjiashuji', 1711349313, 1711349426, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (218, 'file', 217, 'bookshelf/bookbank', '书籍管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'sjgl', 'shujiguanli', 1711349313, 1711349467, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (219, 'file', 218, 'bookshelf/bookbank/booklist', '上架列表', 'fa fa-circle-o', '', '', '', 1, 'addtabs', '', 'sjlb', 'shangjialiebiao', 1711349313, 1711349489, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (220, 'file', 219, 'bookshelf/bookbank/booklist/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711349313, 1711349313, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (221, 'file', 219, 'bookshelf/bookbank/booklist/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711349313, 1711349313, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (222, 'file', 219, 'bookshelf/bookbank/booklist/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711349313, 1711349313, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (223, 'file', 219, 'bookshelf/bookbank/booklist/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711349313, 1711349313, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (224, 'file', 219, 'bookshelf/bookbank/booklist/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711349313, 1711349313, 0, 'normal');

-- ----------------------------
-- Table structure for fa_book_shelf
-- ----------------------------
DROP TABLE IF EXISTS `fa_book_shelf`;
CREATE TABLE `fa_book_shelf`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '书名',
  `book_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '封面图片',
  `book_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '书籍文件',
  `time_shelf` time NULL DEFAULT NULL COMMENT '上架时间',
  `sound_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '系统录音',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'bookshelf' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_book_shelf
-- ----------------------------
INSERT INTO `fa_book_shelf` VALUES (1, '琵琶行简介', '琵琶行', '/uploads/20240325/40aaab2834f0e697b1364762f2a8b26a.jpg', '/uploads/20240325/4bd7ec31591064a1c8913b5905c8be4e.pdf', '15:33:17', '/uploads/20240325/b783da9278f15e633cf9d1a7435c945a.wav');
INSERT INTO `fa_book_shelf` VALUES (2, '将进酒简介', '将进酒', '/uploads/20240325/3f7b9349f85712fe0192335604339962.jpg', '/uploads/20240325/a45621b0cb68c09d8c1fa681dded8342.pdf', '15:35:05', '/uploads/20240325/b783da9278f15e633cf9d1a7435c945a.wav');

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_category
-- ----------------------------
INSERT INTO `fa_category` VALUES (1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_category` VALUES (2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_category` VALUES (3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1491635035, 1491635035, 3, 'normal');
INSERT INTO `fa_category` VALUES (4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_category` VALUES (5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_category` VALUES (6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_category` VALUES (7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_category` VALUES (8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_category` VALUES (9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_category` VALUES (10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_category` VALUES (11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_category` VALUES (12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_category` VALUES (13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1491635035, 1491635035, 13, 'normal');

-- ----------------------------
-- Table structure for fa_cms_addondownload
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_addondownload`;
CREATE TABLE `fa_cms_addondownload`  (
  `id` int(10) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `os` set('windows','linux','mac','ubuntu') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最新版本',
  `filesize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件大小',
  `language` set('zh-cn','en') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '语言',
  `downloadurl` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `screenshots` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '预览截图',
  `downloads` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '下载次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '下载' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_addondownload
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_addonnews
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_addonnews`;
CREATE TABLE `fa_cms_addonnews`  (
  `id` int(10) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_addonnews
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_addonproduct
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_addonproduct`;
CREATE TABLE `fa_cms_addonproduct`  (
  `id` int(10) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `productdata` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '产品列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_addonproduct
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_archives
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_archives`;
CREATE TABLE `fa_cms_archives`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `channel_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '栏目ID',
  `channel_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '副栏目ID集合',
  `model_id` int(10) NOT NULL DEFAULT 0 COMMENT '模型ID',
  `special_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '专题ID集合',
  `admin_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '管理员ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标题',
  `flag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志',
  `style` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '样式',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组图',
  `seotitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'TAG',
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '价格',
  `outlink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '外部链接',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `comments` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论次数',
  `likes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `dislikes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点踩数',
  `diyname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义URL',
  `isguest` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否访客访问',
  `iscomment` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否允许评论',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `publishtime` bigint(16) NULL DEFAULT NULL COMMENT '发布时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` enum('normal','hidden','draft','prepare','rejected','pulloff') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diyname`(`diyname`) USING BTREE,
  INDEX `channel_id`(`channel_id`) USING BTREE,
  INDEX `channel_ids`(`channel_ids`) USING BTREE,
  INDEX `weigh`(`weigh`, `publishtime`) USING BTREE,
  INDEX `channel_id_2`(`channel_id`) USING BTREE,
  INDEX `channel_ids_2`(`channel_ids`) USING BTREE,
  INDEX `diyname_2`(`diyname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_archives
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_autolink
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_autolink`;
CREATE TABLE `fa_cms_autolink`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接',
  `target` enum('self','blank') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'blank' COMMENT '打开方式',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '排序',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击次数',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '自动链接表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_autolink
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_block
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_block`;
CREATE TABLE `fa_cms_block`  (
  `id` smallint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `parsetpl` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '解析模板标签',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `begintime` bigint(16) NULL DEFAULT NULL COMMENT '开始时间',
  `endtime` bigint(16) NULL DEFAULT NULL COMMENT '结束时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_block
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_channel
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_channel`;
CREATE TABLE `fa_cms_channel`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` enum('channel','page','link','list') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型',
  `model_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '模型ID',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `flag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志',
  `seotitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `outlink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '外部链接',
  `linktype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接类型',
  `linkid` int(10) NULL DEFAULT 0 COMMENT '链接ID',
  `items` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章数量',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `channeltpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目页模板',
  `listtpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '列表页模板',
  `showtpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '详情页模板',
  `pagesize` smallint(5) NOT NULL DEFAULT 0 COMMENT '分页大小',
  `vip` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT 'VIP',
  `listtype` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '列表数据类型',
  `iscontribute` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可投稿',
  `isnav` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否导航显示',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `diyname`(`diyname`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE,
  INDEX `type_2`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '栏目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_channel
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_channel_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_channel_admin`;
CREATE TABLE `fa_cms_channel_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `channel_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '栏目ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_id`(`admin_id`, `channel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '栏目权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_channel_admin
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_collection
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_collection`;
CREATE TABLE `fa_cms_collection`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` enum('archives','special','page','diyform') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `aid` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '关联ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '会员ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收藏标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'URL',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `aid`(`type`, `aid`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_collection
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_comment
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_comment`;
CREATE TABLE `fa_cms_comment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `type` enum('archives','page','special') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'archives' COMMENT '类型',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联ID',
  `pid` int(10) NOT NULL DEFAULT 0 COMMENT '父ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `comments` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User Agent',
  `subscribe` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订阅',
  `createtime` bigint(16) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` bigint(16) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post_id`(`aid`, `pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_diyform
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_diyform`;
CREATE TABLE `fa_cms_diyform`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '管理员ID',
  `name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表单名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `seotitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `posttitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发布标题',
  `keywords` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名',
  `fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '字段列表',
  `isguest` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否访客访问',
  `needlogin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否需要登录发布',
  `isedit` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否允许编辑',
  `iscaptcha` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否启用验证码',
  `successtips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '成功提示文字',
  `redirecturl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '成功后跳转链接',
  `posttpl` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表单页模板',
  `listtpl` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '列表页模板',
  `showtpl` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '详情页模板',
  `diyname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义名称',
  `usermode` enum('all','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'all' COMMENT '用户筛选模式',
  `statusmode` enum('all','normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'all' COMMENT '状态筛选模式',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `setting` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单配置',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'hidden' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diyname`(`diyname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '自定义表单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_diyform
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_fields
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_fields`;
CREATE TABLE `fa_cms_fields`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `source` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '来源',
  `source_id` int(10) NOT NULL DEFAULT 0 COMMENT '来源ID',
  `name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `filterlist` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '筛选列表',
  `defaultvalue` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '默认值',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `msg` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `ok` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '成功消息',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `decimals` tinyint(1) NULL DEFAULT NULL COMMENT '小数点',
  `length` mediumint(8) NULL DEFAULT NULL COMMENT '长度',
  `minimum` smallint(6) NULL DEFAULT NULL COMMENT '最小数量',
  `maximum` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大数量',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展信息',
  `setting` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置信息',
  `favisible` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '显示条件',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '排序',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `isorder` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可排序',
  `iscontribute` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可投稿',
  `isfilter` tinyint(1) NOT NULL DEFAULT 0 COMMENT '筛选',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `source`(`source`) USING BTREE,
  INDEX `source_id`(`source_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '模型字段表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_fields
-- ----------------------------
INSERT INTO `fa_cms_fields` VALUES (1, 'model', 1, 'book_name', 'string', '书名', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 1, 1711347510, 1711347510, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (3, 'model', 1, 'sound_file', 'file', '系统录音', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 3, 1711347697, 1711347697, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (4, 'model', 1, 'book_file', 'file', '书籍文件', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 4, 1711347762, 1711347762, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (5, 'model', 2, 'book_name', 'string', '书名', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 5, 1711347870, 1711347870, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (6, 'model', 2, 'book_image', 'image', '封面图片', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 6, 1711347968, 1711347968, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (7, 'model', 2, 'book_file', 'file', '书籍文件', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 7, 1711348196, 1711348196, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (8, 'model', 1, 'book_image', 'image', '封面图片', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 8, 1711348558, 1711348558, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (9, 'model', 2, 'time_shelf', 'time', '上架时间', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 9, 1711348685, 1711348685, 0, 0, 0, 'normal');
INSERT INTO `fa_cms_fields` VALUES (10, 'model', 2, 'sound_file', 'file', '系统录音', 'value1|title1\r\nvalue2|title2', 'value1|title1\r\nvalue2|title2', '', '', '', '', '', 0, 255, 0, 0, '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}', '', 10, 1711348912, 1711348912, 0, 0, 0, 'normal');

-- ----------------------------
-- Table structure for fa_cms_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_friendlink`;
CREATE TABLE `fa_cms_friendlink`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '会员ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '站点名称',
  `image` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '站点Logo',
  `website` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '站点链接',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `memo` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` enum('normal','hidden','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'hidden' COMMENT '状态',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '站点介绍',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `createtime`(`createtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友情链接' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_friendlink
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_message
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_message`;
CREATE TABLE `fa_cms_message`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NULL DEFAULT NULL COMMENT '会员ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '姓名',
  `telephone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电话',
  `qq` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'QQ',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `os` enum('windows','mac') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'windows' COMMENT '操作系统',
  `language` set('zh-cn','en') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '语言',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地区',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `createtime`(`createtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '站内留言' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_message
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_model
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_model`;
CREATE TABLE `fa_cms_model`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模型名称',
  `table` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名',
  `fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '字段列表',
  `channeltpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目页模板',
  `listtpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '列表页模板',
  `showtpl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '详情页模板',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '模型配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '内容模型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_model
-- ----------------------------
INSERT INTO `fa_cms_model` VALUES (1, 'ListBooks', 'list_books', 'book_name,sound_file,book_file,book_image', 'channel.html', 'list.html', 'show.html', 1711347284, 1711347284, '{\"contributefields\":[\"channel_ids\",\"image\",\"images\",\"tags\",\"price\",\"outlink\",\"content\",\"keywords\",\"description\"],\"publishfields\":[\"channel_ids\",\"user_id\",\"special_ids\",\"image\",\"images\",\"diyname\",\"tags\",\"price\",\"outlink\",\"content\",\"seotitle\",\"keywords\",\"description\"]}');
INSERT INTO `fa_cms_model` VALUES (2, 'bookshelf', 'book_shelf', 'book_name,book_image,book_file,time_shelf,sound_file', 'channel.html', 'list.html', 'show.html', 1711347823, 1711347823, '{\"contributefields\":[\"channel_ids\",\"image\",\"images\",\"tags\",\"price\",\"outlink\",\"content\",\"keywords\",\"description\"],\"publishfields\":[\"channel_ids\",\"user_id\",\"special_ids\",\"image\",\"images\",\"diyname\",\"tags\",\"price\",\"outlink\",\"content\",\"seotitle\",\"keywords\",\"description\"]}');

-- ----------------------------
-- Table structure for fa_cms_navigation
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_navigation`;
CREATE TABLE `fa_cms_navigation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '会员ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '导航链接',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `memo` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` enum('normal','hidden','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'hidden' COMMENT '状态',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '介绍',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `createtime`(`createtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '热门导航' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_navigation
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_order
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_order`;
CREATE TABLE `fa_cms_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `orderid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单ID',
  `user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '会员ID',
  `archives_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '文档ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单标题',
  `amount` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '订单金额',
  `payamount` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '支付金额',
  `paytype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付类型',
  `paytime` bigint(16) NULL DEFAULT NULL COMMENT '支付时间',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付方法',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'UserAgent',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('created','paid','expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'created' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `archives_id`(`archives_id`) USING BTREE,
  INDEX `orderid`(`orderid`) USING BTREE,
  INDEX `orderid_2`(`orderid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_order
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_page
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_page`;
CREATE TABLE `fa_cms_page`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(10) NOT NULL DEFAULT 0 COMMENT '分类ID',
  `admin_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '管理员ID',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `seotitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `flag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击',
  `likes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞',
  `dislikes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点踩',
  `comments` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论',
  `diyname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义',
  `showtpl` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视图模板',
  `iscomment` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否允许评论',
  `parsetpl` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '解析模板标签',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diyname`(`diyname`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `diyname_2`(`diyname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '单页表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_page
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_search_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_search_log`;
CREATE TABLE `fa_cms_search_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `keywords` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `nums` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '搜索次数',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '搜索时间',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'hidden' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `keywords`(`keywords`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '搜索记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_search_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_special
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_special`;
CREATE TABLE `fa_cms_special`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '管理员ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `tag_ids` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签ID集合',
  `flag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志',
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Banner图片',
  `diyname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `seotitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专题介绍',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '浏览次数',
  `comments` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '评论次数',
  `iscomment` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否允许评论',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `template` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '专题模板',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `diyname`(`diyname`) USING BTREE,
  INDEX `diyname_2`(`diyname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '专题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_special
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_spider_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_spider_log`;
CREATE TABLE `fa_cms_spider_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` enum('index','archives','page','special','channel','diyform','tag','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `aid` int(10) NULL DEFAULT 0 COMMENT '关联ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '来访页面',
  `nums` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '来访次数',
  `firsttime` bigint(16) NULL DEFAULT NULL COMMENT '首次来访时间',
  `lastdata` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后5次来访时间',
  `lasttime` bigint(16) NULL DEFAULT NULL COMMENT '最后来访时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`type`, `aid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '搜索引擎来访记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_spider_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_tag
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_tag`;
CREATE TABLE `fa_cms_tag`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签名称',
  `nums` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文档数量',
  `seotitle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `views` int(10) NULL DEFAULT NULL COMMENT '浏览次数',
  `autolink` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '自动内链',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `nums`(`nums`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_tag
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_taggable
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_taggable`;
CREATE TABLE `fa_cms_taggable`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tag_id` int(10) NULL DEFAULT NULL COMMENT '标签ID',
  `archives_id` int(10) NULL DEFAULT NULL COMMENT '文档ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  INDEX `archives_id`(`archives_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_cms_taggable
-- ----------------------------

-- ----------------------------
-- Table structure for fa_command
-- ----------------------------
DROP TABLE IF EXISTS `fa_command`;
CREATE TABLE `fa_command`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '命令',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回结果',
  `executetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '执行时间',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('successed','failured') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线命令表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_command
-- ----------------------------
INSERT INTO `fa_command` VALUES (1, 'crud', '[\"--table=fa_list_books\",\"--controller=background\\/bookbank\\/bookList\"]', 'php think crud --table=fa_list_books --controller=background/bookbank/bookList', 'Build Successed', 1711349102, 1711349102, 1711349102, 'successed');
INSERT INTO `fa_command` VALUES (2, 'menu', '[\"--controller=background\\/bookbank\\/BookList\"]', 'php think menu --controller=background/bookbank/BookList', 'Build Successed!', 1711349113, 1711349113, 1711349113, 'successed');
INSERT INTO `fa_command` VALUES (3, 'crud', '[\"--table=fa_book_shelf\",\"--controller=bookshelf\\/bookbank\\/booklist\"]', 'php think crud --table=fa_book_shelf --controller=bookshelf/bookbank/booklist', 'Build Successed', 1711349296, 1711349296, 1711349296, 'successed');
INSERT INTO `fa_command` VALUES (4, 'menu', '[\"--controller=bookshelf\\/bookbank\\/Booklist\"]', 'php think menu --controller=bookshelf/bookbank/Booklist', 'Build Successed!', 1711349313, 1711349313, 1711349313, 'successed');

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '可见条件',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_config
-- ----------------------------
INSERT INTO `fa_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '雅韵', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.1', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `fa_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', '10000', '', '', '', '');
INSERT INTO `fa_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'string', '', 'password', '', '', '', '');
INSERT INTO `fa_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '', '10000@qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}', '', '', '', '');

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_ems
-- ----------------------------

-- ----------------------------
-- Table structure for fa_list_books
-- ----------------------------
DROP TABLE IF EXISTS `fa_list_books`;
CREATE TABLE `fa_list_books`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '书名',
  `sound_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '系统录音',
  `book_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '书籍文件',
  `book_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '封面图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'ListBooks' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_list_books
-- ----------------------------
INSERT INTO `fa_list_books` VALUES (1, '琵琶行简介', '琵琶行', '/uploads/20240325/b783da9278f15e633cf9d1a7435c945a.wav', '/uploads/20240325/a45621b0cb68c09d8c1fa681dded8342.pdf', '/uploads/20240325/40aaab2834f0e697b1364762f2a8b26a.jpg');
INSERT INTO `fa_list_books` VALUES (2, '将进酒简介', '将进酒', '/uploads/20240325/b783da9278f15e633cf9d1a7435c945a.wav', '/uploads/20240325/a45621b0cb68c09d8c1fa681dded8342.pdf', '/uploads/20240325/3f7b9349f85712fe0192335604339962.jpg');

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_sms
-- ----------------------------

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT 0 COMMENT '会员ID',
  `admin_id` int(10) NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '省市',
  `json` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击',
  `workrange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '时间区间',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) NULL DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '测试表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_test
-- ----------------------------
INSERT INTO `fa_test` VALUES (1, 1, 1, 12, '12,13', '互联网,计算机', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '我是一篇测试文章描述，内容过多时将自动隐藏', '广西壮族自治区/百色市/平果县', '{\"a\":\"1\",\"b\":\"2\"}', '[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]', 0.00, 0, '2020-10-01 00:00:00 - 2021-10-31 23:59:59', '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '积分',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` bigint(16) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user
-- ----------------------------
INSERT INTO `fa_user` VALUES (1, 1, 'admin', 'admin', 'ef12a92e0478c46a39382f0333822f72', '01e3b8', 'admin@163.com', '13888888888', 'http://localhost:190/assets/img/avatar.png', 0, 0, '2017-04-08', '', 0.00, 0, 1, 1, 1491635035, 1491635035, '127.0.0.1', 0, '127.0.0.1', 1491635035, 0, 1491635035, '', 'normal', '');

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限节点',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
INSERT INTO `fa_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_money_log`;
CREATE TABLE `fa_user_money_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更余额',
  `before` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更前余额',
  `after` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员余额变动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
INSERT INTO `fa_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_score_log`;
CREATE TABLE `fa_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员积分变动表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员Token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fa_version
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;

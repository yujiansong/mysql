/*
Navicat MySQL Data Transfer

Source Server         : line
Source Server Version : 50718
Source Host           : rm-bp1631p2rg544sro10o.mysql.rds.aliyuncs.com:3306
Source Database       : clinic

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-09-12 16:34:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ss_wxlogin_data
-- ----------------------------
DROP TABLE IF EXISTS `ss_wxlogin_data`;
CREATE TABLE `ss_wxlogin_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '逻辑id',
  `staff_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '员工登录id',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '员工手机号',
  `true_name` varchar(20) NOT NULL DEFAULT '' COMMENT '员工名字',
  `clinic_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '诊所id',
  `clinic_name` varchar(25) NOT NULL DEFAULT '' COMMENT '诊所名称',
  `manager_id` smallint(5) NOT NULL DEFAULT '0' COMMENT '登录账号id',
  `login_time` int(11) NOT NULL DEFAULT '0' COMMENT '登录时间',
  `login_type` enum('2','1') NOT NULL DEFAULT '1' COMMENT '1->自己登录, 2->重新登录',
  PRIMARY KEY (`id`),
  KEY `idx_staff_id` (`staff_id`) USING BTREE COMMENT '员工id',
  KEY `idx_clinic_id` (`clinic_id`) USING BTREE COMMENT '诊所id'
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COMMENT='微信河狸口腔云用户登录日志';

-- ----------------------------
-- Records of ss_wxlogin_data
-- ----------------------------
INSERT INTO `ss_wxlogin_data` VALUES ('1', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536718885', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('2', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536718974', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('3', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536718975', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('4', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719059', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('5', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719093', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('6', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536719567', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('7', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536719580', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('8', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536719588', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('9', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536719588', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('10', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536719593', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('11', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719799', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('12', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719799', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('13', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719803', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('14', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719808', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('15', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719814', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('16', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719824', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('17', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719827', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('18', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719831', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('19', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719838', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('20', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536719839', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('21', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719868', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('22', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719870', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('23', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719874', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('24', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719878', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('25', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719879', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('26', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719880', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('27', '8685', '15207554040', '李先生', '8323', '传承口腔门诊部', '8703', '1536719882', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('28', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720119', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('29', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536720145', '1');
INSERT INTO `ss_wxlogin_data` VALUES ('30', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536720146', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('31', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720161', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('32', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720168', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('33', '205', '13728742758', '刘志专', '87', '深圳张珊诊所', '218', '1536720169', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('34', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720179', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('35', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720186', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('36', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720642', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('37', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720650', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('38', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720664', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('39', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720697', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('40', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720714', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('41', '8621', '15818754087', '15818754087', '8282', '周世测试', '8640', '1536720755', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('42', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740245', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('43', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740272', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('44', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740318', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('45', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740329', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('46', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740344', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('47', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740371', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('48', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740388', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('49', '8680', '13924608604', '潘俊卓', '8318', '珮裴齿科', '8699', '1536740407', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('50', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536740731', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('51', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536740735', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('52', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741151', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('53', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741168', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('54', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741180', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('55', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741197', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('56', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741208', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('57', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741222', '2');
INSERT INTO `ss_wxlogin_data` VALUES ('58', '8680', '13924608604', '潘俊卓', '8318', '珮斐齿科', '8699', '1536741233', '2');

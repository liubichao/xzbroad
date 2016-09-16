/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : xzgd

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2016-09-15 22:20:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT '',
  `descrition` varchar(1000) DEFAULT '',
  `texturl` varchar(200) DEFAULT '',
  `url` varchar(500) DEFAULT '',
  `thumbnailUrl` varchar(500) DEFAULT NULL,
  `sort` int(11) DEFAULT '0',
  `content` varchar(2000) DEFAULT '',
  `categoryId` varchar(50) DEFAULT '',
  `istop` tinyint(1) DEFAULT '1',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_categoryIdA` (`categoryId`),
  CONSTRAINT `FK_categoryIdA` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for buyproductrecords
-- ----------------------------
DROP TABLE IF EXISTS `buyproductrecords`;
CREATE TABLE `buyproductrecords` (
  `id` varchar(50) NOT NULL,
  `smartCardId` varchar(50) DEFAULT '',
  `type` tinyint(1) DEFAULT '1',
  `payProgramId` varchar(50) DEFAULT '',
  `count` int(11) DEFAULT '1',
  `amount` decimal(10,2) DEFAULT '0.00',
  `giftCardId` varchar(50) DEFAULT '',
  `state` tinyint(1) DEFAULT '0',
  `username` varchar(50) DEFAULT '',
  `mobilephone` varchar(50) DEFAULT '',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_paypid` (`payProgramId`),
  CONSTRAINT `FK_paypid` FOREIGN KEY (`payProgramId`) REFERENCES `payproduct` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购买付费产品记录';

-- ----------------------------
-- Records of buyproductrecords
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT '',
  `parentId` varchar(50) DEFAULT '',
  `sort` int(11) DEFAULT '0',
  `module` varchar(20) DEFAULT '' COMMENT '模型   article文章，goods商品',
  `level` tinyint(1) DEFAULT '0' COMMENT '层级',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('04fe151fbb534338ac8e2c9875247b98', '五金', '1111', '0', '', '0', '1', '2016-09-13 18:09:07', '2016-09-13 18:09:07');
INSERT INTO `category` VALUES ('1', '分类管理', '0', '0', '', '0', '1', '2016-09-13 13:38:53', '2016-09-13 13:38:53');
INSERT INTO `category` VALUES ('1111', '商品', '1', '1', 'goods', '0', '1', '2016-09-13 13:49:25', '2016-09-13 13:49:25');
INSERT INTO `category` VALUES ('1112', '文章', '1', '2', 'article', '0', '1', '2016-09-13 13:49:53', '2016-09-13 13:49:53');
INSERT INTO `category` VALUES ('119b813429e3417a977c534b6eeca99b', '电视机', '4c39cde839d84175b35a2c47e0b9e6f0', '1', '', '0', '1', '2016-09-13 18:57:25', '2016-09-13 18:57:25');
INSERT INTO `category` VALUES ('14c80d67eb7d4a00b54ea50d02530ec4', '电线', '04fe151fbb534338ac8e2c9875247b98', '0', '', '0', '1', '2016-09-13 18:57:30', '2016-09-13 18:57:30');
INSERT INTO `category` VALUES ('4c39cde839d84175b35a2c47e0b9e6f0', '家电', '1111', '1', '', '0', '1', '2016-09-13 18:09:17', '2016-09-13 18:09:17');
INSERT INTO `category` VALUES ('8d4f11db10104f73a20a1864fa86688d', '冰箱', '4c39cde839d84175b35a2c47e0b9e6f0', '2', '', '0', '1', '2016-09-14 15:43:27', '2016-09-14 15:43:27');
INSERT INTO `category` VALUES ('bc34b319c472499a86d69a1bb5fcb105', '商城', '1112', '1', '', '0', '1', '2016-09-13 18:08:54', '2016-09-13 18:08:54');
INSERT INTO `category` VALUES ('cec69065da414a71b56252280b8dca03', '彩票', '1112', '0', '', '0', '1', '2016-09-13 18:08:40', '2016-09-13 18:08:40');
INSERT INTO `category` VALUES ('d7a04c71f0914f51a451149539e67dab', '水管', '04fe151fbb534338ac8e2c9875247b98', '1', '', '0', '1', '2016-09-14 15:43:56', '2016-09-14 15:43:56');

-- ----------------------------
-- Table structure for exchangedgoods
-- ----------------------------
DROP TABLE IF EXISTS `exchangedgoods`;
CREATE TABLE `exchangedgoods` (
  `id` varchar(50) NOT NULL,
  `type` tinyint(1) DEFAULT '1',
  `categoryId` varchar(50) DEFAULT '',
  `descrition` varchar(1000) DEFAULT '',
  `content` varchar(2000) DEFAULT '',
  `costIntegral` int(11) DEFAULT '1',
  `amount` decimal(10,2) DEFAULT '0.00',
  `goodsName` varchar(100) DEFAULT '',
  `url` varchar(500) DEFAULT '',
  `thumbnailUrl` varchar(500) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `sort` int(11) DEFAULT '0',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='可以兑换的商品';

-- ----------------------------
-- Records of exchangedgoods
-- ----------------------------
INSERT INTO `exchangedgoods` VALUES ('9a21be9199054067a277b1b8fe1299b5', '3', '8d4f11db10104f73a20a1864fa86688d', '', '双开', '5000', '500.00', '海尔冰箱', '/ARTICLE_IMG/20160915/Image_1473947796231672067.jpg', '/ARTICLE_IMG/20160915/thumbnail/Image_1473947796231672067.jpg', '5', '2016-09-14 16:12:21', '2016-10-05 16:12:24', '3', '1', '2016-09-14 16:12:48', '2016-09-14 16:12:48');
INSERT INTO `exchangedgoods` VALUES ('c1d7da77ef634ad7ba587a16959b3771', '1', '119b813429e3417a977c534b6eeca99b', '', '4K 55寸大屏幕', '10000', '0.00', '海信电视机', '/ARTICLE_IMG/20160915/Image_1473947809129887861.jpg', '/ARTICLE_IMG/20160915/thumbnail/Image_1473947809129887861.jpg', '2', '2016-09-14 15:52:57', '2016-09-21 15:52:59', '1', '1', '2016-09-14 15:56:00', '2016-09-14 15:56:00');
INSERT INTO `exchangedgoods` VALUES ('d1de9c7072f14a0d8e7ed225a6e83299', '1', '8d4f11db10104f73a20a1864fa86688d', '', '三门冰箱', '8000', '0.00', '海尔冰箱', '/ARTICLE_IMG/20160915/Image_1473947816913185363.jpg', '/ARTICLE_IMG/20160915/thumbnail/Image_1473947816913185363.jpg', '5', '2016-09-14 15:57:10', '2016-09-28 15:57:13', '2', '1', '2016-09-14 15:57:20', '2016-09-14 15:57:20');

-- ----------------------------
-- Table structure for expressinfo
-- ----------------------------
DROP TABLE IF EXISTS `expressinfo`;
CREATE TABLE `expressinfo` (
  `id` varchar(50) NOT NULL,
  `wechatId` varchar(50) DEFAULT '',
  `name` varchar(50) DEFAULT '',
  `mobilephone` varchar(50) DEFAULT '',
  `telphone` varchar(50) DEFAULT '',
  `zipcode` varchar(10) DEFAULT '',
  `isdefault` tinyint(1) DEFAULT '0',
  `address` varchar(200) DEFAULT '',
  `remark` varchar(500) DEFAULT '',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户快递信息';

-- ----------------------------
-- Records of expressinfo
-- ----------------------------
INSERT INTO `expressinfo` VALUES ('1', '1111', '善柔', '13588889999', '010-89898989', '123456', '0', '天津路特一号', '该地址的有效性还有待查证', '1', '2016-09-15 10:10:05', '2016-09-15 10:10:05');

-- ----------------------------
-- Table structure for failurereport
-- ----------------------------
DROP TABLE IF EXISTS `failurereport`;
CREATE TABLE `failurereport` (
  `id` varchar(50) NOT NULL,
  `wechatId` varchar(50) DEFAULT '',
  `type` varchar(50) DEFAULT '',
  `name` varchar(50) DEFAULT '',
  `telphone` varchar(20) DEFAULT '',
  `address` varchar(200) DEFAULT '',
  `email` varchar(200) DEFAULT '',
  `content` varchar(2000) DEFAULT '',
  `state` tinyint(1) DEFAULT '0',
  `remark` varchar(2000) DEFAULT '',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of failurereport
-- ----------------------------
INSERT INTO `failurereport` VALUES ('1', '030c0ce722e743b2951db55c84219795', '2', '项少龙', '13455556666', '香港路一号', '123@qq.com', '有线电视从09月15日开始没有信号', '1', '好好坏的好', '1', '2016-09-14 17:27:01', '2016-09-14 17:27:01');

-- ----------------------------
-- Table structure for integralexchangerecord
-- ----------------------------
DROP TABLE IF EXISTS `integralexchangerecord`;
CREATE TABLE `integralexchangerecord` (
  `id` varchar(50) NOT NULL,
  `wechatId` varchar(50) DEFAULT '',
  `type` tinyint(1) DEFAULT '1',
  `costIntegral` int(11) DEFAULT '0',
  `amount` decimal(10,2) DEFAULT '0.00',
  `goodsId` varchar(50) DEFAULT '',
  `goodsName` varchar(100) DEFAULT '',
  `goodsImage` varchar(500) DEFAULT '',
  `count` int(11) DEFAULT '1',
  `expressId` varchar(50) DEFAULT '',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_GOODSID` (`goodsId`),
  KEY `FK_exprid` (`expressId`),
  CONSTRAINT `FK_GOODSID` FOREIGN KEY (`goodsId`) REFERENCES `exchangedgoods` (`id`),
  CONSTRAINT `FK_exprid` FOREIGN KEY (`expressId`) REFERENCES `expressinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分兑换记录';

-- ----------------------------
-- Records of integralexchangerecord
-- ----------------------------

-- ----------------------------
-- Table structure for logclear
-- ----------------------------
DROP TABLE IF EXISTS `logclear`;
CREATE TABLE `logclear` (
  `id` varchar(50) NOT NULL,
  `type` tinyint(1) DEFAULT '0',
  `remainDay` int(11) DEFAULT '30',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logclear
-- ----------------------------
INSERT INTO `logclear` VALUES ('1', '0', '30', '1', '2016-09-11 14:01:16', '2016-09-11 14:01:16');

-- ----------------------------
-- Table structure for loginfo
-- ----------------------------
DROP TABLE IF EXISTS `loginfo`;
CREATE TABLE `loginfo` (
  `ID` varchar(50) NOT NULL,
  `USERNAME` varchar(50) DEFAULT NULL,
  `USERACTION` varchar(500) DEFAULT '',
  `USERIP` varchar(50) DEFAULT '',
  `PROGRAMINFO` varchar(2000) DEFAULT '',
  `ISVALID` tinyint(1) DEFAULT '1',
  `LASTCHANGEDTIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CREATETIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_USERNAME` (`USERNAME`),
  CONSTRAINT `fk_USERNAME` FOREIGN KEY (`USERNAME`) REFERENCES `users` (`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginfo
-- ----------------------------
INSERT INTO `loginfo` VALUES ('00b404e9060443238848e2de20592b36', 'admin', 'login', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:52:42', '2016-09-14 17:52:42');
INSERT INTO `loginfo` VALUES ('030c0ce722e743b2951db55c84219795', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 13:21:23', '2016-09-14 13:21:23');
INSERT INTO `loginfo` VALUES ('098600672a084a8e9735fcbf6bdefad5', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:46:31', '2016-09-14 17:46:31');
INSERT INTO `loginfo` VALUES ('0a8a62024b20449099d54ba62472b46a', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 14:45:25', '2016-09-15 14:45:25');
INSERT INTO `loginfo` VALUES ('0d0420cdb2ea4bc697919067bf29b627', 'admin', 'delete', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from failureReport where id = \'2\'----- result : 1', '1', '2016-09-14 17:50:08', '2016-09-14 17:50:08');
INSERT INTO `loginfo` VALUES ('10e29099223d4814b3d95033863179fa', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:49:41', '2016-09-14 17:49:41');
INSERT INTO `loginfo` VALUES ('120f3e590a884c49a77f94a12e41e628', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 10:41:46', '2016-09-15 10:41:46');
INSERT INTO `loginfo` VALUES ('141b7af9b1284f24aabf1da75c4639b1', 'admin', '修改数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE category S SET S.name = \'电视机\',S.isvalid = \'1\',S.sort = \'1\' WHERE S.id = \'119b813429e3417a977c534b6eeca99b\'----- result : 1', '1', '2016-09-14 15:43:17', '2016-09-14 15:43:17');
INSERT INTO `loginfo` VALUES ('15e4241b9cd6471f9799055bb563bb22', 'admin', '修改数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE category S SET S.name = \'电线\',S.isvalid = \'1\',S.sort = \'0\' WHERE S.id = \'14c80d67eb7d4a00b54ea50d02530ec4\'----- result : 1', '1', '2016-09-14 15:43:49', '2016-09-14 15:43:49');
INSERT INTO `loginfo` VALUES ('16d3224a079342849765bd88b9b3a1be', 'admin', '修改数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE category S SET S.name = \'电工\',S.isvalid = \'1\',S.sort = \'0\' WHERE S.id = \'14c80d67eb7d4a00b54ea50d02530ec4\'----- result : 1', '1', '2016-09-14 15:43:03', '2016-09-14 15:43:03');
INSERT INTO `loginfo` VALUES ('1c73c7d83f7a4bbc9c8b42acd61ac640', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:16:42', '2016-09-14 15:16:42');
INSERT INTO `loginfo` VALUES ('1de4a3fef9da433e82674c2e487fe5da', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.lastChangedTime = \'2016-09-14 17:27:01.0\',S.address = \'香港路一号\',S.telphone = \'13455556666\',S.name = \'项少龙\',S.wechatId = \'030c0ce722e743b2951db55c84219795\',S.remark = \'已安排工程师前往\',S.state = \'1\',S.type = \'2\',S.email = \'123@qq.com\',S.content = \'有线电视从09月15日开始没有信号\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-14 17:41:34', '2016-09-14 17:41:34');
INSERT INTO `loginfo` VALUES ('1de75baa5b7748a396fac2c8f0abc528', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:28:46', '2016-09-15 21:28:46');
INSERT INTO `loginfo` VALUES ('1df1aa18142c4277aaa121a7934ea9d3', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:03:58', '2016-09-14 15:03:58');
INSERT INTO `loginfo` VALUES ('1e5da3939db64576a72ed5562adde66f', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 12:31:28', '2016-09-15 12:31:28');
INSERT INTO `loginfo` VALUES ('1e5eadb5d7d84bdc845907b5b3c2ca4b', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:46:36', '2016-09-15 13:46:36');
INSERT INTO `loginfo` VALUES ('1f7d8b17fe8f4c8286bffaa85e34f590', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:08:29', '2016-09-15 13:08:29');
INSERT INTO `loginfo` VALUES ('2126b8e94c6e4d449f0d1ea5c2237073', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:50:20', '2016-09-15 21:50:20');
INSERT INTO `loginfo` VALUES ('2601b3b58d7443928f86db4677fa80e1', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:11:30', '2016-09-14 15:11:30');
INSERT INTO `loginfo` VALUES ('284b03a63e3c415baea4658ad938b96a', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:44:20', '2016-09-15 13:44:20');
INSERT INTO `loginfo` VALUES ('2a9bbb4bfbec4722a73eae7526083db9', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 13:26:12', '2016-09-14 13:26:12');
INSERT INTO `loginfo` VALUES ('2b4d4b53d66f47499d64f450e54c6ee4', 'admin', '添加数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.save(ServiceImpl.java:38)---- insert into category(id,name,isvalid,sort,parentId) values (\'d7a04c71f0914f51a451149539e67dab\',\'水管\',\'1\',\'1\',\'04fe151fbb534338ac8e2c9875247b98\')----- result : 1', '1', '2016-09-14 15:43:56', '2016-09-14 15:43:56');
INSERT INTO `loginfo` VALUES ('2c09feeae3fb49e293affd32d7bdfba1', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:55:19', '2016-09-15 21:55:19');
INSERT INTO `loginfo` VALUES ('2c14ec47d79743af9f06e8e5b5c016e6', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.lastChangedTime = \'2016-09-14 17:43:13.0\',S.address = \'2\',S.telphone = \'2\',S.name = \'2\',S.remark = \'\',S.state = \'0\',S.type = \'1\',S.email = \'2\',S.content = \'2\' WHERE S.id = \'2\'----- result : 1', '1', '2016-09-14 17:46:49', '2016-09-14 17:46:49');
INSERT INTO `loginfo` VALUES ('2e78f64936894863aec613b2c80eb6c1', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE rechargeRecord S SET S.remark = \'\',S.state = \'0\',S.type = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 10:47:19', '2016-09-15 10:47:19');
INSERT INTO `loginfo` VALUES ('309b0a8b767d4ebd80442a58985fe428', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:30:04', '2016-09-14 15:30:04');
INSERT INTO `loginfo` VALUES ('3255db40c8354b9f897761b952961f09', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:06:41', '2016-09-14 15:06:41');
INSERT INTO `loginfo` VALUES ('353a76130bca4b8986ac94781682abe3', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:34:18', '2016-09-14 15:34:18');
INSERT INTO `loginfo` VALUES ('38098bc756574bcb96c596aba999fe7f', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 14:27:15', '2016-09-14 14:27:15');
INSERT INTO `loginfo` VALUES ('3af7bc03e147495db007b6f3dfb51666', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'eae371ac34a3449bac5d872902d787bb\'----- result : 1', '1', '2016-09-14 14:37:23', '2016-09-14 14:37:23');
INSERT INTO `loginfo` VALUES ('3cdd823e50224cc9a6d0a5a57654f380', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 16:38:16', '2016-09-14 16:38:16');
INSERT INTO `loginfo` VALUES ('3edc86531a4f4238b2064eb05bab2034', 'admin', '添加数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.save(ServiceImpl.java:38)---- insert into payProduct(id,amount,unit,rate,discountType,disamount,sort,title,payProgramId,content,ispredefine) values (\'835f4237849d488e866efa583e2b6e06\',\'6.00\',\'元\',\'100\',\'0\',\'0.00\',\'0\',\'测试\',\'13\',\'测试\',\'0\')----- result : 1', '1', '2016-09-14 13:16:38', '2016-09-14 13:16:38');
INSERT INTO `loginfo` VALUES ('403241abdb9d45d4a2177b85c31999b5', 'admin', 'update', '192.168.0.88', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.remark = \'好好坏的好\',S.state = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-14 17:56:35', '2016-09-14 17:56:35');
INSERT INTO `loginfo` VALUES ('4744c28aba8b487895b7a2ab518d9050', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:56:42', '2016-09-15 13:56:42');
INSERT INTO `loginfo` VALUES ('4a207baeac2c4952ba2fee7676289cec', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE expressinfo S SET S.remark = \'\',S.state = \'0\',S.type = \'1\' WHERE S.id = \'1\'----- result : -1', '1', '2016-09-15 10:44:30', '2016-09-15 10:44:30');
INSERT INTO `loginfo` VALUES ('4b3bca4716424df3b8f1acc1e3b13942', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 14:29:13', '2016-09-14 14:29:13');
INSERT INTO `loginfo` VALUES ('4bcf763f10134f4fba783598ee288b9d', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 16:19:12', '2016-09-14 16:19:12');
INSERT INTO `loginfo` VALUES ('4f915bfbe9764cbc88dde0d4ef7b37ee', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:60)----UPDATE rechargeRecord S SET S.remark = \'\',S.state = \'0\',S.type = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 22:00:22', '2016-09-15 22:00:22');
INSERT INTO `loginfo` VALUES ('50062dddbdca4fe8ba6bf256a7862d8e', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:48:14', '2016-09-14 15:48:14');
INSERT INTO `loginfo` VALUES ('5270046f45ea49ed8ac20eb898375beb', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:14:13', '2016-09-15 21:14:13');
INSERT INTO `loginfo` VALUES ('53fe254432d649bd8374a467cf50219d', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE expressinfo S SET S.remark = \'该地址的有效性还有待查证\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 10:14:51', '2016-09-15 10:14:51');
INSERT INTO `loginfo` VALUES ('563c9cee435646bc8d96c9f03b1aea22', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE expressinfo S SET S.remark = \'\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 10:14:23', '2016-09-15 10:14:23');
INSERT INTO `loginfo` VALUES ('5860049b4e1c4927a5b9739058ade500', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:60)----UPDATE expressinfo S SET S.remark = \'\',S.state = \'0\',S.type = \'1\' WHERE S.id = \'1\'----- result : -1', '1', '2016-09-15 21:57:39', '2016-09-15 21:57:39');
INSERT INTO `loginfo` VALUES ('58a1a61c12e44689b28fcae4612a32b0', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:22:18', '2016-09-15 21:22:18');
INSERT INTO `loginfo` VALUES ('5d10a2870e9544cb9ebbf8e1854878c7', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:40:09', '2016-09-14 15:40:09');
INSERT INTO `loginfo` VALUES ('62e95198787f4f23b4f8d0c7390e47e4', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 13:15:47', '2016-09-14 13:15:47');
INSERT INTO `loginfo` VALUES ('679034e0b2ac4bc98f16a4ef960b025f', 'admin', '删除数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'b8cee3a5f75d46bfa967a7273c59de3a\'----- result : 1', '1', '2016-09-14 15:38:01', '2016-09-14 15:38:01');
INSERT INTO `loginfo` VALUES ('6881f43e8b01473eba786d8c52218b19', 'admin', '登录系统', '192.168.0.88', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 16:00:11', '2016-09-14 16:00:11');
INSERT INTO `loginfo` VALUES ('69d5b67aa9ef4c3b935f6d3490de4b83', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 12:50:26', '2016-09-15 12:50:26');
INSERT INTO `loginfo` VALUES ('6a4ebe6c926746c19406dd7f51a67348', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:22:34', '2016-09-14 15:22:34');
INSERT INTO `loginfo` VALUES ('6bf1f2614eb244ee8fb09b59c3df42f0', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 11:26:12', '2016-09-15 11:26:12');
INSERT INTO `loginfo` VALUES ('6fefa73cbe4143d6927f4089fc62595a', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:18:01', '2016-09-14 15:18:01');
INSERT INTO `loginfo` VALUES ('720abf1b240749b58cdc94cf6432632d', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from scrollPicture where id = \'004a9fbc8625434ca79199b4071c38b8\'----- result : 1', '1', '2016-09-14 13:16:01', '2016-09-14 13:16:01');
INSERT INTO `loginfo` VALUES ('73a50bb749fc436fb486e51925952a28', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.lastChangedTime = \'2016-09-14 17:27:01.0\',S.address = \'香港路一号\',S.telphone = \'13455556666\',S.name = \'项少龙\',S.wechatId = \'030c0ce722e743b2951db55c84219795\',S.discountType = \'1\',S.remark = \'已经安排工程师前往处理~\',S.email = \'123@qq.com\',S.content = \'有线电视从09月15日开始没有信号\' WHERE S.id = \'1\'----- result : -1', '1', '2016-09-14 17:30:13', '2016-09-14 17:30:13');
INSERT INTO `loginfo` VALUES ('7693e068637d4e4fb7e4dc69153f8f6b', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 09:27:44', '2016-09-15 09:27:44');
INSERT INTO `loginfo` VALUES ('776da40a8b314d0085f554416d64cbbe', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from payProduct where id = \'835f4237849d488e866efa583e2b6e06\'----- result : 1', '1', '2016-09-14 13:17:04', '2016-09-14 13:17:04');
INSERT INTO `loginfo` VALUES ('7779072565524d9ea8cfc5ba17cb5062', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 14:21:00', '2016-09-14 14:21:00');
INSERT INTO `loginfo` VALUES ('799976d5d52f4ccaac7eb06e235136f9', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:45:19', '2016-09-15 21:45:19');
INSERT INTO `loginfo` VALUES ('7a02900eb92b40c591827c05ee05589a', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 10:36:38', '2016-09-15 10:36:38');
INSERT INTO `loginfo` VALUES ('7b09cfcc2ac94ffb9e3c09bea303b784', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:29:07', '2016-09-14 17:29:07');
INSERT INTO `loginfo` VALUES ('7bfa0757fd8f45479ae88821b25cf6bd', 'admin', '添加数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.save(ServiceImpl.java:38)---- insert into category(id,name,isvalid,sort,parentId) values (\'8d4f11db10104f73a20a1864fa86688d\',\'冰箱\',\'1\',\'2\',\'4c39cde839d84175b35a2c47e0b9e6f0\')----- result : 1', '1', '2016-09-14 15:43:28', '2016-09-14 15:43:28');
INSERT INTO `loginfo` VALUES ('7c3378bd9a5a4f07af654c208335033f', 'admin', 'update', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.remark = \'\',S.state = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-14 17:52:58', '2016-09-14 17:52:58');
INSERT INTO `loginfo` VALUES ('7ee7e93136fd423d8ca1a64a2dc700a0', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:18:05', '2016-09-15 21:18:05');
INSERT INTO `loginfo` VALUES ('7ef1e10014334afea50284381b7967cb', 'admin', '删除数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'e90a05b0da65499f89f86ef8d8150a36\'----- result : 1', '1', '2016-09-14 15:48:25', '2016-09-14 15:48:25');
INSERT INTO `loginfo` VALUES ('856749fb89fc4cd8a8865e12b5d5de95', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 16:36:12', '2016-09-14 16:36:12');
INSERT INTO `loginfo` VALUES ('899ee954344b4509affac2a50522e0a6', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 11:28:47', '2016-09-15 11:28:47');
INSERT INTO `loginfo` VALUES ('8c7bdce41f57488fb060ac067a681589', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:60)----UPDATE expressinfo S SET S.remark = \'该地址的有效性还有待查证\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 17:47:05', '2016-09-15 17:47:05');
INSERT INTO `loginfo` VALUES ('8ed2ed8b4fe746cda8ffae317c6fcc98', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 10:10:09', '2016-09-15 10:10:09');
INSERT INTO `loginfo` VALUES ('905cbc3083634ee69e480e66faa24b61', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 08:16:31', '2016-09-15 08:16:31');
INSERT INTO `loginfo` VALUES ('9425b1b0016b4aa0b91307fa72d18e74', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:14:30', '2016-09-15 13:14:30');
INSERT INTO `loginfo` VALUES ('95292bddcd864bc99cb69d333257b360', 'admin', '删除数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'669b3d0a0a4e464098280d86d2835963\'----- result : 1', '1', '2016-09-14 15:32:47', '2016-09-14 15:32:47');
INSERT INTO `loginfo` VALUES ('998eaf1a85824319816138d1aa6e85bb', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 22:00:08', '2016-09-15 22:00:08');
INSERT INTO `loginfo` VALUES ('9a3aac0010cc46988751b0a895f27604', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:36:43', '2016-09-14 17:36:43');
INSERT INTO `loginfo` VALUES ('a6d72c655f1946239458199ad759a27b', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE failureReport S SET S.lastChangedTime = \'2016-09-14 17:27:01.0\',S.address = \'香港路一号\',S.telphone = \'13455556666\',S.name = \'项少龙\',S.wechatId = \'030c0ce722e743b2951db55c84219795\',S.remark = \'\',S.state = \'1\',S.type = \'2\',S.email = \'123@qq.com\',S.content = \'有线电视从09月15日开始没有信号\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-14 17:41:02', '2016-09-14 17:41:02');
INSERT INTO `loginfo` VALUES ('a7bb23df47df4f3e8474bd4c1c6cb756', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:27:04', '2016-09-14 15:27:04');
INSERT INTO `loginfo` VALUES ('a9c128c0a0a447df825f15cc018a706c', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 12:54:53', '2016-09-15 12:54:53');
INSERT INTO `loginfo` VALUES ('aa278df02c5444b8a195eba752ae04ff', 'admin', 'login', '192.168.0.88', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:55:34', '2016-09-14 17:55:34');
INSERT INTO `loginfo` VALUES ('aa311a5aa8c94d048b639fec23767b32', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 10:46:19', '2016-09-15 10:46:19');
INSERT INTO `loginfo` VALUES ('aa6c188e8ce3400f8216e0ee6445b803', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 16:10:54', '2016-09-14 16:10:54');
INSERT INTO `loginfo` VALUES ('adfad36e5d104212ae015e4004bc3d85', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:25:27', '2016-09-14 15:25:27');
INSERT INTO `loginfo` VALUES ('ae38df088447435b949cfa110c620e37', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'a1f6caa2645d4694bd44feac5170b230\'----- result : 1', '1', '2016-09-14 13:50:01', '2016-09-14 13:50:01');
INSERT INTO `loginfo` VALUES ('b03d62f229c64d198a14540f2a46a121', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:30:05', '2016-09-15 13:30:05');
INSERT INTO `loginfo` VALUES ('b10df984c22648dcbb80d5363c5b1aab', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'2843b0a3e8ca43c6899549fbfd766321\'----- result : 1', '1', '2016-09-14 14:21:54', '2016-09-14 14:21:54');
INSERT INTO `loginfo` VALUES ('b17bf513c0b842a2b47c39f06b3bb20b', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:37:24', '2016-09-14 15:37:24');
INSERT INTO `loginfo` VALUES ('b60125661bcf42fc828556924b284ce3', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 12:56:16', '2016-09-15 12:56:16');
INSERT INTO `loginfo` VALUES ('b677db920b454ffc8a4992b9bc91b01f', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE category S SET S.name = \'文章\',S.isvalid = \'1\',S.sort = \'2\' WHERE S.id = \'1112\'----- result : 1', '1', '2016-09-14 16:50:13', '2016-09-14 16:50:13');
INSERT INTO `loginfo` VALUES ('b79878f192ed4a4bb118b12be4403318', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:20:48', '2016-09-14 15:20:48');
INSERT INTO `loginfo` VALUES ('b80c1fc69a1141fb92d5469c68c7e747', 'admin', '登录系统', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:32:29', '2016-09-14 15:32:29');
INSERT INTO `loginfo` VALUES ('bd9d4965637440b983241f8ba2f36950', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:62)----UPDATE rechargeRecord S SET S.remark = \'已处理\',S.state = \'1\',S.type = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 10:47:35', '2016-09-15 10:47:35');
INSERT INTO `loginfo` VALUES ('bf40132060e24fb7871a79287f8ca330', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:30:23', '2016-09-15 13:30:23');
INSERT INTO `loginfo` VALUES ('cb10cdff979a43c489782547af2bc457', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 14:52:49', '2016-09-15 14:52:49');
INSERT INTO `loginfo` VALUES ('d0bdd22473ab478da498010852e4d21b', 'admin', '删除数据', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from exchangedGoods where id = \'b5496ab10a5d4c34bacd497cd6f179af\'----- result : 1', '1', '2016-09-14 15:48:22', '2016-09-14 15:48:22');
INSERT INTO `loginfo` VALUES ('d23d608a211e47ab975e9c55b8b80d42', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 09:37:52', '2016-09-15 09:37:52');
INSERT INTO `loginfo` VALUES ('d2fb5b4e69f24afb9874d19a4c882a34', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 21:56:09', '2016-09-15 21:56:09');
INSERT INTO `loginfo` VALUES ('d82f5a5d055e4481b4e5cc3cb663cd26', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:60)----UPDATE category S SET S.name = \'电视机\',S.isvalid = \'1\',S.sort = \'1\' WHERE S.id = \'119b813429e3417a977c534b6eeca99b\'----- result : 1', '1', '2016-09-15 17:48:26', '2016-09-15 17:48:26');
INSERT INTO `loginfo` VALUES ('db466a48e71b446a86cf10bc69f394d1', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 13:48:59', '2016-09-14 13:48:59');
INSERT INTO `loginfo` VALUES ('db4b0c40212a46b89e43ad3ca0cdeb9a', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:22:57', '2016-09-15 13:22:57');
INSERT INTO `loginfo` VALUES ('e0e77c4490b64db2adc0bb5cd6a11158', 'admin', '删除数据', '192.168.0.254', 'com.keerinfo.springmvc.service.impl.ServiceImpl.delete(ServiceImpl.java:87)----delete from scrollPicture where id = \'d397db8e1cd14c56b54b76c415de0b14\'----- result : 1', '1', '2016-09-14 13:15:58', '2016-09-14 13:15:58');
INSERT INTO `loginfo` VALUES ('e13686eda9cf49ddb843af438931d8cb', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 10:13:59', '2016-09-15 10:13:59');
INSERT INTO `loginfo` VALUES ('e5e17ca5737d46e4ac0f1bdd847e411b', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 14:51:26', '2016-09-15 14:51:26');
INSERT INTO `loginfo` VALUES ('e84502614ef24685aa8f4ee9d4f6ff53', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 17:40:29', '2016-09-14 17:40:29');
INSERT INTO `loginfo` VALUES ('e845681fafa540428ba3980161bb8898', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 17:46:00', '2016-09-15 17:46:00');
INSERT INTO `loginfo` VALUES ('ecbcc2b1535344238eb340fde9376693', 'admin', '登录系统', '192.168.0.254', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-14 15:19:25', '2016-09-14 15:19:25');
INSERT INTO `loginfo` VALUES ('ef8837c15ecc456dad03440f8b9b9bd7', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 09:44:39', '2016-09-15 09:44:39');
INSERT INTO `loginfo` VALUES ('f3689bf2eb4644ba8511b7e3d7fd9be9', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 13:05:21', '2016-09-15 13:05:21');
INSERT INTO `loginfo` VALUES ('f8ed1e89dd454238950967523de03b03', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 09:51:50', '2016-09-15 09:51:50');
INSERT INTO `loginfo` VALUES ('fa512611651249ddaf5683a1c489a301', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 11:37:21', '2016-09-15 11:37:21');
INSERT INTO `loginfo` VALUES ('fc2ba186bba142b8be23cb15693cf185', 'admin', 'login', '0:0:0:0:0:0:0:1', '----from users where isvalid = 1 and username = \'admin\' and password = \'14e1b600b1fd579f47433b88e8d85291\' ----- result : 1', '1', '2016-09-15 11:39:27', '2016-09-15 11:39:27');
INSERT INTO `loginfo` VALUES ('fc36cbf5b0f34c1ca1dfd1c39b74e044', 'admin', 'update', '0:0:0:0:0:0:0:1', 'com.keerinfo.springmvc.service.impl.ServiceImpl.update(ServiceImpl.java:60)----UPDATE rechargeRecord S SET S.remark = \'已处理\',S.state = \'1\',S.type = \'1\' WHERE S.id = \'1\'----- result : 1', '1', '2016-09-15 22:00:34', '2016-09-15 22:00:34');

-- ----------------------------
-- Table structure for payproduct
-- ----------------------------
DROP TABLE IF EXISTS `payproduct`;
CREATE TABLE `payproduct` (
  `id` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT '',
  `descrition` varchar(1000) DEFAULT '',
  `payProgramId` varchar(50) DEFAULT '',
  `content` varchar(2000) DEFAULT '',
  `amount` decimal(10,2) DEFAULT '0.00',
  `unit` varchar(50) DEFAULT '',
  `discountType` tinyint(1) DEFAULT '0',
  `rate` int(11) DEFAULT '100',
  `disamount` decimal(10,2) DEFAULT '0.00',
  `sort` int(11) DEFAULT '0',
  `ispredefine` tinyint(1) DEFAULT '0',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付费节目';

-- ----------------------------
-- Records of payproduct
-- ----------------------------
INSERT INTO `payproduct` VALUES ('921e83d3db7f4623ae8dff4ca1f413d6', '文广包标清（B1）', '', 'B1', '东方财经（106）、老年福（107）、七彩戏剧（108）、金色频道（109）、法治天地（110）', '5.00', '元/月•台', '0', '100', '0.00', '0', '1', '1', '2016-09-13 11:28:13', '2016-09-13 11:28:13');
INSERT INTO `payproduct` VALUES ('bce3f5c461b24ab2b093960a28f328a6', '我是小宝宝', '', '00999x', '我是小宝宝是个益智节目', '8.00', '元', '0', '100', '0.00', '0', '0', '1', '2016-09-13 11:49:31', '2016-09-13 11:49:31');

-- ----------------------------
-- Table structure for rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `rechargerecord`;
CREATE TABLE `rechargerecord` (
  `id` varchar(50) NOT NULL,
  `smartCardId` varchar(50) DEFAULT '',
  `type` tinyint(1) DEFAULT '1',
  `amount` decimal(10,2) DEFAULT '0.00',
  `wecharId` varchar(50) DEFAULT '',
  `state` tinyint(1) DEFAULT '0',
  `username` varchar(50) DEFAULT '',
  `mobilephone` varchar(50) DEFAULT '',
  `remark` varchar(500) DEFAULT NULL,
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';

-- ----------------------------
-- Records of rechargerecord
-- ----------------------------
INSERT INTO `rechargerecord` VALUES ('1', '1818151515151', '1', '30.00', '13333333', '1', '连晋', '13988887777', '已处理', '1', '2016-09-15 10:36:03', '2016-09-15 10:36:03');

-- ----------------------------
-- Table structure for scrollpicture
-- ----------------------------
DROP TABLE IF EXISTS `scrollpicture`;
CREATE TABLE `scrollpicture` (
  `id` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT '',
  `url` varchar(200) DEFAULT '',
  `thumbnailUrl` varchar(200) DEFAULT NULL,
  `sort` int(11) DEFAULT '0',
  `isvalid` tinyint(1) DEFAULT '1',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='轮播图片';

-- ----------------------------
-- Records of scrollpicture
-- ----------------------------

-- ----------------------------
-- Table structure for userbindwechat
-- ----------------------------
DROP TABLE IF EXISTS `userbindwechat`;
CREATE TABLE `userbindwechat` (
  `id` varchar(50) NOT NULL,
  `wechatId` varchar(50) DEFAULT '',
  `smartCardId` varchar(50) DEFAULT '',
  `state` tinyint(1) DEFAULT '1',
  `isvalid` tinyint(1) DEFAULT '1',
  `username` varchar(50) DEFAULT '',
  `mobilephone` varchar(50) DEFAULT '',
  `lastChangedTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userbindwechat
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` varchar(50) NOT NULL,
  `TYPE` int(11) NOT NULL DEFAULT '2',
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `USEFULLIFE` int(11) NOT NULL DEFAULT '365',
  `ISVALID` tinyint(1) DEFAULT '1',
  `STATUS` int(11) DEFAULT '0',
  `LASTCHANGEDTIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATETIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '2', 'admin', '14e1b600b1fd579f47433b88e8d85291', '365', '1', '0', '2016-09-08 16:15:58', '2016-09-08 16:15:58');

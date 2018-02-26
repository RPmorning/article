/*
SQLyog v10.2 
MySQL - 5.5.53 : Database - jd
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jd` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jd`;

/*Table structure for table `krcmf_ad` */

DROP TABLE IF EXISTS `krcmf_ad`;

CREATE TABLE `krcmf_ad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `url` varchar(100) DEFAULT NULL COMMENT '链接',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '描述',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_ad` */

insert  into `krcmf_ad`(`id`,`name`,`cover`,`url`,`desc`,`sort`,`view`,`member_id`,`create_time`,`update_time`,`status`) values (1,'艺术文化广告','20170527\\b8425d50bdefa58ffa5f26d4c44e9bc2.jpg','#','艺术文化广告',0,0,1,1495888833,1495888833,1),(2,'文档广告','20170527\\5884bbf1cd3c3fbe98454695534fb60e.jpg','#','文档广告',0,0,1,1495888917,1495888917,1),(3,'网上图书馆广告','20170527\\73e4a5c1a94bf10481c6c86ae8ed5a61.jpg','','',0,0,1,1495888946,1495888946,1),(4,'专题广告','20170527\\2c43e228ce8cc62ac448df38dfbddb33.jpg','#','专题广告',0,0,1,1495888861,1495888861,1),(5,'新闻中心广告','20170527\\1ca41cf22e4e1b6d18d497bffda933b7.jpg','#','新闻中心广告',0,0,1,1495888795,1495888795,1),(6,'搜索广告','20170527\\1ca41cf22e4e1b6d18d497bffda933b7.jpg','#','搜索广告',0,0,1,1495888795,1495888795,1);

/*Table structure for table `krcmf_article` */

DROP TABLE IF EXISTS `krcmf_article`;

CREATE TABLE `krcmf_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字',
  `tag` varchar(50) DEFAULT '' COMMENT '标签',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `content` longtext NOT NULL COMMENT '内容',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `check` int(1) DEFAULT '0' COMMENT '是否发布 0，未发布 1，已发布',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_article` */

insert  into `krcmf_article`(`id`,`name`,`desc`,`category_id`,`keyword`,`tag`,`author`,`source`,`cover`,`content`,`sort`,`hide`,`view`,`member_id`,`create_time`,`update_time`,`status`,`check`) values (21,'aa','aa',3,NULL,'','aa','aa','20180226\\72d00148ea358d5888d63fba9a683888.jpg','<p>asdasdasdasdass</p>',0,0,0,1,1519623759,1519630390,1,1),(22,'理政1','',18,NULL,'','彤彤','自编','20180226\\0735f909544e50c3348dd4b1d829f257.jpg','<p>你好啊，你在哪里？<img src=\"/upload/20180226/eb5a6107b04ddd4aa14358dd12fcf353.png\" title=\"水.png\" alt=\"水.png\"/></p>',0,0,0,1,1519626440,1519634506,1,1);

/*Table structure for table `krcmf_asset` */

DROP TABLE IF EXISTS `krcmf_asset`;

CREATE TABLE `krcmf_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

/*Data for the table `krcmf_asset` */

insert  into `krcmf_asset`(`id`,`user_id`,`file_size`,`create_time`,`status`,`download_times`,`file_key`,`filename`,`file_path`,`file_md5`,`file_sha1`,`suffix`,`more`) values (1,1,160063,1497921108,1,0,'29fe3e8de8d7981e31dac53c260a2c01af335679ede634d86990ca0930280cc6','ssh2.png','20170620\\c25fbf4bbb6097b66e291a43ca6fe370.png','29fe3e8de8d7981e31dac53c260a2c01','44a60cb71fddaeea5565793e61c334a896966ebc','png',NULL),(2,1,18061,1498035598,1,0,'885ddbef713bf83e4b38962510940a7c2297e43772a6082175fc41d7c026f7c6','timg.jpg','20170621\\f96927801e187120220b9dd578bd7039.jpg','885ddbef713bf83e4b38962510940a7c','f804ac528a810ed9377f11cf6fc30edf9f34d432','jpg',NULL),(3,1,160063,1498093486,1,0,'29fe3e8de8d7981e31dac53c260a2c01af335679ede634d86990ca0930280cc6','ssh2.png','20170622/5c95c017de40fe928db4301c94fa47b4.png','29fe3e8de8d7981e31dac53c260a2c01','44a60cb71fddaeea5565793e61c334a896966ebc','png',NULL),(4,1,168149,1498183360,1,0,'d3416fffa5a87b2c0f9605d7aada2a78c6e6255521fec57bb392bfd3769da96a','新建 Microsoft Word 文档.docx','20170623\\57c2035d687a7508fb84de8bad3dd1d6.docx','d3416fffa5a87b2c0f9605d7aada2a78','a63598b83480070e1d2b024a577a504095456ad6','docx',NULL),(5,1,20716,1517902343,1,0,'515516cd9e4e057908701cb9447539384afb28fa3ae5dbb195d241fbdf33199e','58e8faf1b5b1d.jpg','20180206/f005fa0666ab5207b8f84970bef9e7c6.jpg','515516cd9e4e057908701cb944753938','8813407752ee59aba09ec5067c4fccebea0a652a','jpg',NULL),(6,1,11708,1517902416,1,0,'a3be5562d339ce26dada57fe5b4adafda1040d7ac641314fa5f309316081bd04','数据字典.xlsx','20180206/b933b4e77f0e58576a2088e76f1f6763.xlsx','a3be5562d339ce26dada57fe5b4adafd','68161baa6b6d8841e87fe868b494011bf68ff950','xlsx',NULL),(7,1,481482,1517903103,1,0,'9585af4b84be21d459a0341e9b32719dc1bc963ed396a361a8bee00714ebf977','bg.jpg','20180206\\e6dddb75b236c17de93890c638ca7ffa.jpg','9585af4b84be21d459a0341e9b32719d','924a42b0bbf1f48f9ee6f24764c822bac64e80da','jpg',NULL),(8,1,8299,1517903459,1,0,'e3adb8e694c71b193f2113439b7b7b109e94a2efaef040fba56512e8dc4c825a','1-11050516443C21.jpg','20180206\\66269de41d5b10b7a15cf5b6ae47461a.jpg','e3adb8e694c71b193f2113439b7b7b10','7d53c922974dfa9402b6fee749ae666e8f9fe566','jpg',NULL),(9,1,7794,1518315429,1,0,'30fc762d1d4f66fd3d29f90bc3e008e2245255504463cef9c6a287a8683d6174','1.jpg','20180211\\a2b5730a31a9dbd012201c5007d4962f.jpg','30fc762d1d4f66fd3d29f90bc3e008e2','6838ab7ecf0f8e4657aad451af59162beb3c1a7c','jpg',NULL),(10,1,85,1518501073,1,0,'6db5f3a082f5bb50130f26a32d6f57b45c8cc87e775bcc7bcb975a8d13a6b682','12.txt','20180213\\bb9076374d9a36be258b9d3aa2c88646.txt','6db5f3a082f5bb50130f26a32d6f57b4','5c1a9c133b33e9eddd4682ebe60e56b8749cfa9e','txt',NULL),(11,1,201737,1519624136,1,0,'09a71804128d9f5d658a2e80deb79c01c61454f816781f74132dcaa62b78f7df','1-150P5091346.jpg','20180226\\e3f03d0043f2a211d389c509c2aa2841.jpg','09a71804128d9f5d658a2e80deb79c01','d32da24d29da8b5560af4eddf34c9615a5f9a373','jpg',NULL),(12,1,19271,1519626428,1,0,'2b72fe1d46bd0d91b2572c044ad7c0b5b9b065c1feeb098a4e498477e2273847','96703-16031Z92Q9206.jpg','20180226\\4d9fcc564cf2bb36970d4b4d9f65ff55.jpg','2b72fe1d46bd0d91b2572c044ad7c0b5','a1eaa80572a2325a8cc4a04c1529f7ff47930b05','jpg',NULL),(13,1,15760,1519630343,1,0,'9b15b7bcd320e0843a81193be65c6857de32e2795af60b50f77fb25b83a45d22','58d77c525d979.jpg','20180226\\0735f909544e50c3348dd4b1d829f257.jpg','9b15b7bcd320e0843a81193be65c6857','b6c1d6abbfab0c597ea48c266b965b7510a44125','jpg',NULL),(14,1,8926,1519634499,1,0,'56b5b2b624ea5d6a61ada7dd52e436138029989d2d19ee2b06a0a482307e4404','水.png','20180226/eb5a6107b04ddd4aa14358dd12fcf353.png','56b5b2b624ea5d6a61ada7dd52e43613','530cff5883e5da270e69d3b24880fe841560e20a','png',NULL);

/*Table structure for table `krcmf_category` */

DROP TABLE IF EXISTS `krcmf_category`;

CREATE TABLE `krcmf_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '深度',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型 0内部栏目 1单网页 2外部链接',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `url` char(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `is_nav` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在导航显示',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_category` */

insert  into `krcmf_category`(`id`,`name`,`pid`,`level`,`type`,`model_id`,`url`,`sort`,`is_nav`,`hide`,`status`) values (1,'公安要闻',0,1,0,0,'',1,1,0,1),(2,'市局文件',0,1,0,0,'',1,1,0,1),(3,'通知通报',0,1,0,0,'',1,1,0,1),(4,'机关动态',0,1,0,0,'',1,1,0,1),(5,'各地动态',0,1,0,0,'',1,1,0,1),(6,'队伍建设',0,1,0,1,'',1,1,0,1),(7,'情报研判',0,1,0,1,'',1,1,0,1),(8,'每日治安动态',0,1,0,1,'',1,1,0,1),(9,'公安研究',0,1,0,1,'',1,1,0,1),(10,'改革创新',0,1,0,1,'',1,1,0,1),(11,'光荣榜',0,1,0,1,'',1,1,0,1),(12,'两学一做',0,1,0,1,'',1,1,0,1),(13,'警察文化',0,1,0,4,'',0,1,0,1),(14,'媒体聚焦',0,1,0,2,'',0,1,0,1),(15,'公安部规章',0,1,0,2,'',0,1,0,1),(16,'舆情通报',0,1,0,2,'',0,1,0,1),(17,'网络公安形象墙',0,1,0,2,'',0,1,0,1),(18,'网络理政',0,1,0,2,'',0,1,0,1);

/*Table structure for table `krcmf_config` */

DROP TABLE IF EXISTS `krcmf_config`;

CREATE TABLE `krcmf_config` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  `option_lang` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

/*Data for the table `krcmf_config` */

insert  into `krcmf_config`(`option_id`,`option_name`,`option_value`,`autoload`,`option_lang`) values (1,'site_options','{\"site_name\":\"\\u7ef5\\u9633\\u516c\\u5b89\\u4fe1\\u606f\\u7f51\",\"site_login_bg\":\"20180206\\\\e6dddb75b236c17de93890c638ca7ffa.jpg\"}',1,'zh-cn');

/*Table structure for table `krcmf_department` */

DROP TABLE IF EXISTS `krcmf_department`;

CREATE TABLE `krcmf_department` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `department_name` varbinary(20) NOT NULL COMMENT '部门名称',
  `department_desc` varbinary(50) DEFAULT NULL COMMENT '部门描述',
  `d_role_id` varbinary(50) NOT NULL COMMENT '部门角色关联',
  `status` int(1) DEFAULT '1' COMMENT '部门状态',
  `level` int(1) DEFAULT NULL COMMENT '部门等级',
  `pid` int(10) DEFAULT NULL COMMENT '父级部门id',
  `address` varchar(100) DEFAULT NULL COMMENT '部门地点',
  `office_phone` varchar(20) DEFAULT NULL COMMENT '办公电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_department` */

insert  into `krcmf_department`(`id`,`department_name`,`department_desc`,`d_role_id`,`status`,`level`,`pid`,`address`,`office_phone`) values (1,'绵阳市','最高级部门','1,2',1,1,0,'','0816-27364'),(2,'科通支队','发展科技','2,4',1,2,1,'四川绵阳XXX号','0816-27364'),(3,'禁毒办','管理禁毒','3,5',1,2,1,'四川绵阳警钟街','0816-27364'),(4,'信息部','12','2,4,5',1,2,1,'四川绵阳','0816-128374'),(5,'科通一队','','2,4',1,3,2,'四川绵阳','0816-12343');

/*Table structure for table `krcmf_document` */

DROP TABLE IF EXISTS `krcmf_document`;

CREATE TABLE `krcmf_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字',
  `tag` varchar(50) DEFAULT '' COMMENT '标签',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `content` longtext NOT NULL COMMENT '内容',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_document` */

insert  into `krcmf_document`(`id`,`name`,`desc`,`category_id`,`keyword`,`tag`,`author`,`source`,`cover`,`content`,`sort`,`hide`,`view`,`member_id`,`create_time`,`update_time`,`status`) values (21,'12','12',2,NULL,'','12','12','20180213\\bb9076374d9a36be258b9d3aa2c88646.txt','',0,0,0,1,1519612959,1519612959,1);

/*Table structure for table `krcmf_library` */

DROP TABLE IF EXISTS `krcmf_library`;

CREATE TABLE `krcmf_library` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `content` varchar(100) DEFAULT NULL COMMENT '文件头内容',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_library` */

insert  into `krcmf_library`(`id`,`name`,`desc`,`status`,`content`) values (21,'中共陕西燎原航空机械制造公司委员会文件','',1,'司党字 【2017】16号'),(22,'青州市政府文件','',1,'青政发【2099】88号');

/*Table structure for table `krcmf_link` */

DROP TABLE IF EXISTS `krcmf_link`;

CREATE TABLE `krcmf_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `url` varchar(100) DEFAULT NULL COMMENT '链接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_link` */

/*Table structure for table `krcmf_member` */

DROP TABLE IF EXISTS `krcmf_member`;

CREATE TABLE `krcmf_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `realname` char(16) NOT NULL DEFAULT '' COMMENT '人员名称',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别',
  `qq` char(10) DEFAULT NULL COMMENT 'qq号',
  `position` varchar(20) DEFAULT NULL COMMENT '职务',
  `desc` varchar(250) DEFAULT NULL COMMENT '人员描述',
  `mobile_phone` char(15) DEFAULT NULL COMMENT '移动电话',
  `office_phone` char(20) DEFAULT NULL COMMENT '办公电话',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `role_id` int(10) NOT NULL COMMENT '角色id',
  `department_id` int(10) NOT NULL COMMENT '对应部门id',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='会员表';

/*Data for the table `krcmf_member` */

insert  into `krcmf_member`(`id`,`username`,`password`,`realname`,`sex`,`qq`,`position`,`desc`,`mobile_phone`,`office_phone`,`status`,`reg_ip`,`reg_time`,`last_login_ip`,`last_login_time`,`role_id`,`department_id`) values (1,'admin','1396b883c3efd35a0269907e02421437','超级管理员',1,'','','','','',1,3232238869,1494378129,3232238914,1519633840,1,0),(2,'renpeng','1396b883c3efd35a0269907e02421437','测试人员1',1,NULL,NULL,NULL,NULL,NULL,1,0,0,3232238920,1518061595,2,2),(3,'wangs','1396b883c3efd35a0269907e02421437','王s',1,'123','12','发布文章','123','123',1,3232238920,1518158639,3232238920,1519632535,4,2),(4,'wangqq','1396b883c3efd35a0269907e02421437','wangqq',1,'123','123','123','123','123',1,3232238920,1518427518,3232238920,1518507729,5,3);

/*Table structure for table `krcmf_menu` */

DROP TABLE IF EXISTS `krcmf_menu`;

CREATE TABLE `krcmf_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '深度',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_menu` */

insert  into `krcmf_menu`(`id`,`name`,`pid`,`level`,`sort`,`url`,`tip`,`icon`,`status`) values (1,'系统管理',0,1,1,'admin/index/index','0','icon-system',1),(2,'网站配置',1,2,2,'admin/config/index','0','icon-system',1),(3,'用户管理',1,2,3,'admin/member/index','0','icon-member',1),(4,'内容管理',0,1,4,'admin/portal/index','0','icon-system',1),(5,'栏目管理',4,2,5,'admin/category/index','0','icon-guanli1',1),(6,'文章管理',4,2,6,'admin/article/index','0','icon-ryda',1),(7,'作品管理',4,2,7,'admin/works/index','0','icon-web',1),(8,'文档管理',4,2,8,'admin/document/index','0','icon-web',1),(9,'文件头管理',1,2,9,'admin/library/index','0','icon-msnui-portal',1),(10,'页面管理',4,2,10,'admin/page/index','0','icon-file',0),(11,'扩展管理',0,1,11,'admin/addons/index','0','icon-log',1),(20,'部门管理',1,2,3,'admin/department/index','0','icon-department',1),(16,'角色管理',1,2,4,'admin/role/index','0','icon-auth',1),(14,'广告管理',11,2,14,'admin/ad/index','0','icon-log',1),(15,'友情链接',11,2,15,'admin/link/index','0','icon-icon-shgx',1);

/*Table structure for table `krcmf_operation` */

DROP TABLE IF EXISTS `krcmf_operation`;

CREATE TABLE `krcmf_operation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `operation_create` int(1) DEFAULT '0' COMMENT '新增',
  `operation_update` int(1) DEFAULT '0' COMMENT '编辑',
  `operation_delete` int(1) DEFAULT '0' COMMENT '删除',
  `operation_check` int(1) DEFAULT '0' COMMENT '审核',
  `category` varchar(50) DEFAULT NULL COMMENT '对应栏目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_operation` */

insert  into `krcmf_operation`(`id`,`operation_create`,`operation_update`,`operation_delete`,`operation_check`,`category`) values (1,1,1,1,1,'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18'),(2,1,1,1,0,'1,2,3,4,5'),(3,1,1,0,0,'7,5,3,2,1'),(4,0,1,1,1,'1,2,3,4,5'),(5,1,1,1,0,'1,4,10,11'),(15,1,1,0,1,'1,4,6,11,14'),(16,1,0,1,0,'1,2,5,8'),(17,1,1,1,0,'1,5,9');

/*Table structure for table `krcmf_page` */

DROP TABLE IF EXISTS `krcmf_page`;

CREATE TABLE `krcmf_page` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '页面标题',
  `keywords` varchar(40) NOT NULL DEFAULT '0' COMMENT '页面关键字',
  `content` text NOT NULL COMMENT '页面内容',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_page` */

/*Table structure for table `krcmf_role` */

DROP TABLE IF EXISTS `krcmf_role`;

CREATE TABLE `krcmf_role` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `name` char(20) NOT NULL DEFAULT '' COMMENT '角色名称',
  `desc` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `leader_id` int(10) NOT NULL DEFAULT '0' COMMENT '负责人ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(1000) NOT NULL DEFAULT '' COMMENT '角色拥有的规则id，多个规则 , 隔开',
  `operation_id` int(10) DEFAULT '0' COMMENT '对应操作id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `krcmf_role` */

insert  into `krcmf_role`(`id`,`name`,`desc`,`leader_id`,`status`,`rules`,`operation_id`) values (1,'超级管理员','',0,1,'1,2,3,20,16,4,5,6,7,8,9,11,14,15',1),(2,'测试组','',0,1,'4,6,7,8,9',2),(3,'情报员','',0,1,'4,6,7,8',3),(4,'新闻收集员','',0,1,'4,6,7,8,9',4),(5,'新闻编辑员','1233',0,1,'4,6,7,8,9',5),(30,'测试21','2211',0,1,'4,6,7,9',15),(31,'测试3','12',0,1,'4,6,8,9',16),(32,'测试4','12',0,1,'4,6,7,8,9',17);

/*Table structure for table `krcmf_works` */

DROP TABLE IF EXISTS `krcmf_works`;

CREATE TABLE `krcmf_works` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字',
  `tag` varchar(50) DEFAULT '' COMMENT '标签',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `content` longtext NOT NULL COMMENT '内容',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_works` */

insert  into `krcmf_works`(`id`,`name`,`desc`,`category_id`,`keyword`,`tag`,`author`,`source`,`cover`,`content`,`sort`,`hide`,`view`,`member_id`,`create_time`,`update_time`,`status`) values (22,'书法','在这里有好的厉害的额书法。',8,NULL,'','任鹏','科瑞','20170620\\c25fbf4bbb6097b66e291a43ca6fe370.png','<p>哈哈哈哈哈<br/></p>',0,0,0,1,1497925367,1497925367,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

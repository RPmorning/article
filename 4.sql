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
  `tag` int(10) DEFAULT NULL COMMENT '文件头对应ID',
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
  `check_status` int(1) DEFAULT '0' COMMENT '是否发布 0，未发布 1，已发布',
  `departments` text COMMENT '对应需要签收部门id',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_article` */

insert  into `krcmf_article`(`id`,`name`,`desc`,`category_id`,`keyword`,`tag`,`author`,`source`,`cover`,`content`,`sort`,`hide`,`view`,`member_id`,`create_time`,`update_time`,`status`,`check_status`,`departments`) values (21,'aa','aa',3,NULL,0,'aa','aa','20180226\\72d00148ea358d5888d63fba9a683888.jpg','<p>asdasdasdasdass</p>',0,0,35,1,1519623759,1520232442,1,1,NULL),(22,'理政1','',18,NULL,0,'彤彤','自编','20180226\\0735f909544e50c3348dd4b1d829f257.jpg','<p>你好啊，你在哪里？<img src=\"/upload/20180226/eb5a6107b04ddd4aa14358dd12fcf353.png\" title=\"水.png\" alt=\"水.png\"/></p>',0,0,0,1,1519626440,1519634506,1,1,NULL),(24,'动态','asdas',5,NULL,22,'动态','动态','20180301\\82b16973c63a92ed226c4696e6097803.jpg','<p style=\"line-height: 16px;\"><img style=\"vertical-align: middle; margin-right: 2px;\" src=\"http://www.my.com/static/lib/ueditor/dialogs/attachment/fileTypeImages/icon_txt.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/upload/20180228/fee55f96c2c4bb28706d748b0aa389ad.txt\" title=\"1.txt\">1.txt</a></p><p>爱上一个人<br/></p><p style=\"line-height: 16px;\"><img style=\"vertical-align: middle; margin-right: 2px;\" src=\"http://www.my.com/static/lib/ueditor/dialogs/attachment/fileTypeImages/icon_doc.gif\"/><a style=\"font-size:12px; color:#0066cc;\" href=\"/upload/20180228/10dd1cfa07a4eb3da075b5dcc22fb074.doc\" title=\"安徽省社区戒毒社区康复工作手册（光盘）.doc\">安徽省社区戒毒社区康复工作手册（光盘）.doc</a></p><p><br/></p>',0,0,3,3,1519777785,1520492236,1,1,NULL),(34,'123','123',1,NULL,0,'','','20180305\\7c8eb8c80adaa071338eb090b19196be.png','',0,0,1,1,1520220680,1520474405,1,1,NULL),(33,'动态打算离开达拉斯肯德基来的卡洛斯大家l《但是凯迪拉克死了》','撒打算的',4,NULL,22,'阿萨阿萨德','asa','20180302\\63c4255c488d2c9b2abb85f48a0fae26.png','<p><strong>阿斯达斯</strong></p><p><span style=\"font-size: 24px;\"><strong>sdasdsadasdasd</strong></span></p><p><span style=\"font-size: 24px; color: rgb(149, 55, 52);\"><strong>dasdsadsadsa</strong></span></p><p><img src=\"/upload/20180302/93d9a2b6bf3cb329fdf817d7b8f6cad7.jpeg\" title=\"58be8fccb086e.jpeg\" alt=\"58be8fccb086e.jpeg\"/></p>',0,0,12,1,1519967063,1520495920,1,1,NULL),(31,'sdasd','sdasdankfds放得开拉萨分类考试的飞机迪斯科法计算了的看法减肥的世界疯了分列第三款奋斗史的撒打算的',1,NULL,22,'','','','<p>asdasd</p>',0,0,2,1,1519957989,1520397660,1,1,NULL),(35,'123123123','亲生的发生非法',27,NULL,21,'234','','','<p>阿斯顿发士大夫</p>',0,0,1,1,1520236968,1520395285,1,0,NULL),(36,'队伍的撒阿斯达','打算打算',6,NULL,0,'','','','<p>啊实打实的大声道</p>',0,0,24,1,1520302863,1520478777,1,1,NULL),(37,'经文大声道打算','阿斯达所发生的',13,NULL,0,'','','','<p>阿斯顿发士大夫</p>',0,0,8,1,1520304251,1520470989,1,1,NULL),(38,'经文大声道打算','阿斯达所发生的',13,NULL,0,'','','','<p>阿斯顿发士大夫</p>',0,0,0,1,1520304251,1520304251,1,1,NULL),(39,'王企鹅热发生大幅','阿斯顿发大水',1,NULL,0,'','','','<p>发士大夫</p>',0,0,0,1,1520304265,1520390327,1,1,NULL),(40,'王企鹅发生大发','阿斯顿发士大夫',6,NULL,0,'','','','<p>阿斯顿发生</p>',0,0,1,1,1520304278,1520470719,1,1,NULL),(41,'阿斯顿发士大夫','阿斯顿发士大夫',13,NULL,0,'','','','<p>阿斯顿发士大夫</p>',0,0,4,1,1520304296,1520494582,1,1,NULL),(42,'阿斯顿发士大夫','暗示法士大夫',30,NULL,0,' 阿斯蒂芬','阿斯达发生的','','<p>阿斯蒂芬<br/></p>',0,0,2,1,1520304313,1520494688,1,1,NULL),(43,'3123123','12312312',29,NULL,0,'','','','<p>12312312312</p>',0,0,3,1,1520305236,1520495914,1,1,NULL),(44,'1234124','2341234124',28,NULL,0,'','','','<p>12341234</p>',0,0,0,1,1520305253,1520305253,1,1,NULL),(45,'打击破案','打击破案',31,NULL,0,'','','','<p>打击破案</p>',0,0,20,1,1520306284,1520492146,1,1,NULL),(46,'dsad',' 阿斯达',29,NULL,0,'','','','<p>阿斯达</p>',0,0,1,1,1520308223,1520470776,1,1,NULL),(47,'asd',' 阿斯达',29,NULL,0,'','','','<p>阿斯达</p>',0,0,0,1,1520308233,1520383569,1,1,NULL),(48,'啊实打实','阿斯达',29,NULL,22,'','','','<p>阿斯达<img src=\"/upload/20180307/9a40e8e317078c4ddb49764e46c66ded.jpg\" title=\"1.jpg\" alt=\"1.jpg\"/></p>',0,0,29,1,1520308243,1520475059,1,1,NULL),(49,'1212313','123123123123',1,NULL,0,'','','20180307\\1183180da0a95ffce3c80d6d0fd2c6b8.png','<p>123123213123</p>',0,0,1,1,1520388096,1520391069,1,1,NULL),(50,'23341234','2341234',1,NULL,0,'','','20180307\\30bc5cf7f82acf0ad1a81ed15cb1c4c6.png','<p>12342134</p>',0,0,0,1,1520388116,1520390309,1,1,NULL),(74,'1','1',1,NULL,0,'','','','<p>1</p>',0,0,9,1,1520402654,1520403741,1,1,NULL),(75,'12341241234132412341234','1234123412413241234124',28,NULL,0,'','','','<p><span style=\"background-color: rgb(255, 0, 0);\"><em><strong><span style=\"background-color: rgb(255, 0, 0); font-size: 24px;\">撒大声地</span></strong></em></span></p><p><span style=\"background-color: rgb(255, 0, 0);\"><em><strong><span style=\"background-color: rgb(255, 0, 0); font-size: 24px;\"><img src=\"/upload/20180307/0b20e947b278d9917a848db1d3ec85a0.png\" title=\"news_pic.png\" alt=\"news_pic.png\"/>&nbsp;&nbsp;&nbsp;&nbsp;啊实打实</span></strong></em></span></p>',0,0,8,1,1520404646,1520470706,1,1,NULL),(70,'1','1',4,NULL,0,'','','','<p>1</p>',0,0,7,1,1520402624,1520495896,1,1,NULL),(71,'1','1',1,NULL,0,'','','','<p>1</p>',0,0,0,1,1520402633,1520402633,1,1,NULL),(72,'1','1',1,NULL,0,'','','','<p>1</p>',0,0,0,1,1520402640,1520402640,1,1,NULL),(73,'1','1',1,NULL,0,'','','','<p>1</p>',0,0,0,1,1520402647,1520402647,1,1,NULL),(60,'市局文件','苏打撒旦的拉萨的法律打算开发票',2,NULL,22,'','','20180307\\4b8444dd516f62f534eec1f8d31c7131.jpg','<p>费大幅，；的萨芬，；，fgaregaer<br/></p><p>，高大上，；方式，刚，，公司</p><p>电风扇地方</p>',0,0,0,1,1520394051,1520814954,1,1,''),(61,'队伍建设','大苏打撒旦地方 如果开发商给，；受托人个人提供平日通过， ',6,NULL,0,'','','20180307\\5e072cc74496a5dd097c7cc10cfcd8b7.jpg','<p>是的撒大发热分 额外费额外费访问额外<img src=\"/upload/20180307/0adebf9ffca9bf9da3e0550eaa27cd7e.jpg\" title=\"1-11050516443C21.jpg\" alt=\"1-11050516443C21.jpg\"/></p>',0,0,1,1,1520399997,1520470771,1,1,NULL),(62,'1231','312312',1,NULL,0,'','','','<p>12312</p>',0,0,0,1,1520402026,1520402026,1,1,NULL),(63,'qweqweqwe','qweqeqw',1,NULL,0,'','','','<p>qweqwe</p>',0,0,0,1,1520402052,1520402052,1,1,NULL),(64,'asdsad','asdasdasd',1,NULL,0,'','','','<p>asdsad</p>',0,0,0,1,1520402069,1520402069,1,1,NULL),(65,'asdsad','aasdsadasd',29,NULL,0,'','','20180307\\170b3c49d3d9c752704e52373691c4e8.png','<p>asdasdsad</p>',0,0,18,1,1520402101,1520495767,1,1,NULL),(56,'','',0,NULL,NULL,'','未知','','',0,0,0,1,1520393904,1520393904,1,1,NULL),(57,'','',0,NULL,NULL,'','未知','','',0,0,0,1,1520393917,1520393917,1,1,NULL),(58,'','',0,NULL,NULL,'','未知','','',0,0,0,1,1520393960,1520393960,1,1,NULL),(66,'asdsad','asdsad',1,NULL,0,'','','','<p>asdasd</p>',0,0,0,1,1520402145,1520402145,1,1,NULL),(67,'asdsa','dasdasd',1,NULL,0,'','','','<p>asdasd</p>',0,0,0,1,1520402151,1520402151,1,1,NULL),(68,'asdasd','asdasd',1,NULL,0,'','','','<p>asdasd</p>',0,0,0,1,1520402162,1520402162,1,1,NULL),(69,'asdasd','asdasdasd',1,NULL,0,'','','','<p>asdasdas</p>',0,0,0,1,1520402169,1520402169,1,1,NULL),(76,'asdasd12312312','123123123',1,NULL,0,'','','','<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-size: 24px;\">&nbsp;啊实打实的啊实打实的</span><br/></p><p><span style=\"font-size: 24px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 阿斯达啊实打实的<br/></span></p><p><span style=\"font-size: 24px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;爱上大声大声道<br/></span></p><p><span style=\"font-size: 24px;\">啊实打实的</span></p><p><span style=\"font-size: 24px;\">&nbsp;&nbsp;&nbsp;&nbsp;2018-03-0715:07:16</span></p><table><tbody><tr class=\"firstRow\"><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">13243</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">3214</td><td width=\"187\" valign=\"top\">2134</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">214</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">1234</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">2314</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">124</td></tr><tr><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">大师傅</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">阿斯蒂芬</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">撒地方</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">爱的色放</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">撒地方</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">士大夫</td><td width=\"187\" valign=\"top\" style=\"word-break: break-all;\">阿斯蒂芬</td></tr><tr><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td></tr><tr><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td></tr><tr><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td></tr><tr><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td></tr><tr><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td><td width=\"187\" valign=\"top\"><br/></td></tr></tbody></table><p><span style=\"font-size: 24px;\"></span><span style=\"color: rgb(255, 0, 0); font-size: 24px;\">发生的发生四大发生的<sub>撒地方</sub></span><br/></p>',0,0,8,1,1520406454,1520410390,1,1,NULL),(77,'1234','1234124',1,NULL,0,'','','','<p>12341234</p>',0,0,0,1,1520410786,1520410786,1,1,NULL),(78,'1234123','1234124',1,NULL,0,'','','20180307\\457c2a68d1a423986256c4b8aea4e4bc.png','<p>12343124</p>',0,0,4,1,1520410802,1520495667,1,1,NULL),(79,'1234124','123412412',17,NULL,0,'','','20180307\\7f16ac7fc83c67a739aa5fa6558aeeaa.png','<p>12341234</p>',0,0,3,1,1520410824,1520491669,1,1,NULL),(80,'13','12341234',17,NULL,0,'','','20180307\\718200f78f0944cda98b8ede88a66463.png','<p>1234</p>',0,0,3,1,1520410852,1520493293,1,1,NULL),(81,'12341234124','123431241234',1,NULL,0,'','','20180307\\a5b2d64a78229485753ed1bd60e958bf.png','<p>1234124</p>',0,0,3,1,1520410882,1520473481,1,1,NULL),(82,'1234132','41234124',17,NULL,0,'','','20180307\\88d3619cc3a1d2bbd0b76fd4ac57e024.png','<p>2134124</p>',0,0,4,1,1520410894,1520472887,1,1,NULL),(83,'321412341324','1234123412',1,NULL,0,'','','20180307\\4b4d9654517fbd1305357e1a6e982490.png','<p>412341324</p>',0,0,7,1,1520410907,1520555556,1,1,NULL),(84,'3124','1234214',17,NULL,0,'','','20180307\\8e513614765c995b030f45574ce5e119.png','<p>1234</p>',0,0,0,1,1520411173,1520411173,1,1,NULL),(85,'12341234','421343124',17,NULL,0,'','','20180307\\ce024aac706268a196b1c12d69b4179c.png','<p>1234124</p>',0,0,1,1,1520411200,1520493311,1,1,NULL),(86,'3124','2134214',17,NULL,0,'','','20180307\\33b49088bf9230b5a3b1630e94632ef4.png','<p>123421</p>',0,0,0,1,1520411215,1520411256,1,1,NULL),(87,'12341234','2134213412',1,NULL,0,'','','','<p>12341234124</p>',0,0,5,1,1520411226,1520470217,1,1,NULL),(88,'12324r4232文章标题','rewfsdadsf',27,NULL,21,'','','','<p>asdfasdfsadfasdf</p>',0,0,52,1,1520470362,1520495390,1,1,NULL),(89,'31234','1234',11,NULL,0,'','','','<p>21342314</p>',0,0,9,1,1520471838,1520492665,1,1,NULL),(90,'12341234','12341234',27,NULL,21,'','','','<p>12341234</p>',0,0,2,1,1520473532,1520495700,1,1,NULL),(91,'safsadfasdf','afadsfadsf',1,NULL,22,'','','20180308\\894208c6577a8fb3673bcdfddf199991.png','<p>asdfasdfasdf</p>',0,0,14,1,1520474478,1520493403,1,1,NULL),(92,'向阿斯顿阿斯达','大声道啊实打实的',1,NULL,22,'','','20180308\\2cdcce97b1a9b2e8339ce6bd80e8c3df.png','<p>asdfasdfasdfads的萨菲大声道啊SD</p>',0,0,0,1,1520474740,1520474740,1,1,NULL),(93,'ASDsd爱的色放爱的色放','啊sd萨达发大水阿斯蒂芬',1,NULL,21,'','','20180308\\85cb4a98ec55fa12552d9c2b84db05ad.png','<p>阿斯顿发生</p>',0,0,15,1,1520474762,1520818007,1,1,NULL),(94,'23413234萨达','啊SD啊sd',6,NULL,21,'','ASD ','','<p>D啊sd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"/upload/20180308/d1434fd514c11d0935d3afe02083a26e.png\" title=\"wall_1.png\" alt=\"wall_1.png\"/></p>',0,0,4,1,1520475013,1520495478,1,1,NULL),(95,'各地','大撒旦撒旦数达到发达地方发沃尔夫 ',5,NULL,0,'','','','',0,0,3,1,1520477520,1520495217,1,1,'2,3,4'),(96,'123213213213212','3123123123213123',5,NULL,0,'','','','',0,0,0,1,1520484010,1520484010,1,1,''),(97,'分开拉福美来','大撒旦拉姆洛克',5,NULL,0,'','','','',0,0,2,1,1520484044,1520492130,1,1,'2,4'),(98,'领导讲话','领导讲话',28,NULL,22,'','','','<p>领导讲话</p>',0,0,0,1,1520487340,1520487340,1,1,''),(99,'会议通知','会议通知',27,NULL,22,'','','','<p>会议通知</p>',0,0,10,1,1520487593,1520495163,1,1,''),(100,'机关动态','机关动态',4,NULL,21,'','','','<p>机关动态</p>',0,0,0,1,1520487712,1520487712,1,1,''),(101,'曝光台','曝光台',33,NULL,21,'','','','<p>曝光台</p>',0,0,1,1,1520487947,1520493494,1,1,''),(102,'各地动态','各地动态',5,NULL,22,'','','','<p>各地动态</p>',0,0,0,1,1520488026,1520488026,1,1,''),(103,'重点工作推进','重点工作推进',32,NULL,21,'','','','<p>重点工作推进</p>',0,0,0,1,1520488253,1520488253,1,1,''),(104,'改革创新','大声大声道撒大声地',10,NULL,21,'','','','<p>啊实打实的萨达</p>',0,0,0,1,1520488279,1520488279,1,1,''),(105,'情报研判','情报研判',7,NULL,0,'','','','<p>情报研判</p>',0,0,0,1,1520488365,1520488365,1,1,''),(106,'每日治安动态','每日治安动态',8,NULL,0,'','','','<p>每日治安动态</p>',0,0,0,1,1520488380,1520488380,1,1,''),(107,'媒体聚焦','媒体聚焦',14,NULL,0,'','','','<p>媒体聚焦</p>',0,0,1,1,1520488398,1520494768,1,1,''),(108,'舆情通报','舆情通报',16,NULL,0,'','','','<p>舆情通报</p>',0,0,5,1,1520488412,1520494864,1,1,''),(109,'公安研究','阿斯蒂芬',1,NULL,21,'','','','<p>爱的色放</p>',0,0,1,1,1520499621,1520814286,1,1,'2,3'),(110,'公安研究','公安研究',9,NULL,0,'','','','<p>公安研究</p>',0,0,1,1,1520499653,1520499660,1,1,''),(111,'光荣榜','光荣榜光荣榜光荣榜光荣榜光荣榜光荣榜',11,NULL,22,'','','20180309\\49e07cd4b4f6de41ce7619f9219a5fd0.png','<p>&nbsp; &nbsp;&nbsp;<span style=\"font-size: 24px;\">是啊实打实的啊实打实撒大声地啊实打实大师啊实打实大师啊实打实大师</span><br/></p><p><span style=\"font-size: 24px;\">&nbsp; &nbsp;啊实打实的啊实打实爱上大声大声道啊实打实的啊实打实的</span></p><table><tbody><tr class=\"firstRow\"><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">萨达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td></tr><tr><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">按时d</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">按时</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">按时</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td></tr><tr><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">&nbsp;按时</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">按时</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">&nbsp;ads</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">&nbsp;阿斯达</td><td width=\"222\" valign=\"top\" style=\"word-break: break-all;\">按时</td></tr></tbody></table><p>&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"/upload/20180309/393fdc3a8b750e5d946367d2d7775481.png\" title=\"wall_4.png\" alt=\"wall_4.png\"/>&nbsp;&nbsp;<span style=\"font-size: 24px;\"></span><br/></p><p>&nbsp;</p>',0,0,3,1,1520555842,1520557133,1,1,''),(112,'曝光台22222','打算打算',33,NULL,22,'','','','<table><tbody><tr class=\"firstRow\"><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 18px;\">阿斯达</span></td><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 18px;\">阿斯达</span></td><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\"><span style=\"font-size: 18px;\">阿斯达</span></td></tr><tr><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\">阿斯达</td><td width=\"466\" valign=\"top\" style=\"word-break: break-all;\">按时的</td></tr></tbody></table><p><br/></p>',0,0,22,1,1520556560,1520557081,1,1,''),(113,'201839','201839',28,NULL,21,'','','','<p>201839</p>',0,0,0,1,1520557344,1520557344,1,1,''),(114,'201839','阿斯蒂芬',16,NULL,21,'','','','<p>阿斯蒂芬</p>',0,0,0,1,1520557409,1520557409,1,1,'2,3,4,6'),(115,'23141234213二234','额外欠人情未确认',4,NULL,21,'','','','<p>去玩儿</p>',0,0,1,1,1520557508,1520580569,1,1,'2,3,4,6'),(116,'sdfafdsdf','asdfasf',5,NULL,21,'','','','<p>asdf</p>',0,0,0,1,1520558772,1520816065,1,1,'2,3,4');

/*Table structure for table `krcmf_article_sign` */

DROP TABLE IF EXISTS `krcmf_article_sign`;

CREATE TABLE `krcmf_article_sign` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `department_id` int(10) DEFAULT NULL COMMENT '部门id',
  `sign_time` int(10) DEFAULT NULL COMMENT '签收时间',
  `article_id` int(10) DEFAULT NULL COMMENT '文章id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_article_sign` */

insert  into `krcmf_article_sign`(`id`,`department_id`,`sign_time`,`article_id`) values (1,2,1520061210,21),(2,2,1520222187,21),(3,3,1520222233,21),(4,3,1520222249,21),(5,2,1520232016,21),(6,2,1520232117,21),(7,2,1520232118,21),(8,2,1520232118,21),(9,2,1520232118,21),(10,2,1520232118,21),(11,2,1520232119,21),(12,2,1520232119,21),(13,2,1520232119,21),(14,2,1520232143,21),(15,2,1520232144,21),(16,2,1520232145,21),(17,2,1520232145,21),(18,2,1520232152,21),(19,2,1520232383,21),(20,2,1520232434,21),(21,2,1520407674,76),(22,2,1520470199,87),(23,2,1520470957,37),(24,2,1520477936,88),(25,2,1520477959,88),(26,2,1520477981,45),(27,2,1520478095,89),(28,2,1520478233,36),(29,2,1520492006,89),(30,2,1520492230,24),(31,2,1520494577,41),(32,2,1520494695,42),(33,2,1520494715,94),(34,2,1520494782,107),(35,2,1520494818,108),(36,2,1520494856,108),(37,2,1520494863,108),(38,2,1520494980,99),(39,2,1520495040,99),(40,2,1520495099,99),(41,2,1520495108,99),(42,2,1520495168,99),(43,2,1520495184,95),(44,2,1520495230,70),(45,2,1520495281,70),(46,2,1520495487,94),(47,2,1520495695,90),(48,2,1520495695,116),(49,4,1520495695,116);

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

/*Data for the table `krcmf_asset` */

insert  into `krcmf_asset`(`id`,`user_id`,`file_size`,`create_time`,`status`,`download_times`,`file_key`,`filename`,`file_path`,`file_md5`,`file_sha1`,`suffix`,`more`) values (1,1,160063,1497921108,1,0,'29fe3e8de8d7981e31dac53c260a2c01af335679ede634d86990ca0930280cc6','ssh2.png','20170620\\c25fbf4bbb6097b66e291a43ca6fe370.png','29fe3e8de8d7981e31dac53c260a2c01','44a60cb71fddaeea5565793e61c334a896966ebc','png',NULL),(2,1,18061,1498035598,1,0,'885ddbef713bf83e4b38962510940a7c2297e43772a6082175fc41d7c026f7c6','timg.jpg','20170621\\f96927801e187120220b9dd578bd7039.jpg','885ddbef713bf83e4b38962510940a7c','f804ac528a810ed9377f11cf6fc30edf9f34d432','jpg',NULL),(3,1,160063,1498093486,1,0,'29fe3e8de8d7981e31dac53c260a2c01af335679ede634d86990ca0930280cc6','ssh2.png','20170622/5c95c017de40fe928db4301c94fa47b4.png','29fe3e8de8d7981e31dac53c260a2c01','44a60cb71fddaeea5565793e61c334a896966ebc','png',NULL),(4,1,168149,1498183360,1,0,'d3416fffa5a87b2c0f9605d7aada2a78c6e6255521fec57bb392bfd3769da96a','新建 Microsoft Word 文档.docx','20170623\\57c2035d687a7508fb84de8bad3dd1d6.docx','d3416fffa5a87b2c0f9605d7aada2a78','a63598b83480070e1d2b024a577a504095456ad6','docx',NULL),(5,1,20716,1517902343,1,0,'515516cd9e4e057908701cb9447539384afb28fa3ae5dbb195d241fbdf33199e','58e8faf1b5b1d.jpg','20180206/f005fa0666ab5207b8f84970bef9e7c6.jpg','515516cd9e4e057908701cb944753938','8813407752ee59aba09ec5067c4fccebea0a652a','jpg',NULL),(6,1,11708,1517902416,1,0,'a3be5562d339ce26dada57fe5b4adafda1040d7ac641314fa5f309316081bd04','数据字典.xlsx','20180206/b933b4e77f0e58576a2088e76f1f6763.xlsx','a3be5562d339ce26dada57fe5b4adafd','68161baa6b6d8841e87fe868b494011bf68ff950','xlsx',NULL),(7,1,481482,1517903103,1,0,'9585af4b84be21d459a0341e9b32719dc1bc963ed396a361a8bee00714ebf977','bg.jpg','20180206\\e6dddb75b236c17de93890c638ca7ffa.jpg','9585af4b84be21d459a0341e9b32719d','924a42b0bbf1f48f9ee6f24764c822bac64e80da','jpg',NULL),(8,1,8299,1517903459,1,0,'e3adb8e694c71b193f2113439b7b7b109e94a2efaef040fba56512e8dc4c825a','1-11050516443C21.jpg','20180206\\66269de41d5b10b7a15cf5b6ae47461a.jpg','e3adb8e694c71b193f2113439b7b7b10','7d53c922974dfa9402b6fee749ae666e8f9fe566','jpg',NULL),(9,1,7794,1518315429,1,0,'30fc762d1d4f66fd3d29f90bc3e008e2245255504463cef9c6a287a8683d6174','1.jpg','20180211\\a2b5730a31a9dbd012201c5007d4962f.jpg','30fc762d1d4f66fd3d29f90bc3e008e2','6838ab7ecf0f8e4657aad451af59162beb3c1a7c','jpg',NULL),(10,1,85,1518501073,1,0,'6db5f3a082f5bb50130f26a32d6f57b45c8cc87e775bcc7bcb975a8d13a6b682','12.txt','20180213\\bb9076374d9a36be258b9d3aa2c88646.txt','6db5f3a082f5bb50130f26a32d6f57b4','5c1a9c133b33e9eddd4682ebe60e56b8749cfa9e','txt',NULL),(11,1,201737,1519624136,1,0,'09a71804128d9f5d658a2e80deb79c01c61454f816781f74132dcaa62b78f7df','1-150P5091346.jpg','20180226\\e3f03d0043f2a211d389c509c2aa2841.jpg','09a71804128d9f5d658a2e80deb79c01','d32da24d29da8b5560af4eddf34c9615a5f9a373','jpg',NULL),(12,1,19271,1519626428,1,0,'2b72fe1d46bd0d91b2572c044ad7c0b5b9b065c1feeb098a4e498477e2273847','96703-16031Z92Q9206.jpg','20180226\\4d9fcc564cf2bb36970d4b4d9f65ff55.jpg','2b72fe1d46bd0d91b2572c044ad7c0b5','a1eaa80572a2325a8cc4a04c1529f7ff47930b05','jpg',NULL),(13,1,15760,1519630343,1,0,'9b15b7bcd320e0843a81193be65c6857de32e2795af60b50f77fb25b83a45d22','58d77c525d979.jpg','20180226\\0735f909544e50c3348dd4b1d829f257.jpg','9b15b7bcd320e0843a81193be65c6857','b6c1d6abbfab0c597ea48c266b965b7510a44125','jpg',NULL),(14,1,8926,1519634499,1,0,'56b5b2b624ea5d6a61ada7dd52e436138029989d2d19ee2b06a0a482307e4404','水.png','20180226/eb5a6107b04ddd4aa14358dd12fcf353.png','56b5b2b624ea5d6a61ada7dd52e43613','530cff5883e5da270e69d3b24880fe841560e20a','png',NULL),(15,1,60262,1519711118,1,0,'5aa9ce3d767781d88ff3536fea52d54c63f85243a275c83b91f93f694b4f00d7','u=2907985307,2218684719&fm=214&gp=0.jpg','20180227\\6bd6bd6018d8ba6020fd8e59101e4570.jpg','5aa9ce3d767781d88ff3536fea52d54c','75b3beae1dc20889716bfb7993fad7ae30ae0378','jpg',NULL),(16,1,321866,1519711327,1,0,'788e0d6236d8fdd367a419eac7a72cfbcf3e4b8d86451adc3ebd772284c0601c','183815ny3kllijlvizfo3j.jpg','20180227\\c6781b38e0f451f7c68facbd39fea121.jpg','788e0d6236d8fdd367a419eac7a72cfb','67d698418f4f9163e563d7437bf569a0bc759df6','jpg',NULL),(17,1,297395,1519724063,1,0,'6e69d4348f3aa255fe0a58e8ca92e7eed2934ab7ef4bf62be2f426fdc45f696c','login_back.jpg','20180227\\0f2e3b3abd595179f90f4d72f2ac7432.jpg','6e69d4348f3aa255fe0a58e8ca92e7ee','19f6e8374f0ed2e26d98a784b5288ec59d66e2af','jpg',NULL),(18,1,267,1519777752,1,0,'56caaca47e6991a3707ea5c6fe839dd3e18b86252201681604725a7f2f6bc1b6','1.txt','20180228/fee55f96c2c4bb28706d748b0aa389ad.txt','56caaca47e6991a3707ea5c6fe839dd3','ff5faff55a2ad8fcd87f5897954913d6903c704d','txt',NULL),(19,1,932864,1519778270,1,0,'1fcfcf5623ba0cebe119dcec67d21f0fff7aa1ef945872860eefd2a45fb10e66','安徽省社区戒毒社区康复工作手册（光盘）.doc','20180228/10dd1cfa07a4eb3da075b5dcc22fb074.doc','1fcfcf5623ba0cebe119dcec67d21f0f','a0415366c1735ea7b11d4408d5658e0dce2843ab','doc',NULL),(20,1,266129,1519784554,1,0,'9470f2ac6237ca2daccb0a8cdf05fddb711ae57398b901ee24b0df7d4422c428','login_backgroup.jpg','20180228\\e83e5b7b8d58da4af423f324c518a311.jpg','9470f2ac6237ca2daccb0a8cdf05fddb','e65646001305127dad2866b2d08368f954bcb695','jpg',NULL),(21,1,80651,1519876032,1,0,'d212777346632bac3c59d8cd6265393f07f117c98e9b9e76a61f5555b1855009','1-150103092639.jpg','20180301\\82b16973c63a92ed226c4696e6097803.jpg','d212777346632bac3c59d8cd6265393f','1c1e896b84a4ef1007c9dc52b26af1517bfea096','jpg',NULL),(22,1,875046,1519966948,1,0,'aca1ac5fbabc3392e53917ec29ea5fb36da7d26600a2343b9f9fbd3048205a4c','2b83bec66224159fedc1b98f80371365.jpg','20180302\\24ce4255daedced261629c0a96bb6d4d.jpg','aca1ac5fbabc3392e53917ec29ea5fb3','b5fbe1345aaaecb4dbd6f50b8254b333b991766a','jpg',NULL),(23,1,241769,1519967102,1,0,'56f5155ceeb54999692404c07e15b741f1018cb08dcb73ad0eceb5cb1091b664','TIM截图20180116142809.png','20180302\\63c4255c488d2c9b2abb85f48a0fae26.png','56f5155ceeb54999692404c07e15b741','0fd32f0a7eb53c17a5519baef6e4ddc465949885','png',NULL),(24,1,16808,1519967247,1,0,'2f3c3cf81bc4bc0cd42832dec3252f5fb55cb3887a8f4d12312f124faba793c7','58be8fccb086e.jpeg','20180302/93d9a2b6bf3cb329fdf817d7b8f6cad7.jpeg','2f3c3cf81bc4bc0cd42832dec3252f5f','e400c09a7caad49fe8c5e4748717ac06bc74ca81','jpeg',NULL),(25,1,182582,1520235693,1,0,'59950657026d369ea39b33463670a313d61dc7a4d012c48896e03d7e78bfcc69','TIM截图20180305154058.png','20180305\\720c14d063cb4dd30551482b698cb41b.png','59950657026d369ea39b33463670a313','34c61c4cd6345179fd6cc11ea07fbdaecc411814','png',NULL),(26,1,239167,1520388091,1,0,'3217c2176495cf507a427b303c70b639bbed39637d1123ae1f08586c381db119','news_pic.png','20180307\\1183180da0a95ffce3c80d6d0fd2c6b8.png','3217c2176495cf507a427b303c70b639','c213e85bd5a79ca492717e4d9b6ed3cc0323aabe','png',NULL),(27,1,83677,1520388112,1,0,'3bf99e17aa2ba69d84518642c15941ddf9ec30ff8e74649333b9ddc04a49b132','wall_1.png','20180307\\30bc5cf7f82acf0ad1a81ed15cb1c4c6.png','3bf99e17aa2ba69d84518642c15941dd','e7fdebef5d99d0368227e567061ae7bbfd157bcf','png',NULL),(28,1,20047,1520393777,1,0,'df288e063131ff700d50f167279abd146bd77ee96f1af4cbdca700f2c0cd263e','ce467c56885007aa86239a8f4866bdd6.jpg','20180307\\e1437e4c03ee9cf9bba0c9b088993dae.jpg','df288e063131ff700d50f167279abd14','4c673717c362e00275dc4f28a0821f7ebb08646d','jpg',NULL),(29,1,16655,1520399930,1,0,'8986b80254f123d2e50cc49c0558509bf9140794023478b2bcc07bb03702474a','58ad2a8409b2b.jpg','20180307\\4b8444dd516f62f534eec1f8d31c7131.jpg','8986b80254f123d2e50cc49c0558509b','3547d7655996023f3d419de2f1125dd51afeb5ab','jpg',NULL),(30,1,8299,1520399994,1,0,'e3adb8e694c71b193f2113439b7b7b109e94a2efaef040fba56512e8dc4c825a','1-11050516443C21.jpg','20180307/0adebf9ffca9bf9da3e0550eaa27cd7e.jpg','e3adb8e694c71b193f2113439b7b7b10','7d53c922974dfa9402b6fee749ae666e8f9fe566','jpg',NULL),(31,1,239167,1520404640,1,0,'3217c2176495cf507a427b303c70b639bbed39637d1123ae1f08586c381db119','news_pic.png','20180307/0b20e947b278d9917a848db1d3ec85a0.png','3217c2176495cf507a427b303c70b639','c213e85bd5a79ca492717e4d9b6ed3cc0323aabe','png',NULL),(32,1,7794,1520407204,1,0,'30fc762d1d4f66fd3d29f90bc3e008e2245255504463cef9c6a287a8683d6174','1.jpg','20180307/9a40e8e317078c4ddb49764e46c66ded.jpg','30fc762d1d4f66fd3d29f90bc3e008e2','6838ab7ecf0f8e4657aad451af59162beb3c1a7c','jpg',NULL),(33,1,52229,1520474728,1,0,'9aa03043c00dc456ba650200fb9d7f199f3a74baf276aa0d2246efd2c0df39fc','list_img.png','20180308\\2cdcce97b1a9b2e8339ce6bd80e8c3df.png','9aa03043c00dc456ba650200fb9d7f19','b34608517e3cd38a171a0f808f8d58a42e2d1296','png',NULL),(34,1,93623,1520474761,1,0,'5c3e461912035a2c1381fa568b322add3dc28e1a2afe16d4889ace3feccc44f0','wall_4.png','20180308\\27bfbb9c1d70a702df8ec8208bb02992.png','5c3e461912035a2c1381fa568b322add','be1e3ad01ad393326ef0aa8512cfaf9122fca894','png',NULL),(35,1,83677,1520475003,1,0,'3bf99e17aa2ba69d84518642c15941ddf9ec30ff8e74649333b9ddc04a49b132','wall_1.png','20180308/d1434fd514c11d0935d3afe02083a26e.png','3bf99e17aa2ba69d84518642c15941dd','e7fdebef5d99d0368227e567061ae7bbfd157bcf','png',NULL),(36,1,93623,1520555820,1,0,'5c3e461912035a2c1381fa568b322add3dc28e1a2afe16d4889ace3feccc44f0','wall_4.png','20180309/024f9d6586ecb8fba41c4640603b2218.png','5c3e461912035a2c1381fa568b322add','be1e3ad01ad393326ef0aa8512cfaf9122fca894','png',NULL),(37,1,93623,1520555832,1,0,'5c3e461912035a2c1381fa568b322add3dc28e1a2afe16d4889ace3feccc44f0','wall_4.png','20180309/393fdc3a8b750e5d946367d2d7775481.png','5c3e461912035a2c1381fa568b322add','be1e3ad01ad393326ef0aa8512cfaf9122fca894','png',NULL),(38,1,2049,1520587052,1,0,'ed05db4d65f64b6afc136c4d53be5836ef7b358e09a8e4d25f1864f0b5d30db7','link_item.png','20180309/98a225101c0a8e1c6319235ed3ec2f48.png','ed05db4d65f64b6afc136c4d53be5836','b3139d043340b382ae6f12e46102c6ff6401cc47','png',NULL);

/*Table structure for table `krcmf_category` */

DROP TABLE IF EXISTS `krcmf_category`;

CREATE TABLE `krcmf_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '深度',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型 0内部栏目 1外部链接',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `url` char(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `is_nav` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否在导航显示',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_category` */

insert  into `krcmf_category`(`id`,`name`,`pid`,`level`,`type`,`model_id`,`url`,`sort`,`is_nav`,`hide`,`status`) values (1,'公安要闻',0,1,0,0,'',1,1,0,1),(2,'市局文件',0,1,0,0,'',1,1,0,1),(3,'通知通报',0,1,0,0,'',1,1,0,1),(4,'机关动态',0,1,0,0,'',1,1,0,1),(5,'各地动态',0,1,0,0,'',1,1,0,1),(6,'队伍建设',0,1,0,1,'',1,1,0,1),(7,'情报研判',0,1,0,1,'',1,1,0,1),(8,'每日治安动态',0,1,0,1,'',1,1,0,1),(9,'公安研究',0,1,0,1,'',1,1,0,1),(10,'改革创新',0,1,0,1,'',1,1,0,1),(11,'光荣榜',0,1,0,1,'',1,1,0,1),(12,'两学一做',0,1,0,1,'',1,1,0,1),(13,'警营文化',0,1,0,0,'',0,1,0,1),(14,'媒体聚焦',0,1,0,2,'',0,1,0,1),(15,'公安部规章',0,1,0,2,'',0,1,0,1),(16,'舆情通报',0,1,0,2,'',0,1,0,1),(17,'网络公安形象墙',0,1,0,2,'',0,1,0,1),(18,'网络理政',0,1,0,2,'',0,1,0,1),(20,'测试栏目',0,1,0,0,'',0,1,0,1),(30,'民警风采',0,1,0,0,'',0,1,0,1),(21,'友情链接',0,1,1,0,'',0,1,0,1),(24,'专家指南',0,1,1,0,'',0,1,0,1),(28,'领导讲话',0,1,0,0,'',0,1,0,1),(27,'会议通知',0,1,0,0,'',0,1,0,1),(25,'其他系统',0,1,1,0,'',0,1,0,1),(29,'市局重要信息',0,1,0,0,'',0,1,0,1),(31,'打击破案',0,1,0,0,'',0,1,0,1),(32,'重点工作推进',0,1,0,0,'',0,1,0,1),(33,'曝光台',0,1,0,0,'',0,1,0,1),(34,'业务应用平台',0,1,1,0,'',0,1,0,1);

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

insert  into `krcmf_config`(`option_id`,`option_name`,`option_value`,`autoload`,`option_lang`) values (1,'site_options','{\"site_name\":\"\\u7ef5\\u9633\\u516c\\u5b89\\u4fe1\\u606f\\u7f51\",\"site_login_bg\":\"20180228\\\\e83e5b7b8d58da4af423f324c518a311.jpg\"}',1,'zh-cn');

/*Table structure for table `krcmf_department` */

DROP TABLE IF EXISTS `krcmf_department`;

CREATE TABLE `krcmf_department` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `department_name` varchar(20) NOT NULL COMMENT '部门名称',
  `department_desc` varchar(50) DEFAULT NULL COMMENT '部门描述',
  `d_role_id` varchar(50) NOT NULL COMMENT '部门角色关联',
  `status` int(1) DEFAULT '1' COMMENT '部门状态',
  `level` int(1) DEFAULT NULL COMMENT '部门等级',
  `pid` int(10) DEFAULT NULL COMMENT '父级部门id',
  `address` varchar(100) DEFAULT NULL COMMENT '部门地点',
  `office_phone` varchar(20) DEFAULT NULL COMMENT '办公电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_department` */

insert  into `krcmf_department`(`id`,`department_name`,`department_desc`,`d_role_id`,`status`,`level`,`pid`,`address`,`office_phone`) values (1,'绵阳市','最高级部门','1,2',1,1,0,'','0816-27364'),(2,'科通支队','发展科技','2,4',1,2,1,'四川绵阳XXX号','0816-27364'),(3,'禁毒办','管理禁毒','3,5',1,2,1,'四川绵阳警钟街','0816-27364'),(4,'信息部','12','2,4,5',1,2,1,'四川绵阳','0816-128374'),(5,'科通一队','','2,4',1,3,2,'四川绵阳','0816-12343'),(6,'信息技术','测试','33',1,2,1,'绵阳','0816-23832');

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
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '栏目id',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_link` */

insert  into `krcmf_link`(`id`,`name`,`url`,`category_id`,`view`,`member_id`,`create_time`,`update_time`,`status`) values (20,'百度','www.baidu.com',24,0,1,1520210419,1520225529,1),(21,'12','12',25,0,1,1520210743,1520225538,1),(23,'绵阳公安局','http://gaj.my.gov.cn/',21,0,1,1520233795,1520233795,1),(24,'成都公安局','http://www.gaj.chengdu.gov.cn/',21,0,1,1520233830,1520233830,1),(25,'2222','123213123',34,0,1,1520408987,1520408987,1),(26,'2314123','2134124',34,0,1,1520409003,1520409003,1),(27,'123421','1234124',34,0,1,1520409011,1520409011,1),(28,'12342134','2341234',34,0,1,1520409020,1520409020,1),(29,'12342134','21342134',0,0,1,1520409029,1520409029,1),(30,'12421','21341234',34,0,1,1520409039,1520409039,1);

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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员表';

/*Data for the table `krcmf_member` */

insert  into `krcmf_member`(`id`,`username`,`password`,`realname`,`sex`,`qq`,`position`,`desc`,`mobile_phone`,`office_phone`,`status`,`reg_ip`,`reg_time`,`last_login_ip`,`last_login_time`,`role_id`,`department_id`) values (1,'admin','1396b883c3efd35a0269907e02421437','超级管理员',1,'','','','','',1,3232238869,1494378129,3232238920,1521419809,1,0),(2,'renpeng','1396b883c3efd35a0269907e02421437','测试人员1',1,'','','','','',1,0,0,3232238920,1518061595,2,2),(3,'wangs','1396b883c3efd35a0269907e02421437','王s',1,'123','12','发布文章','123','123',1,3232238920,1518158639,3232238920,1520400072,4,2),(4,'wangqq','1396b883c3efd35a0269907e02421437','wangqq',1,'123','123','123','123','123',1,3232238920,1518427518,3232238920,1518507729,5,3),(6,'测试cs','1396b883c3efd35a0269907e02421437','测试',1,'12','12','12','1212','12',1,3232238920,1519789494,3232238920,1519789507,33,6);

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
  `category` text COMMENT '对应栏目',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `krcmf_operation` */

insert  into `krcmf_operation`(`id`,`operation_create`,`operation_update`,`operation_delete`,`operation_check`,`category`) values (1,1,1,1,1,'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,30,28,27,29,31,32,33'),(2,1,1,1,0,'1,2,3,4,5'),(3,1,1,0,0,'7,5,3,2,1'),(4,1,1,1,0,'1,2,3,4,5,20'),(5,1,1,1,0,'1,4,10,11'),(15,1,1,0,1,'1,4,6,11,14'),(16,1,0,1,0,'1,2,5,8'),(17,1,1,1,0,'1,5,9'),(18,1,1,1,1,'1');

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
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `krcmf_role` */

insert  into `krcmf_role`(`id`,`name`,`desc`,`leader_id`,`status`,`rules`,`operation_id`) values (1,'超级管理员','',0,1,'1,2,3,20,16,4,5,6,7,8,9,11,14,15',1),(2,'测试组','',0,1,'4,6,7,8,9',2),(3,'情报员','',0,1,'4,6,7,8',3),(4,'新闻收集员','',0,1,'4,6,7,8',4),(5,'新闻编辑员','1233',0,1,'4,6,7,8,9',5),(30,'测试21','2211',0,1,'4,6,7,9',15),(31,'测试3','12',0,1,'4,6,8,9',16),(32,'测试4','12',0,1,'4,6,7,8,9',17),(33,'测试测试','测试',0,1,'4,5,6',18);

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

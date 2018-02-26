-- -----------------------------
-- Table structure for `krcmf_member`
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_member`;
CREATE TABLE `krcmf_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `realname` char(16) NOT NULL DEFAULT '' COMMENT '人员名称',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别',
  `qq` char(10)  NULL COMMENT 'qq号',
  `position` varchar(20)  NULL COMMENT '职务',
  `desc` varchar(250)  NULL COMMENT '人员描述',
  `mobile_phone` char(15)  NULL COMMENT '移动电话',
  `office_phone` char(20)  NULL COMMENT '办公电话',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of krcmf_member
-- ----------------------------
INSERT INTO `krcmf_member` VALUES ('1', 'admin', '5f8d23af2bbce4b83818863790f88d99', '超级管理员', '1', '', '', '', '', '', '1', '3232238869', '1494378129', '3232238869', '1494378129');


-- -----------------------------
-- Table structure for krcmf_menu
-- -----------------------------
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
  KEY `pid` (`pid`),
  KEY `status` (`status`),
  UNIQUE KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of krcmf_menu
-- ----------------------------
INSERT INTO `krcmf_menu` VALUES ('1', '系统管理', '0', '1', '1', 'admin/index/index', '0', 'icon-system', '1');
INSERT INTO `krcmf_menu` VALUES ('2', '网站配置', '1', '2', '2','admin/config/index', '0', 'icon-member', '1');
INSERT INTO `krcmf_menu` VALUES ('3', '用户管理', '1', '2', '3', 'admin/member/index', '0', 'icon-content', '1');
INSERT INTO `krcmf_menu` VALUES ('4', '内容管理', '0', '1', '4', 'admin/portal/index', '0', 'icon-system', '1');
INSERT INTO `krcmf_menu` VALUES ('5', '栏目管理', '4', '2', '5', 'admin/category/index', '0', 'icon-auth', '1');
INSERT INTO `krcmf_menu` VALUES ('6', '文章管理', '4', '2', '6', 'admin/article/index', '0', 'icon-web', '1');
INSERT INTO `krcmf_menu` VALUES ('7', '作品管理', '4', '2', '7', 'admin/works/index', '0', 'icon-web', '1');
INSERT INTO `krcmf_menu` VALUES ('8', '文档管理', '4', '2', '8', 'admin/document/index', '0', 'icon-web', '1');
INSERT INTO `krcmf_menu` VALUES ('9', '网上图书馆', '4', '2', '9', 'admin/library/index', '0', 'icon-web', '1');
INSERT INTO `krcmf_menu` VALUES ('10', '页面管理', '4', '2', '10', 'admin/page/index', '0', 'icon-file', '0');
INSERT INTO `krcmf_menu` VALUES ('11', '扩展管理', '0', '1', '11', 'admin/addons/index', '0', 'icon-log', '1');
INSERT INTO `krcmf_menu` VALUES ('12', '专题管理', '11', '2', '12', 'admin/topic/index', '0', 'icon-menu', '1');
INSERT INTO `krcmf_menu` VALUES ('13', '幻灯管理', '11', '2', '13', 'admin/slide/index', '0', 'icon-log', '1');
INSERT INTO `krcmf_menu` VALUES ('14', '广告管理', '11', '2', '14', 'admin/ad/index', '0', 'icon-log', '1');
INSERT INTO `krcmf_menu` VALUES ('15', '友情链接', '11', '2', '15', 'admin/link/index', '0', 'icon-log', '1');





-- -----------------------------
-- Table structure for `krcmf_config`
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_config`;
CREATE TABLE IF NOT EXISTS `krcmf_config` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  `option_lang` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='全站配置表' AUTO_INCREMENT=7 ;

-- ----------------------------
-- Records of krcmf_config
-- ----------------------------
INSERT INTO `krcmf_config` (`option_id`, `option_name`, `option_value`, `autoload`, `option_lang`) VALUES
(1, 'site_options', '{"site_name":"四川科瑞软件有限责任公司","site_domain":"keywaysoft.com","site_logo":"","site_desc":"四川科瑞软件有限责任公司","site_keywords":"四川科瑞软件有限责任公司","site_theme":"default","site_status":"1","site_copy":"四川科瑞软件有限责任公司","site_login_bg":"","site_beian":""}', 1, 'zh-cn');


-- -----------------------------
-- Table structure for krcmf_category
-- -----------------------------
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

-- ----------------------------
-- Records of krcmf_category
-- ----------------------------
INSERT INTO `krcmf_category` VALUES ('1', '新闻中心', '0', '1', '0', '0', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('2', '图片新闻', '1', '2', '0', '0', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('3', '政工动态', '1', '2', '0', '0', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('4', '政工研讨', '1', '2', '0', '0', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('5', '时政要闻', '1', '2', '0', '0', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('6', '艺术文化', '0', '1', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('7', '摄影', '6', '2', '0', '1',  '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('8', '书法', '6', '2', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('9', '绘画', '6', '2', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('10', '文学', '6', '2', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('11', '音乐', '6', '2', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('12', '视频', '6', '2', '0', '1', '', '1', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('13', '专题集锦', '0', '1', '0', '4', '', '0', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('14', '通知公告', '0', '1', '0', '2', '', '0', '0', '0', '1');
INSERT INTO `krcmf_category` VALUES ('15', '曝光台', '0', '1', '0', '2', '', '0', '0', '0', '1');
INSERT INTO `krcmf_category` VALUES ('16', '教育课件', '0', '1', '0', '2', '', '0', '1', '0', '1');
INSERT INTO `krcmf_category` VALUES ('17', '拟办理工作', '0', '1', '0', '2', '', '0', '0', '0', '1');
INSERT INTO `krcmf_category` VALUES ('18', '已完成工作', '0', '1', '0', '2', '', '0', '0', '0', '1');
INSERT INTO `krcmf_category` VALUES ('19', '网上图书馆', '0', '1', '0', '3', '', '0', '0', '0', '1');


-- -----------------------------
-- Table structure for krcmf_article
-- -----------------------------
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
  `content` longtext NOT NULL DEFAULT '' COMMENT '内容',
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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for krcmf_works
-- -----------------------------
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
  `content` longtext NOT NULL DEFAULT '' COMMENT '内容',
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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Table structure for krcmf_library
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_library`;
CREATE TABLE `krcmf_library` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字',
  `tag` varchar(50) DEFAULT '' COMMENT '标签',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `attachment` varchar(255) NOT NULL DEFAULT '' COMMENT '图书附件',
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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Table structure for krcmf_topic
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_topic`;
CREATE TABLE `krcmf_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '摘要',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字',
  `tag` varchar(50) DEFAULT '' COMMENT '标签',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `content` longtext NOT NULL DEFAULT '' COMMENT '领导讲话',
  `content_file` longtext NOT NULL DEFAULT '' COMMENT '文件通知',
  `content_image` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '图片展示',
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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Table structure for krcmf_document
-- -----------------------------
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
  `content` longtext NOT NULL DEFAULT '' COMMENT '内容',
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
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `krcmf_page`
-- ----------------------------
DROP TABLE IF EXISTS `krcmf_page`;
CREATE TABLE `krcmf_page` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '页面标题',
  `keywords` varchar(40) NOT NULL DEFAULT '0' COMMENT '页面关键字',
  `content` text  NOT NULL DEFAULT '' COMMENT '页面内容',
  `member_id` int(10) unsigned NOT NULL COMMENT '发布人ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for krcmf_slide
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_slide`;
CREATE TABLE `krcmf_slide` (
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


-- -----------------------------
-- Table structure for krcmf_ad
-- -----------------------------
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

-- ----------------------------
-- Records of krcmf_ad
-- ----------------------------
INSERT INTO `krcmf_ad` VALUES ('1', '艺术文化广告', '20170527\\b8425d50bdefa58ffa5f26d4c44e9bc2.jpg', '#', '艺术文化广告', '0', '0', '1', '1495888833', '1495888833', '1');
INSERT INTO `krcmf_ad` VALUES ('2', '文档广告', '20170527\\5884bbf1cd3c3fbe98454695534fb60e.jpg', '#', '文档广告', '0', '0', '1', '1495888917', '1495888917', '1');
INSERT INTO `krcmf_ad` VALUES ('3', '网上图书馆广告', '20170527\\73e4a5c1a94bf10481c6c86ae8ed5a61.jpg', '', '', '0', '0', '1', '1495888946', '1495888946', '1');
INSERT INTO `krcmf_ad` VALUES ('4', '专题广告', '20170527\\2c43e228ce8cc62ac448df38dfbddb33.jpg', '#', '专题广告', '0', '0', '1', '1495888861', '1495888861', '1');
INSERT INTO `krcmf_ad` VALUES ('5', '新闻中心广告', '20170527\\1ca41cf22e4e1b6d18d497bffda933b7.jpg', '#', '新闻中心广告', '0', '0', '1', '1495888795', '1495888795', '1');
INSERT INTO `krcmf_ad` VALUES ('6', '搜索广告', '20170527\\1ca41cf22e4e1b6d18d497bffda933b7.jpg', '#', '搜索广告', '0', '0', '1', '1495888795', '1495888795', '1');


-- -----------------------------
-- Table structure for krcmf_link
-- -----------------------------
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

-- -----------------------------
-- Table structure for krcmf_asset
-- -----------------------------
DROP TABLE IF EXISTS `krcmf_asset`;
CREATE TABLE IF NOT EXISTS `krcmf_asset` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';
/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.20-log : Database - assert
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`assert` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `assert`;

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '物品名称',
  `assetId` varchar(20) NOT NULL DEFAULT '' COMMENT '物品编号',
  `applicant` varchar(100) NOT NULL DEFAULT '' COMMENT '申请人',
  `receive` varchar(200) DEFAULT '' COMMENT '接收人',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，0：冻结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `goods` */

insert  into `goods`(`id`,`name`,`assetId`,`applicant`,`receive`,`status`) values (11,'test','1234','1qaz','2wsx',1),(12,'qwe','qwe','qwe','qwe',1),(13,'23','qw','qw','qw',1);

/*Table structure for table `sys_acl` */

DROP TABLE IF EXISTS `sys_acl`;

CREATE TABLE `sys_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '权限码',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限名称',
  `acl_module_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限所在的权限模块id',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '请求的url, 可以填正则表达式',
  `type` int(11) NOT NULL DEFAULT '3' COMMENT '类型，1：菜单，2：按钮，3：其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，0：冻结',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '权限在当前模块下的顺序，由小到大',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一个更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_acl` */

insert  into `sys_acl`(`id`,`code`,`name`,`acl_module_id`,`url`,`type`,`status`,`seq`,`remark`,`operator`,`operate_time`,`operate_ip`) values (11,'20191219153647_77','进入用户管理页面',12,'sys/dept/dept.page',3,1,1,'','Admin','2019-12-19 16:46:55','127.0.0.1'),(12,'20191220105350_36','仓库管理界面',15,'/goods/config.page',3,1,1,'','Admin','2019-12-23 13:01:18','127.0.0.1'),(13,'20191223125503_50','修改仓库属性',15,'/goods/update.json',1,1,2,'','Admin','2019-12-23 14:04:19','127.0.0.1'),(14,'20191223130042_94','新增仓库物品',15,'/goods/save.json',1,1,3,'','Admin','2019-12-23 13:00:52','127.0.0.1'),(15,'20191223141633_45','仓库展示页',15,'/goods/page.json',1,1,4,'','Admin','2019-12-23 14:16:34','127.0.0.1');

/*Table structure for table `sys_acl_module` */

DROP TABLE IF EXISTS `sys_acl_module`;

CREATE TABLE `sys_acl_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限模块id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限模块名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级权限模块id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '权限模块层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '权限模块在当前层级下的顺序，由小到大',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，0：冻结',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_acl_module` */

insert  into `sys_acl_module`(`id`,`name`,`parent_id`,`level`,`seq`,`status`,`remark`,`operator`,`operate_time`,`operate_ip`) values (12,'用户管理模块',0,'0',1,1,'','Admin','2019-12-23 12:58:31','127.0.0.1'),(13,'角色管理模块',0,'0',1,1,'','Admin','2019-12-23 12:58:38','127.0.0.1'),(14,'权限管理模块',0,'0',1,1,'','Admin','2019-12-23 12:58:43','127.0.0.1'),(15,'仓库管理模块',0,'0',1,1,'','Admin','2019-12-23 12:58:48','127.0.0.1');

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '部门层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '部门在当前层级下的顺序，由小到大',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`name`,`parent_id`,`level`,`seq`,`remark`,`operator`,`operate_time`,`operate_ip`) values (13,'运维部',0,'0',1,'运维','Admin','2019-12-20 17:25:56','127.0.0.1'),(14,'技术部',0,'0',1,'技术','Admin','2019-12-19 15:22:31','127.0.0.1'),(15,'值守（1线）',0,'0',3,'','Admin','2019-12-24 17:26:38','127.0.0.1');

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '权限更新的类型，1：部门，2：用户，3：权限模块，4：权限，5：角色，6：角色用户关系，7：角色权限关系',
  `target_id` int(11) NOT NULL COMMENT '基于type后指定的对象id，比如用户、权限、角色等表的主键',
  `old_value` text COMMENT '旧值',
  `new_value` text COMMENT '新值',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前是否复原过，0：没有，1：复原过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`type`,`target_id`,`old_value`,`new_value`,`operator`,`operate_time`,`operate_ip`,`status`) values (26,1,13,'','{\"id\":13,\"name\":\"运维部\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1576740115784,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:21:56','127.0.0.1',1),(27,1,14,'','{\"id\":14,\"name\":\"技术部\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"remark\":\"技术\",\"operator\":\"Admin\",\"operateTime\":1576740150626,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:22:31','127.0.0.1',1),(28,5,6,'','{\"id\":6,\"name\":\"仓库管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740165371,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:22:45','127.0.0.1',1),(29,5,7,'','{\"id\":7,\"name\":\"权限管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740174333,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:22:54','127.0.0.1',1),(30,3,12,'','{\"id\":12,\"name\":\"用户管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740190466,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:23:11','127.0.0.1',1),(31,3,13,'','{\"id\":13,\"name\":\"角色管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740206968,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:23:27','127.0.0.1',1),(32,3,14,'','{\"id\":14,\"name\":\"权限管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740216501,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:23:37','127.0.0.1',1),(33,5,6,'{\"id\":6,\"name\":\"仓库管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740165000,\"operateIp\":\"127.0.0.1\"}','{\"id\":6,\"name\":\"仓库管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740225249,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:23:45','127.0.0.1',1),(34,7,6,'[]','[1]','Admin','2019-12-19 15:23:51','127.0.0.1',1),(35,2,6,'','{\"id\":6,\"username\":\"admin@qq.com\",\"telephone\":\"12312312\",\"mail\":\"12312313\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740266492,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:24:27','127.0.0.1',1),(36,2,7,'','{\"id\":7,\"username\":\"去恶气委屈啊\",\"telephone\":\"qqwe\",\"mail\":\"q\'q\'we\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740440081,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:27:20','127.0.0.1',1),(37,4,11,'','{\"id\":11,\"code\":\"20191219153647_77\",\"name\":\"添加用户\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1576741007306,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:36:47','127.0.0.1',1),(38,4,11,'{\"id\":11,\"code\":\"20191219153647_77\",\"name\":\"添加用户\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1576741007000,\"operateIp\":\"127.0.0.1\"}','{\"id\":11,\"name\":\"添加用户\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576741016125,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:36:56','127.0.0.1',1),(39,4,11,'{\"id\":11,\"code\":\"20191219153647_77\",\"name\":\"添加用户\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576741016000,\"operateIp\":\"127.0.0.1\"}','{\"id\":11,\"name\":\"进入用户管理页面\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576741278108,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 15:41:18','127.0.0.1',1),(40,2,7,'{\"id\":7,\"username\":\"去恶气委屈啊\",\"telephone\":\"qqwe\",\"mail\":\"q\'q\'we\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740440000,\"operateIp\":\"127.0.0.1\"}','{\"id\":7,\"username\":\"123\",\"telephone\":\"qqwe\",\"mail\":\"q\'q\'we\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576744604264,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 16:36:44','127.0.0.1',1),(41,4,11,'{\"id\":11,\"code\":\"20191219153647_77\",\"name\":\"进入用户管理页面\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576741278000,\"operateIp\":\"127.0.0.1\"}','{\"id\":11,\"name\":\"进入用户管理页面\",\"aclModuleId\":12,\"url\":\"sys/dept/dept.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576745214763,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-19 16:46:55','127.0.0.1',1),(42,2,8,'','{\"id\":8,\"username\":\"123456\",\"telephone\":\"12345678\",\"mail\":\"123456789@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576808349842,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-20 10:19:10','127.0.0.1',1),(43,3,15,'','{\"id\":15,\"name\":\"仓库管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576810364403,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-20 10:52:45','127.0.0.1',1),(44,4,12,'','{\"id\":12,\"code\":\"20191220105350_36\",\"name\":\"许培华\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576810430789,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-20 10:53:51','127.0.0.1',1),(45,1,13,'{\"id\":13,\"name\":\"运维部\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1576740116000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"运维部\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1576833956098,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-20 17:25:56','127.0.0.1',1),(46,2,9,'','{\"id\":9,\"username\":\"admin123123@qq.com\",\"telephone\":\"123123123\",\"mail\":\"12312312\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577063517601,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 09:11:58','127.0.0.1',1),(47,2,7,'{\"id\":7,\"username\":\"123\",\"telephone\":\"qqwe\",\"mail\":\"q\'q\'we\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576744604000,\"operateIp\":\"127.0.0.1\"}','{\"id\":7,\"username\":\"oqw\",\"telephone\":\"qqwe\",\"mail\":\"q\'q\'we\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577065703497,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 09:48:24','127.0.0.1',1),(48,2,8,'{\"id\":8,\"username\":\"123456\",\"telephone\":\"12345678\",\"mail\":\"123456789@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576808350000,\"operateIp\":\"127.0.0.1\"}','{\"id\":8,\"username\":\"123456\",\"telephone\":\"123456789\",\"mail\":\"123456789@qq.com\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577070072600,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 11:01:13','127.0.0.1',1),(49,2,10,'','{\"id\":10,\"username\":\"123123123\",\"telephone\":\"1231213\",\"mail\":\"123123123\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577070102097,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 11:01:42','127.0.0.1',1),(50,6,6,'[]','[12]','Admin','2019-12-23 12:53:34','127.0.0.1',1),(51,7,7,'[]','[1]','Admin','2019-12-23 12:53:52','127.0.0.1',1),(52,4,13,'','{\"id\":13,\"code\":\"20191223125503_50\",\"name\":\"test\",\"aclModuleId\":12,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577076903517,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:55:04','127.0.0.1',1),(53,4,13,'{\"id\":13,\"code\":\"20191223125503_50\",\"name\":\"test\",\"aclModuleId\":12,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577076904000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"test\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577076944180,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:55:44','127.0.0.1',1),(54,6,6,'[12]','[12,13]','Admin','2019-12-23 12:57:35','127.0.0.1',1),(55,6,7,'[]','[11,12,13]','Admin','2019-12-23 12:57:40','127.0.0.1',1),(56,3,12,'{\"id\":12,\"name\":\"用户管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740190000,\"operateIp\":\"127.0.0.1\"}','{\"id\":12,\"name\":\"用户管理模块\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577077110574,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:58:31','127.0.0.1',1),(57,3,13,'{\"id\":13,\"name\":\"角色管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740207000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"角色管理模块\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577077118479,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:58:39','127.0.0.1',1),(58,3,14,'{\"id\":14,\"name\":\"权限管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576740217000,\"operateIp\":\"127.0.0.1\"}','{\"id\":14,\"name\":\"权限管理模块\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577077123338,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:58:43','127.0.0.1',1),(59,3,15,'{\"id\":15,\"name\":\"仓库管理\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1576810364000,\"operateIp\":\"127.0.0.1\"}','{\"id\":15,\"name\":\"仓库管理模块\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577077127654,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:58:48','127.0.0.1',1),(60,4,12,'{\"id\":12,\"code\":\"20191220105350_36\",\"name\":\"许培华\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1576810431000,\"operateIp\":\"127.0.0.1\"}','{\"id\":12,\"name\":\"仓库管理\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1577077157417,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:59:17','127.0.0.1',1),(61,4,12,'{\"id\":12,\"code\":\"20191220105350_36\",\"name\":\"仓库管理\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1577077157000,\"operateIp\":\"127.0.0.1\"}','{\"id\":12,\"name\":\"仓库管理\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1577077161616,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 12:59:22','127.0.0.1',1),(62,4,13,'{\"id\":13,\"code\":\"20191223125503_50\",\"name\":\"test\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577076944000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"修改仓库属性\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577077203077,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 13:00:03','127.0.0.1',1),(63,4,14,'','{\"id\":14,\"code\":\"20191223130042_94\",\"name\":\"新增仓库物品\",\"aclModuleId\":15,\"url\":\"goods/save.json\",\"type\":1,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1577077242488,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 13:00:43','127.0.0.1',1),(64,4,14,'{\"id\":14,\"code\":\"20191223130042_94\",\"name\":\"新增仓库物品\",\"aclModuleId\":15,\"url\":\"goods/save.json\",\"type\":1,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1577077242000,\"operateIp\":\"127.0.0.1\"}','{\"id\":14,\"name\":\"新增仓库物品\",\"aclModuleId\":15,\"url\":\"/goods/save.json\",\"type\":1,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1577077251561,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 13:00:52','127.0.0.1',1),(65,4,13,'{\"id\":13,\"code\":\"20191223125503_50\",\"name\":\"修改仓库属性\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577077203000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"修改仓库属性\",\"aclModuleId\":15,\"url\":\"/goods/update\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577077263817,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 13:01:04','127.0.0.1',1),(66,4,12,'{\"id\":12,\"code\":\"20191220105350_36\",\"name\":\"仓库管理\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1577077162000,\"operateIp\":\"127.0.0.1\"}','{\"id\":12,\"name\":\"仓库管理界面\",\"aclModuleId\":15,\"url\":\"/goods/config.page\",\"type\":3,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1577077278031,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 13:01:18','127.0.0.1',1),(67,7,7,'[1]','[1,6]','Admin','2019-12-23 13:05:06','127.0.0.1',1),(68,4,13,'{\"id\":13,\"code\":\"20191223125503_50\",\"name\":\"修改仓库属性\",\"aclModuleId\":15,\"url\":\"/goods/update\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577077264000,\"operateIp\":\"127.0.0.1\"}','{\"id\":13,\"name\":\"修改仓库属性\",\"aclModuleId\":15,\"url\":\"/goods/update.json\",\"type\":1,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1577081058741,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 14:04:19','127.0.0.1',1),(69,4,15,'','{\"id\":15,\"code\":\"20191223141633_45\",\"name\":\"仓库展示页\",\"aclModuleId\":15,\"url\":\"/goods/page.json\",\"type\":1,\"status\":1,\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1577081793661,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 14:16:34','127.0.0.1',1),(70,6,6,'[12,13]','[12,13,14,15]','Admin','2019-12-23 14:17:07','127.0.0.1',1),(71,7,6,'[1]','[1,6]','Admin','2019-12-23 14:17:35','127.0.0.1',1),(72,7,7,'[1,6]','[1,6,8]','Admin','2019-12-23 15:13:50','127.0.0.1',1),(73,2,11,'','{\"id\":11,\"username\":\"test1\",\"telephone\":\"234567\",\"mail\":\"123@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577085898867,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-23 15:24:59','127.0.0.1',1),(74,2,12,'','{\"id\":12,\"username\":\"1231231\",\"telephone\":\"123123123132\",\"mail\":\"123123123@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":13,\"status\":1,\"operator\":\"test1\",\"operateTime\":1577086222717,\"operateIp\":\"127.0.0.1\"}','test1','2019-12-23 15:30:23','127.0.0.1',1),(75,7,6,'[1,6]','[1,6,11]','test1','2019-12-23 15:31:25','127.0.0.1',1),(76,1,15,'','{\"id\":15,\"name\":\"值守（1线）\",\"parentId\":0,\"level\":\"0\",\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1577179598410,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-24 17:26:39','127.0.0.1',1),(77,2,12,'','{\"id\":12,\"username\":\"邓学进\",\"telephone\":\"123213\",\"mail\":\"123123@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":15,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1577179658139,\"operateIp\":\"127.0.0.1\"}','Admin','2019-12-24 17:27:38','127.0.0.1',1),(78,7,6,'[1,6,11]','[1,6,11,12]','Admin','2019-12-24 17:28:21','127.0.0.1',1),(79,6,7,'[11,12,13]','[11,12,13,14]','Admin','2019-12-24 17:29:02','127.0.0.1',1),(80,7,7,'[1,6,8]','[1,6,12]','Admin','2019-12-24 17:29:06','127.0.0.1',1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '角色的类型，1：管理员角色，2：其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：可用，0：冻结',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`type`,`status`,`remark`,`operator`,`operate_time`,`operate_ip`) values (6,'仓库管理员',1,1,'','Admin','2019-12-19 15:23:45','127.0.0.1'),(7,'权限管理员',1,1,'','Admin','2019-12-19 15:22:54','127.0.0.1');

/*Table structure for table `sys_role_acl` */

DROP TABLE IF EXISTS `sys_role_acl`;

CREATE TABLE `sys_role_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `acl_id` int(11) NOT NULL COMMENT '权限id',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(200) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role_acl` */

insert  into `sys_role_acl`(`id`,`role_id`,`acl_id`,`operator`,`operate_time`,`operate_ip`) values (7,6,12,'Admin','2019-12-23 14:17:07','127.0.0.1'),(8,6,13,'Admin','2019-12-23 14:17:07','127.0.0.1'),(9,6,14,'Admin','2019-12-23 14:17:07','127.0.0.1'),(10,6,15,'Admin','2019-12-23 14:17:07','127.0.0.1'),(11,7,11,'Admin','2019-12-24 17:29:01','127.0.0.1'),(12,7,12,'Admin','2019-12-24 17:29:01','127.0.0.1'),(13,7,13,'Admin','2019-12-24 17:29:01','127.0.0.1'),(14,7,14,'Admin','2019-12-24 17:29:01','127.0.0.1');

/*Table structure for table `sys_role_user` */

DROP TABLE IF EXISTS `sys_role_user`;

CREATE TABLE `sys_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_role_user` */

insert  into `sys_role_user`(`id`,`role_id`,`user_id`,`operator`,`operate_time`,`operate_ip`) values (30,6,1,'Admin','2019-12-24 17:28:21','127.0.0.1'),(31,6,6,'Admin','2019-12-24 17:28:21','127.0.0.1'),(32,6,11,'Admin','2019-12-24 17:28:21','127.0.0.1'),(33,6,12,'Admin','2019-12-24 17:28:21','127.0.0.1'),(34,7,1,'Admin','2019-12-24 17:29:06','127.0.0.1'),(35,7,6,'Admin','2019-12-24 17:29:06','127.0.0.1'),(36,7,12,'Admin','2019-12-24 17:29:06','127.0.0.1');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名称',
  `telephone` varchar(13) NOT NULL DEFAULT '' COMMENT '手机号',
  `mail` varchar(20) NOT NULL DEFAULT '' COMMENT '邮箱',
  `password` varchar(40) NOT NULL DEFAULT '' COMMENT '加密后的密码',
  `dept_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户所在部门的id',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，0：冻结状态，2：删除',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`telephone`,`mail`,`password`,`dept_id`,`status`,`remark`,`operator`,`operate_time`,`operate_ip`) values (1,'Admin','18612344321','admin@qq.com','25D55AD283AA400AF464C76D713C07AD',1,1,'admin','system','2019-12-19 15:12:31',''),(6,'admin@qq.com','12312312','12312313','25D55AD283AA400AF464C76D713C07AD',13,1,'','Admin','2019-12-19 15:24:26','127.0.0.1'),(11,'test1','234567','123@qq.com','25D55AD283AA400AF464C76D713C07AD',13,1,'','Admin','2019-12-23 15:24:59','127.0.0.1'),(12,'邓学进','123213','123123@qq.com','25D55AD283AA400AF464C76D713C07AD',15,1,'','Admin','2019-12-24 17:27:38','127.0.0.1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

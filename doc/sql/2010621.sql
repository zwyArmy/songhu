/*修改管理员的成长事迹20160621*/
UPDATE `songhu`.`g_menu` SET `click`='common/article/list.jsp' WHERE `bh_cd`='0203';
CREATE TABLE `cms_xyrz` (
  `id` varchar(32) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `item_no` varchar(10) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `visits` int(11) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `state` varchar(1) DEFAULT NULL,
  `author` varchar(32) DEFAULT NULL,
  `path` varchar(50) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `type_name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*dev*/
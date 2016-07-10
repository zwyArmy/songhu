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
/*20160628修改菜单栏链接*/
UPDATE `g_menu` SET `click`='common/cityDevelop/list.jsp' WHERE `bh_cd`='0301';
UPDATE `g_menu` SET `click`='common/technicalService/list.jsp' WHERE `bh_cd`='0302';
UPDATE `g_menu` SET `click`='common/productDevelope/list.jsp' WHERE `bh_cd`='0303';

UPDATE `songhu`.`cms_column` SET `link`='' WHERE `id`='03';

UPDATE `songhu`.`cms_column` SET `link`='municipalConstruction.html?column_id=0301&parentId=03' WHERE `id`='0301';
UPDATE `songhu`.`cms_column` SET `link`='municipalConstruction.html?column_id=0302&parentId=03' WHERE `id`='0302';
UPDATE `songhu`.`cms_column` SET `link`='municipalConstruction.html?column_id=0303&parentId=03' WHERE `id`='0303';
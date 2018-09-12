# mysql实现同一张表内，统计不同条件下的数据

*工作中遇到的问题，一个很好的尝试*
> 数据表

```
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COMMENT='微信河狸口腔云用户登录日志';

```

## 1.需求:
> 1.每一天统计前一天用户进行登录的数据

> 2.只查询用户第一次登录的时间(去重)

> 3.统计用户登录的次数

> 4.统计用户重新登录的次数

## 2.解决方案:

```
SELECT
	FROM_UNIXTIME(
		login_time,
		'%Y-%m-%d %H:%i:%s'
	) AS 登录时间,
	clinic_name AS 诊所名称,
	true_name AS 登录用户,
	mobile AS 联系方式,
	SUM(IF((login_type = '1'), 1, 0)) AS '用户登录次数',
	SUM(IF((login_type = '2'), 1, 0)) AS '重新登录次数',
	staff_id AS 用户id,
	clinic_id AS 诊所id
FROM
	ss_wxlogin_data
WHERE
	login_time BETWEEN unix_timestamp(
		date_add(curdate(), INTERVAL - 1 DAY)
	)
AND unix_timestamp(
	concat(
		date_add(curdate(), INTERVAL + 1 DAY),
		' 23:59:59'
	)
)
GROUP BY
	clinic_id
ORDER BY
	login_time ASC;
```

```
+---------------------+-----------------------+--------------+--------------+--------------------+--------------------+----------+----------+
| 登录时间            | 诊所名称              | 登录用户     | 联系方式     | 用户登录次数       | 重新登录次数       | 用户id   | 诊所id   |
+---------------------+-----------------------+--------------+--------------+--------------------+--------------------+----------+----------+
| 2018-09-12 10:21:25 | 珮裴齿科              | 潘俊卓       | 13924608604  |                 13 |                  0 |     8680 |     8318 |
| 2018-09-12 10:22:54 | 深圳张珊诊所          | 刘志专       | 13728742758  |                  8 |                  2 |      205 |       87 |
| 2018-09-12 10:37:48 | 传承口腔门诊部        | 李先生       | 15207554040  |                  7 |                  0 |     8685 |     8323 |
| 2018-09-12 10:41:59 | 周世测试              | 15818754087  | 15818754087  |                  0 |                 11 |     8621 |     8282 |
+---------------------+-----------------------+--------------+--------------+--------------------+--------------------+----------+----------+
4 rows in set (0.02 sec)
```

## 3.主要分析：
> 1.根据登录时间戳查询 在 2018-09-11 00:00:00 到 2018-09-13 00:00:00时间范围内的用户登录数据 </br>
**DATE_ADD**
https://www.yiibai.com/mysql/date_add.html </br>
**curdate()**  http://www.w3school.com.cn/sql/func_curdate.asp </br>
**SUM(IF((login_type = '1'), 1, 0)) AS '用户登录次数'** https://blog.csdn.net/design321/article/details/8690855 </br>
*意思是如果 login_type = '1' , 将 1 累加到 用户登录次数 , 否则将 0 累加到 用户登录次数*

## 4.相关sql数据:
ss_wxlogin_data.sql
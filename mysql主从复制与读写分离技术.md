下面是我在实际工作过程中所整理的笔记，在此分享出来，以供大家参考。</br>
我的安装过程都是源码编译安装
### 1.编译mysql

#### 1. 安装cmake
> cmake也是一款c语言的编译软件，类似于gcc和gcc++，但是算是后者的一个升级版本，在mysql的安装过程中需要使用cmake，因为mysql从5.5版本之后使用的是cmake编译的，并且要求cmake 版本大于2.8。

```
[root@localhost data]# pwd
/root/data
[root@localhost data]# ls -lht
总用量 30M
-rw-r--r--. 1 root root  24M 9月   3 2017 mysql-5.5.17.tar.gz
-rw-r--r--. 1 root root 6.6M 9月   3 2017 cmake-3.6.0.tar.gz
[root@localhost data]# tar -zxvf cmake-3.6.0.tar.gz 
[root@localhost data]# cd cmake-3.6.0
[root@localhost cmake-3.6.0]# 
[root@localhost cmake-3.6.0]# ./bootstrap 
[root@localhost cmake-3.6.0]# echo $?
0
[root@localhost cmake-3.6.0]# gmake && gmake install
[root@localhost cmake-3.6.0]# echo $?
0
```

#### 2.安装ncurses-devel
```
[root@localhost cmake-3.6.0]# mkdir /mnt/cdrom
[root@localhost cmake-3.6.0]# mount /dev/sr0 /mnt/cdrom
mount: block device /dev/sr0 is write-protected, mounting read-only
[root@localhost mnt]# cd cdrom/Packages/
[root@localhost Packages]# 
[root@localhost Packages]# ls ncurses-devel*
ncurses-devel-5.7-3.20090208.el6.i686.rpm
[root@localhost Packages]# rpm -ivh ncurses-devel-5.7-3.20090208.el6.i686.rpm 
Preparing...                ########################################### [100%]
   1:ncurses-devel          ########################################### [100%]
```

#### 3.安装mysql
```
[root@localhost Packages]# cd /root/data/
[root@localhost data]# ls -lht mysql-5.5.17.tar.gz 
-rw-r--r--. 1 root root 24M 9月   3 2017 mysql-5.5.17.tar.gz

[root@localhost data]# tar -zxvf mysql-5.5.17.tar.gz 
[root@localhost data]# cd mysql-5.5.17
[root@localhost mysql-5.5.17]# cmake \
> -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
> -DMYSQL_DATADIR=/usr/local/mysql/data \
> -DDEFAULT_CHARSET=utf8 \
> -DDEFAULT_COLLATION=utf8_general_ci
[root@localhost mysql-5.5.17]# echo $?
0
```
> DCMAKE_INSTALL_PREFIX： 安装路径</br>
  -DMYSQL_DATADIR：mysql的数据目录 </br>
  -DEFAULT_CHARSET：设置mysql的默认字符集 </br>
  -DDEFAULT_COLLATION：设置默认的排序 </br>

```
[root@localhost mysql-5.5.17]# make && make install
[root@localhost mysql-5.5.17]# echo $?
0
产生mysql配置文件（下述命令必须在mysql的解压目录中执行）：
[root@localhost mysql-5.5.17]# cp support-files/my-medium.cnf /etc/my.cnf
cp：是否覆盖"/etc/my.cnf"？ y
Mysql用户组及权限设置：
[root@localhost mysql-5.5.17]# useradd mysql
useradd: user 'mysql' already exists
[root@localhost mysql-5.5.17]# find /usr/local/ -maxdepth 1 -name '*mysql*'
/usr/local/mysql
[root@localhost mysql-5.5.17]# chmod u+x,g+x,o+x /usr/local/mysql
[root@localhost mysql-5.5.17]# ls -lht /usr/local/
总用量 44K
drwxr-xr-x. 13 root root 4.0K 8月   4 10:53 mysql
[root@localhost mysql-5.5.17]# chown -R mysql.mysql /usr/local/mysql
[root@localhost mysql-5.5.17]# ls -lht /usr/local/
总用量 44K
drwxr-xr-x. 13 mysql mysql 4.0K 8月   4 10:53 mysql
```

> chmod u+x,g+x,o+x　/usr/local/mysql：对/usr/local/mysql加上可执行权限 </br>
chown –R  mysql.mysql /usr/local/mysql：对/usr/local/mysql目录变更所有者和所属组

> 在linux下装好mysql之后本身没有一些默认的数据，如test数据库。所以需要进行数据库的初始化操作。
数据库初始化：
```
[root@localhost mysql-5.5.17]# /usr/local/mysql/scripts/mysql_install_db \
> --user=mysql \
> --basedir=/usr/local/mysql \
> --datadir=/usr/local/mysql/data &
```
&符号，表示所在的命令后台执行。
卡屏时，按下回车键即可：

> 把mysql安装文件(除data)的所有者都改为root，避免数据库恢复为出厂设置：
```
[root@localhost mysql-5.5.17]# ls -lht /usr/local/
总用量 44K
drwxr-xr-x. 13 mysql mysql 4.0K 8月   4 10:53 mysql
[root@localhost mysql-5.5.17]# chown -R root /usr/local/mysql
[root@localhost mysql-5.5.17]# ls -lht /usr/local/
总用量 44K
drwxr-xr-x. 13 root mysql 4.0K 8月   4 10:53 mysql
#除了mysql/data目录之外
[root@localhost mysql-5.5.17]# chown -R mysql /usr/local/mysql/data
[root@localhost mysql-5.5.17]# ls -lht /usr/local/mysql/
总用量 76K
drwxr-xr-x.  5 mysql mysql 4.0K 8月   4 11:08 data
```

> 后台运行mysql服务，命令完成按下回车：
```
[root@localhost mysql-5.5.17]# /usr/local/mysql/support-files/mysql.server start
Starting MySQL..                                           [确定]
查看mysql是否启动：
[root@localhost mysql-5.5.17]# ps -aux | grep mysql
Warning: bad syntax, perhaps a bogus '-'? See /usr/share/doc/procps-3.2.8/FAQ
root     18759  0.0  0.1   6680  1284 pts/0    S    11:15   0:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/usr/local/mysql/data --pid-file=/usr/local/mysql/data/localhost.localdomain.pid
mysql    19010  1.0  3.2 327700 33972 pts/0    Sl   11:15   0:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=/usr/local/mysql/data/localhost.localdomain.err --pid-file=/usr/local/mysql/data/localhost.localdomain.pid --socket=/tmp/mysql.sock --port=3306
root     19037  0.0  0.0   5980   736 pts/0    S+   11:15   0:00 grep mysql
测试数据库：
[root@localhost mysql-5.5.17]# /usr/local/mysql/bin/mysql -u root
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.5.17-log Source distribution

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 

```
出现此界面时，表示安装成功：

> 设置数据库密码：
```
mysql> update user set password=password('123456') where user = 'root';
Query OK, 4 rows affected (0.00 sec)
Rows matched: 4  Changed: 4  Warnings: 0
设置root用户的密码为 123456
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
mysql> exit;
Bye

[root@localhost mysql-5.5.17]# /usr/local/mysql/bin/mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.5.17-log Source distribution

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

#### 4.为mysql建立软链接
```
[root@localhost mysql-5.5.17]# ln -s /usr/local/mysql/bin/mysql /bin/mysql
[root@localhost mysql-5.5.17]# ls -lht /bin/mysql 
lrwxrwxrwx. 1 root root 26 8月   4 11:25 /bin/mysql -> /usr/local/mysql/bin/mysql
[root@localhost mysql-5.5.17]# mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.5.17-log Source distribution

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```
#### 5.配置自启动服务shell脚本
```
[root@localhost mysql-5.5.17]# vim /etc/rc.d/rc.local                           
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local
#启动mysql
/usr/local/mysql/support-files/mysql.server start

```

### 2.主从服务器

#### 1.主从服务器的实现原理
![主从副服务器的实现原理](D9720215FBA440449BD7439BFC107992)

> 和bin-log日志相关的一些函数 </br>
> 1.刷新所有日志 flush logs; </br>
> 2.查看当前所有日志状态  show master logs </br>
> 3.查看当前日志位置 show master status </br>
> 4.清除bin-log日志 reset master

```
mysql> show master status;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000004 |      107 |              |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
mysql> show master logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000001 |     27828 |
| mysql-bin.000002 |   1027959 |
| mysql-bin.000003 |       472 |
| mysql-bin.000004 |       107 |
+------------------+-----------+
4 rows in set (0.00 sec)

```

#### 2.使用log-bin日志完成数据恢复

> 由于误操作，将网站数据库删掉了，此时，可以使用mysqlbinlog命令将binlog日志中的修改数据的记录导出来，进行数据恢复

### 3.主从复制
> 1.主从复制需要两台mysql服务器，两台服务器的IP地址不能一样。</br>
> 2.关闭两台mysql服务器的防火墙（service iptables stop），防止干预。</br>
> 3.两个mysql服务器IP地址：
主服务器：192.168.80.137
从服务器：192.168.80.138

#### 1.配置主服务器
> 第一步： 修改配置文件 /etc/my.cnf
```
[root@localhost mysql]# vim /etc/my.cnf
# required unique id between 1 and 2^32 - 1
# defaults to 1 if master-host is not set
# but will not function as a master if omitted
server-id       = 1 #此id值在局域网中不能重复
```

> 第二步： 添加授权账号
```
mysql> GRANT REPLICATION SLAVE ON *.* TO repuser@"192.168.%.%" IDENTIFIED BY 'yjs66';   
Query OK, 0 rows affected (0.01 sec)
```

#### 2.配置从服务器
> 第一步： 修改配置文件 /etc/my.cnf
```
[root@localhost ~]# vim /etc/my.cnf
# required unique id between 1 and 2^32 - 1
# defaults to 1 if master-host is not set
# but will not function as a master if omitted
server-id       = 138

```

> 第二步： 在主服务器137上查看bin-log日志文件名称及位置点：
```
mysql> show master status;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000005 |      344 |              |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
```

> 在从服务器138上执行相关命令：
```
mysql> CHANGE MASTER TO MASTER_HOST='192.168.80.137',MASTER_USER='repuser',MASTER_PASSWORD='yjs66',MASTER_LOG_FILE='mysql-bin.000005',MASTER_LOG_POS=344;
Query OK, 0 rows affected (0.01 sec)

mysql> start slave;
Query OK, 0 rows affected (0.00 sec)

mysql> show slave status \G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.80.137
                  Master_User: repuser
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000005
          Read_Master_Log_Pos: 344
               Relay_Log_File: localhost-relay-bin.000002
                Relay_Log_Pos: 253
        Relay_Master_Log_File: mysql-bin.000005
             Slave_IO_Running: Yes   #Slave_IO_Running 与 Slave_SQL_Running 的值都必须为YES，才表明状态正常
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 344
              Relay_Log_Space: 413
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
1 row in set (0.00 sec)
```

> 第三步： 主从两台服务器都要重启

> 验证主从复制效果
```
#主服务器创建一个数据库
mysql> create database first_db;
Query OK, 1 row affected (0.01 sec)
mysql> use first_db
Database changed
mysql> create table first_tb(id int(3),name char(10));
Query OK, 0 rows affected (0.01 sec)
mysql> insert into first_tb values (12, 'laoerpang');
Query OK, 1 row affected (0.00 sec)


#在从服务器上查看状态
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| first_db           |
| mysql              |
| performance_schema |
| test               |
+--------------------+
5 rows in set (0.00 sec)
mysql> use first_db;
Database changed
mysql> show tables;
+--------------------+
| Tables_in_first_db |
+--------------------+
| first_tb           |
+--------------------+
1 row in set (0.00 sec)

mysql> select * from first_tb;
+------+-----------+
| id   | name      |
+------+-----------+
|   12 | laoerpang |
+------+-----------+
1 row in set (0.00 sec)
```

> 在从数据库上发现 </br> 
> 1.数据库first_db已经自动生成 </br>
> 2.数据库表first_tb也已经自动创建 </br>
> 3.记录也已经存在


> 取消重复服务器 
```
mysql> stop slave;
Query OK, 0 rows affected (0.00 sec)

mysql> show slave status \G;
*************************** 1. row ***************************
               Slave_IO_State: 
                  Master_Host: 192.168.80.137
                  Master_User: repuser
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000005
          Read_Master_Log_Pos: 1753
               Relay_Log_File: localhost-relay-bin.000002
                Relay_Log_Pos: 953
        Relay_Master_Log_File: mysql-bin.000005
             Slave_IO_Running: No    #已停止
            Slave_SQL_Running: No    #已停止
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 1753
              Relay_Log_Space: 1113
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
1 row in set (0.00 sec)
```


> 如果主服务器已经存在应用数据，则在进行主从复制时，需要做以下处理：</br>
> (1)主数据库进行锁表操作，不让数据再进行写入动作
mysql> FLUSH TABLES WITH READ LOCK; </br>
> (2)查看主数据库状态
mysql> show master status; </br>
> (3)记录下 FILE 及 Position 的值。
将主服务器的数据文件（整个/usr/local/mysql/data目录）复制到从服务器，建议通过tar归档压缩后再传到从服务器解压。</br>
> (4)取消主数据库锁定
mysql> UNLOCK TABLES;


> 读写分离的配置
如果在从服务器my.cnf文件里，加入read-only=1，那么从服务器只能读，普通用户不能写入，但管理员用户可以读写。
不建议从服务器配置为只读模式：假如主服务器挂了，那么从服务器也只能读，不能写。如果不配置只读模式，那么可以使用相关的软件mycat/keepalive/mysql-proxy等软件来监控主从复制模式，发现主服务器挂了，可以使用从服务器升级为主服务器。

#!/bin/bash
service mysqld start
mysql -uroot mysql -e "source /usr/local/mysql_init.sql"
service mysqld restart

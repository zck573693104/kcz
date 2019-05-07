#!/bin/bash
cd /usr/local/mysql/ && ./scripts/mysql_install_db --user=root
service mysql start
mysql -uroot mysql -e "source /usr/local/mysql_init.sql"
service mysql restart
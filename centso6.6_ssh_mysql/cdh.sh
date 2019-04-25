#!/bin/bash
mysql -uroot -p123456 mysql -e "drop database if EXISTS cm"
service httpd start
/opt/cloudera-manager/cm-5.7.0/share/cmf/schema/scm_prepare_database.sh mysql cm -hlocalhost -uroot -p123456 --scm-host localhost scm scm scm
/etc/init.d/cloudera-scm-server start
/etc/init.d/cloudera-scm-agent start
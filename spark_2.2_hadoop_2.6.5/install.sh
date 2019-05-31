#先执行了卸载 maria java  cp了环境变量 
export JAVA_HOME=/usr/local/jdk1.8.0_191
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JRE_HOME=$JAVA_HOME/jre
export HBASE_HOME=/opt/cloudera/parcels/CDH-5.10.0-1.cdh5.10.0.p0.41/lib/hbase
export HADOOP_HOME=/opt/cloudera/parcels/CDH-5.10.0-1.cdh5.10.0.p0.41/
export HIVE_HOME=/opt/cloudera/parcels/CDH-5.10.0-1.cdh5.10.0.p0.41/lib/hive
export HADOOP_CMD=/opt/cloudera/parcels/CDH-5.10.0-1.cdh5.10.0.p0.41/lib/hadoop/bin/hadoop
export HCAT_HOME=/opt/cloudera/parcels/CDH-5.10.0-1.cdh5.10.0.p0.41/lib/hive-hcatalog
export KYLIN_HOME=/usr/local/kylin
export HADOOP_CONF_DIR=/etc/hadoop/conf
export HIVE_CONF=/etc/hive/conf
export MYSQL_HOME=/usr/local/mysql-5.6.43
export SQOOP_HOME=/usr/local/sqoop
export PATH=${PATH}:${JAVA_HOME}/bin:${PATH}:${KYLIN_HOME}/bin:${PATH}:${MYSQL_HOME}/bin:$SQOOP_HOME/bin
 
#vim /etc/hosts
#vim /etc/hostname
#vim /etc/sysconfig/network
#HOSTNAME=name
#systemctl stop firewalld
#systemctl disable firewalld
#rpm -qa | grep maria 
#rpm -e --nodeps
#重启


yum -y install gcc gcc-c++ make cmake ncurses ncurses-devel man ncurses libxml2 libxml2-devel openssl-devel  bison bison-devel libxml2-devel libxslt-devel perl perl-devel autoconf net-tools psmisc
yum -y install cyrus-sasl-plain cyrus-sasl-devel cyrus-sasl-gssapi lrzsz vim

#java
mkdir -p /usr/share/
mkdir -p /usr/java/
tar -zxvf /usr/local/soft/jdk-8u191-linux-x64.tar.gz -C /usr/local
ln -s /usr/local/jdk1.8.0_191 /usr/local/jdk1.8
ln -s /usr/local/jdk1.8.0_191 /usr/local/java
ln -s /usr/local/jdk1.8.0_191 /usr/share/java
ln -s /usr/local/jdk1.8.0_191 /usr/local/java
ln -s /usr/local/jdk1.8.0_191 /usr/java/defaulkt

#mysql
mkdir -p /data/mysql
cp /usr/local/soft/mysql-connector-java.jar /usr/share/java/
mkdir -p /usr/local/mysql-5.6.43 && tar -zxvf /usr/local/soft/mysql-5.6.43.tar.gz -C /usr/local/mysql-5.6.43 --strip-components 1
ln -s /usr/local/mysql-5.6.43 /usr/local/mysql
chown -R root:root /usr/local/mysql-5.6.43
cp /usr/local/soft/my.cnf /etc
cp /usr/local/soft/mysql.server /etc/init.d/mysql
chmod 777 /etc/init.d/mysql

cd /usr/local/mysql/ && ./scripts/mysql_install_db --user=root
service mysql start

use mysql;
update user set password=password("123456");

CREATE DATABASE hive DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

CREATE DATABASE amon DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

CREATE DATABASE hue DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

CREATE DATABASE monitor DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

CREATE DATABASE oozie DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;

FLUSH PRIVILEGES;

service mysql restart

cd /etc/init.d/ && chkconfig --add mysql
chkconfig mysql on
ln -s /usr/local/mysql-5.6.43/lib/libmysqlclient.so.18 /usr/lib64/libmysqlclient.so.18

#CDH

mkdir -p /var/cloudera-scm-server
mkdir -p /opt/cloudera/parcel-repo
mkdir -p /opt/cloudera-manager
cp /usr/local/soft/CDH* /opt/cloudera/parcel-repo/
cp /usr/local/soft/manifest.json /opt/cloudera/parcel-repo/
tar xf /usr/local/soft/cloudera-manager-centos7-cm5.10.0_x86_64.tar.gz -C /opt/cloudera-manager
useradd --system --home=/opt/cloudera-manager/cm-5.10.0/run/cloudera-scm-server --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm
chown cloudera-scm:cloudera-scm /var/cloudera-scm-server
chown cloudera-scm:cloudera-scm /opt/cloudera-manager
chown cloudera-scm:cloudera-scm /opt/cloudera/parcel-repo
cd /opt/cloudera-manager/cm-5.10.0/share/cmf/schema/ && ./scm_prepare_database.sh mysql -uroot  –p123456 --scm-host localhost scm scm scm
vim  /opt/cloudera-manager/cm-5.10.0/etc/cloudera-scm-agent/config.ini

#!/bin/bash
/usr/local/hadoop-2.6.5/bin/hdfs namenode -format
/usr/local/hadoop-2.6.5/sbin/start-dfs.sh
hadoop fs -mkdir -p /history
hadoop fs -mkdir -p /spark/history
hadoop fs -mkdir /tmp
hadoop fs -mkdir /hbase
hadoop fs -mkdir -p /usr/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /usr/hive/warehouse
/usr/local/hadoop-2.6.5/sbin/start-yarn.sh
/usr/local/zookeeper-3.4.13/bin/zkServer.sh start
/usr/local/mysql.sh
schematool -dbType mysql -initSchema
/usr/local/kafka_2.11-2.1.0/bin/kafka-server-start.sh /usr/local/kafka_2.11-2.1.0/config/server.properties

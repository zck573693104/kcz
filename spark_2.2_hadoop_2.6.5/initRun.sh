#!/bin/bash
/usr/local/mysql.sh
sleep 3
/usr/local/zookeeper/bin/zkServer.sh start
sleep 3
/usr/local/hadoop/bin/hdfs namenode -format
sleep 3
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh
sleep 3
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver
sleep 2
hadoop fs -mkdir -p /history
hadoop fs -mkdir -p /kylin/spark/
hadoop fs -put /usr/local/spark/jars/spark-libs.jar /kylin/spark/
hadoop fs -mkdir -p /spark/history
hadoop fs -mkdir /tmp
hadoop fs -mkdir /hbase
hadoop fs -mkdir -p /usr/hive/warehouse
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /usr/hive/warehouse
sleep 2
/usr/local/hbase/bin/start-hbase.sh
sleep 3
schematool -dbType mysql -initSchema
sleep 3
hive --service metastore -p 9083 &
#/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties

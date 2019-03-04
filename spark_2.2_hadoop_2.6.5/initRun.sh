#!/bin/bash
/usr/local/hadoop-2.6.5/bin/hdfs namenode -format
/usr/local/hadoop-2.6.5/sbin/start-dfs.sh
hadoop fs -mkdir -p /history
hadoop fs -mkdir -p /spark/history
/usr/local/hadoop-2.6.5/sbin/start-yarn.sh
/usr/local/zookeeper-3.4.13/bin/zkServer.sh start
/usr/local/kafka_2.11-2.1.0/bin/kafka-server-start.sh /usr/local/kafka_2.11-2.1.0/config/server.properties

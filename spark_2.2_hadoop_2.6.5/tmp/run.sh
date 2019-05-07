#!/bin/bash
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh
/usr/local/zookeeper/bin/zkServer.sh start
/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties

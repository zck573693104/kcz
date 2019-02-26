#!/bin/bash
/usr/local/hadoop-2.6.5/bin/hdfs namenode -format
/usr/local/hadoop-2.6.5/sbin/start-dfs.sh
hadoop fs -mkdir -p /history
hadoop fs -mkdir -p /spark/history
/usr/local/hadoop-2.6.5/sbin/start-yarn.sh

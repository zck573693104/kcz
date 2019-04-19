java -cp KafkaOffsetMonitor-assembly-0.2.0.jar com.quantifind.kafka.offsetapp.OffsetGetterWeb \
--port 8088 \
--zk master:12181 \
--refresh 5.minutes \
--retain 1.day >/dev/null 2>&1;
#!/bin/bash

exec java -cp /kafkaoffsetmonitor/KafkaOffsetMonitor.jar \
  com.quantifind.kafka.offsetapp.OffsetGetterWeb \
  --zk ${ZK_HOSTS:-localhost:2181} \
  --port ${PORT:-8080} \
  --refresh ${REFRESH_SECONDS:-10}.seconds \
  --retain ${RETAIN_DAYS:-2}.days

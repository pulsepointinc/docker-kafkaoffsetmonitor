FROM centos:7

RUN yum update -y && yum clean all

RUN yum install -y java-1.8.0-openjdk-headless && yum clean all

RUN mkdir /kafkaoffsetmonitor && \
  curl -s -L \
  -o /kafkaoffsetmonitor/KafkaOffsetMonitor.jar \
  https://github.com/quantifind/KafkaOffsetMonitor/releases/download/v0.2.1/KafkaOffsetMonitor-assembly-0.2.1.jar

COPY start.sh /kafkaoffsetmonitor/start.sh

EXPOSE 8080

CMD ["/kafkaoffsetmonitor/start.sh"]

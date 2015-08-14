FROM centos:7

RUN yum install -y java-1.8.0-openjdk-headless && yum clean all

ENV \
  KOM_CHECKOUT=bf10dcee3423112e89cc10e732eb5ac577d7d376 \
  KOMG_CHECKOUT=992d414a8a66ccf1ae981dee9264b0f7103e6818

RUN curl -o /etc/yum.repos.d/bintray-sbt-rpm.repo \
  https://bintray.com/sbt/rpm/rpm && \
  yum install -y sbt git && \
  git clone https://github.com/quantifind/KafkaOffsetMonitor.git /tmp/kafkaoffsetmonitor && \
  cd /tmp/kafkaoffsetmonitor && \
  git checkout ${KOM_CHECKOUT} && \
  sbt publishM2 && \
  mkdir /cp && \
  cp target/scala-*/*.jar /cp && \
  git clone https://github.com/allegro/kafka-offset-monitor-graphite.git /tmp/kafkaoffsetmonitorgraphite && \
  cd /tmp/kafkaoffsetmonitorgraphite && \
  git checkout ${KOMG_CHECKOUT} && \
  sbt assembly && \
  cp target/scala-*/*.jar /cp && \
  yum autoremove -y git sbt && \
  yum clean all && \
  rm -rf /root/.m2 /root/.sbt /root/.ivy2 /tmp/*

EXPOSE 8080

COPY start.sh /start.sh

CMD ["/start.sh"]

#! /bin/sh

. /vagrant_scripts/kafka/common.sh

verify ()
{
  if [ $r -eq 0 ]; then
    info "$msg: OK"
  else
    error "$msg: KO. Error: $r"
  fi
}

#sudo yum install java -y
KAFKA_DOWNLOAD=http://apache.crihan.fr/dist/kafka/2.6.0/kafka_2.13-2.6.0.tgz
KAFKA_BINARY=kafka_2.13-2.6.0.tgz

cd /tmp
rm -Rf ${KAFKA_BINARY}
rm -Rf kafka*
rm -Rf kafka-logs
rm -Rf zookeeper

#Kafka download
wget $KAFKA_DOWNLOAD > /dev/null 2>&1
r=$?
msg="Download kafka binaries"
verify $msg $r


tar -xzf $KAFKA_BINARY > /dev/null 2>&1
r=$?
msg="untar kafka binaires"
verify $msg $r

cd kafka*

#Start zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties > /dev/null 2>&1 &
r=$?
msg="Start zookeeper server"
verify $msg $r

sleep 10

#Start kafka
bin/kafka-server-start.sh config/server.properties > /dev/null 2>&1 &
r=$?
msg="Start kafka server"
verify $msg $r

sleep 10

#List topic
info "Listing kafka topics"
bin/kafka-topics.sh --list --bootstrap-server localhost:9092  > /dev/null 2>&1 &

cd /tmp/kafka*

cd /tmp/kafka*

#Start zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties &

sleep 10

#Start kafka
bin/kafka-server-start.sh config/server.properties &

cd -

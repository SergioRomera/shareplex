cd /tmp/kafka*

#Consume topic
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic shareplex --from-beginning

cd -

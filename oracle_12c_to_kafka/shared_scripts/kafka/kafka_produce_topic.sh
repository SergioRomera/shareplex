cd /tmp/kafka*

#Produce topic
echo "test local machine"  | bin/kafka-console-producer.sh --broker-list localhost:9092 --topic shareplex

cd -

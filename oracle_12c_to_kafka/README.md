# Vagrant for Quest Shareplex

The Vagrant scripts here will allow you to build virtual machines in your computer with an Oracle Linux 7.5, an Oracle Database 12cR1 and **Shareplex 9.4** in node 1 and **Kafka 2.6.0** in node 2.

Features:

* Replication from Oracle 12c to Kafka 2.6.0

## Required Software

Download and install the following software.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* SharePlex licenses

## Clone Repository

Pick an area on your file system to act as the base for this git repository and issue the following command. If you are working on Windows remember to check your Git settings for line terminators. If the bash scripts are converted to Windows terminators you will have problems.

```
git clone https://github.com/SergioRomera/shareplex.git
```

Copy the software under the "quest" directory.

Or download the shareplex-master.zip file in a directory and unzip.


## Architecture

[Oracle to Kafka](https://arcentry.com/app/embed.html?id=04e162c7-2263-47a7-aa0c-42dfc0d139ac)

[![Oracle to Kafka](oracle-to-kafka.png)](https://arcentry.com/app/embed.html?id=04e162c7-2263-47a7-aa0c-42dfc0d139ac)

# Licenses
Shareplex and Foglight require licenses. This step is mandatory. Put your licenses in this files:

* Shareplex license

```
└───software
        shareplex_customer_name.txt
        shareplex_licence_key.txt
```

* Kafka license: Kafka is under [Apache License](https://www.apache.org/licenses/LICENSE-2.0.html) 

# Build the Shareplex System

The following commands will leave you with a functioning Shareplex installation.

Start the first node and wait for it to complete. This will create the primary database.

```
#Primary Oracle DB
cd node1
vagrant up
```

# Build Kafka System

The following commands will leave you with a functioning Kafka replicated installation.

Start the node 2 and wait for it to complete.

```
cd ../node2
vagrant up
```

# Turn Off System

Perform the following to turn off the system cleanly.


```
cd ../node2
vagrant halt

cd ../node1
vagrant halt
```

# Remove Whole System

The following commands will destroy all VMs and the associated files, so you can run the process again.

```
cd ../node2
vagrant destroy -f

cd ../node1
vagrant destroy -f
```

# Shareplex configuration

**Node 1**
```
Machine name: ol7-121-splex1
Machine port: 2201

OS User: oracle
OS password: oracle

Database name: pdb1
Oracle user: kafka
Oracle password: kafka

Database connection string: 

sqlplus kafka/kafka@pdb1

Shareplex commands:

gocop                    -> Start SharePlex
spc                      -> SharePlex console
  show                   -> Show process
  list config            -> List SharePlex config files
  show config            -> Show SharePlex config
```

**Node 2**
```
Machine name: ol7-kafka
Machine port: 2202

OS user: kafka
OS password: kafka

Kafka config:
Kafka port: 9092
Topic: shareplex

Shareplex commands:

gocop                    -> Start SharePlex
spc                      -> SharePlex console
  show                   -> Show process
  list config            -> List SharePlex config files
  show config            -> Show SharePlex config
```

```
Kafka commands:
Kafka is already installed and running with Zookeeper.
To start the test, run this command and insert data in table kafka.kafka_table in node 1.

cd /vagrant_scripts/kafka/
sh kafka_consume_topic.sh
```

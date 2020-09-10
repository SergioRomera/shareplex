. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

export MACHINE_HOSTNAME=$NODE2_HOSTNAME

sh /vagrant_scripts/configure_hostname.sh

sh /vagrant_scripts/install_os_packages.sh

echo ""
echo "******************************************************************************"
echo "Set root password and change ownership of /u01." `date`
echo "******************************************************************************"
echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | passwd

useradd kafka
echo -e "kafka\nkafka" | passwd kafka

chown -R kafka:kafka /u01
chmod -R 775 /u01

sh /vagrant_scripts/configure_hosts_base.sh

sh /vagrant_scripts/configure_chrony.sh


echo ""
echo "******************************************************************************"
echo "Change ip configuration" `date`
echo "******************************************************************************"
sudo sed -i 's/BOOTPROTO/#BOOTPROTO/g' /etc/sysconfig/network-scripts/ifcfg-eth0
cat >> /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
BOOTPROTO=static
IPADDR=10.0.2.16
NETMASK=255.255.255.0
EOF

echo ""
echo "******************************************************************************"
echo "Install Quest Shareplex." `date` 
echo "******************************************************************************"
su - kafka -c 'sh /vagrant_scripts/shareplex_install_kafka_config.sh'

echo ""
echo "******************************************************************************"
echo "Install Kafka." `date` 
echo "******************************************************************************"
su - kafka -c 'sh /vagrant_scripts/kafka/kafka_installation.sh'

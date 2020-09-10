. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

echo "******************************************************************************"
echo "Prepare yum repos and install base packages." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
cd /etc/yum.repos.d
yum install -y unzip mlocate tree telnet ksh 

#Foglight 5.9.5
yum install -y dejavu* fontconfig
fc-cache -f -v

sh /vagrant_scripts/configure_hosts_base.sh

sh /vagrant_scripts/configure_chrony.sh

ORACLE_HOSTNAME=${NODE4_HOSTNAME}
sh /vagrant_scripts/configure_hostname.sh

echo "******************************************************************************"
echo "Change ip configuration" `date`
echo "******************************************************************************"
sudo sed -i 's/BOOTPROTO/#BOOTPROTO/g' /etc/sysconfig/network-scripts/ifcfg-eth0
cat >> /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
BOOTPROTO=static
IPADDR=10.0.2.18
ot_boo  =255.255.255.0
EOF

echo "******************************************************************************"
echo "Foglight installation." `date`
echo "******************************************************************************"

useradd foglight

sudo su - foglight -c "sh /vagrant/scripts/foglight_setup.sh"

echo ""
echo "******************************************************************************"
echo "Foglight auto start" `date`
echo "******************************************************************************"
sh /vagrant/scripts/foglight_auto_start.sh

echo "******************************************************************************"
echo "Foglight Installation finished." `date`
echo "******************************************************************************"

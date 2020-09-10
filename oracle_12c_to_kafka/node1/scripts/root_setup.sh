. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

export MACHINE_HOSTNAME=$NODE1_HOSTNAME
sh /vagrant_scripts/configure_hostname.sh
sh /vagrant_scripts/configure_hosts_base.sh

sh /vagrant_scripts/install_os_packages.sh

echo ""
echo "******************************************************************************"
echo "Set root and oracle password and change ownership of /u01." `date`
echo "******************************************************************************"
echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | passwd
echo -e "${ORACLE_PASSWORD}\n${ORACLE_PASSWORD}" | passwd oracle
chown -R oracle:oinstall /u01
chmod -R 775 /u01


sh /vagrant_scripts/configure_chrony.sh

su - oracle -c 'sh /vagrant/scripts/oracle_user_environment_setup.sh'
. /home/oracle/scripts/setEnv.sh

su - oracle -c 'sh /vagrant_scripts/oracle_db_software_installation.sh'

echo ""
echo "******************************************************************************"
echo "Run DB root scripts." `date` 
echo "******************************************************************************"
sh ${ORA_INVENTORY}/orainstRoot.sh
sh ${ORACLE_HOME}/root.sh

su - oracle -c 'sh /vagrant/scripts/oracle_create_database.sh'

echo ""
echo "******************************************************************************"
echo "Install Quest Shareplex." `date` 
echo "******************************************************************************"
su - oracle -c 'sh /vagrant_scripts/shareplex_install.sh'

echo ""
echo "******************************************************************************"
echo "Quest Shareplex queue configuration." `date`
echo "******************************************************************************"
su - oracle -c '. /vagrant_config/install.env && cat > ${SHAREPLEX_VARDIR}/config/kafka.cfg <<EOF
Datasource:o.pdb1
kafka.kafka_table   !kafka                  ol7-kafka

EOF'

echo ""
echo "******************************************************************************"
echo "Create Kafka user and table." `date`
echo "******************************************************************************"
su - oracle -c 'sh /vagrant/scripts/kafka_database_config.sh'

echo "******************************************************************************"
echo "Quest Shareplex configuration." `date`
echo "******************************************************************************"
su - oracle -c 'cd ${SHAREPLEX_DIRINSTALL}/bin | echo -e "activate config kafka.cfg" | sp_ctrl'

echo ""
echo "******************************************************************************"
echo "Quest Shareplex show configuration." `date`
echo "******************************************************************************"
su - oracle -c 'cd ${SHAREPLEX_DIRINSTALL}/bin | echo -e "show\nstatus" | sp_ctrl'

echo ""
echo "******************************************************************************"
echo "Autostart DB scripts." `date` 
echo "******************************************************************************"
sh /vagrant_scripts/oracle_auto_startdb.sh

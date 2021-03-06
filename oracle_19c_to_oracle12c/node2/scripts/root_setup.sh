. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

sh /vagrant_scripts/install_os_packages.sh

echo "******************************************************************************"
echo "Set root and oracle password and change ownership of /u01." `date`
echo "******************************************************************************"
echo -e "${ROOT_PASSWORD}\n${ROOT_PASSWORD}" | passwd
echo -e "${ORACLE_PASSWORD}\n${ORACLE_PASSWORD}" | passwd oracle
chown -R oracle:oinstall /u01
chmod -R 775 /u01

sh /vagrant_scripts/configure_hosts_base.sh

sh /vagrant_scripts/configure_chrony.sh

su - oracle -c 'sh /vagrant/scripts/oracle_user_environment_setup.sh'
. /home/oracle/scripts/setEnv.sh

sh /vagrant_scripts/configure_hostname.sh

echo "******************************************************************************"
echo "Install Oracle." `date` 
echo "******************************************************************************"
#su - oracle -c 'sh /vagrant_scripts/oracle_db_software_installation.sh'
su oracle -c 'sh /vagrant_scripts/oracle_db_software_installation.sh'

echo "******************************************************************************"
echo "Run DB root scripts." `date` 
echo "******************************************************************************"
sh ${ORA_INVENTORY}/orainstRoot.sh
sh ${ORACLE_HOME}/root.sh

# Uncomment the following line if you want to apply patches.
# You must have downloaded the patches and amended the "oracle_software_patch.sh" script.
#su - oracle -c '/vagrant_scripts/oracle_software_patch.sh'

su - oracle -c 'sh /vagrant/scripts/oracle_create_database.sh'

echo ""
echo "******************************************************************************"
echo "Install Quest Shareplex." `date` 
echo "******************************************************************************"
su - oracle -c 'sh /vagrant_scripts/shareplex_install.sh'

echo ""
echo "******************************************************************************"
echo "Autostart DB scripts." `date` 
echo "******************************************************************************"
sh /vagrant_scripts/oracle_auto_startdb.sh

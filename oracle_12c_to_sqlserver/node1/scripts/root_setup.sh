. /vagrant_config/install.env

sh /vagrant_scripts/prepare_u01_disk.sh

sh /vagrant_scripts/install_os_packages.sh

echo ""
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
su - oracle -c '. /vagrant_config/install.env && cat > ${SHAREPLEX_VARDIR}/config/replication_oracle_sqlserver.cfg <<EOF
datasource:o.pdb1
#source tables      target tables            routing map
hr.countries        "dbo"."COUNTRIES"        ol7-mssql1@r.test
hr.departments      "dbo"."DEPARTMENTS"      ol7-mssql1@r.test
hr.employees        "dbo"."EMPLOYEES"        ol7-mssql1@r.test
hr.job_history      "dbo"."JOB_HISTORY"      ol7-mssql1@r.test
hr.jobs             "dbo"."JOBS"             ol7-mssql1@r.test
hr.locations        "dbo"."LOCATIONS"        ol7-mssql1@r.test
hr.regions          "dbo"."REGIONS"          ol7-mssql1@r.test
EOF'

echo ""
echo "******************************************************************************"
echo "Quest Shareplex show configuration." `date`
echo "******************************************************************************"
su - oracle -c 'cd ${SHAREPLEX_DIRINSTALL}/bin | echo -e "show\nstatus" | sp_ctrl'

echo ""
echo "******************************************************************************"
echo "Set the PDB to auto-start." `date`
echo "******************************************************************************"
sleep 5
su - oracle -c 'sh /vagrant_scripts/oracle_sample_databases.sh'

echo ""
echo "******************************************************************************"
echo "Autostart DB scripts." `date` 
echo "******************************************************************************"
sh /vagrant_scripts/oracle_auto_startdb.sh

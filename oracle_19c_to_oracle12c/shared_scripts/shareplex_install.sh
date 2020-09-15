. /vagrant_config/install.env

echo ""
echo "******************************************************************************"
echo "Create Quest Shareplex dedicated tablespace" `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF

alter session set container=pdb1;
--DROP TABLESPACE "QUEST_SHAREPLEX" INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
CREATE TABLESPACE "QUEST_SHAREPLEX" DATAFILE '/u01/oradata/CDB1/quest_shareplex.dbf' SIZE 104857600 REUSE;

-- TEST USER
create user test identified by test;
grant connect,resource to test;
alter user test quota unlimited on USERS;

EXIT;
EOF

echo ""
echo "******************************************************************************"
echo "Quest Shareplex database configuration." `date`
echo "******************************************************************************"
sqlplus / as sysdba <<EOF

--select LOG_MODE, name, SUPPLEMENTAL_LOG_DATA_MIN, SUPPLEMENTAL_LOG_DATA_PK, SUPPLEMENTAL_LOG_DATA_UI, SUPPLEMENTAL_LOG_DATA_FK, SUPPLEMENTAL_LOG_DATA_ALL from v$database;
ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY, UNIQUE, FOREIGN KEY) COLUMNS;

ALTER SYSTEM SWITCH LOGFILE;
--select LOG_MODE, name, SUPPLEMENTAL_LOG_DATA_MIN, SUPPLEMENTAL_LOG_DATA_PK, SUPPLEMENTAL_LOG_DATA_UI, SUPPLEMENTAL_LOG_DATA_FK, SUPPLEMENTAL_LOG_DATA_ALL from v$database;

create user c##sp_admin identified by sp_admin;
grant dba to c##sp_admin container=ALL;
grant select on sys.user$ to c##sp_admin with grant option container=ALL;
grant select on sys.enc$ to c##sp_admin with grant option container=ALL;

EXIT;
EOF

#mkdir -p /u01/app/quest
rm -fR ${SHAREPLEX_DIRINSTALL} ; rm -fR ${SHAREPLEX_VARDIR} ; rm -fR /home/oracle/.shareplex/
mkdir -p ${SHAREPLEX_DIRINSTALL} 
#; mkdir -p ${SHAREPLEX_VARDIR}/2100/

cat >> /home/oracle/.bash_profile <<EOF
. /vagrant_scripts/shareplex_functions.sh
EOF

echo ""
echo "******************************************************************************"
echo "Quest Shareplex installation." `date`
echo "******************************************************************************"
cd /vagrant_software
license_key=`cat /vagrant_software/shareplex_licence_key.txt`
customer_name=`cat /vagrant_software/shareplex_customer_name.txt`
echo -e "\n\n\n\n/home/oracle\n\nsplex\nsplex\n/u01/app/quest/shareplex9.4/\n/u01/app/quest/vardir/2100/\n\n\n\n\n\n${license_key}\n${customer_name}" | ./SharePlex-9.4.0-b59-rhel-amd64-m64.tpm

echo ""
echo "******************************************************************************"
echo "Binary Shareplex download" `date`
echo "******************************************************************************"
if [ -f $SHAREPLEX_SOFTWARE ]; then
  echo "Shareplex binary found"
else
  echo "Shareplex binary not found"
  echo "Download $SHAREPLEX_SOFTWARE in progress..."
  cd $SHAREPLEX_BINARIES_INSTALL
  wget -q $SHAREPLEX_BINARY_DOWNLOAD
fi

# SharePlex 9.4
echo -e "\n" | $SHAREPLEX_SOFTWARE -r /vagrant_software/shareplex/splex_non_root_install.rsp

echo ""
echo "******************************************************************************"
echo "Quest Shareplex configuration." `date`
echo "******************************************************************************"
cd ${SHAREPLEX_DIRINSTALL}/bin
#Shareplex 9.4
echo -e "n\n\n\npdb1\nc##sp_admin\nsp_admin\n\n\n\nQUEST_SHAREPLEX\n\nQUEST_SHAREPLEX\n\n" | ./ora_setup

mkdir -p ${SHAREPLEX_VARDIR}/2100/

echo ""
echo "******************************************************************************"
echo "Quest Shareplex start process." `date`
echo "******************************************************************************"
cd ${SHAREPLEX_DIRINSTALL}/bin
./sp_cop -u2100 &
sleep 5

echo ""
echo "******************************************************************************"
echo "Quest Shareplex show configuration." `date`
echo "******************************************************************************"
echo -e ""
echo -e "show\nstatus" | ${SHAREPLEX_DIRINSTALL}/bin/sp_ctrl

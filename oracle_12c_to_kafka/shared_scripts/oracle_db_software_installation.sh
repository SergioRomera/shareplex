. /vagrant_config/install.env

echo ""
echo "******************************************************************************"
echo "Unzip database software." `date`
echo "******************************************************************************"
mkdir /u01/software/
#cd /u01/software/

cd $ORACLE_BINARIES_INSTALL

echo "******************************************************************************"
echo "Oracle Binaries download" `date`
echo "******************************************************************************"
if [ -f $ORACLE_BINARIES_INSTALL/$ORACLE_SOFTWARE1 ]; then
  echo "Oracle binary 1 found"
else
  echo "Oracle binary 1 not found"
  echo "Download $ORACLE_SOFTWARE1 in progress..."
  wget -q $ORACLE_BINARY_DOWNLOAD1
  # wget --header="Host: vuqnjg.dm.files.1drv.com" \
       # --header="Referer: https://onedrive.live.com/" \
       # --header="Connection: keep-alive" "https://vuqnjg.dm.files.1drv.com/y4myoNAT374-maKv7JqQBSu3ymVs2nUi4Jkfhm_TDePKXChg8akObuA3w8IlPmu6p2g5-_gYWSsVRlU9M7Qdb4B_4UaUkt4LdlXysvBD3_aj1QqGjv-MxA5Tj0KTRk7X4I03DXAHm3nlyEZF6Exp9XTMu9RRJWMmOSw8wE0jbGDGyKWkpw4c1pj0uTNx44gtf0P/linuxamd64_12102_database_1of2.zip?download&psid=1" \
       # -O "linuxamd64_12102_database_1of2.zip" \
       # -c -q
fi

if [ -f $ORACLE_BINARIES_INSTALL/$ORACLE_SOFTWARE2 ]; then
  echo "Oracle binary 2 found"
else
  echo "Oracle binary 2 not found"
  echo "Download $ORACLE_SOFTWARE2 in progress..."
  wget -q $ORACLE_BINARY_DOWNLOAD2
  #wget --header="Host: vuqnjg.dm.files.1drv.com" \
  #     --header="Referer: https://onedrive.live.com/" \
  #     --header="Connection: keep-alive" "https://vuqnjg.dm.files.1drv.com/y4mqf2a0NYIM2JPLAg416g-HcG2q8K6UvCfW5w5GnEqSR1h2f-MyghZXAXnlyYo6IIRuNKvcGPM_E7Zz2TxAbFcaePlFylHh26BsaeP_t8aYeRLGQu3YV4HXJJxq5FMpJmw0QQCsSp44TOXjrBD9nSfPl_Tg9Ve5Ivl5UFrLmaLZV0ipCPcbDe76eJ3CApmnIuL/linuxamd64_12102_database_2of2.zip?download&psid=1" \
  #     -O "linuxamd64_12102_database_2of2.zip" \
  #     -c -q
fi

cd /u01/software/
echo "******************************************************************************"
echo "Unzip Oracle database software" `date`
echo "******************************************************************************"
unzip -oq "${ORACLE_BINARIES_INSTALL}/${ORACLE_SOFTWARE1}"
unzip -oq "${ORACLE_BINARIES_INSTALL}/${ORACLE_SOFTWARE2}"
cd database

echo ""
echo "******************************************************************************"
echo "Do database software-only installation." `date`
echo "******************************************************************************"
./runInstaller -ignorePrereq -waitforcompletion -silent \
        -responseFile /u01/software/database/response/db_install.rsp \
        oracle.install.option=INSTALL_DB_SWONLY \
        ORACLE_HOSTNAME=${ORACLE_HOSTNAME} \
        UNIX_GROUP_NAME=oinstall \
        INVENTORY_LOCATION=${ORA_INVENTORY} \
        SELECTED_LANGUAGES=${ORA_LANGUAGES} \
        ORACLE_HOME=${ORACLE_HOME} \
        ORACLE_BASE=${ORACLE_BASE} \
        oracle.install.db.InstallEdition=EE \
        oracle.install.db.DBA_GROUP=dba \
        oracle.install.db.BACKUPDBA_GROUP=dba \
        oracle.install.db.DGDBA_GROUP=dba \
        oracle.install.db.KMDBA_GROUP=dba \
        SECURITY_UPDATES_VIA_MYORACLESUPPORT=false \
        DECLINE_SECURITY_UPDATES=true

. /vagrant_config/install.env

#export ORACLE_EDITION=${NODE1_ORACLE_EDITION}
#export ORACLE_VERSION=${NODE1_ORACLE_VERSION}
echo "Oracle version    : ${ORACLE_VERSION}"
echo "Oracle edition    : ${ORACLE_EDITION}"
echo "Oracle binary path: $ORACLE_BINARIES_INSTALL"

# ******************
# *** Oracle 12c ***
# ******************
if [ "$ORACLE_VERSION" = "12" ]; then

    echo ""
    echo "******************************************************************************"
    echo "Oracle Binaries download" `date`
    echo "******************************************************************************"
    mkdir /u01/software/

    cd $ORACLE_BINARIES_INSTALL

    if [ -f $ORACLE_BINARIES_INSTALL/$ORACLE_SOFTWARE_12_1 ]; then
      echo "Oracle binary 1 found"
    else
      echo "Oracle binary 1 not found"
      echo "Download $ORACLE_SOFTWARE_12_1 in progress..."
      wget -q $ORACLE_BINARY_DOWNLOAD1
    fi

    if [ -f $ORACLE_BINARIES_INSTALL/$ORACLE_SOFTWARE_12_2 ]; then
      echo "Oracle binary 2 found"
    else
      echo "Oracle binary 2 not found"
      echo "Download $ORACLE_SOFTWARE_12_2 in progress..."
      wget -q $ORACLE_BINARY_DOWNLOAD2
    fi

    cd /u01/software/
    echo "******************************************************************************"
    echo "Unzip Oracle 12cdatabase software" `date`
    echo "******************************************************************************"
    unzip -oq "${ORACLE_BINARIES_INSTALL}/${ORACLE_SOFTWARE_12_1}"
    unzip -oq "${ORACLE_BINARIES_INSTALL}/${ORACLE_SOFTWARE_12_2}"
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
            oracle.install.db.InstallEdition=${ORACLE_EDITION} \
            oracle.install.db.DBA_GROUP=dba \
            oracle.install.db.BACKUPDBA_GROUP=dba \
            oracle.install.db.DGDBA_GROUP=dba \
            oracle.install.db.KMDBA_GROUP=dba \
            SECURITY_UPDATES_VIA_MYORACLESUPPORT=false \
            DECLINE_SECURITY_UPDATES=true
fi

# ******************
# *** Oracle 19c ***
# ******************
if [ "$ORACLE_VERSION" = "19" ]; then

    echo "******************************************************************************"
    echo "Unzip database software." `date`
    echo "******************************************************************************"
    cd ${ORACLE_HOME}
    unzip -oq /vagrant_software/${DB_SOFTWARE_19}

    echo "******************************************************************************"
    echo "Do database software-only installation." `date`
    echo "******************************************************************************"
    export CV_ASSUME_DISTID=OEL7.6

    ${ORACLE_HOME}/runInstaller -ignorePrereq -waitforcompletion -silent \
            -responseFile ${ORACLE_HOME}/install/response/db_install.rsp \
            oracle.install.option=INSTALL_DB_SWONLY \
            ORACLE_HOSTNAME=${ORACLE_HOSTNAME} \
            UNIX_GROUP_NAME=oinstall \
            INVENTORY_LOCATION=${ORA_INVENTORY} \
            SELECTED_LANGUAGES=${ORA_LANGUAGES} \
            ORACLE_HOME=${ORACLE_HOME} \
            ORACLE_BASE=${ORACLE_BASE} \
            oracle.install.db.InstallEdition=${ORACLE_EDITION} \
            oracle.install.db.OSDBA_GROUP=dba \
            oracle.install.db.OSBACKUPDBA_GROUP=dba \
            oracle.install.db.OSDGDBA_GROUP=dba \
            oracle.install.db.OSKMDBA_GROUP=dba \
            oracle.install.db.OSRACDBA_GROUP=dba \
            SECURITY_UPDATES_VIA_MYORACLESUPPORT=false \
            DECLINE_SECURITY_UPDATES=true
fi

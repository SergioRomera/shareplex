. /vagrant_config/install.env

#mkdir -p /u01/app/quest
rm -fR /u01/app/quest/shareplex9.2/ ; rm -fR /u01/app/quest/vardir/ 
mkdir -p /u01/app/quest/shareplex9.2/ ; mkdir -p /u01/app/quest/vardir/2100/

echo "******************************************************************************"
echo "Shareplex installation." `date`
echo "******************************************************************************"
#rm -Rf /u01/app/quest/vardir/2100/
cd /vagrant_software/shareplex
license_key=`cat /vagrant_software/shareplex_licence_key.txt`
customer_name=`cat /vagrant_software/shareplex_customer_name.txt`
. /vagrant_config/install.env
SP_SYS_HOST_NAME=${NODE5_HOSTNAME}

cat >/vagrant_software/shareplex/splex_sqlserver_install.rsp <<EOF
# Please modify the following settings for your particular system to
# install the SharePlex for Oracle on. Only values to the right of a
# colon may be editted. Incorrect changes on the left side may make
# the installer output questions and wait for answeres, thus becoming
# interactive instead of silent.
#
Create new SharePlex Admin user "splex": yes
the SharePlex Admin: splex
Create new SharePlex Admin group "splex": yes
home directory for the SharePlex admin user "splex": /home/splex
the SharePlex Admin group: spadmin
specify a password for new SharePlex Admin user "splex": no
Create new SharePlex Operator group "spopr": yes
Create new SharePlex View group "spview": yes
product directory location: ${SHAREPLEX_DIRINSTALL}
variable data directory location: ${SHAREPLEX_VARDIR}
TCP/IP port number for SharePlex communications: ${SHAREPLEX_PORT}

the License key: ${license_key}
the customer name associated with this license key: ${customer_name}

# Do not change settings bellow.
#
Proceed with installation: yes
Proceed with upgrade: no
OK to upgrade: no
valid SharePlex v. 9.2.0 license: yes
update the license: no
EOF

echo ""
echo "******************************************************************************"
echo "Binary Shareplex download" `date`
echo "******************************************************************************"
if [ -f $SHAREPLEX_OPENTARGET_SOFTWARE ]; then
  echo "Shareplex Open Target binary found"
else
  echo "Shareplex Open Target binary not found"
  echo "Download $SHAREPLEX_OPENTARGET_DOWNLOAD in progress..."
  cd $SHAREPLEX_BINARIES_INSTALL
  wget -q $SHAREPLEX_OPENTARGET_DOWNLOAD
fi

#root
#echo -e "\n\n\n\n/home\n\nsplex\nsplex\n/u01/app/quest/shareplex9.2/\n/u01/app/quest/vardir/2100/\n\n\n\n\n\n${licence_key}\n${customer_name}" | ./SPX-9.2.0-b42-oracle110-rh-40-amd64-m64.tpm
./SPX-9.2.0-b42-oracle110-rh-40-amd64-m64.tpm -r /vagrant_software/shareplex/splex_sqlserver_install.rsp

echo "******************************************************************************"
echo "ODBC configuration." `date`
echo "******************************************************************************"
cat >> /u01/app/quest/vardir/2100/odbc/odbc.ini <<EOF

[test]
Driver = /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.6.so.1.1
Server = localhost
Port = 1433
User =
Password =
Database = test
EOF

cat >> /etc/odbc.ini <<EOF

[test]
Driver = /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.6.so.1.1
Server = localhost
Port = 1433
User =
Password =
Database = test
EOF

echo "******************************************************************************"
echo "Quest Shareplex configuration." `date`
echo "******************************************************************************"
cd /u01/app/quest/shareplex9.2/bin
echo -e "test\nSA\nSQLServer01\ntest\n\nsplex\nsplex\nsplex\n\n" | ./mss_setup

chsh -s /bin/bash splex
echo -e "splex\nsplex\n" | passwd splex

cat >> /home/splex/.bash_profile <<EOF
. /vagrant_scripts/shareplex_functions.sh
alias s="/opt/mssql-tools/bin/sqlcmd -D -Stest -USA -P$MSSQL_SA_PASSWORD"
EOF

echo "******************************************************************************"
echo "Quest Shareplex start process." `date`
echo "******************************************************************************"
cd /u01/app/quest/shareplex9.2/bin
./sp_cop -u2100 &
sleep 5

echo "******************************************************************************"
echo "Quest Shareplex show configuration." `date`
echo "******************************************************************************"
echo -e ""
echo -e "show\nstatus" | /u01/app/quest/shareplex9.2/bin/sp_ctrl


echo -e "connection r.test set user=splex" | ./sp_ctrl
echo -e "connection r.test set password=splex" | ./sp_ctrl
echo -e "connection r.test set port=1433" | ./sp_ctrl
echo -e "connection r.test set server=localhost" | ./sp_ctrl
echo -e "connection r.test show" | ./sp_ctrl


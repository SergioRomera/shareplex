. /vagrant_config/install.env

#mkdir -p /u01/app/quest
rm -fR ${SHAREPLEX_DIRINSTALL} ; rm -fR ${SHAREPLEX_VARDIR}
mkdir -p ${SHAREPLEX_DIRINSTALL} 

echo "******************************************************************************"
echo "Shareplex installation." `date`
echo "******************************************************************************"
cd /vagrant_software/shareplex
license_key=`cat /vagrant_software/shareplex_licence_key.txt`
customer_name=`cat /vagrant_software/shareplex_customer_name.txt`
. /vagrant_config/install.env
SP_SYS_HOST_NAME=${KAFKA_HOSTNAME}

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

echo -e "/u01/app/quest/shareplex9.2/\n/u01/app/quest/vardir/2100/\n\n2100\n\n\n${license_key}\n${customer_name}" | ./SPX-9.2.0-b42-oracle110-rh-40-amd64-m64.tpm

echo "******************************************************************************"
echo "Quest Shareplex configuration." `date`
echo "******************************************************************************"
cat >> /home/kafka/.bash_profile <<EOF
. /vagrant_scripts/shareplex_functions.sh
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

echo "target x.kafka set kafka broker=localhost:9092"
echo "target x.kafka set kafka topic=shareplex"

echo -e ""
echo -e "target x.kafka show" | /u01/app/quest/shareplex9.2/bin/sp_ctrl

. /vagrant_config/install.env

echo "******************************************************************************"
echo "Set Hostname." `date`
echo "******************************************************************************"
hostname ${KAFKA_HOSTNAME}
cat > /etc/hostname <<EOF
${KAFKA_HOSTNAME}
EOF

. /vagrant_config/install.env

echo "******************************************************************************"
echo "Set Hostname." `date`
echo "******************************************************************************"
hostname ${MACHINE_HOSTNAME}
cat > /etc/hostname <<EOF
${MACHINE_HOSTNAME}
EOF

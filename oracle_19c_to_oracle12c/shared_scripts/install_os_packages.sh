echo "******************************************************************************"
echo "Prepare yum repos and install base packages." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

dnf install -y dnf-utils zip unzip mlocate

rpm -Uvh https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/r/rlwrap-0.43-5.el8.x86_64.rpm

dnf install -y oracle-database-preinstall-19c
#yum -y update

cat >> /home/vagrant/.bash_profile <<EOF
PS1="[\u@\h:\[\033[33;1m\]\w\[\033[m\] ] $ "
alias o='sudo su - oracle'
EOF

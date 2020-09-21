. /vagrant_config/install.env

echo "******************************************************************************"
echo "Create environment scripts." `date`
echo "******************************************************************************"
mkdir -p /home/oracle/scripts

cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=${NODE1_FQ_HOSTNAME}
export ORACLE_BASE=${ORACLE_BASE}
export ORA_INVENTORY=${ORA_INVENTORY}
export ORACLE_HOME=\$ORACLE_BASE/${ORACLE_HOME_EXT_NODE1}
export ORACLE_SID=${ORACLE_SID}
export DATA_DIR=${DATA_DIR}
export ORACLE_TERM=xterm
export BASE_PATH=/usr/sbin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$BASE_PATH
export ORACLE_EDITION=${NODE1_ORACLE_EDITION}
export ORACLE_VERSION=${NODE1_ORACLE_VERSION}

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
EOF

cat >> /home/oracle/.bash_profile <<EOF
. /home/oracle/scripts/setEnv.sh
PS1="[\u@\h:\[\033[33;1m\]\w\[\033[m\] ] $ "
alias sqlplus='rlwrap sqlplus'
alias s='sqlplus / as sysdba'
alias test='sqlplus test/test@pdb1'
EOF

echo "******************************************************************************"
echo "Create directories." `date`
echo "******************************************************************************"
. /home/oracle/scripts/setEnv.sh
mkdir -p ${ORACLE_HOME}
mkdir -p ${DATA_DIR}

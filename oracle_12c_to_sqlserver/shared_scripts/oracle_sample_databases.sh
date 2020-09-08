#!/bin/sh

# Documentation
# https://github.com/oracle/db-sample-schemas

wget https://github.com/oracle/db-sample-schemas/archive/master.zip
unzip master
cd db-sample-schemas-master/
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat

echo -e '@mksample manager manager hr oe pm ix sh bi users temp /tmp/ localhost:1521/pdb1' | sqlplus system/manager@pdb1 


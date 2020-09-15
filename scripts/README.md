# SharePlex scripts

This script allow you to check SharePlex configuration before to do a SharePlex installation.
It is mandatory to execute this file to check if all objects to replicate are compatible with SharePlex replication.

Execute this command:

```
[oracle@ol8-19-splex1:~ ] $ sqlplus system/manager@pdb1

SQL*Plus: Release 19.0.0.0.0 - Production on Tue Sep 15 15:58:54 2020
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> @/tmp/Cust_DBInfo_v94.sql

...
...
...
...

*********************************************************************
****    CDB1.lst has been generated.
****    Please send it to Quest Software
*********************************************************************
```

--#####################################################################################################################################
--
-- Script Name:        	Cust_DBInfo_v100.sql
-- Create Date:         	January 2001
-- Last Update:        		September 2020
-- Current Version:     	10.0.0
-- Author:              	Quest Software.
-- Copyright:			2001,2020 Quest Software Inc,
-- All rights reserved 
-- May not be copied or distributed without written permission from Quest Software
--
-- SCRIPT MAINTENCE:    THIS SCRIPT IS OWNED AND MAINTAINED BY SHAREPLEX NAM SE TEAM

-- Revision:                   10.0.0
-- When:                       2020/09/25
-- Who:			       Clay Jackson,
-- What:           1. Added Data Type Checks file target
--		   2. Release 10.0.0 of SharePlex

-- Revision:                   9.2.9
-- When:                       2020/08/26
-- Who:			       Clay Jackson,
-- What:           1. Added Data Type Checks for SQLServer Target

-- Revision:                   9.2.7
-- When:                       2020/05/05
-- Who:			       Clay Jackson, Mike Shurtz
-- What:           1. Changed version to correspond to latest version of SharePlex
-- 		        2.  NCHAR is fully supported
--					

-- Revision:                   9.4
-- When:                       2020/05/05
-- Who:			       Clay Jackson, Mike Shurtz
-- What:                     1. Changed version to correspond to latest version of SharePlex
--			     2. Added version prompt
--			     3. Deleted timing reports throughout
--		             4. Cleaned up headings
--			     5. Added test for database/table forcelogging 
--			     6. Added check for PDBs 
--                           7. Added check for materialized views
--                           8. Added CPU count
--                           9. Display exclusion list
--                           10.Clean up and add to exclusion list
--                           11.Changed report date to US format
--                           12.Moved database parameters to end of report
--			     13.Added copyright and no distribution statements

-- Revision:                   9.22
-- When:                       2020/04/24
-- Who:			       Mike Shurtz
-- What:                     1. Added check for flashback on or off
-- Revision:                   9.21
-- When:                       2019/03/27
-- Who:			       Clay Jackson
-- What:                     1. Deleted non-Oracle Targets
-- Revision:                   9.20
-- When:                       2018/11/14
-- Who:			       Clay Jackson
-- What:                     1. Added Supported Data Types in SharePlex 9.2 for SQLServer
--_Revision:                   9.1.3	
-- When:                       2018/03/05
-- Who:			       Clay Jackson
-- What:                     1. Added Supported Data Types in SharePlex 9.1.3 for SQLServer
--					   2. Changed version to confirm with SharePlex version
-- Revision:                   8.4	
-- When:                       2018/03/05
-- Who:			       Clay Jackson
-- What:                      	   1. Replaced references to Dell
-- Revision:                   8.3	
-- When:                       2017/08/23
-- Who:			       Clay Jackson
-- What:                      	   1. Fixed typo in comments around Nested Types
-- 
-- Revision:                   8.2	
-- When:                       2016/05/26
-- Who:			       tony.liu
-- What:                            1. Added section to report on datatypes not supported for replication to SAP/Postgres/Teradata/HANA
--					add "and a.OWNER=b.owner" to sql
--
-- Revision:                   8.1	
-- When:                       November 2014
-- Who:			       Clay Jackson
-- What:                            1. Added section to report on datatypes not supported for replication to SQLServer
--    
-- Revision:                   8.0
-- When:                       August 2013
-- Who:			       Rolando Manlagnit / Ron Koster
-- What:                            1. Re-Organized script and added comments to be more readable
--                                  2. Removed check for invalid hostname
--                                  3. Fixed query for checking if RAC database
--                                  4. Removed check for LMT (locally managed tablespace)
--
-- Revision:                   7.0
-- When:                       June 2011
-- Who:
-- What:                            1. Add check for TDE, Compression, Cluster table, Secured File LOB from Patrick Schwanke script
--                                  2. Add check of NO_LOGGING table and exclude TEMPORARY
--                                  3. Add user variable for excluded user to query
--                                  4. Exclude RMAN from output
--
-- Revision:                   6.1
-- When:                       December 2010
-- Who:                         
-- What:                            Get database name, Oracle Version, Archive_log mode, supplemental logging level from the database
--
-- Revision:                   6.0
-- When:                       November 2010
-- Who:                         
-- What:                            Exclude all system users (sys, system, sysman,tsmsys, dbsnmp, ctxsys,wmsys,dmsys,exfsys,ordsys,mdsys
--
-- Revision:                   5.0
-- When:                       August 2007
-- Who:                         
-- What:                            Changed column sizes in printout
--
-- Revision:                   4.2
-- When:                       July 2004
-- Who:                         
-- What:                            Added prompt for SID to appropriately name output file
--
-- Revision:                   4.1
-- When:                       June 2004
-- Who:                         
-- What:                            1. Replaced the 3 UDT queries with one simple query that pulls out information about UDTs with nested arrays.
--                                  2. Added a query for on delete cascades
--                                  3. Added a query to find tables with more than 254 columns
--
-- Revision:                   4.0
-- When:                       January 2004
-- Who:
-- What:                            1. Separated the queries for long and lob for efficiency.
--                                  2. DBA_LOBS is now queried to find info about lobs including chunk size and in row.
--                                  3. Added a compute sum to tablespace info so information does not have to be interpreted outside of the report.
--                                  4. Modified the statement level trigger query to display more detailed information than just a count.
--                                  5. Modified the redo log size query to display the value in megabytes for readability.
--                                  6. Added a PL/SQL block to Calculate average redo switches and volumes
--                                  7. Added a query to highlight and validate the log_parallelism parameter
--                                  8. Added a query to highlight and validate the recovery_parallelism parameter
--                                  9. Added float as a basic datatype. (float has been supported for years)
--                                  10. Added query for bitmap indexes.
--
-- Revision:                   3.2
-- When:                       December 2003
-- Who:
-- What:                            1. Modified partition sql to pull from dba_tab_partitions to list more partion info including chaining
--                                  2. Changed linesize to 300 to allow for easier to read formatting of the information.
--                                  3. Added 3 sql statements to find out information about user defined datatypes.  The third selects from 
--                                     dba_type_versions which is only available in Oracle 9i.   This sql will fail on 8i instances but it is 
--                                     in here to allow for keeping only one version of this script.
--
-- Revision:                   3.1
-- When:                       September 2003
-- Who:
-- What:                            1. Removed Total Space sum for datafiles.  Formula was giving inconsistent results
--
-- Revision:                   3.0
-- When:                       August 2003
-- Who:
-- What:                            1. Added new columns to chained row select
--                                  2. Added select for nonBasic datatypes.
--                                  3. Removed count of sequences per schema as it was a redundant select
--                                  4. Removed individual used and free tablespace selects
--                                  5. Added new tablespace select to combine total, used and unused in one select.  Improved performance.
--                                  6. Added -- timing for total script time.
--                                  7. Added -- timings for individual selects.
--                                  8. Removed individual datafiles/sizing select.  It's now included in the new tablespace select statement.
--                                  9. Added total size of datafiles statement.
--
--#####################################################################################################################################

set termout on
set verify off;
set linesize 300;
set pagesize 1000;
set trimspool on

define user_exclusion="('SYS', 'SYSTEM', 'XS$NULL', 'OJVMSYS', 'LBACSYS', 'OUTLN', 'SYS$UMF', 'DBSNMP', 'APPQOSSYS', 'DBSFWUSER', 'GGSYS', 'ANONYMOUS', 'CTXSYS', 'DVF', 'DVSYS', 'GSMADMIN_INTERNAL', 'MDSYS', 'OLAPSYS', 'XDB', 'WMSYS')"
define user_exclusion1= "('GSMCATUSER', 'MDDATA', 'REMOTE_SCHEDULER_AGENT', 'SYSBACKUP', 'GSMUSER', 'GSMROOTUSER', 'SYSRAC', 'SI_INFORMTN_SCHEMA', 'AUDSYS', 'DIP', 'ORDPLUGINS', 'ORDDATA', 'SYSKM', 'ORACLE_OCM', 'ORDSYS', 'SYSDG', 'SPLEX' )"
define user_exclusion2= "('EXFSYS','FLOWS_FILES','SYSMAN','OWB','OWBSYS','SCOTT','OWBSYS_AUDIT')"

define review_data_types="('ANYDATA','BLOB','CLOB','NCLOB','XMLTYPE', 'BINARY_FLOAT','BINARY_DOUBLE','LONG RAW','LONG','VARRAY')"
define oracle_ok_data_types = "('ANYDATA','NCLOB','SDO_GEOMETRY','UROWID','XMLTYPE','INTERVAL','BFILE','VARCHAR','VARCHAR2','DATE','NUMBER','NVARCHAR2','LOB','BLOB','CLOB','LONG','LONG RAW','CHAR','ROWID','RAW','FLOAT','NCLOB', 'NCHAR')"
define sqlserver_ok_data_types = "('ANYDATA','BLOB','CHAR','CLOB','DATE','LONG','LONG RAW','NCHAR','NCLOB','NUMBER','NVARCHAR','RAW','VARCHAR2')"
define file_ok_data_types = "('BLOB','CHAR','CLOB','DATE','LONG','LONG RAW','NCHAR','NCLOB','NUMBER','NVARCHAR','RAW','VARCHAR2','VARRAY')"



column chain_cnt format 999G999G999G999
column num_rows format 999G999G999G999
set heading off;

COLUMN defdbname NEW_VAL dbname
COLUMN defdbuser NEW_VAL dbuser
COLUMN deflogmode NEW_VAL log_mode
COLUMN defcreated NEW_VAL crdate
COLUMN defversion new_val version
COLUMN defbanner NEW_VAL banner
COLUMN defcompatible NEW_VAL compatible
COLUMN defstartuptime NEW_VAL inststartup
COLUMN defsysdate NEW_VAL sysdatum
COLUMN defhostname NEW_VAL host 
COLUMN defplatform NEW_VAL platform
COLUMN defcharset NEW_VAL charset
COLUMN defncharset NEW_VAL ncharset
COLUMN defrac NEW_VAL rac
COLUMN defprogver NEW_VAL progver
COLUMN defapexuser NEW_VAL apexuser

select '10.0.0' AS defprogver from dual;

SELECT name AS defdbname,
       TO_CHAR(created,'DD.MM.YYYY HH24:MI:SS') AS defcreated,
       log_mode AS deflogmode
FROM   v$database;

SELECT USER AS defdbuser 
FROM   dual;

SELECT version AS defversion,
       TO_CHAR(startup_time,'DD.MM.YYYY HH24:MI:SS') as defstartuptime
FROM   v$instance;

SELECT banner AS defbanner 
FROM   v$version 
WHERE  ROWNUM = 1;

SELECT value AS defcompatible
FROM   v$parameter
WHERE  name = 'compatible';

SELECT TO_CHAR(SYSDATE,'MM.DD.YYYY HH24:MI:SS') AS defsysdate 
FROM   dual;

SELECT host_name AS defhostname 
FROM   v$instance;

SELECT platform_name AS defplatform  
FROM   v$database;

SELECT value AS defcharset
FROM   nls_database_parameters
WHERE  parameter = 'NLS_CHARACTERSET';

SELECT value AS defncharset
FROM   nls_database_parameters
WHERE  parameter = 'NLS_NCHAR_CHARACTERSET';

SELECT DECODE(value,'TRUE','YES','NO') AS defrac
FROM   v$parameter
WHERE  name = 'cluster_database';

spool &dbname..lst

PROMPT *********************************************************************
PROMPT ****	Customer DB Info 			: &progver     
PROMPT **** 	Report Date                             : &sysdatum
PROMPT ****	Report for Database                     : &dbname
PROMPT ****	User                                    : &dbuser
PROMPT ****	Software Version                        : &version	
PROMPT ****	Effective Version (compatible parameter): &compatible	
PROMPT ****	Banner                                  : &banner	
PROMPT ****	Platform name                           : &platform	
PROMPT ****	Server name                             : &host		
PROMPT ****	Database logging mode                   : &log_mode 
PROMPT ****	Database creation date                  : &crdate	
PROMPT ****	Instance startup time                   : &inststartup	
PROMPT ****	Database characterset                   : &charset	
PROMPT ****	Database national characterset          : &ncharset
PROMPT ****	RAC 	      		                    : &rac	
PROMPT ****     COPYRIGHT 2001,2020 Quest Software Inc
PROMPT ****     MAY NOT BE COPIED OR DISTRIBUTED WITHOUT WRITTEN
PROMPT ****     PERMISSION FROM QUEST SOFTWARE
PROMPT *********************************************************************
PROMPT
PROMPT *********************************************************************
PROMPT ***      PURPOSE - Ths script scans databases being replicated by
PROMPT ***	SharePlex and reports on data types, redo log usage and other
PROMPT ***      database attributes to assist Quest and the customer in 
PROMPT ***      configuring SharePlex
PROMPT ***
PROMPT ***      NOTE - Version 9.4 of SharePlex supports Oracle        
PROMPT ***      version 11.2.0.4 and later ONLY.  For earlier versions  
PROMPT ***      of Oracle, please contact your Account Manager BEFORE 
PROMPT ***      proceeding.                                             
PROMPT *********************************************************************
PROMPT ***
PROMPT ***      The script does not examine the following Oracle and
PROMPT ***      SharePlex owned schemas, as they are typically not
PROMPT ***      candidates for replication.   Pleae contact your Account Manager
PROMPT ***      BEFORE attempting to replicate any tables except the 
PROMPT ***      SPLEX.DEMO tables, in these schemas.
PROMPT *** 
PROMPT ***  : &user_exclusion
PROMPT ***  : &user_exclusion1
PROMPT ***  : &user_exclusion2
PROMPT ***
PROMPT **********************************************************************

set heading off;
set feedback off;

PROMPT 
PROMPT *********************************************************************
PROMPT ****     Check for APEX schema
PROMPT ****     APEX schema typically contains data types that are not
PROMPT ****     Supported by SharePlex - please contact Account Manager BEFORE
PROMPT ****     attempting to replicate objects in this schema
PROMPT *********************************************************************
set serveroutput on 
DECLARE 
	apexusers integer;
BEGIN
	select count(*) into apexusers from dba_users 
	    where username like 'APEX%';
        IF apexusers > 0 THEN
            dbms_output.put_line ('APEX Schema is present');
	ELSE
            dbms_output.put_line ('APEX Schema is NOT present');
	END IF;
END;
/
set serveroutput off
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT **** 	Check for supplemental logging                     	
PROMPT **** 	MUST be at least MIN level                              
PROMPT **** 	PK/UI STRONGLY recommended to provide best performance  
PROMPT *********************************************************************
SET heading off;
SET feedback off;

SET SERVEROUTPUT ON
DECLARE
  suplog_min_avail NUMBER;
  suplog_pk_avail NUMBER;
  suplog_ui_avail NUMBER;
  suplog_fk_avail NUMBER;
  suplog_all_avail NUMBER;
  suplog_pl_avail NUMBER;
  suplog_min VARCHAR2(20);
  suplog_pk VARCHAR2(20);
  suplog_ui VARCHAR2(20);
  suplog_fk VARCHAR2(20);
  suplog_all VARCHAR2(20);
  suplog_pl VARCHAR2(20);
BEGIN
  SELECT SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_MIN',1,0)),
         SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_PK',1,0)),
         SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_UI',1,0)),
         SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_FK',1,0)),
         SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_ALL',1,0)),
         SUM(DECODE(column_name,'SUPPLEMENTAL_LOG_DATA_PL',1,0))
  INTO suplog_min_avail,suplog_pk_avail,suplog_ui_avail,suplog_fk_avail,suplog_all_avail,suplog_pl_avail
  FROM dba_tab_columns
  WHERE owner = 'SYS' 
  AND table_name = 'V_$DATABASE';
  
  IF suplog_min_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_min FROM v$database' INTO suplog_min;
  ELSE
    suplog_min := 'N.A.';
  END IF;
  
  IF suplog_pk_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_pk FROM v$database' INTO suplog_pk ;
  ELSE
    suplog_pk := 'N.A.';
  END IF;
  
  IF suplog_ui_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_ui FROM v$database' INTO suplog_ui ;
  ELSE
    suplog_ui := 'N.A.';
  END IF;
  
  IF suplog_fk_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_fk FROM v$database' INTO suplog_fk ;
  ELSE
    suplog_fk := 'N.A.';
  END IF;
  
  IF suplog_all_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_all FROM v$database' INTO suplog_all ;
  ELSE
    suplog_all := 'N.A.';
  END IF;
  
  IF suplog_pl_avail = 1 THEN
    EXECUTE IMMEDIATE 'SELECT supplemental_log_data_pl FROM v$database' INTO suplog_pl ;
  ELSE
    suplog_pl := 'N.A.';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('MIN       PK        UI        FK        ALL       PL');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE(RPAD(suplog_min,10) || RPAD(suplog_pk,10) || RPAD(suplog_ui,10) || RPAD(suplog_fk,10) || RPAD(suplog_all,10) || RPAD(suplog_pl,10));
END;
/

PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT **** 	Check for Flashback Database ON or OFF               	
PROMPT ****     Flashback NOT supported on source database
PROMPT ****								
PROMPT **** 	FLASHBACK ON on target will impact performance         
PROMPT **** 							  	
PROMPT *********************************************************************
set heading off 
set feedback off
select 'Flashback Enabled -> ' || flashback_on from v$database;

PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT **** 	Check for PDB databases               	
PROMPT **** 							  	
PROMPT *********************************************************************
set serveroutput on
set heading off
set feedback off
declare
 vid	varchar2(15);
begin
 select substr(version, 1, 4) INTO vid from v$instance;
  if vid = '11.2' then 
  dbms_output.put_line ('this version is 11g, there should be no PDBs and next line will show an error');
 else
  dbms_output.put_line ('Status of the PDB where this program was executed. If more than one is listed check if script was run in the container' );
  dbms_output.put_line ('If this was run in the container, please ALSO run this script in each pluggable database that will be a replication source' );
end if;
end;
/
set heading on
set lines 300
col name format a20
select con_id, name, open_mode from v$pdbs;

set heading off;
prompt
prompt
prompt *********************************************************************
prompt ****	PARALLELISM Settings                			
prompt ****	SharePlex does not support PARALLELISM           		
prompt *********************************************************************
select decode(value,1,'LOG PARALLELISM NOT SET','LOG PARALLELISM IS NOT 1') from v$parameter where name = 'log_parallelism';
select decode(value,0,'RECOVERY PARALLELISM NOT SET','RECOVERY PARALLELISM IS NOT 0') from v$parameter where name = 'recovery_parallelism';


prompt
prompt
PROMPT *********************************************************************
PROMPT ****	NOLOGGING Check - Tables being replicated MUST be logged
PROMPT ****     CAUTION - if database or tablespace level logging is set
PROMPT ****     and subsequently turned off, be sure to check tables with
PROMPT ****     NOLOGGING
PROMPT *********************************************************************
column force_logging format A15
set heading off;
set feedback off;

PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT *** Database level force logging
PROMPT *********************************************************************
select 'Database level force logging = ', force_logging from v$database;

PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT *** Tablespace level force logging
PROMPT *********************************************************************
set heading on;
column tablespace_name format a50
select tablespace_name, force_logging from dba_tablespaces;

PROMPT
PROMPT
PROMPT ********************************************************************
PROMPT **** 	Tables with NOLOGGING attribute set                 	
PROMPT ****	These may be ignored if force logging is set                  
PROMPT ****	at either tablespace or database level              	
PROMPT ****	or if tables are not replicated                         
PROMPT *********************************************************************

COLUMN table_name FORMAT A30
set feedback on;
SELECT owner, table_name, NULL AS partition_name, NULL AS subpartition_name 
FROM   dba_tables 
WHERE  logging = 'NO' AND temporary = 'N'
AND    owner NOT IN &user_exclusion
AND    owner NOT IN &user_exclusion
AND    owner NOT IN &user_exclusion1
AND    owner NOT LIKE 'APEX%'
UNION
SELECT table_owner AS owner, table_name, partition_name, NULL AS subpartition_name 
FROM   dba_tab_partitions
WHERE  logging = 'NO'
AND    table_owner NOT IN &user_exclusion
AND    table_owner NOT IN &user_exclusion1
AND    table_owner NOT IN &user_exclusion2
AND    table_owner NOT LIKE 'APEX%'
UNION
SELECT table_owner AS owner, table_name, partition_name, subpartition_name 
FROM   dba_tab_subpartitions
WHERE  logging = 'NO'
AND    table_owner NOT LIKE 'APEX%'
AND    table_owner NOT IN &user_exclusion
AND    table_owner NOT IN &user_exclusion1
AND    table_owner NOT IN &user_exclusion2;

set feedback off;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	List of Objects by Schema Owner        			
prompt ****     Primarily for informational purposes   			
prompt *********************************************************************
set heading on;
col username for a30
col Tabs  format 999999
col Indx  format 999999
col Syns  format 999999
col Views format 999999
col Seqs  format 999999
col Procs format 999999
col Funcs format 999999
col Pkgs  format 999999
col Trigs format 999999
col Deps  format 999999


compute sum of "Tabs"  on report
compute sum of "Indx" on report
compute sum of "Syns" on report
compute sum of "Views" on report
compute sum of "Seqs" on report
compute sum of "Procs" on report
compute sum of "Funcs" on report
compute sum of "Pkgs" on report
compute sum of "Trigs" on report
compute sum of "Deps" on report
break on report
select   USERNAME,
         count(decode(o.TYPE#, 2,o.OBJ#,'')) as "Tabs",
         count(decode(o.TYPE#, 1,o.OBJ#,'')) as "Indx",
         count(decode(o.TYPE#, 5,o.OBJ#,'')) as "Syns",
         count(decode(o.TYPE#, 4,o.OBJ#,'')) as "Views",
         count(decode(o.TYPE#, 6,o.OBJ#,'')) as "Seqs",
         count(decode(o.TYPE#, 7,o.OBJ#,'')) as "Procs",
         count(decode(o.TYPE#, 8,o.OBJ#,'')) as "Funcs",
         count(decode(o.TYPE#, 9,o.OBJ#,'')) as "Pkgs",
         count(decode(o.TYPE#,12,o.OBJ#,'')) as "Trigs",
         count(decode(o.TYPE#,10,o.OBJ#,'')) as "Deps"
from     sys.obj$ o, dba_users u
where    u.USER_ID = o.OWNER# (+)
and      o.TYPE# is NOT NULL
and      u.username not in &user_exclusion
AND      u.username NOT IN &user_exclusion1
AND      u.username NOT IN &user_exclusion2
AND      u.username NOT LIKE 'APEX%'
group by USERNAME
order by USERNAME;
clear breaks;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	Tablespace Info                 			
prompt ****	mostly informational                         		
prompt *********************************************************************

set heading on;
break on report
compute sum of "total MB" on report
col "total MB" format 999G999G990
compute sum of "Free MB" on report
col "Free MB" format 999G999G990
compute sum of "Used MB" on report
col "Used MB" format 999G999G990
column tablespace_name format a30
column "Datafile name" format a50
select
 d.tablespace_name, 
 SUBSTR(d.file_name,1,50) "Datafile name",
 ROUND(MAX(d.bytes)/1024/1024,2) as "total MB", 
 DECODE(SUM(f.bytes), null, 0, ROUND(SUM(f.Bytes)/1024/1024,2)) as "Free MB" , 
 DECODE( SUM(f.Bytes), null, 0, ROUND((MAX(d.bytes)/1024/1024) - (SUM(f.bytes)/1024/1024),2)) as "Used MB" 
from 
  DBA_FREE_SPACE f , DBA_DATA_FILES d 
where 
 f.tablespace_name = d.tablespace_name 
 and f.file_id = d.file_id 
group by 
d.tablespace_name,d.file_name;

clear breaks

PROMPT
PROMPT
prompt *********************************************************************
prompt **** 	Database size Info              			
prompt *********************************************************************


col "Database Size" format a20
col "Free space" format a20
col "Used space" format a20
select round(sum(used.bytes) / 1024 / 1024) || ' MB' "Database Size"
, round(sum(used.bytes) / 1024 / 1024 ) - 
round(free.p / 1024 / 1024) || ' MB' "Used space"
, round(free.p / 1024 / 1024) || ' MB' "Free space"
from (select bytes
from v$datafile
union all
select bytes
from v$tempfile
union all
select bytes
from v$log) used
, (select sum(bytes) as p
from dba_free_space) free
group by free.p;


set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt **** 	Redo Log Files and Sizing          			
prompt *********************************************************************

set heading on;
col "File Name" for a80;
col "Size in MB" format 999G999G999G999G990
select substr(a.member,1,80) as "File Name",b.bytes/1024/1024 as "Size in MB" 
from v$logfile a,v$log b where a.group#=b.group#;

set heading off;
prompt
prompt
prompt *********************************************************************
prompt ****     Redolog Switch Rate by Date and Hour     		
prompt *********************************************************************

set heading on;
column day format a3
col Total for 99G990;
col h00 for 999;
col h01 for 999;
col h02 for 999;
col h03 for 999;
col h04 for 999;
col h05 for 999;
col h06 for 999;
col h07 for 999;
col h08 for 999;
col h09 for 999;
col h10 for 999;
col h11 for 999;
col h12 for 999;
col h13 for 999;
col h14 for 999;
col h15 for 999;
col h16 for 999;
col h17 for 999;
col h18 for 999;
col h19 for 999;
col h20 for 999;
col h21 for 999;
col h22 for 999;
col h23 for 999;
col h24 for 999;


break on report
compute max of "Total" on report
compute max of "h00" on report
compute max of "h01" on report
compute max of "h02" on report
compute max of "h03" on report
compute max of "h04" on report
compute max of "h05" on report
compute max of "h06" on report
compute max of "h07" on report
compute max of "h08" on report
compute max of "h09" on report
compute max of "h10" on report
compute max of "h11" on report
compute max of "h12" on report
compute max of "h13" on report
compute max of "h14" on report
compute max of "h15" on report
compute max of "h16" on report
compute max of "h17" on report
compute max of "h18" on report
compute max of "h19" on report
compute max of "h20" on report
compute max of "h21" on report
compute max of "h22" on report
compute max of "h23" on report

SELECT  trunc(first_time) "Date",
        to_char(first_time, 'Dy') "Day",
        count(1) as "Total",
        SUM(decode(to_char(first_time, 'hh24'),'00',1,0)) as "h00",
        SUM(decode(to_char(first_time, 'hh24'),'01',1,0)) as "h01",
        SUM(decode(to_char(first_time, 'hh24'),'02',1,0)) as "h02",
        SUM(decode(to_char(first_time, 'hh24'),'03',1,0)) as "h03",
        SUM(decode(to_char(first_time, 'hh24'),'04',1,0)) as "h04",
        SUM(decode(to_char(first_time, 'hh24'),'05',1,0)) as "h05",
        SUM(decode(to_char(first_time, 'hh24'),'06',1,0)) as "h06",
        SUM(decode(to_char(first_time, 'hh24'),'07',1,0)) as "h07",
        SUM(decode(to_char(first_time, 'hh24'),'08',1,0)) as "h08",
        SUM(decode(to_char(first_time, 'hh24'),'09',1,0)) as "h09",
        SUM(decode(to_char(first_time, 'hh24'),'10',1,0)) as "h10",
        SUM(decode(to_char(first_time, 'hh24'),'11',1,0)) as "h11",
        SUM(decode(to_char(first_time, 'hh24'),'12',1,0)) as "h12",
        SUM(decode(to_char(first_time, 'hh24'),'13',1,0)) as "h13",
        SUM(decode(to_char(first_time, 'hh24'),'14',1,0)) as "h14",
        SUM(decode(to_char(first_time, 'hh24'),'15',1,0)) as "h15",
        SUM(decode(to_char(first_time, 'hh24'),'16',1,0)) as "h16",
        SUM(decode(to_char(first_time, 'hh24'),'17',1,0)) as "h17",
        SUM(decode(to_char(first_time, 'hh24'),'18',1,0)) as "h18",
        SUM(decode(to_char(first_time, 'hh24'),'19',1,0)) as "h19",
        SUM(decode(to_char(first_time, 'hh24'),'20',1,0)) as "h20",
        SUM(decode(to_char(first_time, 'hh24'),'21',1,0)) as "h21",
        SUM(decode(to_char(first_time, 'hh24'),'22',1,0)) as "h22",
        SUM(decode(to_char(first_time, 'hh24'),'23',1,0)) as "h23"
FROM    V$log_history
group by trunc(first_time), to_char(first_time, 'Dy')
Order by 1;

clear breaks

set heading off;
prompt
prompt
prompt *********************************************************************
prompt ****  	Redolog Daily and Hourly volume calculated  		
prompt *********************************************************************


--##########################################################################
--##  PL/SQL used here to gather and display average redo volumes         ##
--##########################################################################

set serveroutput on;
set feedback off
declare

v_log    number;
v_days   number;
v_logsz  number;
v_adsw   number;
V_advol  number;
v_ahsw   number;
v_ahvol  number;


begin

select count(first_time) into v_log from v$log_history;
select count(distinct(to_char(first_time,'dd-mon-rrrr'))) into v_days from v$log_history;
select max(bytes)/1024/1024 into v_logsz from v$log;

v_adsw := round(v_log / v_days);
v_advol := round(v_adsw * v_logsz);
v_ahsw := round(v_adsw / 24);
v_ahvol := round((v_adsw / 24 )) * v_logsz;

dbms_output.put_line(' ');
dbms_output.put ('Total Switches' || ' '||v_log||'  ==>  ');
dbms_output.put ('Total Days' || ' '|| v_days||'  ==>  ');
dbms_output.put_line ('Redo Size' || ' ' || v_logsz);
dbms_output.put ('Avg Daily Switches' || ' ' || v_adsw||'  ==>  ');
dbms_output.put_line ('Avg Daily Volume in Meg' || ' ' || v_advol);
dbms_output.put ('Avg Hourly Switches' || ' ' || v_ahsw||'  ==>  ');
dbms_output.put_line ('Avg Hourly Volume in Meg' || ' ' || v_ahvol);
dbms_output.put_line(' ');


end;

/

set heading off;

PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT ****  The above is to help you compute the amount of disk space	
PROMPT ****  needed for the SharePlex queues. Use the below formula.   
PROMPT ****                                                             
PROMPT ****  [size of a redo log] x [# of log switches in 1 hour]       
PROMPT ****  x 1/3  x [number of hours downtime]                        
PROMPT ****  = amount of disk space needed for the queues on each system
PROMPT ****                                                             
PROMPT ****  For example,                                               
PROMPT ****  if you expect to recover from 8 hours of downtime,         
PROMPT ****  and your redo logs are 500 MB in size                      
PROMPT ****  and switch five times an hour,                             
PROMPT ****  then you could need 6.5 GB of                              
PROMPT ****  space on both the source and target machines               
PROMPT ****  for the SharePlex queues.                                  
PROMPT ****  [500 MB redo log] x [5 switches/hour] x [1/3] x [8 hours]  
PROMPT ****  = 6.5 GB disk space                                        
PROMPT *********************************************************************
PROMPT
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT ****	CLUSTERED TABLES                                    	
PROMPT **** 	NOT SUPPORTED                                       	
PROMPT *********************************************************************
column cluster_name format a30
set heading on;
set feedback on;
SELECT owner, cluster_name
FROM   dba_clusters
WHERE  owner NOT IN &user_exclusion
AND  owner NOT IN &user_exclusion1
AND  owner NOT IN &user_exclusion2
AND  owner NOT LIKE 'APEX%'
ORDER BY owner, cluster_name;

set heading off;
PROMPT
PROMPT
PROMPT *********************************************************************	
PROMPT **** 	Tablespaces with Transparent Data Encryption        	
PROMPT ****	Note - replication of tables using TDE requires configuration 
PROMPT ***      in ora_setup and access to the Oracle Wallet
PROMPT *********************************************************************
set heading on;

SELECT t.name
FROM   v$encrypted_tablespaces e, sys.ts$ t
WHERE  e.ts# = t.ts# 
AND    e.encryptedts = 'YES';

set heading off;
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT ****	Compressed tables, partitions or subpartitions      
PROMPT ****     If Yes, then compression is supported 
PROMPT *********************************************************************
set heading on;
SELECT owner, table_name,compression,compress_for, NULL AS partition_name, NULL AS subpartition_name, 
  CASE WHEN compress_for IN ('BASIC','DIRECT LOAD ONLY') THEN 'Yes'
       WHEN compress_for IN ('FOR ALL OPERATIONS') THEN 'Yes'
       WHEN compress_for IN ('OLTP') THEN '11gR2, 12cR1 ONLY'
       WHEN compress_for IN ('QUERY LOW','QUERY HIGH','ARCHIVE LOW','ARCHIVE HIGH') THEN 'See Release Notes'
       ELSE 'Please doublecheck! (Unknown compression type: ' || compress_for || ')'
  END AS "Supported?"
FROM dba_tables
WHERE compression = 'ENABLED' 
AND   owner NOT IN &user_exclusion
AND   owner NOT IN &user_exclusion1
AND   owner NOT IN &user_exclusion2
AND   owner NOT LIKE 'APEX%'
UNION
SELECT table_owner AS owner, table_name,compression,compress_for, partition_name, NULL AS subpartition_name, 
  CASE WHEN compress_for IN ('BASIC','DIRECT LOAD ONLY') THEN 'Yes'
       WHEN compress_for IN ('FOR ALL OPERATIONS') THEN 'Yes'
       WHEN compress_for IN ('OLTP') THEN '11gR2, 12cR1 ONLY'
       WHEN compress_for IN ('QUERY LOW','QUERY HIGH','ARCHIVE LOW','ARCHIVE HIGH') THEN 'See Release Notes'
       ELSE 'Please doublecheck! (Unknown compression type: ' || compress_for || ')'
  END AS "Supported?"
FROM dba_tab_partitions
WHERE compression = 'ENABLED' 
AND   table_owner NOT IN &user_exclusion
AND   table_owner NOT IN &user_exclusion1
AND   table_owner NOT IN &user_exclusion2
AND   table_owner NOT LIKE 'APEX%'
UNION
SELECT table_owner AS owner, table_name,compression,compress_for, partition_name, subpartition_name, 
  CASE WHEN compress_for IN ('BASIC','DIRECT LOAD ONLY') THEN 'Yes'
       WHEN compress_for IN ('FOR ALL OPERATIONS') THEN 'Yes'
       WHEN compress_for IN ('OLTP') THEN '11gR2, 12cR1 ONLY'
       WHEN compress_for IN ('QUERY LOW','QUERY HIGH','ARCHIVE LOW','ARCHIVE HIGH') THEN 'See Release Notes'
       ELSE 'Please doublecheck! (Unknown compression type: ' || compress_for || ')'
  END AS "Supported?"
FROM dba_tab_subpartitions
WHERE compression = 'ENABLED' 
AND   table_owner NOT IN &user_exclusion
AND   table_owner NOT IN &user_exclusion1
AND   table_owner NOT IN &user_exclusion2
AND   table_owner NOT LIKE 'APEX%'
ORDER BY owner, table_name, partition_name, subpartition_name;

set heading off;
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT **** 	Columns with Transparent Data Encryption		
PROMPT ****	Supported for some datatypes  	
PROMPT ****	Not supported for Shareplex key columns!          	
PROMPT ****	Column on target database has to be nullable!     	
PROMPT *********************************************************************
set heading on;
COLUMN owner FORMAT A20
COLUMN table_name FORMAT A30
COLUMN column_name FORMAT A20
COLUMN "Datatype supported?" FORMAT A30
COLUMN "Part ok Shareplex Key?" FORMAT A40
COLUMN nullable FORMAT A8
SELECT tc.owner, tc.table_name, tc.column_name, 
  CASE WHEN tc.data_type IN ('CHAR', 'NCHAR', 'VARCHAR2', 'NVARCHAR2', 'NUMBER', 'DATE', 'RAW') THEN 'Yes with SP7.6+ (' 
       ELSE 'No (' 
  END || data_type || ')' AS "Datatype supported?",
  CASE WHEN c.constraint_name IS NULL THEN 'No PK (check for Shareplex key!)' 
       WHEN c.constraint_name IS NOT NULL AND cc.column_name IS NULL THEN 'Yes' 
	   ELSE 'No (different Shareplex key?)' 
  END AS "Outside of Primary Key?" , 
  tc.nullable   
FROM   dba_encrypted_columns ec 
       INNER JOIN dba_tab_cols tc ON (tc.owner = ec.owner AND tc.table_name = ec.table_name AND tc.column_name = ec.column_name)  
       LEFT OUTER JOIN dba_constraints c ON (tc.owner = c.owner AND tc.table_name = c.table_name AND c.constraint_type = 'P') 
       LEFT OUTER JOIN dba_cons_columns cc ON (c.owner = cc.owner AND c.constraint_name = cc.constraint_name AND tc.column_name = cc.column_name)
WHERE  ec.owner NOT IN &user_exclusion
AND ec.owner NOT IN &user_exclusion1
AND ec.owner NOT IN &user_exclusion2
AND ec.owner NOT LIKE 'APEX%'
ORDER BY SUBSTR("Datatype supported?",1,1) ASC,
         SUBSTR("Outside of Primary Key?",1,1) ASC, 
		 nullable ASC, 
		 owner, table_name, column_name;


set heading off;		 
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT **** 	SecureFile LOBs					
PROMPT ****	SecureFile LOBs with LOGGING and 
PROMPT ****	without encryption, compression and dedup are supported
PROMPT *********************************************************************

COLUMN owner FORMAT A20
COLUMN table_name FORMAT A30
COLUMN column_name FORMAT A20
COLUMN partition_name FORMAT A20
COLUMN subpartition_name FORMAT A20
SELECT owner, table_name, column_name, partition_name, subpartition_name, 'SUPPORTED'  
FROM ( 
  SELECT owner, table_name, column_name, NULL AS partition_name, NULL AS subpartition_name
  FROM   dba_lobs 
  WHERE  securefile='YES'
  AND    owner NOT IN &user_exclusion
  AND    owner NOT IN &user_exclusion1
  AND    owner NOT IN &user_exclusion2
  AND    owner NOT LIKE 'APEX%'
  AND encrypt IN ('NO','NONE') AND compression IN ('NO','NONE') AND deduplication IN ('NO','NONE')
  AND logging = 'YES'
  UNION
  SELECT table_owner, table_name, column_name, partition_name, NULL AS subpartition_name
  FROM   dba_lob_partitions
  WHERE  securefile='YES'
  AND    table_owner NOT IN &user_exclusion
  AND    table_owner NOT IN &user_exclusion1
  AND    table_owner NOT IN &user_exclusion2
  AND    table_owner NOT LIKE 'APEX%'
  AND encrypt IN ('NO','NONE') AND compression IN ('NO','NONE') AND deduplication IN ('NO','NONE')
  AND logging = 'YES'
  UNION
  SELECT table_owner, table_name, column_name, lob_partition_name AS partition_name, subpartition_name
  FROM   dba_lob_subpartitions
  WHERE  securefile='YES'
  AND    table_owner NOT IN &user_exclusion
  AND    table_owner NOT IN &user_exclusion1
  AND    table_owner NOT IN &user_exclusion2
  AND    table_owner NOT LIKE 'APEX%'
  AND encrypt IN ('NO','NONE') AND compression IN ('NO','NONE') AND deduplication IN ('NO','NONE')
  AND logging = 'YES')
UNION
SELECT owner, table_name, column_name, partition_name, subpartition_name, 'NOT SUPPORTED'  
FROM ( 
  SELECT owner, table_name, column_name, NULL AS partition_name, NULL AS subpartition_name
  FROM   dba_lobs 
  WHERE  securefile='YES'
  AND    owner NOT IN &user_exclusion
  AND    owner NOT IN &user_exclusion1
  AND    owner NOT IN &user_exclusion2
  AND    owner NOT LIKE 'APEX%'
  AND (encrypt NOT IN ('NO','NONE') OR compression NOT IN ('NO','NONE') OR deduplication NOT IN ('NO','NONE')
  OR logging != 'YES')
  UNION
  SELECT table_owner, table_name, column_name, partition_name, NULL AS subpartition_name
  FROM   dba_lob_partitions
  WHERE  securefile='YES'
  AND    table_owner NOT IN &user_exclusion
  AND    table_owner NOT IN &user_exclusion1
  AND    table_owner NOT IN &user_exclusion2
  AND    table_owner NOT LIKE 'APEX%'
  AND (encrypt NOT IN ('NO','NONE') OR compression NOT IN ('NO','NONE') OR deduplication NOT IN ('NO','NONE')
  OR logging != 'YES')
  UNION
  SELECT table_owner, table_name, column_name, lob_partition_name AS partition_name, subpartition_name
  FROM   dba_lob_subpartitions
  WHERE  securefile='YES'
  AND    table_owner NOT IN &user_exclusion
  AND    table_owner NOT IN &user_exclusion1
  AND    table_owner NOT IN &user_exclusion2
  AND    table_owner NOT LIKE 'APEX%'
  AND (encrypt NOT IN ('NO','NONE') OR compression NOT IN ('NO','NONE') OR deduplication NOT IN ('NO','NONE')
  OR logging != 'YES'))
ORDER BY owner, table_name, column_name, partition_name, subpartition_name;


set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	List of Data Types that should be reviewed
prompt ****	See release notes for additional information
prompt ****     ALL extended data types (Oracle 12c and later)
prompt ****     should be reviewed
prompt *********************************************************************

set heading on;
select a.owner, a.table_name, a.column_name,a.data_type from dba_tab_columns a, dba_objects b
where a.data_type in &review_data_types
and a.owner not in &user_exclusion
AND a.owner not in &user_exclusion1
AND a.owner not in &user_exclusion2
AND a.owner not LIKE 'APEX%'
and a.table_name = b.object_name
and b.object_type = 'TABLE'
order by a.owner;

PROMPT
PROMPT
prompt *********************************************************************************
prompt ****	List of Data Types that are not supported for replication to any target
prompt ****	See release notes for additional information
prompt **********************************************************************************
set heading on;
select a.owner, a.table_name, a.column_name,a.data_type from dba_tab_columns a, dba_objects b
where data_type not in &oracle_ok_data_types
AND data_type not like 'TIMESTAMP%'
and data_type not like 'INTERVAL%' 
and data_type not like 'BINARY%'
and data_type not like 'VARRAY%'
and data_type not like 'SDO%'
and a.owner not in &user_exclusion
and a.owner not in &user_exclusion1
and a.owner not in &user_exclusion2
and a.owner  NOT LIKE 'APEX%'
and a.table_name = b.object_name
and b.object_type = 'TABLE'
order by a.owner;

PROMPT
PROMPT
prompt ******************************************************************************
prompt ****	List of Data Types that are not supported for replication to SQLServer
prompt ****	See release notes for additional information
prompt *******************************************************************************
set heading on;
select a.owner, a.table_name, a.column_name,a.data_type from dba_tab_columns a, dba_objects b
where data_type not in &sqlserver_ok_data_types
AND data_type not like 'TIMESTAMP%'
and data_type not like 'BINARY%'
and a.owner not in &user_exclusion
and a.owner not in &user_exclusion1
and a.owner not in &user_exclusion2
and a.owner  NOT LIKE 'APEX%'
and a.table_name = b.object_name
and b.object_type = 'TABLE'
order by a.owner;

PROMPT
PROMPT
prompt ******************************************************************************
prompt ****	List of Data Types that are not supported for replication to files
prompt ****     (Kafka, JSON, XML) See release notes for VARRAY
prompt ****	See release notes for additional information
prompt *******************************************************************************
set heading on;
select a.owner, a.table_name, a.column_name,a.data_type from dba_tab_columns a, dba_objects b
where data_type not in &file_ok_data_types
AND data_type not like 'TIMESTAMP%'
and data_type not like 'BINARY%'
and a.owner not in &user_exclusion
and a.owner not in &user_exclusion1
and a.owner not in &user_exclusion2
and a.owner  NOT LIKE 'APEX%'
and a.table_name = b.object_name
and b.object_type = 'TABLE'
order by a.owner;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	 List of Nested Arrays                                	
prompt ****	 For UDTs Only                                        	
prompt ****	 Check if the Schema owners of the nested		
prompt ****	 objects are the same on source and target.           
prompt *********************************************************************

Set heading on;
select b.owner,b.attr_type_name as "Nested Array", b.type_name as "Nested In Type", b.attr_name as "Nested in Column"  
from dba_type_attrs b 
where b.attr_type_name in (select a.type_name from dba_types a where 
a.owner not in &user_exclusion 
and a.owner not in &user_exclusion1 
and a.owner not in &user_exclusion2 
and a.owner NOT LIKE 'APEX%'
and typecode = 'COLLECTION')
order by b.owner;

set heading off;
PROMPT
PROMPT
PROMPT
PROMPT
PROMPT
prompt *********************************************************************
prompt ****	NOTE 						
prompt ****	THE REMAINING OUTPUT IS IMFORMATIONAL AND 	
prompt ****	USED FOR IMPLEMENTATION AND PLANNING PURPOSES 		
prompt *********************************************************************
PROMPT
PROMPT
PROMPT
PROMPT
PROMPT
set heading off;
prompt *********************************************************************
prompt ****     List of Tables with more than 254 columns      	
prompt *********************************************************************

set heading on;
column owner format a30
column table_name format a30
column numcols format 999G999G999

select owner,table_name,count(table_name) as "NumCols" 
from dba_tab_columns where owner not in &user_exclusion 
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
group by owner,table_name having count(table_name) > 254
order by owner;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	List of Tables that contain LONG data types        	
prompt *********************************************************************
set heading on;
column column_name format a30
column table_name format A30
column data_type format a30
select owner,table_name,column_name,data_type from dba_tab_columns where data_type in ('LONG') 
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****   	Listing of Index Organized Tables      			
prompt *********************************************************************

set heading on;
select owner,table_name,iot_type 
from dba_tables 
where iot_type = 'IOT' 
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****    	Listing of Bitmap Indexes           			
prompt *********************************************************************

set heading on;
select owner,index_name,table_owner,table_name 
from dba_indexes where index_type = 'BITMAP'
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****	List of Data Types Contained in the Database 		
prompt *********************************************************************

set heading on;
select distinct data_type from dba_tab_columns 
where owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt **** 	List of Tables with size > 100 MB              		
prompt *********************************************************************

set heading on;
column MBYTE format 999G999G990
column PCT_FREE format 999
column PCT_USED format 999
select t.owner, t.table_name, t.tablespace_name, s.bytes/1024/1024 MBYTE, t.pct_free, t.pct_used, t.num_rows, t.chain_cnt, t.blocks
from dba_tables t, dba_segments s
where t.owner = s.owner
and t.table_name = s.segment_name
and t.owner not in &user_exclusion
and t.owner not in &user_exclusion1
and t.owner not in &user_exclusion2
and t.owner NOT LIKE 'APEX%'
and s.bytes > 100000000
order by t.owner, t.table_name;


set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****  	list of tables not analysed for the last 30 days 	
prompt *********************************************************************

set heading on;
select owner, table_name, to_char(last_analyzed,'DD-MON-RR') as "Analyzed" 
from dba_tables 
where last_analyzed is not NULL 
and last_analyzed < sysdate-30 
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by 1,2,3;

set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****    	List of Tables Created in the last 60 Days  	
prompt *********************************************************************

set heading on;
col "Table_Nm" for a30;
select owner, substr(object_name,1,30) as "Table_Nm",created 
from dba_objects where object_type = 'TABLE' 
and created > sysdate-60 
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by 1,2;


set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt **** 	Count of triggers by Row Level and then Statement Level 
prompt *********************************************************************

set heading on;
select count(trigger_type) as "Row Level" 
from dba_triggers 
where trigger_type like '%ROW%' 
and owner NOT LIKE 'APEX%'
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2;

set heading off;
prompt *** Statement Level ****
set heading on;
select owner,trigger_name,trigger_type,table_owner,table_name 
from dba_triggers 
where trigger_type not like '%ROW%' 
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner;


set heading off;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****   	List Constraints with On-Delete Cascades   		
prompt *********************************************************************

set heading on;

select owner,constraint_name,table_name from dba_constraints 
where delete_rule = 'CASCADE'
and owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner;


PROMPT
PROMPT
prompt *********************************************************************
prompt ****   	List Materialized Views
prompt *********************************************************************
column mview_name format A30
select owner,
       mview_name
from sys.dba_mviews
where owner not in &user_exclusion
and owner not in &user_exclusion1
and owner not in &user_exclusion2
and owner NOT LIKE 'APEX%'
order by owner, mview_name;

PROMPT
PROMPT
prompt *********************************************************************
prompt ****   	Count of CPUs (INFORMATION ONLY)
PROMPT ****     Please contact your Account Manager licensing information
prompt *********************************************************************

select stat_name,value from v$osstat where stat_name like 'NUM_CPU%';
prompt
prompt
prompt *********************************************************************
prompt ****     Database Parameter Settings
prompt ****     Looking for things out of the norm
prompt *********************************************************************
col Parameter for a35;
col Setting for a50;
select substr(name,1,35) as "Parameter", substr(value,1,50) as "Setting" from v$parameter order by name;


PROMPT
PROMPT
prompt *********************************************************************
prompt ****  	&dbname..lst has been generated. 			
prompt ****	Please send it to Quest Software   		
prompt *********************************************************************


set verify on;

spool off;

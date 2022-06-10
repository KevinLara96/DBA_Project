-- @Autor: 					Lara Sala Kevin Arturo y Miranda Cortés Yak Balam.
-- @Fecha creación: 8 Junio 2022
-- @Descripción:		Archivo SQL encargado de crear la Base de Datos para el
-- 									proyecto final del curso.


connect sys/hola1234* as sysdba
startup nomount


whenever sqlerror exit rollback;

create database lamiproy
	user sys identified by system3
	user system identified by system3
	user sysbackup identified by system3
	--Redo Logs.
	logfile group 1 (
		'/unam-bda/d11/app/oracle/oradata/LAMIPROY/redo01a.log',
		'/unam-bda/d12/app/oracle/oradata/LAMIPROY/redo01b.log',
		'/unam-bda/d13/app/oracle/oradata/LAMIPROY/redo01c.log') size 50m blocksize 512,
	group 2 (
		'/unam-bda/d11/app/oracle/oradata/LAMIPROY/redo01a.log',
		'/unam-bda/d12/app/oracle/oradata/LAMIPROY/redo01b.log',
		'/unam-bda/d13/app/oracle/oradata/LAMIPROY/redo01c.log') size 50m blocksize 512,
	group 3 (
		'/unam-bda/d11/app/oracle/oradata/LAMIPROY/redo01a.log',
		'/unam-bda/d12/app/oracle/oradata/LAMIPROY/redo01b.log',
		'/unam-bda/d13/app/oracle/oradata/LAMIPROY/redo01c.log') size 50m blocksize 512
	maxloghistory 1
	maxlogfiles 6
	maxlogmembers 3
	maxdatafiles 1024
	character set AL32UTF8
	national character set AL16UTF16
	extent management local
	--System.
	datafile '/u01/app/oracle/oradata/LAMIPROY/system01.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Sysaux.
	sysaux datafile '/u01/app/oracle/oradata/LAMIPROY/sysaux01.dbf'
		size 550m reuse autoextend on next 10240k maxsize unlimited
--	default tablespace users
--		datafile '/u01/app/oracle/oradata/LAMIPROY/users01.dbf'
--		size 500m reuse autoextend on maxsize unlimited
	--Temporal.
	default temporary tablespace tempts1
		tempfile '/u01/app/oracle/oradata/LAMIPROY/temp01.dbf'
		size 20m reuse autoextend on next 640k maxsize unlimited
	--Undo.
	undo tablespace undotbs1
		datafile '/u01/app/oracle/oradata/LAMIPROY/undotbs01.dbf'
		size 200m reuse autoextend on next 5120k maxsize unlimited;

alter user sys identified by system3;
alter user system identified by system3;
alter user sysbackup identified by system3;

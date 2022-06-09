-- @Autor: 					Lara Sala Kevin Arturo y Miranda Cortés Yak Balam.
-- @Fecha creación: 8 Junio 2022
-- @Descripción:		Archivo SQL encargado de crear la Base de Datos para el
-- 									proyecto final del curso.


connect sys/Hola1234* as sysdba
startup nomount


whenever sqlerror exit rollback;

create database lamiproy
	user sys identified by system2
	user system identified by system2
	user sysbackup identified by system2
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
	--Datafiles.
	extent management local
	--System.
	datafile '/unam-bda/..../app/oracle/oradata/LAMIPROY/system01.dbf' --¿?
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Proveedor.
	datafile '/unam-bda/d14/app/oracle/oradata/LAMIPROY/ts_proveedor1.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	datafile '/unam-bda/d15/app/oracle/oradata/LAMIPROY/ts_proveedor2.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Documentos proveedor.
	datafile '/unam-bda/d16/app/oracle/oradata/LAMIPROY/ts_prov_docs-fotos.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Índices proveedor.
	datafile '/unam-bda/d17/app/oracle/oradata/LAMIPROY/ts_prov_indices.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Fotos servicio.
	datafile '/unam-bda/d18/app/oracle/oradata/LAMIPROY/ts_prov_foto-servicio.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Cliente.
	datafile '/unam-bda/d19/app/oracle/oradata/LAMIPROY/ts_cliente1.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	datafile '/unam-bda/d20/app/oracle/oradata/LAMIPROY/ts_cliente2.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Documentos cliente.
	datafile '/unam-bda/d21/app/oracle/oradata/LAMIPROY/ts_cli_docs-fotos.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Índices cliente.
	datafile '/unam-bda/d22/app/oracle/oradata/LAMIPROY/ts_cli_indices.dbf'
		size 700m reuse autoextend on next 10240k maxsize unlimited
	--Sysaux.
	sysaux datafile '/unam-bda/..../app/oracle/oradata/LAMIPROY/sysaux01.dbf' --¿?
		size 550m reuse autoextend on next 10240k maxsize unlimited
	--Users.
	default tablespace users
		datafile '/unam-bda/..../app/oracle/oradata/LAMIPROY/users01.dbf' --¿?
		size 500m reuse autoextend on maxsize unlimited
	--Temporal.
	default temporary tablespace tempts1
		tempfile '/unam-bda/d24/app/oracle/oradata/LAMIPROY/temp01.dbf'
		size 20m reuse autoextend on next 640k maxsize unlimited
	--Undo.
	undo tablespace undotbs1
		datafile '/unam-bda/d23/app/oracle/oradata/LAMIPROY/undotbs01.dbf'
		size 200m reuse autoextend on next 5120k maxsize unlimited;

alter user sys identified by system2;
alter user system identified by system2;
alter user sysbackup identified by system2;

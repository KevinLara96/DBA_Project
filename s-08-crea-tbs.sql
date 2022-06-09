-- @Autor:          Lara Sala Kevin Arturo y Miranda Cortés Yak Balam.
-- @Fecha creación: 8 Junio 2022
-- @Descripción:    Archivo SQL encargado de crear la Base de Datos para el
--                  proyecto final del curso.


connect sys/system3 as sysdba

whenever sqlerror exit rollback;


--Proveedor.
create tablespace ts_proveedor1
datafile '/unam-bda/d14/app/oracle/oradata/LAMIPROY/ts_proveedor1.dbf'
  size 500m reuse autoextend on next 50m maxsize unlimited;
create tablespace ts_proveedor2
datafile '/unam-bda/d15/app/oracle/oradata/LAMIPROY/ts_proveedor2.dbf'
  size 500m reuse autoextend on next 50m maxsize unlimited;
--Documentos proveedor.
create tablespace ts_prov_docs-fotos
datafile '/unam-bda/d16/app/oracle/oradata/LAMIPROY/ts_prov_docs-fotos.dbf'
  size 700m reuse autoextend on next 100m maxsize unlimited;
--Índices proveedor.
create tablespace ts_prov_indices
datafile '/unam-bda/d17/app/oracle/oradata/LAMIPROY/ts_prov_indices.dbf'
  size 400m reuse autoextend on next 10m maxsize unlimited;
--Fotos servicio.
create tablespace ts_prov_foto-servicio
datafile '/unam-bda/d18/app/oracle/oradata/LAMIPROY/ts_prov_foto-servicio.dbf'
  size 700m reuse autoextend on next 700m maxsize unlimited;
--Cliente.
create tablespace ts_cliente1
datafile '/unam-bda/d19/app/oracle/oradata/LAMIPROY/ts_cliente1.dbf'
  size 500m reuse autoextend on next 50m maxsize unlimited;
create tablespace ts_cliente2
datafile '/unam-bda/d20/app/oracle/oradata/LAMIPROY/ts_cliente2.dbf'
  size 500m reuse autoextend on next 50m maxsize unlimited;
--Documentos cliente.
create tablespace ts_cli_docs-photos
datafile '/unam-bda/d21/app/oracle/oradata/LAMIPROY/ts_cli_docs-fotos.dbf'
  size 700m reuse autoextend on next 100m maxsize unlimited;
--Índices cliente.
create tablespace ts_cli_indices
datafile '/unam-bda/d22/app/oracle/oradata/LAMIPROY/ts_cli_indices.dbf'
  size 400m reuse autoextend on next 10m maxsize unlimited;

--Users. (Usar si se necesita).
--  default tablespace users
--    datafile '/u01/app/oracle/oradata/LAMIPROY/users01.dbf'
--    size 500m reuse autoextend on maxsize unlimited


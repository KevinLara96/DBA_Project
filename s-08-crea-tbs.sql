-- @Autor:          Lara Sala Kevin Arturo y Miranda Cortés Yak Balam.
-- @Fecha creación: 8 Junio 2022
-- @Descripción:    Archivo SQL encargado de crear la Base de Datos para el
--                  proyecto final del curso.


connect sys/system3 as sysdba

whenever sqlerror exit rollback;


--Proveedor.
create tablespace ts_provedor
datafile '/unam-bda/d14/app/oracle/oradata/LAMIPROY/ts_provedor1.dbf'
  size 250m reuse autoextend on next 50m maxsize 1g,
  '/unam-bda/d15/app/oracle/oradata/LAMIPROY/ts_provedor2.dbf'
  size 250m reuse autoextend on next 50m maxsize 1g
extent management local autoallocate
segment space management auto
online;

--Documentos proveedor.
create tablespace ts_p_docs_fotos
datafile '/unam-bda/d16/app/oracle/oradata/LAMIPROY/ts_p_docs_fotos.dbf'
  size 700m reuse autoextend on next 100m maxsize 2g
extent management local autoallocate
segment space management auto
online;

--Índices proveedor.
create tablespace ts_p_indices
datafile '/unam-bda/d17/app/oracle/oradata/LAMIPROY/ts_p_indices.dbf'
  size 300m reuse autoextend on next 10m maxsize 500m
extent management local autoallocate
segment space management auto
online;

--Fotos servicio.
create tablespace ts_p_foto_servicio
datafile '/unam-bda/d18/app/oracle/oradata/LAMIPROY/ts_p_foto_servicio.dbf'
  size 700m reuse autoextend on next 700m maxsize 2g
extent management local autoallocate
segment space management auto
online;

--Cliente.
create tablespace ts_cliente
datafile '/unam-bda/d19/app/oracle/oradata/LAMIPROY/ts_cliente1.dbf'
  size 250m reuse autoextend on next 50m maxsize 1g,
  '/unam-bda/d20/app/oracle/oradata/LAMIPROY/ts_cliente2.dbf'
  size 250m reuse autoextend on next 50m maxsize 1g;
extent management local autoallocate
segment space management auto
online;

--Documentos cliente.
create tablespace ts_c_docs_fotos
datafile '/unam-bda/d21/app/oracle/oradata/LAMIPROY/ts_c_docs_fotos.dbf'
  size 700m reuse autoextend on next 100m maxsize 2g,
  extent management local autoallocate
  segment space management auto
  online;

--Índices cliente.
create tablespace ts_c_indices
datafile '/unam-bda/d22/app/oracle/oradata/LAMIPROY/ts_c_indices.dbf'
  size 300m reuse autoextend on next 10m maxsize 500m
  extent management local autoallocate
  segment space management auto
  online;

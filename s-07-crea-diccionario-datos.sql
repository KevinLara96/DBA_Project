--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 02/05/2022
--@Descripción: Script para ejecutar archivos posteriores a la creación de la
--							BD.

whenever sqlerror exit rollback;

-- Conectando como usuario sys
connect sys/system3 as sysdba

startup open
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect system/system3 as sysdba
@?/sqlplus/admin/pupbld.sql

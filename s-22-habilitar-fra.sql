-- @Autor:          Lara Sala Kevin Arturo y Miranda Cortés Yak Balam.
-- @Fecha creación: 13 Junio 2022
-- @Descripción:    Archivo SQL encargado de activar la FRA

connect sys/system3 as sysdba

alter system set db_recovery_file_dest_size = 3G scope = both;
alter system set db_recovery_file_dest = '/unam-bda/d23' scope = both;
alter system set db_flashback_retention_target = = 1440 scope=both;



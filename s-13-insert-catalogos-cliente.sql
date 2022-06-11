--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Script para la insercion de datos del modulo Cliente

whenever sqlerror exit rollback;
connect cliente/cliente

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

-- Insercion en 
insert into STATUS_SERVICIO (STATUS_SERVICIO_ID,NOMBRE_STATUS) values (1,'registrado');
insert into STATUS_SERVICIO (STATUS_SERVICIO_ID,NOMBRE_STATUS) values (2,'aceptado');
insert into STATUS_SERVICIO (STATUS_SERVICIO_ID,NOMBRE_STATUS) values (3,'en ejecucion');
insert into STATUS_SERVICIO (STATUS_SERVICIO_ID,NOMBRE_STATUS) values (4,'por pagar');
insert into STATUS_SERVICIO (STATUS_SERVICIO_ID,NOMBRE_STATUS) values (5,'pagado');
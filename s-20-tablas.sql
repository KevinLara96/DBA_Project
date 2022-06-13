--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 12/06/2022
--@Descripción: Creacion de todas las tablas

whenever sqlerror exit rollback;
-- Provedor
@@s-10-tablas-provedor.sql
@@s-11-insert-catalogos-provedor.sql
@@s-14-tr-modulo-provedor.sql
@@s-17-carga-datos-provedor.sql

-- Cliente
@@s-12-tablas-cliente.sql
@@s-13-insert-catalogos-cliente.sql
@@s-15-tr-modulo-cliente.sql
@@s-18-carga-datos-cliente.sql
@@s-19-carga-servicios-cliente.sql

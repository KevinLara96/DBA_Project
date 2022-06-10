--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 02/05/2022
--@Descripción: Script para crear el archivo SPFILE
Prompt marca1
whenever sqlerror exit rollback;
Prompt marca2
-- Conectando como usuario sys
connect sys/hola1234* as sysdba
Prompt marca3
startup nomount
Prompt marca4
-- Creacion del archivo spfile
create spfile from pfile;
Prompt marca5
-- Verificacion del que el archivo fue creado
-- '!' Permite ejecutar una instruccion de shell (consola)
!ls ${ORACLE_HOME}/dbs/spfilelamiproy.ora
Prompt Archivo de parametros creado.

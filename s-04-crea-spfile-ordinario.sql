--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 02/05/2022
--@Descripción: Script para crear el archivo SPFILE

whenever sqlerror exit rollback;

-- Conectando como usuario sys
connect sys/hola1234* as sysdba

startup nomount

-- Creacion del archivo spfile
create spfile from pfile;

-- Verificacion del que el archivo fue creado
-- '!' Permite ejecutar una instruccion de shell (consola)
!ls ${ORACLE_HOME}/dbs/spfilelamiproy.ora
Prompt Archivo creado.

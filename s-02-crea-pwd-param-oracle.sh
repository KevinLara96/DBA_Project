# @Autor Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
# @Fecha 02/05/2022
# @Descripcion Script para generar el archivo de passwords

export ORACLE_SID=lamiproy

# Creacion del archivo de passwords
orapwd FILE='$ORACLE_HOME/dbs/orapwlamiproy' FORCE=Y FORMAT=12.2 \
	SYS=password	\
	SYSBACKUP=password

ls -l $ORACLE_HOME/dbs/orapwlamiproy




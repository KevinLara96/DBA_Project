# @Autor Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
# @Fecha 02/05/2022
# @Descripcion Script para generar el archivo de parametros

# Creacion del archivo de parametros
echo "1. Creando un archivo de parámetros básico"
export ORACLE_SID=lamiproy
pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora


if [ -f "${pfile}" ]; then
	read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"db_name='${ORACLE_SID}'
db_domain=fi.unam
memory_target=768M
control_files=(	/unam-bda/d11/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
                /unam-bda/d12/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
                /unam-bda/d13/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl)
" > ${pfile}

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}

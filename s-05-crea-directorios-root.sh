# @Autor Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
# @Fecha 02/05/2022
# @Descripcion Script para la creacion de los directorios para crear la BD:
#               - Directorio para los Data Files
#               - Directorio para archivos Redo Logs
#               - Directorio para archivos Control Files

#Creacion de dir para Data Files
export ORACLE_SID=lamiproy
cd /u01/app/oracle/oradata
mkdir ${ORACLE_SID^^}
chown oracle:oinstall ${ORACLE_SID^^}
chmod 750 ${ORACLE_SID^^}

#Crecion de directorios para archivos de control multiplexados y grupos Redo Logs
cd /unam-bda/d11
mkdir -p app/oracle/oradata/LAMIPROY
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda/d12
mkdir -p app/oracle/oradata/LAMIPROY
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda/d13
mkdir -p app/oracle/oradata/LAMIPROY
chown -R oracle:oinstall app
chmod -R 750 app

echo "Mostrando directorio de data files"
ls -l /u01/app/oracle/oradata
echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam-bda/d0*/app/oracle/oradata


# @Autor Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
# @Fecha 02/05/2022
# @Descripcion Script para la creacion de los directorios para crear la BD:
#               - Directorio para los Data Files
#               - Directorio para archivos Redo Logs
#               - Directorio para archivos Control Files

export ORACLE_SID=lamiproy

#Directorio para tablespaces de sistema.
cd /u01/app/oracle/oradata
mkdir ${ORACLE_SID^^}
chown oracle:oinstall ${ORACLE_SID^^}
chmod 750 ${ORACLE_SID^^}


# Creacion de dir para Data Files de la Base.
cd /unam-bda
mkdir -p d14/app/oracle/oradata/LAMIPROY
# ts_provedor (disco 1)
cd /unam-bda/d14
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d15/app/oracle/oradata/LAMIPROY
# ts_provedor (disco 2)
cd /unam-bda/d15
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d16/app/oracle/oradata/LAMIPROY
# ts_p_docs-fotos (Provedor)
cd /unam-bda/d16
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d17/app/oracle/oradata/LAMIPROY
cd /unam-bda/d17
# ts_p_indices
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d18/app/oracle/oradata/LAMIPROY
cd /unam-bda/d18
# ts_p_foto-servicio
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d19/app/oracle/oradata/LAMIPROY
cd /unam-bda/d19
# ts_cliente (disco 1)
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d20/app/oracle/oradata/LAMIPROY
cd /unam-bda/d20
# ts_cliente (disco 2)
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d21/app/oracle/oradata/LAMIPROY
cd /unam-bda/d21
# ts_c_docs-fotos (Cliente)
chown -R oracle:oinstall app
chmod -R 750 app

cd /unam-bda
mkdir -p d22/app/oracle/oradata/LAMIPROY
cd /unam-bda/d22
# ts_c_indices
chown -R oracle:oinstall app
chmod -R 750 app

# Directorio para la FRA
cd /unam-bda
mkdir -p d23/fra
cd /unam-bda/d23
# ts_fra
chown -R oracle:oinstall app
chmod -R 750 app

# Crecion de directorios para archivos de control multiplexados y grupos Redo Logs
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
ls -l /unam-bda/
echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam-bda/d11/app/oracle/oradata
ls -l /unam-bda/d12/app/oracle/oradata
ls -l /unam-bda/d13/app/oracle/oradata


--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Script para la insercion de datos del modulo Provedor

connect provedor/provedor

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

-- Insercion en NIVEL_ESTUDIO
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (1,'primaria');
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (2,'secundaria');
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (3,'bachillerato');
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (4,'licenciatura');
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (5,'maestria');
insert into NIVEL_ESTUDIO (NIVEL_ESTUDIO_ID, NOMBRE_NIVEL) values (6,'doctorado');

-- Insercion en TELEFONO_TIPO
insert into TELEFONO_TIPO (TELEFONO_TIPO_ID,TELEFONO_TIPO) values (1,'fijo');
insert into TELEFONO_TIPO (TELEFONO_TIPO_ID,TELEFONO_TIPO) values (2,'celular');

-- Insercion en BANCO
insert into BANCO (BANCO_ID, NOMBRE) values (1,'BBVA');
insert into BANCO (BANCO_ID, NOMBRE) values (2,'Santander');
insert into BANCO (BANCO_ID, NOMBRE) values (3,'Bancomer');
insert into BANCO (BANCO_ID, NOMBRE) values (4,'HSBC');

-- Insercion en TIPO_SERVICIO
insert into TIPO_SERVICIO (TIPO_SERVICIO_ID,NOMBRE,DESCRIPCION) values (1,'plomero','Instalación y reparación de tuberías utilizadas para la distribución y desecho de aire, gas y agua.');
insert into TIPO_SERVICIO (TIPO_SERVICIO_ID,NOMBRE,DESCRIPCION) values (2,'carpintero','Trabajo con la madera para crear muebles del hogar como mesas, puertas, herramientas, etc.');
insert into TIPO_SERVICIO (TIPO_SERVICIO_ID,NOMBRE,DESCRIPCION) values (3,'pintor','Trabajos de pintura de casas, edificios y fachadas.');
insert into TIPO_SERVICIO (TIPO_SERVICIO_ID,NOMBRE,DESCRIPCION) values (4,'electricista','Colocación y reparación de instalaciones eléctricas.');
insert into TIPO_SERVICIO (TIPO_SERVICIO_ID,NOMBRE,DESCRIPCION) values (5,'mecanico','Reparacion de electrodomesticos.');

-- Insercion en STATUS_PROVEDOR 
insert into STATUS_PROVEDOR (STATUS_PROVEDOR_ID,NOMBRE_STATUS) values (1,'validacion');
insert into STATUS_PROVEDOR (STATUS_PROVEDOR_ID,NOMBRE_STATUS) values (2,'en servicio');
insert into STATUS_PROVEDOR (STATUS_PROVEDOR_ID,NOMBRE_STATUS) values (3,'suspendido');
insert into STATUS_PROVEDOR (STATUS_PROVEDOR_ID,NOMBRE_STATUS) values (4,'expulsado');
insert into STATUS_PROVEDOR (STATUS_PROVEDOR_ID,NOMBRE_STATUS) values (5,'inactivo');

-- Insercion en 
insert into 

-- Insercion en 
insert into 

-- Insercion en 


-- Insercion en 
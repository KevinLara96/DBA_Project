--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 12/06/2022
--@Descripción: carga de datos de provedores

whenever sqlerror exit rollback;
connect provedor/provedor

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

insert into PROVEDOR (PROVEDOR_ID, NOMBRE, APELLIDO, FECHA_NACIMIENTO, LUGAR_NACIMIENTO, DIRECCION, STATUS_PROVEDOR_ID, NIVEL_ESTUDIO_ID, BANCO_ID) values (1, 'Ichabod', 'Greenwood', '15/08/1998', 'Brazil', '388 Bellgrove Plaza', 5, 3, 1);
insert into PROVEDOR (PROVEDOR_ID, NOMBRE, APELLIDO, FECHA_NACIMIENTO, LUGAR_NACIMIENTO, DIRECCION, STATUS_PROVEDOR_ID, NIVEL_ESTUDIO_ID, BANCO_ID) values (2, 'Bogey', 'Gronous', '16/08/1986', 'Ireland', '673 John Wall Street', 5, 1, 4);
insert into PROVEDOR (PROVEDOR_ID, NOMBRE, APELLIDO, FECHA_NACIMIENTO, LUGAR_NACIMIENTO, DIRECCION, STATUS_PROVEDOR_ID, NIVEL_ESTUDIO_ID, BANCO_ID) values (3, 'Rog', 'Trenaman', '04/11/1973', 'China', '43 Evergreen Hill', 5, 2, 2);
insert into PROVEDOR (PROVEDOR_ID, NOMBRE, APELLIDO, FECHA_NACIMIENTO, LUGAR_NACIMIENTO, DIRECCION, STATUS_PROVEDOR_ID, NIVEL_ESTUDIO_ID, BANCO_ID) values (4, 'Damian', 'Ponte', '05/08/1995', 'Bahamas', '07 Knutson Court', 5, 3, 3);

insert into PROVEDOR_EMAIL (provedor_email_id, email, provedor_id) values (1, 'nbeernaert0@amazon.co.uk', 1);
insert into PROVEDOR_EMAIL (provedor_email_id, email, provedor_id) values (2, 'mstanbro1@amazon.de', 2);
insert into PROVEDOR_EMAIL (provedor_email_id, email, provedor_id) values (3, 'tfisher2@quantcast.com', 3);
insert into PROVEDOR_EMAIL (provedor_email_id, email, provedor_id) values (4, 'olegrand3@wix.com', 4);


insert into PROVEDOR_TELEFONO (provedor_telefono_id, telefono, provedor_id, telefono_tipo_id) values (1, '9585092147', 1, 2);
insert into PROVEDOR_TELEFONO (provedor_telefono_id, telefono, provedor_id, telefono_tipo_id) values (2, '7538439943', 2, 1);
insert into PROVEDOR_TELEFONO (provedor_telefono_id, telefono, provedor_id, telefono_tipo_id) values (3, '0759109794', 3, 2);
insert into PROVEDOR_TELEFONO (provedor_telefono_id, telefono, provedor_id, telefono_tipo_id) values (4, '5767536035', 4, 1);

commit;


set linesize window
col comprobante format a30
col identificacion_pdf format a20
col comprobante_domicilio format a25
col descripcion format a30
col servicio_imagen format a15
col descripcion_imagen format a40

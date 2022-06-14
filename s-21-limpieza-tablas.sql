--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 12/06/2022
--@Descripción: Eliminacion de todas las tablas

whenever sqlerror exit rollback;

-- cliente
connect cliente/cliente

drop table TARJETA;
drop table PERSONA;
drop table HISTORICO_STATUS_SERVICIO;
drop table EMPRESA;
drop table DEPOSITO;
drop table COBRO_SERVICIO;
drop table CALIFICACION;
drop table SERVICIO;
drop table CLIENTE;
drop table STATUS_SERVICIO;

drop sequence seq_historico_status_servicio;
drop sequence seq_tarjeta;
drop sequence seq_cobro_servicio;
drop sequence seq_deposito;
drop sequence seq_calificacion;

-- provedor
connect provedor/provedor

drop table servicio_realizado_imagen;
drop table servicio_provedor_realizado;
drop table seguridad;
drop table prov_servicio_comprobante;
drop table historico_provedor_status;
drop table provedor_servicio;
drop table provedor_email;
drop table provedor_telefono;
drop table TELEFONO_TIPO;
drop table TIPO_SERVICIO;
drop table provedor;
drop table BANCO;
drop table STATUS_PROVEDOR;
drop table NIVEL_ESTUDIO;

drop sequence seq_historico_provedor_status;
drop sequence seq_provedor_servicio;
drop sequence seq_prov_servicio_comprobante;
drop sequence seq_seguridad;
drop sequence seq_servicio_provedor_realizado;
drop sequence seq_servicio_realizado_imagen;
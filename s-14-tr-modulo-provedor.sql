--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Triggers para el modulo provedor

whenever sqlerror exit rollback;
connect provedor/provedor

-- Secuencia para la llave primaria de la tabla historico_provedor_status
create sequence seq_historico_provedor_status
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para el almacenamiento del historico del status del provedor
-- tabla: historico_provedor_status
create or replace trigger tr_historico_provedor_status
	after insert or update of status_provedor_id
	on provedor
	for each row
declare
v_seq_hist number(6,0);
v_fecha_status date;
v_status_provedor_id number(1);
v_provedor_id number(5,0);

begin
	select seq_historico_provedor_status.nextval into v_seq_hist from dual;
	case
		when inserting then
			v_fecha_status:= sysdate;
			v_status_provedor_id := :new.status_provedor_id;
			v_provedor_id := :new.provedor_id;

			insert into historico_provedor_status (historico_provedor_status_id, fecha_status, status_provedor_id, provedor_id)
			values (v_seq_hist, v_fecha_status, v_status_provedor_id, v_provedor_id);

		when updating('status_provedor_id') then
			v_fecha_status:= sysdate;
			v_status_provedor_id := :new.status_provedor_id;
			v_provedor_id := :new.provedor_id;

			insert into historico_provedor_status (historico_provedor_status_id, fecha_status, status_provedor_id, provedor_id)
			values (v_seq_hist, v_fecha_status, v_status_provedor_id, v_provedor_id);
	end case;
end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla provedor_servicio
create sequence seq_provedor_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para guardar los servicios que ofrece un provedor
-- Tabla: PROVEDOR_SERVICIO

create or replace trigger tr_provedor_servicio
	after insert 
	on provedor
	for each row
declare
v_seq_prov_servicio provedor_servicio.provedor_servicio_id%TYPE;
v_anio_experiencia1 provedor_servicio.anio_experiencia%TYPE;
v_tipo_servicio_id1 provedor_servicio.tipo_servicio_id%TYPE;
v_anio_experiencia2 provedor_servicio.anio_experiencia%TYPE;
v_tipo_servicio_id2 provedor_servicio.tipo_servicio_id%TYPE;
v_provedor_id provedor.provedor_id%TYPE;
begin
	select seq_provedor_servicio.nextval into v_seq_prov_servicio from dual;
	v_anio_experiencia1:= round(dbms_random.value(1,10));
	v_tipo_servicio_id1:= round(dbms_random.value(1,3));
	v_provedor_id:= :new.provedor_id;
		
	insert into provedor_servicio (provedor_servicio_id,anio_experiencia,tipo_servicio_id,provedor_id)
	values (v_seq_prov_servicio,v_anio_experiencia1,v_tipo_servicio_id1,v_provedor_id);

	select seq_provedor_servicio.nextval into v_seq_prov_servicio from dual;
	v_anio_experiencia2:=round(dbms_random.value(1,10));
	v_tipo_servicio_id2:=round(dbms_random.value(4,5));

	insert into provedor_servicio (provedor_servicio_id,anio_experiencia,tipo_servicio_id,provedor_id)
	values (v_seq_prov_servicio,v_anio_experiencia2,v_tipo_servicio_id2,v_provedor_id);
end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla prov_servicio_comprobante
create sequence seq_prov_servicio_comprobante
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para insertar datos de comprobante por servicio realizado
-- TABLA: PROV_SERVICIO_COMPROBANTE

create or replace trigger tr_prov_servicio_comprobante
	after insert 
	on provedor_servicio
	for each row
declare
v_seq_prov_servicio_comprobante_id prov_servicio_comprobante.prov_servicio_comprobante_id%TYPE;
v_provedor_servicio_id prov_servicio_comprobante.provedor_servicio_id%TYPE;

begin
	select seq_prov_servicio_comprobante.nextval into v_seq_prov_servicio_comprobante_id from dual;
	v_provedor_servicio_id := :new.provedor_servicio_id;

	insert into prov_servicio_comprobante (prov_servicio_comprobante_id,provedor_servicio_id) 
	values (v_seq_prov_servicio_comprobante_id, v_provedor_servicio_id);

end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla seguridad
create sequence seq_seguridad
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para guardar los archivos/datos de seguridad de un provedor 	
-- Tabla: PROVEDOR_SERVICIO

create or replace trigger tr_seguridad
	after insert 
	on provedor
	for each row
declare
v_seq_seguridad seguridad.seguridad_id%TYPE;
v_clabe seguridad.clabe%TYPE;
v_provedor_id seguridad.provedor_id%TYPE;
begin
	select seq_seguridad.nextval into v_seq_seguridad from dual;
	select dbms_random.string('X', 18) into v_clabe from dual;
	v_provedor_id:= :new.provedor_id;
		
	insert into seguridad (seguridad_id,clabe,provedor_id)
	values (v_seq_seguridad,v_clabe,v_provedor_id);
end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla servicio_provedor_realizado
create sequence seq_servicio_provedor_realizado
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para insertar datos de los servicios hechos con anterioridad
-- TABLA: SERVICIO_PROVEDOR_REALIZADO

create or replace trigger tr_servicio_provedor_realizado
	after insert 
	on provedor_servicio
	for each row
declare
v_seq_servicio_provedor_realizado servicio_provedor_realizado.servicio_provedor_realizado_id%TYPE;
v_descripcion servicio_provedor_realizado.descripcion%TYPE;
v_fecha_servicio servicio_provedor_realizado.fecha_servicio%TYPE;
v_provedor_id servicio_provedor_realizado.provedor_id%TYPE;

begin
	select seq_servicio_provedor_realizado.nextval into v_seq_servicio_provedor_realizado from dual;
	select dbms_random.string('L', 200) into v_descripcion from dual;
	select sysdate-round(dbms_random.value(0,30*12*5),0) into v_fecha_servicio from dual;
	v_provedor_id := :new.provedor_id;

	insert into servicio_provedor_realizado (servicio_provedor_realizado_id,descripcion,fecha_servicio,provedor_id) 
	values (v_seq_servicio_provedor_realizado,v_descripcion,v_fecha_servicio,v_provedor_id);

end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla servicio_realizado_imagen
create sequence seq_servicio_realizado_imagen
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para insertar evidencias de los servicios hechos con anterioridad
-- TABLA: SERVICIO_REALIZADO_IMAGEN

create or replace trigger tr_servicio_realizado_imagen
	after insert 
	on servicio_provedor_realizado
	for each row
declare
v_seq_servicio_realizado_imagen servicio_realizado_imagen.servicio_realizado_imagen_id%TYPE;
v_descripcion_imagen servicio_realizado_imagen.descripcion_imagen%TYPE;
v_servicio_provedor_realizado_id servicio_realizado_imagen.servicio_provedor_realizado_id%TYPE;


begin
	select seq_servicio_realizado_imagen.nextval into v_seq_servicio_realizado_imagen from dual;
	select dbms_random.string('L', 500) into v_descripcion_imagen from dual;
	v_servicio_provedor_realizado_id := :new.servicio_provedor_realizado_id;

	insert into servicio_realizado_imagen (servicio_realizado_imagen_id,descripcion_imagen,servicio_provedor_realizado_id) 
	values (v_seq_servicio_realizado_imagen,v_descripcion_imagen,v_servicio_provedor_realizado_id);

	select seq_servicio_realizado_imagen.nextval into v_seq_servicio_realizado_imagen from dual;
	select dbms_random.string('L', 500) into v_descripcion_imagen from dual;

	insert into servicio_realizado_imagen (servicio_realizado_imagen_id,descripcion_imagen,servicio_provedor_realizado_id) 
	values (v_seq_servicio_realizado_imagen,v_descripcion_imagen,v_servicio_provedor_realizado_id);

end;
/ 
show errors 

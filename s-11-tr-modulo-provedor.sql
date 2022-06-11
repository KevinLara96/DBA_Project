--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Triggers para el modulo provedor


-- Secuencia para la llave primaria de la tabla historico_provedor_status
create sequence seq_historico_provedor_status
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    noorder
;

-- Trigger para el almacenamiento del historico del status del provedor
-- tabla: historico_provedor_status
create or replace trigger tr_historico_provedor_status
	after insert or update of status_provedor_id
	on provedor
	for each row
declare
v_seq_hist number(6);
v_fecha_status date;
v_status_provedor_id number(1);
v_provedor_id number(5);

begin
	select seq_historico_provedor_status.nextval into v_seq_hist from dual;
	case
		when inserting then
			v_fecha_status:= sysdate;
			v_status_provedor_id := :new.status_provedor_id
			v_provedor_id := :new.prvedor_id;

			insert into historico_provedor_status (historico_provedor_status_id, fecha_status, status_provedor_id, prvedor_id)
			values (v_seq_hist, v_fecha_status, v_status_provedor_id, v_provedor_id);

		when updating('status_provedor_id') then
			v_fecha_status:= sysdate;
			v_status_provedor_id := :new.status_provedor_id
			v_provedor_id := :new.prvedor_id;

			insert into historico_provedor_status (historico_provedor_status_id, fecha_status, status_provedor_id, prvedor_id)
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
    noorder
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
	v_anio_experiencia1:=round(dbms_random.value(1,10));
	v_tipo_servicio_id1:=round(dbms_random.value(1,3));
	v_provedor_id:=new:provedor_id;
		
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
    noorder
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
	v_provedor_servicio_id := new.provedor_servicio_id;

	insert into prov_servicio_comprobante (prov_servicio_comprobante_id,provedor_servicio_id) 
	values (v_seq_prov_servicio_comprobante_id, v_provedor_servicio_id);

end;
/ 
show errors 


servicio_provedor_realizado
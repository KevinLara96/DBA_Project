--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Triggers para el modulo cliente

whenever sqlerror exit rollback;
connect cliente/cliente

-- Secuencia para la llave primaria de la tabla historico_status_servicio
create sequence seq_historico_status_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para el almacenamiento del historico del status del provedor
-- tabla: historico_status_servicio
create or replace trigger tr_historico_status_servicio
	after insert or update of status_servicio_id
	on servicio
	for each row
declare
v_seq_hist            historico_status_servicio.historico_status_servicio_id%TYPE;
v_fecha_status        historico_status_servicio.fecha_status%TYPE;
v_status_servicio_id  historico_status_servicio.status_servicio_id%TYPE;
v_servicio_id         historico_status_servicio.servicio_id%TYPE;

begin
	select seq_historico_status_servicio.nextval into v_seq_hist from dual;
	case
		when inserting then
			v_fecha_status:= sysdate;
			v_status_servicio_id := :new.status_servicio_id;
			v_servicio_id := :new.servicio_id;

			insert into historico_status_servicio (historico_status_servicio_id, fecha_status, status_servicio_id, servicio_id)
			values (v_seq_hist, v_fecha_status, v_status_servicio_id, v_servicio_id);

		when updating('status_servicio_id') then
			v_fecha_status:= sysdate;
			v_status_servicio_id := :new.status_servicio_id;
			v_servicio_id := :new.servicio_id;

			insert into historico_status_servicio (historico_status_servicio_id, fecha_status, status_servicio_id, servicio_id)
			values (v_seq_hist, v_fecha_status, v_status_servicio_id, v_servicio_id);
	end case;
end;
/ 
show errors 


-- Trigger para insertar datos del tipo de cliente
-- TABLA: PERSONA, EMPRESA 

create or replace trigger tr_persona_or_empresa
	after insert 
	on cliente
	for each row
declare
v_cliente_id          cliente.cliente_id%TYPE;
v_tipo                cliente.tipo%TYPE;

v_nombre_empresa      empresa.nombre_empresa%TYPE;
v_descripcion_empresa empresa.descripcion_empresa%TYPE;
v_empleados_aprox     empresa.empleados_aprox%TYPE;

v_curp                persona.curp%TYPE;
v_fecha_nacimiento    persona.fecha_nacimiento%TYPE;


begin
	v_cliente_id := :new.cliente_id;
	v_tipo := :new.tipo;

	if (v_tipo = '0') then
		select dbms_random.string('X', 25) into v_nombre_empresa from dual;
		select dbms_random.string('X', 200) into v_descripcion_empresa from dual;
		v_empleados_aprox := round(dbms_random.value(10000,999999));

		insert into empresa(cliente_id,nombre_empresa,descripcion_empresa,empleados_aprox)
		values (v_cliente_id,v_nombre_empresa,v_descripcion_empresa,v_empleados_aprox);
	else
		select dbms_random.string('X', 18) into v_curp from dual;
		select sysdate-round(dbms_random.value(0,30*12*40),0) into v_fecha_nacimiento from dual;

		insert into persona(cliente_id,curp,fecha_nacimiento)
		values (v_cliente_id,v_curp,v_fecha_nacimiento);

	end if;

end;
/ 
show errors 


-- Secuencia para la llave primaria de la tabla tarjeta
create sequence seq_tarjeta
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Trigger para insertar datos de tarjeta del cliente
-- TABLA: TARJETA

create or replace trigger tr_tarjeta
	after insert 
	on cliente
	for each row
declare
v_seq_tarjeta  tarjeta.tarjeta_id%TYPE;
v_saldo        tarjeta.saldo%TYPE;
v_cliente_id   tarjeta.cliente_id%TYPE;

begin
	select seq_tarjeta.nextval into v_seq_tarjeta from dual;
	v_saldo := round(dbms_random.value(50000,9999999));
	v_cliente_id := :new.cliente_id;

	insert into tarjeta (tarjeta_id,saldo,cliente_id)
	values (v_seq_tarjeta,v_saldo,v_cliente_id);

end;
/ 
show errors 


-- trigger para cuando se actualiza el status del servicio
-- Tabla: PROVEDOR 
create or replace trigger tr_status_provedor
	after update of status_servicio_id
	on servicio
	for each row
declare
v_provedor_id         servicio.provedor_id%TYPE;
v_servicio_id         servicio.servicio_id%TYPE;
v_status_servicio_id  servicio.status_servicio_id%TYPE;

begin
	v_status_servicio_id := :new.status_servicio_id;
	v_provedor_id        := :new.provedor_id;

	if (v_status_servicio_id = 1) then
		update provedor.provedor set status_provedor_id = 1 
		where provedor_id=v_provedor_id;

	elsif (v_status_servicio_id = 2) then
		update provedor.provedor set status_provedor_id = 5
		where provedor_id=v_provedor_id;

	elsif (v_status_servicio_id = 3) then
		update provedor.provedor set status_provedor_id = 2 
		where provedor_id=v_provedor_id;

	elsif (v_status_servicio_id = 4) then
		update provedor.provedor set status_provedor_id = 3 
		where provedor_id=v_provedor_id;

	else
		update provedor.provedor set status_provedor_id = 5
		where provedor_id=v_provedor_id;

	end if;
end;
/ 
show errors 


-- secuencia para llave primara de la tabla deposito
create sequence seq_deposito
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- trigger para agregar depositos
-- Tabla: DEPOSITO 
create or replace trigger tr_deposito
	after insert
	on cobro_servicio
	for each row
declare
v_deposito_id    deposito.deposito_id%TYPE;
v_importe        deposito.importe%TYPE;
v_clabe          deposito.clabe%TYPE;
v_banco          deposito.banco%TYPE;
v_servicio_id    deposito.servicio_id%TYPE;

begin
	select seq_deposito.nextval into v_deposito_id from dual;
	v_importe := :new.cargo + :new.comision;
	v_servicio_id := :new.servicio_id;
	select clabe into v_clabe from provedor.seguridad where provedor_id=(select provedor_id from servicio where servicio_id=v_servicio_id);
	select nombre into v_banco from provedor.banco where banco_id=(select banco_id from provedor.provedor where provedor_id=(select provedor_id from servicio where servicio_id=v_servicio_id));

	insert into deposito (deposito_id,importe,clabe,banco,servicio_id)
	values (v_deposito_id,v_importe,v_clabe,v_banco,v_servicio_id);

end;
/ 
show errors 

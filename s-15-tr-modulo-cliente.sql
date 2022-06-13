--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Triggers para el modulo cliente


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


-- Insert servicios

-- secuencia par allave primara de la tabla servicio
create sequence seq_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

declare
v_seq_servicio        servicio.servicio_id%TYPE;
v_fecha_servicio      servicio.fecha_servicio%TYPE;
v_requerimientos      servicio.requerimientos%TYPE;
v_cliente_id          servicio.cliente_id%TYPE;
v_tipo_servicio_id    servicio.tipo_servicio_id%TYPE;
v_status_servicio_id  servicio.status_servicio_id%TYPE;
v_provedor_id         servicio.provedor_id%TYPE;

begin
	for i in 1..2 loop
		select seq_servicio.nextval into v_seq_servicio from dual;
		select sysdate+round(dbms_random.value(5,30)) into v_fecha_servicio from dual;
		select dbms_random.string('L', 1000) into v_requerimientos from dual;
		select cliente_id into v_cliente_id from (select cliente_id from cliente order by dbms_random.value) where rownum =1;
		select provedor_id into v_provedor_id from (select provedor_id from provedor.provedor order by dbms_random.value) where rownum =1;
		select tipo_servicio_id into v_tipo_servicio_id from (select tipo_servicio_id from provedor.provedor_servicio where provedor_id=v_provedor_id order by dbms_random.value) where rownum =1;
		v_status_servicio_id := 1;

		insert into servicio (servicio_id,fecha_servicio,requerimientos,cliente_id,tipo_servicio_id,status_servicio_id,provedor_id)
		values (v_seq_servicio,v_fecha_servicio,v_requerimientos,v_cliente_id,v_tipo_servicio_id,v_status_servicio_id,v_provedor_id);
	end loop;
end;
/ 



-- secuencia para llave primara de la tabla cobro_servicio
create sequence seq_cobro_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- Updates de Servicio
declare
v_servicio_id             servicio.servicio_id%TYPE;
v_status_servicio_id      servicio.status_servicio_id%TYPE;
v_precio                  servicio.precio%TYPE;
v_instrucciones_provedor  servicio.instrucciones_provedor%TYPE;
v_mensualidades           servicio.mensualidades%TYPE;

v_cobro_servicio_id  cobro_servicio.cobro_servicio_id%TYPE;
v_num_pago           cobro_servicio.num_pago%TYPE;
v_cargo              cobro_servicio.cargo%TYPE;
v_comision           cobro_servicio.comision%TYPE;
v_servicio           cobro_servicio.servicio%TYPE;
v_fecha_pago         cobro_servicio.fecha_pago%TYPE;

begin
	for i in 1..5 loop
		select servicio_id into v_servicio_id from (select servicio_id from servicio order by dbms_random.value) where rownum =1;
		select status_servicio_id into v_status_servicio_id from servicio where servicio_id=v_servicio_id;

		if (v_status_servicio_id=1) then
			v_precio := round(dbms_random.value(500,99999));
			v_instrucciones_provedor := dbms_random.string('L', 100);
			v_mensualidades := round(dbms_random.value(1,5));

			update servicio set status_servicio_id = v_status_servicio_id+1, precio = v_precio, instrucciones_provedor=v_instrucciones_provedor, mensualidades=v_mensualidades
			where servicio_id = v_servicio_id;


			select v_precio/v_mensualidades into v_cargo from dual;
			select v_cargo*15/100 into v_comision from dual;
			select nombre into v_servicio from provedor.tipo_servicio where tipo_servicio_id = (select tipo_servicio_id from servicio where servicio_id = 3);

			for i in 1..v_mensualidades loop
				select seq_cobro_servicio.nextval into v_cobro_servicio_id from dual;
				v_num_pago := i;
				select fecha_servicio+round(dbms_random.value(0,30*i),0) into v_fecha_pago from servicio where servicio_id = v_servicio_id;

				insert into cobro_servicio (cobro_servicio_id,num_pago,cargo,comision,servicio,fecha_pago,servicio_id)
				values (v_cobro_servicio_id, v_num_pago, v_cargo, v_comision, v_servicio, v_fecha_pago, v_servicio_id);
			end loop;

		elsif (v_status_servicio_id >1 and v_status_servicio_id<5) then
			update servicio set status_servicio_id = v_status_servicio_id+1
			where servicio_id = v_servicio_id;

		end if;
	end loop;
end;
/ 


-- secuencia para llave primara de la tabla deposito
create sequence seq_deposito
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

-- trigger para cuando se actualiza el status del servicio
-- Tabla: PROVEDOR, 
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

--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 12/06/2022
--@Descripción: Carga de datos de servicios

whenever sqlerror exit rollback;
connect cliente/cliente

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

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
	for i in 1..5 loop
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


-- Updates de Servicio

-- secuencia para llave primara de la tabla cobro_servicio
create sequence seq_cobro_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    order
;

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
	for i in 1..15 loop
		select servicio_id into v_servicio_id from (select servicio_id from servicio order by dbms_random.value) where rownum =1;
		select status_servicio_id into v_status_servicio_id from servicio where servicio_id=v_servicio_id;

		if (v_status_servicio_id=1) then
			v_precio := round(dbms_random.value(500,99999));
			v_instrucciones_provedor := dbms_random.string('L', 100);
			v_mensualidades := round(dbms_random.value(1,5));

			update servicio set status_servicio_id = v_status_servicio_id+1, precio = v_precio, instrucciones_provedor=v_instrucciones_provedor, mensualidades=v_mensualidades
			where servicio_id = v_servicio_id;


			select v_precio/v_mensualidades into v_cargo from dual;
			select round(v_cargo*15/100) into v_comision from dual;
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

commit;
--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 13/06/2022
--@Descripción: Generacion de datos redo

whenever sqlerror exit rollback;
connect cliente/cliente

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

-- provedores



-- clientes








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
	for i in 1..1500 loop
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

commit;
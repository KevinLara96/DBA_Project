--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 08/05/2022
--@Descripción: Triggers para el modulo cliente


-- Secuencia para la llave primaria de la tabla historico_status_servicio
create sequence seq_historico_status_servicio
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    noorder
;

-- Trigger para el almacenamiento del historico del status del provedor
-- tabla: historico_status_servicio
create or replace trigger tr_historico_status_servicio
	after insert or update of status_servicio_id
	on servicio
	for each row
declare
v_seq_hist number(7);
v_fecha_status date;
v_status_servicio_id number(1);
v_servicio_id number(7);

begin
	select seq_historico_status_servicio.nextval into v_seq_hist from dual;
	case
		when inserting then
			v_fecha_status:= sysdate;
			v_status_servicio_id := :new.status_provedor_id
			v_servicio_id := :new.prvedor_id;

			insert into historico_status_servicio (historico_status_servicio_id, fecha_status, status_servicio_id, servicio_id)
			values (v_seq_hist, v_fecha_status, v_status_servicio_id, v_servicio_id);

		when updating('status_servicio_id') then
			v_fecha_status:= sysdate;
			v_status_servicio_id := :new.status_provedor_id
			v_servicio_id := :new.prvedor_id;

			insert into historico_status_servicio (historico_status_servicio_id, fecha_status, status_servicio_id, servicio_id)
			values (v_seq_hist, v_fecha_status, v_status_servicio_id, v_servicio_id);
	end case;
end;
/ 
show errors 
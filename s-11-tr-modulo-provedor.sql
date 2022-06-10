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
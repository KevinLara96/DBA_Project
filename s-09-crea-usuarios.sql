--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 09/05/2022
--@Descripción: Creacion de usuarios

whenever sqlerror exit rollback;
connect sys/system3 as sysdba

-- Creacion del usuario del modulo Provedor
declare
v_count number;
v_username varchar2(20) := 'PROVEDOR';

begin
	select count(*) into v_count from all_users where username=v_username;
	if v_count >0 then
		execute immediate 'drop user '||v_username|| ' cascade';
	end if;
end;
/
Prompt creando al usuario PROVEDOR
create user provedor identified by provedor 
quota unlimited on ts_provedor
quota unlimited on ts_p_docs_fotos
quota unlimited on ts_p_indices
quota unlimited on ts_p_foto_servicio
default tablespace ts_provedor;

grant create session, create table, create sequence, create trigger, create procedure to provedor;


-- Creacion del usuario del modulo Cliente
declare
v_count number;
v_username varchar2(20) := 'CLIENTE';

begin
	select count(*) into v_count from all_users where username=v_username;
	if v_count >0 then
		execute immediate 'drop user '||v_username|| ' cascade';
	end if;
end;
/
Prompt creando al usuario CLIENTE
create user cliente identified by cliente
quota unlimited on ts_cliente
quota unlimited on ts_c_docs_fotos
quota unlimited on ts_c_indices
default tablespace ts_cliente;

grant create session, create table, create sequence, create trigger, create procedure to cliente;


-- Desbloqueo del usuario SYSBACKUP

alter user sysbackup account unlock;


-- Creacion de directorio donde estan las foto y dcumentos

create or replace directory dir_fotos_docs as '/unam-bda/pf-docs-fotos';
grant read,write on directory dir_fotos_docs to provedor;
grant read,write on directory dir_fotos_docs to cliente;
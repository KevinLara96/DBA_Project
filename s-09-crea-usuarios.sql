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


-- Creacion del usuario SYSBACKUP
declare
v_count number;
v_username varchar2(20) := 'SYSBACKUP';

begin
select count(*) into v_count from all_users where username=v_username;
if v_count >0 then
execute immediate 'drop user '||v_username|| ' cascade';
end if;
end;
/
Prompt creando al usuario SYSBACKUP
create user sysbackup identified by system3
quota unlimited on xxxxx;

grant create session, sysbackup to sysbackup;
--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 12/06/2022
--@Descripción: Carga de datos de clientes

whenever sqlerror exit rollback;
connect cliente/cliente

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

insert into CLIENTE (cliente_id, usuario, password, email, telefono, direccion, tipo) values (1, 'Voltsillam', 'Lergan', 'alergan0@mediafire.com', '5949589342', '55994 Jackson Street', 0);
insert into CLIENTE (cliente_id, usuario, password, email, telefono, direccion, tipo) values (2, 'Viva', 'Knudsen', 'wknudsen1@over-blog.com', '4063972187', '6 Hayes Terrace', 1);
insert into CLIENTE (cliente_id, usuario, password, email, telefono, direccion, tipo) values (3, 'Tin', 'Sealove', 'isealove2@ucoz.com', '1769510009', '8 Myrtle Center', 1);
insert into CLIENTE (cliente_id, usuario, password, email, telefono, direccion, tipo) values (4, 'Kanlam', 'Ivanichev', 'vivanichev3@exblog.jp', '5321638454', '86795 Rieder Avenue', 0);
insert into CLIENTE (cliente_id, usuario, password, email, telefono, direccion, tipo) values (5, 'Biodex', 'Paulley', 'kpaulley4@amazon.com', '0828259178', '15 Arkansas Parkway', 0);

commit;

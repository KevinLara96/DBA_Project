--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 10/05/2022
--@Descripción: Script para crear las tablas de Cliente

whenever sqlerror exit rollback;
connect cliente/cliente

-- 
-- TABLE: CLIENTE 
--

CREATE TABLE CLIENTE(
    CLIENTE_ID        NUMBER(5, 0)    NOT NULL,
    USUARIO           VARCHAR2(20)    NOT NULL,
    PASSWORD          VARCHAR2(15)    NOT NULL,
    EMAIL             VARCHAR2(40)    NOT NULL,
    TELEFONO          VARCHAR2(10)    NOT NULL,
    DIRECCION         VARCHAR2(70)    NOT NULL,
    FECHA_REGISTRO    DATE            DEFAULT SYSDATE,
    TIPO              CHAR(1)         NOT NULL,
    CONSTRAINT CLIENTE_PK PRIMARY KEY (CLIENTE_ID)
    USING INDEX (
        CREATE UNIQUE INDEX CLIENTE_PK ON CLIENTE(CLIENTE_ID)
        TABLESPACE ts_p_indices
    ),
    CONSTRAINT CLIENTE_TIPO_CHK CHECK(TIPO IN ('0','1'))
) TABLESPACE ts_cliente
;



-- 
-- TABLE: STATUS_SERVICIO 
--

CREATE TABLE STATUS_SERVICIO(
    STATUS_SERVICIO_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE_STATUS         VARCHAR2(12)    NOT NULL,
    CONSTRAINT STATUS_SERVICIO_PK PRIMARY KEY (STATUS_SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX STATUS_SERVICIO_PK ON STATUS_SERVICIO(STATUS_SERVICIO_ID)
        TABLESPACE ts_c_indices
    ),
    CONSTRAINT STATUS_SERVICIO_NOMBRE_CHK CHECK (NOMBRE_STATUS IN 
    ('registrado','aceptado','en ejecucion','por pagar', 'pagado'))
) TABLESPACE ts_cliente
;



-- 
-- TABLE: SERVICIO 
--

CREATE TABLE SERVICIO(
    SERVICIO_ID               NUMBER(7, 0)      NOT NULL,
    FECHA_SERVICIO            DATE              NOT NULL,
    FECHA_STATUS              DATE              DEFAULT SYSDATE,
    REQUERIMIENTOS            VARCHAR2(1000)    NOT NULL,
    REQUERIMIENTOS_PDF        BLOB,
    PRECIO                    NUMBER(5, 0),
    INSTRUCCIONES_PROVEDOR    VARCHAR2(100),
    MENSUALIDADES             NUMBER(2, 0),
    CLIENTE_ID                NUMBER(5, 0)      NOT NULL,
    TIPO_SERVICIO_ID          NUMBER(1, 0)      NOT NULL,
    STATUS_SERVICIO_ID        NUMBER(1, 0)      NOT NULL,
    PROVEDOR_ID               NUMBER(5, 0)      NOT NULL,
    CONSTRAINT SERVICIO_PK PRIMARY KEY (SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX SERVICIO_PK ON SERVICIO(SERVICIO_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT SERVICIO_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT SERVICIO_TIPO_SERVICIO_ID_FK FOREIGN KEY (TIPO_SERVICIO_ID)
    REFERENCES PROVEDOR.TIPO_SERVICIO(TIPO_SERVICIO_ID),
    CONSTRAINT SERVICIO_STATUS_SERVICIO_ID_FK FOREIGN KEY (STATUS_SERVICIO_ID)
    REFERENCES STATUS_SERVICIO(STATUS_SERVICIO_ID),
    CONSTRAINT SERVICIO_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR.PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_cliente
    LOB (REQUERIMIENTOS_PDF) STORE AS SECUREFILE SERVICIO_REQUERIMIENTOS_PDF_LOB (
        TABLESPACE ts_c_docs_fotos INDEX SERVICIO_REQUERIMIENTOS_PDF_IX (TABLESPACE ts_c_indices)
    )
;



-- 
-- TABLE: CALIFICACION 
--

CREATE TABLE CALIFICACION(
    CALIFICACION_ID    NUMBER(6, 0)    NOT NULL,
    ESTRELLAS          NUMBER(1, 0)    NOT NULL,
    COMETARIO          VARCHAR2(150)   NOT NULL,
    CLIENTE_ID         NUMBER(5, 0)    NOT NULL,
    SERVICIO_ID        NUMBER(7, 0)    NOT NULL,
    CONSTRAINT CALIFICACION_PK PRIMARY KEY (CALIFICACION_ID)
    USING INDEX (
        CREATE UNIQUE INDEX CALIFICACION_PK ON CALIFICACION(CALIFICACION_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT CALIFICACION_ESTRELLAS_CHK CHECK (ESTRELLAS IN (0,1,2,3,4,5)),
    CONSTRAINT CALIFICACION_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT CALIFICACION_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID)
    REFERENCES SERVICIO(SERVICIO_ID)
) TABLESPACE ts_cliente
;



-- 
-- TABLE: COBRO_SERVICIO 
--

CREATE TABLE COBRO_SERVICIO(
    COBRO_SERVICIO_ID    NUMBER(6, 0)    NOT NULL,
    NUM_PAGO             NUMBER(2, 0)    NOT NULL,
    CARGO                NUMBER(6, 0)    NOT NULL,
    COMISION             NUMBER(4, 0)    NOT NULL,
    SERVICIO             VARCHAR2(15)    NOT NULL,
    FECHA_PAGO           DATE            NOT NULL,
    SERVICIO_ID          NUMBER(7, 0)    NOT NULL,
    CONSTRAINT COBRO_SERVICIO_PK PRIMARY KEY (COBRO_SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX COBRO_SERVICIO_PK ON COBRO_SERVICIO(COBRO_SERVICIO_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT COBRO_SERVICIO_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID)
    REFERENCES SERVICIO(SERVICIO_ID)
) TABLESPACE ts_cliente
;



-- 
-- TABLE: DEPOSITO 
--

CREATE TABLE DEPOSITO(
    DEPOSITO_ID         NUMBER(5, 0)    NOT NULL,
    IMPORTE             NUMBER(5, 0)    NOT NULL,
    FECHA_PAGO          DATE            DEFAULT SYSDATE,
    CLABE               VARCHAR2(18)    NOT NULL,
    BANCO               VARCHAR2(10)    NOT NULL,
    COMPROBANTE_PAGO    BLOB,
    SERVICIO_ID         NUMBER(7, 0)    NOT NULL,
    CONSTRAINT DEPOSITO_PK PRIMARY KEY (DEPOSITO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DEPOSITO_PK ON DEPOSITO(DEPOSITO_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT DEPOSITO_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID)
    REFERENCES SERVICIO(SERVICIO_ID)
) TABLESPACE ts_cliente
    LOB (COMPROBANTE_PAGO) STORE AS SECUREFILE DEPOSITO_COMPROBANTE_PAGO_LOB (
        TABLESPACE ts_c_docs_fotos INDEX DEPOSITO_COMPROBANTE_PAGO_IX (TABLESPACE ts_c_indices)
    )
;



-- 
-- TABLE: EMPRESA 
--

CREATE TABLE EMPRESA(
    CLIENTE_ID             NUMBER(5, 0)    NOT NULL,
    NOMBRE_EMPRESA         VARCHAR2(30)    NOT NULL,
    DESCRIPCION_EMPRESA    VARCHAR2(200)    NOT NULL,
    LOGO_EMPRESA           BLOB,
    EMPLEADOS_APROX        NUMBER(6, 0)    NOT NULL,
    CONSTRAINT EMPRESA_PK PRIMARY KEY (CLIENTE_ID)
    USING INDEX (
        CREATE UNIQUE INDEX EMPRESA_PK ON EMPRESA(CLIENTE_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT EMPRESA_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID) ON DELETE CASCADE
) TABLESPACE ts_cliente
    LOB (LOGO_EMPRESA) STORE AS SECUREFILE EMPRESA_LOGO_EMPRESA_LOB (
        TABLESPACE ts_c_docs_fotos INDEX EMPRESA_LOGO_EMPRESA_IX (TABLESPACE ts_c_indices)
    )
;



-- 
-- TABLE: HISTORICO_STATUS_SERVICIO 
--

CREATE TABLE HISTORICO_STATUS_SERVICIO(
    HISTORICO_STATUS_SERVICIO_ID    NUMBER(7, 0)    NOT NULL,
    FECHA_STATUS                    DATE            NOT NULL,
    STATUS_SERVICIO_ID              NUMBER(1, 0)    NOT NULL,
    SERVICIO_ID                     NUMBER(7, 0)    NOT NULL,
    CONSTRAINT HISTORICO_STATUS_SERVICIO_PK PRIMARY KEY (HISTORICO_STATUS_SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX HISTORICO_STATUS_SERVICIO_PK ON HISTORICO_STATUS_SERVICIO(HISTORICO_STATUS_SERVICIO_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT HISTORICO_STATUS_SERVICIO_STATUS_SERVICIO_ID_FK FOREIGN KEY (STATUS_SERVICIO_ID)
    REFERENCES STATUS_SERVICIO(STATUS_SERVICIO_ID),
    CONSTRAINT HISTORICO_STATUS_SERVICIOSERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID)
    REFERENCES SERVICIO(SERVICIO_ID)
) TABLESPACE ts_cliente
;



-- 
-- TABLE: PERSONA 
--

CREATE TABLE PERSONA(
    CLIENTE_ID          NUMBER(5, 0)    NOT NULL,
    FOTO_PERSONA        BLOB,
    CURP                CHAR(18)        NOT NULL,
    FECHA_NACIMIENTO    DATE            NOT NULL,
    CONSTRAINT PERSONA_PK PRIMARY KEY (CLIENTE_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PERSONA_PK ON PERSONA(CLIENTE_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT PERSONA_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID) ON DELETE CASCADE
) TABLESPACE ts_cliente
    LOB (FOTO_PERSONA) STORE AS SECUREFILE PERSONA_FOTO_PERSONA_LOB (
        TABLESPACE ts_c_docs_fotos INDEX PERSONA_FOTO_PERSONA_IX (TABLESPACE ts_c_indices)
    )
;



-- 
-- TABLE: TARJETA 
--

CREATE TABLE TARJETA(
    TARJETA_ID    NUMBER(5, 0)    NOT NULL,
    SALDO         NUMBER(7, 0)    NOT NULL,
    CLIENTE_ID    NUMBER(5, 0)    NOT NULL,
    CONSTRAINT TARJETA_PK PRIMARY KEY (TARJETA_ID)
    USING INDEX (
        CREATE UNIQUE INDEX TARJETA_PK ON TARJETA(TARJETA_ID)
        TABLESPACE ts_c_indices
    ), 
    CONSTRAINT TARJETA_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID)
) TABLESPACE ts_cliente
;
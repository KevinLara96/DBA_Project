--@Autor: Lara Sala Kevin Arturo y Miranda Cortes Yak Balam
--@Fecha creación: 10/05/2022
--@Descripción: Script para crear las tablas de Cliente

CREATE TABLE BANCO(
    BANCO_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE      VARCHAR2(10)    NOT NULL,
    CONSTRAINT BANCO_PK PRIMARY KEY (BANCO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX BANCO_PK ON BANCO(BANCO_ID)
        TABLESPACE ts_p_indices
    )
) TABLESPACE ts_provedor
;



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
    FECHA_REGISTRO    DATE            NOT NULL,
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
-- TABLE: TIPO_SERVICIO 
--

CREATE TABLE TIPO_SERVICIO(
    TIPO_SERVICIO_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE              VARCHAR2(15)    NOT NULL,
    DESCRIPCION         VARCHAR2(100)    NOT NULL,
    CONSTRAINT TIPO_SERVICIO_PK PRIMARY KEY (TIPO_SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX TIPO_SERVICIO_PK ON TIPO_SERVICIO(TIPO_SERVICIO_ID)
        TABLESPACE ts_p_indices
    )
) TABLESPACE ts_provedor
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
-- TABLE: STATUS_PROVEDOR 
--

CREATE TABLE STATUS_PROVEDOR(
    STATUS_PROVEDOR_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE_STATUS         VARCHAR2(13)    NOT NULL,
    CONSTRAINT STATUS_PROVEDOR_PK PRIMARY KEY (STATUS_PROVEDOR_ID)
    USING INDEX (
        CREATE UNIQUE INDEX STATUS_PROVEDOR_PK ON STATUS_PROVEDOR(STATUS_PROVEDOR_ID)
        TABLESPACE ts_p_indices
    ),
    CONSTRAINT STATUS_PROVEDOR_NOMBRE_STATUS_CHK CHECK (NOMBRE_STATUS IN 
    ('en validacion','en servicio','suspendido','expulsado','inactivo'))
) TABLESPACE ts_provedor
;



-- 
-- TABLE: NIVEL_ESTUDIO 
--

CREATE TABLE NIVEL_ESTUDIO(
    NIVEL_ESTUDIO_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE_NIVEL        VARCHAR2(15)    NOT NULL,
    CONSTRAINT NIVEL_ESTUDIO_PK PRIMARY KEY (NIVEL_ESTUDIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX NIVEL_ESTUDIO_PK ON NIVEL_ESTUDIO(NIVEL_ESTUDIO_ID)
        TABLESPACE ts_p_indices
    ),
    CONSTRAINT NIVEL_ESTUDIO_NOMBRE CHECK (NOMBRE_NIVEL IN 
    ('primaria','secundaria','bachillerato','licenciatura','maestria','doctorado'))
) TABLESPACE ts_provedor
;



-- 
-- TABLE: PROVEDOR 
--

CREATE TABLE PROVEDOR(
    PROVEDOR_ID           NUMBER(5, 0)    NOT NULL,
    NOMBRE                VARCHAR2(30)    NOT NULL,
    APELLIDO              VARCHAR2(30)    NOT NULL,
    FOTO                  BLOB,
    FECHA_NACIMIENTO      DATE            NOT NULL,
    FECHA_STATUS          DATE            NOT NULL,
    LUGAR_NACIMIENTO      VARCHAR2(30)    NOT NULL,
    DIRECCION             VARCHAR2(70)    NOT NULL,
    STATUS_PROVEDOR_ID    NUMBER(1, 0)    NOT NULL,
    NIVEL_ESTUDIO_ID      NUMBER(1, 0)    NOT NULL,
    BANCO_ID              NUMBER(1, 0)    NOT NULL,
    CONSTRAINT PROVEDOR_PK PRIMARY KEY (PROVEDOR_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVEDOR_PK ON PROVEDOR(PROVEDOR_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT PROVEDOR_BANCO_ID_FK FOREIGN KEY (BANCO_ID)
    REFERENCES BANCO(BANCO_ID),
    CONSTRAINT PROVEDOR_STATUS_PROVEDOR_ID_FK FOREIGN KEY (STATUS_PROVEDOR_ID)
    REFERENCES STATUS_PROVEDOR(STATUS_PROVEDOR_ID),
    CONSTRAINT PROVEDOR_NIVEL_ESTUDIO_ID_FK FOREIGN KEY (NIVEL_ESTUDIO_ID)
    REFERENCES NIVEL_ESTUDIO(NIVEL_ESTUDIO_ID)
) TABLESPACE ts_provedor
    LOB (FOTO) STORE AS SECUREFILE PROVEDOR_FOTO_LOB (
        TABLESPACE ts_p_docs_fotos INDEX PROVEDOR_FOTO_IX (TABLESPACE ts_p_indices)
    )
;



-- 
-- TABLE: SERVICIO 
--

CREATE TABLE SERVICIO(
    SERVICIO_ID               NUMBER(7, 0)      NOT NULL,
    FECHA_SERVICIO            DATE              NOT NULL,
    FECHA_STATUS              DATE              NOT NULL,
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
    REFERENCES TIPO_SERVICIO(TIPO_SERVICIO_ID),
    CONSTRAINT SERVICIO_STATUS_SERVICIO_ID_FK FOREIGN KEY (STATUS_SERVICIO_ID)
    REFERENCES STATUS_SERVICIO(STATUS_SERVICIO_ID),
    CONSTRAINT SERVICIO_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
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
    FECHA_PAGO          DATE            NOT NULL,
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
) ts_cliente
    LOB (LOGO_EMPRESA) STORE AS SECUREFILE EMPRESA_LOGO_EMPRESA_LOB (
        TABLESPACE ts_c_docs_fotos INDEX EMPRESA_LOGO_EMPRESA_IX (TABLESPACE ts_c_indices)
    )
;



-- 
-- TABLE: HISTORICO_PROVEDOR_STATUS 
--

CREATE TABLE HISTORICO_PROVEDOR_STATUS(
    HISTORICO_PROVEDOR_STATUS_ID    NUMBER(6, 0)    NOT NULL,
    FECHA_STATUS                    DATE            NOT NULL,
    STATUS_PROVEDOR_ID              NUMBER(1, 0)    NOT NULL,
    PROVEDOR_ID                     NUMBER(5, 0)    NOT NULL,
    CONSTRAINT HISTORICO_PROVEDOR_STATUS_PK PRIMARY KEY (HISTORICO_PROVEDOR_STATUS_ID)
    USING INDEX (
        CREATE UNIQUE INDEX HISTORICO_PROVEDOR_STATUS_PK ON HISTORICO_PROVEDOR_STATUS(HISTORICO_PROVEDOR_STATUS_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT HISTORICO_PROVEDOR_STATUS_STATUS_PROVEDOR_ID_FK FOREIGN KEY (STATUS_PROVEDOR_ID)
    REFERENCES STATUS_PROVEDOR(STATUS_PROVEDOR_ID),
    CONSTRAINT HISTORICO_PROVEDOR_STATUS_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_provedor
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
-- TABLE: PROVEDOR_SERVICIO 
--

CREATE TABLE PROVEDOR_SERVICIO(
    PROVEDOR_SERVICIO_ID    NUMBER(6, 0)    NOT NULL,
    ANIO_EXPERIENCIA        NUMBER(2, 0)    NOT NULL,
    TIPO_SERVICIO_ID        NUMBER(1, 0)    NOT NULL,
    PROVEDOR_ID             NUMBER(5, 0)    NOT NULL,
    CONSTRAINT PROVEDOR_SERVICIO_PK PRIMARY KEY (PROVEDOR_SERVICIO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVEDOR_SERVICIO_PK ON PROVEDOR_SERVICIO(PROVEDOR_SERVICIO_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT PROVEDOR_SERVICIO_TIPO_SERVICIO_ID_FK FOREIGN KEY (TIPO_SERVICIO_ID)
    REFERENCES TIPO_SERVICIO(TIPO_SERVICIO_ID),
    CONSTRAINT PROVEDOR_SERVICIO_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_provedor
;



-- 
-- TABLE: PROV_SERVICIO_COMPROBANTE 
--

CREATE TABLE PROV_SERVICIO_COMPROBANTE(
    PROV_SERVICIO_COMPROBANTE_ID    NUMBER(6, 0)    NOT NULL,
    COMPROBANTE                     BLOB,
    PROVEDOR_SERVICIO_ID            NUMBER(6, 0)    NOT NULL,
    CONSTRAINT PROV_SERVICIO_COMPROBANTE_PK PRIMARY KEY (PROV_SERVICIO_COMPROBANTE_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROV_SERVICIO_COMPROBANTE_PK ON PROV_SERVICIO_COMPROBANTE(PROV_SERVICIO_COMPROBANTE_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT PROV_SERVICIO_COMPROBANTE_PROVEDOR_SERVICIO_ID_FK FOREIGN KEY (PROVEDOR_SERVICIO_ID)
    REFERENCES PROVEDOR_SERVICIO(PROVEDOR_SERVICIO_ID)
) TABLESPACE ts_provedor
    LOB (COMPROBANTE) STORE AS SECUREFILE PROV_SERVICIO_COMPROBANTE_PDF_LOB (
        TABLESPACE ts_p_docs_fotos INDEX PROV_SERVICIO_COMPROBANTE_PDF_IX (TABLESPACE ts_p_indices)
    )
;



-- 
-- TABLE: PROVEDOR_EMAIL 
--

CREATE TABLE PROVEDOR_EMAIL(
    PROVEDOR_EMAIL_ID    NUMBER(5, 0)    NOT NULL,
    EMAIL                VARCHAR2(40)    NOT NULL,
    PROVEDOR_ID          NUMBER(5, 0)    NOT NULL,
    CONSTRAINT PROVEDOR_EMAIL_PK PRIMARY KEY (PROVEDOR_EMAIL_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVEDOR_EMAIL_PK ON PROVEDOR_EMAIL(PROVEDOR_EMAIL_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT PROVEDOR_EMAIL_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_provedor
;



-- 
-- TABLE: TELEFONO_TIPO 
--

CREATE TABLE TELEFONO_TIPO(
    TELEFONO_TIPO_ID    NUMBER(1, 0)    NOT NULL,
    NOMBRE_TIPO         VARCHAR2(7)     NOT NULL,
    CONSTRAINT TELEFONO_TIPO_PK PRIMARY KEY (TELEFONO_TIPO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX TELEFONO_TIPO_PK ON TELEFONO_TIPO(TELEFONO_TIPO_ID)
        TABLESPACE ts_p_indices
    ),
    CONSTRAINT TELEFONO_TIPO_NOMBRE_CHK CHECK (NOMBRE_TIPO IN ('fijo','celular'))
) TABLESPACE ts_provedor
;



-- 
-- TABLE: PROVEDOR_TELEFONO 
--

CREATE TABLE PROVEDOR_TELEFONO(
    PROVEDOR_TELEFONO_ID    NUMBER(6, 0)    NOT NULL,
    TELEFONO                VARCHAR2(10)    NOT NULL,
    PROVEDOR_ID             NUMBER(5, 0)    NOT NULL,
    TELEFONO_TIPO_ID        NUMBER(1, 0)    NOT NULL,
    CONSTRAINT PROVEDOR_TELEFONO_PK PRIMARY KEY (PROVEDOR_TELEFONO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVEDOR_TELEFONO_PK ON PROVEDOR_TELEFONO(PROVEDOR_TELEFONO_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT PROVEDOR_TELEFONO_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID),
    CONSTRAINT PROVEDOR_TELEFONO_TELEFONO_TIPO_ID_FK FOREIGN KEY (TELEFONO_TIPO_ID)
    REFERENCES TELEFONO_TIPO(TELEFONO_TIPO_ID)
) TABLESPACE ts_provedor
;



-- 
-- TABLE: SEGURIDAD 
--

CREATE TABLE SEGURIDAD(
    SEGURIDAD_ID             NUMBER(5, 0)    NOT NULL,
    IDENTIFICACION_PDF       BLOB,
    COMPROBANTE_DOMICILIO    BLOB,
    CLABE                    CHAR(18)        NOT NULL,
    PROVEDOR_ID              NUMBER(5, 0)    NOT NULL,
    CONSTRAINT SEGURIDAD_PK PRIMARY KEY (SEGURIDAD_ID)
    USING INDEX (
        CREATE UNIQUE INDEX SEGURIDAD_PK ON SEGURIDAD(SEGURIDAD_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT SEGURIDAD_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_provedor
    LOB (IDENTIFICACION_PDF) STORE AS SECUREFILE SEGURIDAD_IDENTIFICACION_PDF_LOB (
        TABLESPACE ts_p_docs_fotos INDEX SEGURIDAD_IDENTIFICACION_PDF_IX (TABLESPACE ts_p_indices)
    )
    LOB (COMPROBANTE_DOMICILIO) STORE AS SECUREFILE SEGURIDAD_COMPROBANTE_DOMICILIO_LOB (
        TABLESPACE ts_p_docs_fotos INDEX SEGURIDAD_COMPROBANTE_DOMICILIO_IX (TABLESPACE ts_p_indices)
    )
;



-- 
-- TABLE: SERVICIO_PROVEDOR_REALIZADO 
--

CREATE TABLE SERVICIO_PROVEDOR_REALIZADO(
    SERVICIO_PROVEDOR_REALIZADO_ID    NUMBER(7, 0)    NOT NULL,
    DESCRIPCION                       VARCHAR2(200)    NOT NULL,
    FECHA_SERVICIO                    DATE            NOT NULL,
    PROVEDOR_ID                       NUMBER(5, 0)    NOT NULL,
    CONSTRAINT SERVICIO_PROVEDOR_REALIZADO_PK PRIMARY KEY (SERVICIO_PROVEDOR_REALIZADO_ID)
    USING INDEX (
        CREATE UNIQUE INDEX SERVICIO_PROVEDOR_REALIZADO_PK ON SERVICIO_PROVEDOR_REALIZADO(SERVICIO_PROVEDOR_REALIZADO_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT SERVICIO_PROVEDOR_REALIZADO_PROVEDOR_ID_FK FOREIGN KEY (PROVEDOR_ID)
    REFERENCES PROVEDOR(PROVEDOR_ID)
) TABLESPACE ts_provedor
;



-- 
-- TABLE: SERVICIO_REALIZADO_IMAGEN 
--

CREATE TABLE SERVICIO_REALIZADO_IMAGEN(
    SERVICIO_REALIZADO_IMAGEN_ID      NUMBER(7, 0)     NOT NULL,
    SERVICIO_IMAGEN                   BLOB,
    DESCRIPCION_IMAGEN                VARCHAR2(500),
    SERVICIO_PROVEDOR_REALIZADO_ID    NUMBER(7, 0)     NOT NULL,
    CONSTRAINT SERVICIO_REALIZADO_IMAGEN_PK PRIMARY KEY (SERVICIO_REALIZADO_IMAGEN_ID)
    USING INDEX (
        CREATE UNIQUE INDEX SERVICIO_REALIZADO_IMAGEN_PK ON SERVICIO_REALIZADO_IMAGEN(SERVICIO_REALIZADO_IMAGEN_ID)
        TABLESPACE ts_p_indices
    ), 
    CONSTRAINT SERVICIO_REALIZADO_IMAGEN_SERVICIO_PROVEDOR_REALIZADO_ID_FK FOREIGN KEY (SERVICIO_PROVEDOR_REALIZADO_ID)
    REFERENCES SERVICIO_PROVEDOR_REALIZADO(SERVICIO_PROVEDOR_REALIZADO_ID)
) TABLESPACE ts_provedor
    LOB (SERVICIO_IMAGEN) STORE AS SECUREFILE SERVICIO_REALIZADO_IMAGEN_FOTO_LOB (
        TABLESPACE ts_p_foto_servicio INDEX SERVICIO_REALIZADO_IMAGEN_FOTO_IX (TABLESPACE ts_p_indices)
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
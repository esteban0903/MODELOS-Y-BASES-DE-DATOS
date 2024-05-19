---------------------------------------TABLAS---------------------------------------
CREATE TABLE CLIENTES(
idCliente VARCHAR(20) NOT NULL,
tidCliente VARCHAR(2) NOT NULL
);

CREATE TABLE SUSCRITOS(
clienteI VARCHAR(20) NOT NULL,
clienteT VARCHAR(2) NOT NULL,
nombreUsuario VARCHAR(50) NOT NULL,
metodoPago VARCHAR(2)NOT NULL,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL
);

CREATE TABLE RESERVAS(
clienteI VARCHAR(20) NOT NULL,
clienteT VARCHAR(2) NOT NULL,
idReserva VARCHAR(20) NOT NULL,
estado CHAR(1) NOT NULL
);

CREATE TABLE PROVEEDORES(
nombreP VARCHAR(100) NOT NULL,
clienteI VARCHAR(20) NOT NULL,
clienteT VARCHAR(2) NOT NULL,
catalogo VARCHAR(100) NOT NULL,
correoElectronico VARCHAR(100) NOT NULL
);

CREATE TABLE VENTAS(
articuloI VARCHAR(20) NOT NULL,
clienteI VARCHAR(20) NOT NULL,
clienteT VARCHAR(2) NOT NULL,
idCompra VARCHAR(20) NOT NULL,
metodoPago VARCHAR(2) NOT NULL,
total NUMBER NOT NULL,
fechaCompra DATE NOT NULL
);

CREATE TABLE ARTICULOS(
idArticulo VARCHAR(20) NOT NULL,
prestamoI VARCHAR(20),
genero VARCHAR(20),
descripcion VARCHAR(100) NOT NULL,
fechaPublicacion DATE,
nombreArticulo VARCHAR(100) NOT NULL
);

CREATE TABLE AUTORES(
articuloI VARCHAR(20) NOT NULL,
autor VARCHAR(100) NOT NULL
);

CREATE TABLE FISICOS(
articuloI VARCHAR(20) NOT NULL,
estado VARCHAR(100) NOT NULL,
disponible CHAR(1) NOT NULL
);

CREATE TABLE DIGITALES(
articuloI VARCHAR(20) NOT NULL,
formato VARCHAR(5) NOT NULL
);

CREATE TABLE PRESTAMOS(
clienteI VARCHAR(20) NOT NULL,
clienteT VARCHAR(2) NOT NULL,
idPrestamo VARCHAR(20) NOT NULL,
reservaI VARCHAR(20),
fechaEntrega DATE NOT NULL,
fechaDevolucionEstimada DATE NOT NULL
);

CREATE TABLE DEVOLUCIONES(
prestamoI VARCHAR(20) NOT NULL,
estado CHAR(1) NOT NULL,
fechaDevolucion DATE NOT NULL
);

CREATE TABLE FACTURAS(
prestamoI VARCHAR(20) NOT NULL,
idFactura VARCHAR(20) NOT NULL,
metodoPago VARCHAR(2) NOT NULL,
fecha DATE NOT NULL,
total NUMBER NOT NULL,
estado CHAR(1) NOT NULL
);

CREATE TABLE MULTAS(
facturaI VARCHAR(20) NOT NULL,
idMulta VARCHAR(20) NOT NULL,
monto NUMBER NOT NULL,
descripcion VARCHAR(100) NOT NULL
);

---------------------------------------ATRIBUTOS---------------------------------------
ALTER TABLE CLIENTES ADD CONSTRAINT CK_CLIENTES_tidCliente_Ttid CHECK (tidCliente in ('CC','TI','CE'));
ALTER TABLE PROVEEDORES ADD CONSTRAINT CK_PROVEEDORES_clienteT_Ttid CHECK (clienteT in ('CC','TI','CE'));
ALTER TABLE SUSCRITOS ADD CONSTRAINT CK_SUSCRITOS_clienteT_Ttid CHECK (clienteT in ('CC','TI','CE'));
ALTER TABLE PRESTAMOS ADD CONSTRAINT CK_PRESTAMOS_clienteT_Ttid CHECK (clienteT in ('CC','TI','CE'));
ALTER TABLE RESERVAS ADD CONSTRAINT CK_RESERVAS_clienteT_Ttid CHECK (clienteT in ('CC','TI','CE'));
ALTER TABLE VENTAS ADD CONSTRAINT CK_VENTAS_clienteT_Ttid CHECK (clienteT in ('CC','TI','CE'));

ALTER TABLE SUSCRITOS ADD CONSTRAINT CK_SUSCRITOS_metodoPago_TmetodoPago CHECK (metodoPago in ('T','E','C','TB'));
ALTER TABLE VENTAS ADD CONSTRAINT CK_VENTAS_metodoPago_TmetodoPago CHECK (metodoPago in ('T','E','C','TB'));
ALTER TABLE FACTURAS ADD CONSTRAINT CK_FACTURAS_metodoPago_TmetodoPago CHECK (metodoPago in ('T','E','C','TB'));

ALTER TABLE FISICOS ADD CONSTRAINT CK_FISICOS_disponible_Tbooleano CHECK (disponible in ('Y','N'));

ALTER TABLE DIGITALES ADD CONSTRAINT CK_DIGITALES_formato_Tformato CHECK (formato in ('PDF','EPUB','MOBI'));

ALTER TABLE RESERVAS ADD CONSTRAINT CK_RESERVAS_estado_Testado CHECK(estado in('A','D'));
ALTER TABLE DEVOLUCIONES ADD CONSTRAINT CK_DEVOLUCIONES_estado_Testado CHECK(estado in('A','D'));
ALTER TABLE FACTURAS ADD CONSTRAINT CK_FACTURAS_estado_Testado CHECK(estado in('A','D'));



---------------------------------------PRIMARY KEYS---------------------------------------

ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES
PRIMARY KEY(idCliente, tidCliente);

ALTER TABLE SUSCRITOS ADD CONSTRAINT PK_SUSCRITOS
PRIMARY KEY(ClienteI, ClienteT);

ALTER TABLE RESERVAS ADD CONSTRAINT PK_RESERVAS
PRIMARY KEY(idReserva);

ALTER TABLE PROVEEDORES ADD CONSTRAINT PK_PROVEEDORES
PRIMARY KEY(ClienteI, ClienteT);

ALTER TABLE VENTAS ADD CONSTRAINT PK_VENTAS
PRIMARY KEY(articuloI,ClienteI, ClienteT,idCompra);

ALTER TABLE ARTICULOS ADD CONSTRAINT PK_ARTICULOS
PRIMARY KEY(idArticulo);

ALTER TABLE AUTORES ADD CONSTRAINT PK_AUTORES
PRIMARY KEY(articuloI,autor);

ALTER TABLE FISICOS ADD CONSTRAINT PK_FISICOS
PRIMARY KEY(articuloI);

ALTER TABLE DIGITALES ADD CONSTRAINT PK_DIGITALES
PRIMARY KEY(articuloI);

ALTER TABLE PRESTAMOS ADD CONSTRAINT PK_PRESTAMOS
PRIMARY KEY(idPrestamo);

ALTER TABLE DEVOLUCIONES ADD CONSTRAINT PK_DEVOLUCIONES
PRIMARY KEY(PrestamoI);

ALTER TABLE FACTURAS ADD CONSTRAINT PK_FACTURAS
PRIMARY KEY(idFactura);

ALTER TABLE MULTAS ADD CONSTRAINT PK_MULTAS
PRIMARY KEY(idMulta);

---------------------------------------UNIQUE KEYS---------------------------------------

ALTER TABLE SUSCRITOS ADD CONSTRAINT UK_SUSCRITOS
UNIQUE(nombreUsuario);

ALTER TABLE PROVEEDORES ADD CONSTRAINT UK_PROVEEDORES
UNIQUE(correoElectronico);

---------------------------------------FOREIGN KEYS ---------------------------------------


ALTER TABLE PROVEEDORES ADD CONSTRAINT FK_PROVEEDORES_CLIENTES_clienteI_clienteT
FOREIGN KEY(clienteI,clienteT) REFERENCES CLIENTES(idCliente,tidCliente)
ON DELETE CASCADE;

ALTER TABLE VENTAS ADD CONSTRAINT FK_VENTAS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(idArticulo)
ON DELETE CASCADE;

ALTER TABLE VENTAS ADD CONSTRAINT FK_VENTAS_PROVEEDORES_clienteI_clienteT
FOREIGN KEY(clienteI,clienteT) REFERENCES PROVEEDORES(clienteI,clienteT)
ON DELETE CASCADE;

ALTER TABLE SUSCRITOS ADD CONSTRAINT FK_SUSCRITOS_CLIENTES_clienteI_clienteT
FOREIGN KEY(clienteI,clienteT) REFERENCES CLIENTES(idCliente,tidCliente)
ON DELETE CASCADE;

ALTER TABLE RESERVAS ADD CONSTRAINT FK_RESERVAS_SUSCRITOS_clienteI_clienteT
FOREIGN KEY(clienteI,clienteT) REFERENCES SUSCRITOS(clienteI,clienteT)
ON DELETE CASCADE;

ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_PRESTAMOS_prestamoI
FOREIGN KEY(prestamoI) REFERENCES PRESTAMOS(idPrestamo)
ON DELETE CASCADE; 

ALTER TABLE AUTORES ADD CONSTRAINT FK_AUTORES_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(idArticulo)
ON DELETE CASCADE; 

ALTER TABLE FISICOS ADD CONSTRAINT FK_FISICOS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(idArticulo)
ON DELETE CASCADE; 

ALTER TABLE DIGITALES ADD CONSTRAINT FK_DIGITALES_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(idArticulo)
ON DELETE CASCADE; 

ALTER TABLE PRESTAMOS ADD CONSTRAINT FK_PRESTAMOS_CLIENTES_clienteI_clienteT
FOREIGN KEY(clienteI,clienteT) REFERENCES CLIENTES(idCliente,tidCliente)
ON DELETE CASCADE;

ALTER TABLE PRESTAMOS ADD CONSTRAINT FK_PRESTAMOS_RESERVAS_reservaI
FOREIGN KEY(reservaI) REFERENCES RESERVAS(idReserva)
ON DELETE CASCADE;

ALTER TABLE DEVOLUCIONES ADD CONSTRAINT FK_DEVOLUCIONES_PRESTAMOS_prestamoI
FOREIGN KEY(prestamoI) REFERENCES PRESTAMOS(idPrestamo)
ON DELETE CASCADE; 

ALTER TABLE FACTURAS ADD CONSTRAINT FK_FACTURAS_PRESTAMOS_prestamoI
FOREIGN KEY(prestamoI) REFERENCES PRESTAMOS(idPrestamo)
ON DELETE CASCADE; 

ALTER TABLE MULTAS ADD CONSTRAINT FK_MULTAS_FACTURAS_facturaI
FOREIGN KEY(facturaI) REFERENCES FACTURAS(idFactura) 
ON DELETE CASCADE; 
----------------------------TUPLAS----------------------------
--Tipo Tcredencial---
CREATE OR REPLACE TRIGGER TR_SUSCRITOS_nombreUsuario
BEFORE INSERT ON SUSCRITOS
FOR EACH ROW
BEGIN
    :new.nombreUsuario := :new.nombre || '_' || :new.apellido || '_' || :new.clienteI;
END;
/
-- para poder analizar el trabajo tenemos que determinar el coeficiente de los tipos --


---La fecha de devolucion deberia ser menor a 21 dias ---
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA_DEVOLUCION
AFTER INSERT OR UPDATE ON PRESTAMOS
FOR EACH ROW
DECLARE
    v_diferencia_dias NUMBER;
BEGIN
    v_diferencia_dias := ABS(:NEW.fechaDevolucionEstimada - :NEW.fechaEntrega);
    
    IF v_diferencia_dias > 21 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de devolucion ser al menos 15 dias despues de haberlo entregado, y menos de 30 dias de haber sido entregado');
        
    END IF;
END;
/



---El total de la factura debe ser la suma de lo que ya existe mas el total de la multa---
CREATE OR REPLACE TRIGGER TR_FACTURAS_total
BEFORE INSERT OR UPDATE ON FACTURAS
FOR EACH ROW
DECLARE
    v_total_factura NUMBER;
BEGIN
    SELECT NVL(SUM(monto), 0) INTO v_total_factura FROM MULTAS WHERE facturaI = :NEW.idFactura;
    
    -- Solo actualiza el total si es una actualizacion y el campo total se ha modificado explicitamente.
    IF UPDATING('total') or INSERTING THEN
        :NEW.total := :NEW.total + v_total_factura;
    END IF;
END;
/
---La factura solo se puede modificar si esta en estado denegado---
CREATE OR REPLACE TRIGGER TR_FACTURAS_estado
BEFORE UPDATE ON FACTURAS
FOR EACH ROW
BEGIN
    IF :OLD.estado!='D' THEN
            RAISE_APPLICATION_ERROR(-20001,'Si el estado de la factura no es denegado, no se puede modificar'); 
    END IF;
END;
/

-- Nuevos Triggers --
-- La fecha de entrega se autogenera el dia en que se hace el prestamo 
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA_AUTO
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
BEGIN
    :NEW.fechaEntrega := SYSDATE;
END;
/

-- La fecha de entrega se autogenera cuando se hace el prestamo, por lo que no debe poder cambiar 
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA_ENTREGA_INMUTABLE
BEFORE UPDATE ON PRESTAMOS
FOR EACH ROW
BEGIN
    IF :NEW.fechaEntrega != :OLD.fechaEntrega THEN
        RAISE_APPLICATION_ERROR(-20000, 'La fecha de entrega se crea el dia del prestamo, es inmutable');
	END IF;
END;
/


-- La multa debe ser positiva --
CREATE OR REPLACE TRIGGER TR_MULTAS_VALOR_POSITIVO
BEFORE INSERT OR UPDATE ON MULTAS
FOR EACH ROW
BEGIN
    IF :NEW.monto < 0 THEN
        RAISE_APPLICATION_ERROR(-19999, 'Los valores de monto de una multa deben ser positivos');
    END IF;
END;
/

-- El total de la factura debe ser positivo --
CREATE OR REPLACE TRIGGER TR_FACTURAS_VALOR_POSITIVO
BEFORE INSERT OR UPDATE ON FACTURAS
FOR EACH ROW
BEGIN 
    IF :NEW.total < 0 THEN
        RAISE_APPLICATION_ERROR(-19998, 'Los valores de monto de una multa deben ser positivos');
    END IF;
END;
/

---------------------------- Automatizacion de indices con Disparadores----------------------------
-- Secuencias de automatizacion --
CREATE SEQUENCE secuencia_ventas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_articulos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_prestamos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_facturas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_clientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_reservas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_multas START WITH 1 INCREMENT BY 1;
-- Generar indices de idClientes en Clientes --
CREATE OR REPLACE TRIGGER TR_CLIENTES_generar_idCliente
BEFORE INSERT ON CLIENTES
FOR EACH ROW
BEGIN
    :new.idCliente := 'C'|| TO_CHAR(secuencia_clientes.NEXTVAL);
END;
/

-- Generar indices de idCompra en Ventas --
CREATE OR REPLACE TRIGGER TR_VENTAS_generar_idCompra
BEFORE INSERT ON VENTAS
FOR EACH ROW
BEGIN
    :new.idCompra := 'V'|| TO_CHAR(secuencia_ventas.NEXTVAL);
END;
/

-- Generar indices de idArticulo en Articulos --
CREATE OR REPLACE TRIGGER TR_ARTICULOS_generar_idArticulo
BEFORE INSERT ON ARTICULOS
FOR EACH ROW
BEGIN
    :new.idArticulo := 'A'||TO_CHAR(secuencia_articulos.NEXTVAL);
END;
/

-- Generar indices de idPrestamo en PRESTAMOS --
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_generar_idPrestamo
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
BEGIN
    :new.idPrestamo := 'P'|| TO_CHAR(secuencia_prestamos.NEXTVAL);
END;
/

-- Generar indices de idFacturas en FACTURAS --
CREATE OR REPLACE TRIGGER TR_FACTURAS_generar_idFactura
BEFORE INSERT ON FACTURAS
FOR EACH ROW
BEGIN
    :new.idFactura := 'F'|| TO_CHAR(secuencia_facturas.NEXTVAL);
END;
/
-- Generar indices de idReservas en RESERVAS --
CREATE OR REPLACE TRIGGER TR_RESERVAS_generar_idReserva
BEFORE INSERT ON RESERVAS
FOR EACH ROW
BEGIN
    :new.idReserva := 'R'|| TO_CHAR(secuencia_reservas.NEXTVAL);
END;
/
-- Generar indices de idMultas en MULTAS --
CREATE OR REPLACE TRIGGER TR_MULTAS_generar_idMulta
BEFORE INSERT ON MULTAS
FOR EACH ROW
BEGIN
    :new.idMulta := 'M'|| TO_CHAR(secuencia_multas.NEXTVAL);
END;
/
---------------------------- VISTAS ----------------------------
-- Solo consultar los clientes --
CREATE VIEW CLIENTES_SUSCRITOS AS SELECT nombre, apellido, clienteI, clienteT FROM SUSCRITOS;

-- Solo consultar las ventas --
CREATE VIEW COMPRAS AS 
SELECT PROVEEDORES.nombreP AS "PROVEEDORES",VENTAS.clienteI AS "ID PROVEEDOR", ARTICULOS.nombreArticulo AS "ARTICULO", VENTAS.articuloI AS "ID ARTICULO", VENTAS.total AS "TOTAL", VENTAS.fechaCompra 
FROM VENTAS 
JOIN ARTICULOS ON VENTAS.articuloI = ARTICULOS.idArticulo
JOIN PROVEEDORES ON PROVEEDORES.clienteI = VENTAS.clienteI AND PROVEEDORES.clienteT = VENTAS.clienteT;

-- Consultar las facturas de los clientes con multa --
CREATE VIEW FACTURAS_CON_MULTA AS 
SELECT SUSCRITOS.nombre, SUSCRITOS.apellido, FACTURAS.total AS "Total a Pagar", MULTAS.monto AS "Total de multa", MULTAS.idMulta
FROM FACTURAS 
JOIN PRESTAMOS ON FACTURAS.prestamoI = PRESTAMOS.idPrestamo 
JOIN SUSCRITOS ON SUSCRITOS.clienteI = PRESTAMOS.clienteI AND SUSCRITOS.clienteT = PRESTAMOS.clienteT 
JOIN MULTAS ON MULTAS.facturaI = FACTURAS.idFactura;
-- Articulos fisicos --
CREATE VIEW ARTICULOS_FISICOS AS SELECT * FROM ARTICULOS a JOIN FISICOS b ON a.idArticulo=b.articuloI;

-- Nombre del articulo, nombre de quien lo reservo, fecha de entrega, fecha estimada de devolucion --
CREATE VIEW ARTICULOS_EN_RESERVA AS
SELECT ARTICULOS.nombreArticulo AS "ARTICULO", SUSCRITOS.nombre, SUSCRITOS.apellido, PRESTAMOS.fechaEntrega, PRESTAMOS.fechaDevolucionEstimada AS "FECHA DEVOLUCION"
FROM RESERVAS
JOIN PRESTAMOS ON PRESTAMOS.reservaI = RESERVAS.idReserva
JOIN SUSCRITOS ON SUSCRITOS.clienteI = PRESTAMOS.clienteI AND SUSCRITOS.clienteT = PRESTAMOS.clienteT
JOIN ARTICULOS ON ARTICULOS.prestamoI = PRESTAMOS.idPrestamo;

---------------------------- INDICES ----------------------------
/*
    Solo hacemos dos de los que creemos que seran 
    los mas importantes y que ya contamos con 15 indices
*/
CREATE UNIQUE INDEX I_NOMBRES_USUARIO
ON SUSCRITOS(clienteI, nombre);

CREATE UNIQUE INDEX I_NOMBRES_ARTICULOS
ON ARTICULOS(idArticulo, nombreArticulo);


--------------------------- CRUDE ---------------------------
CREATE OR REPLACE PACKAGE PC_CLIENTES AS
    -- CREATE --
    PROCEDURE crear_cliente(
        p_tid_cliente   IN VARCHAR2,
        p_id_cliente    OUT     VARCHAR2
    );
    -- READ --
    FUNCTION leer_clientes RETURN SYS_REFCURSOR;
    FUNCTION leer_cliente_con_nombre_usuario(p_tid_cliente IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- UPDATE --
    -- DELETE --
END PC_CLIENTES;
/

CREATE OR REPLACE PACKAGE PC_SUSCRITOS AS
    -- CREATE --
    PROCEDURE crear_suscrito(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    );

    -- READ --
    FUNCTION leer_suscritos RETURN SYS_REFCURSOR;
    
    FUNCTION leer_suscrito_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_suscrito(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE eliminar_suscrito(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    );
END PC_SUSCRITOS;
/

CREATE OR REPLACE PACKAGE PC_RESERVAS AS
    -- CREATE --
    PROCEDURE crear_reserva(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    );
    -- READ --
    FUNCTION leer_reserva_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR;
    
    FUNCTION leer_reservas RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_reserva(
        p_reservaId IN VARCHAR2,
        p_estado    IN CHAR
    );
    -- DELETE --
    PROCEDURE eliminar_reserva(
        p_reservaId IN VARCHAR2
    );
END PC_RESERVAS;
/

CREATE OR REPLACE PACKAGE PC_PROVEEDORES AS
    -- CREATE --
    PROCEDURE crear_proveedor(
        p_nombreP IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    );
    -- READ --
    FUNCTION leer_proveedores RETURN SYS_REFCURSOR;
    
    FUNCTION leer_proveedor_id(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE eliminar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2
    );
END PC_PROVEEDORES;
/


CREATE OR REPLACE PACKAGE PC_VENTAS AS
    -- CREATE --
    PROCEDURE crear_ventas(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- READ --
    FUNCTION leer_ventas RETURN SYS_REFCURSOR;
    FUNCTION leer_venta(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- UPDATE --
    PROCEDURE actualizar_venta(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- DELETE --
    PROCEDURE eliminar_venta(
        p_idCompra IN VARCHAR2
    );
END PC_VENTAS;
/

CREATE OR REPLACE PACKAGE PC_ARTICULOS AS
    -- CREATE
    PROCEDURE crear_articulo(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    );

    -- READ
    FUNCTION leer_articulos RETURN SYS_REFCURSOR;
    FUNCTION leer_articulo(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_articulo(
    p_idArticulo IN VARCHAR2,
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_articulo(p_idArticulo IN VARCHAR2);
END PC_ARTICULOS;
/

CREATE OR REPLACE PACKAGE PC_AUTORES AS
    -- CREATE
    PROCEDURE crear_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- READ
    FUNCTION leer_autores RETURN SYS_REFCURSOR;
    FUNCTION leer_autor(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_autor(p_articuloI IN VARCHAR2,p_autor IN VARCHAR2);
END PC_AUTORES;
/

CREATE OR REPLACE PACKAGE PC_FISICOS AS
    -- CREATE
    PROCEDURE crear_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2
    );

    -- READ
    FUNCTION leer_fisicos RETURN SYS_REFCURSOR;
    FUNCTION leer_fisico(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_disponible IN CHAR
    );

    -- DELETE
    PROCEDURE eliminar_fisico(p_articuloI IN VARCHAR2);
END PC_FISICOS;
/

CREATE OR REPLACE PACKAGE PC_DIGITALES AS
    -- CREATE
    PROCEDURE crear_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- READ
    FUNCTION leer_digitales RETURN SYS_REFCURSOR;
    FUNCTION leer_digital(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_digital(p_articuloI IN VARCHAR2);
END PC_DIGITALES;
/

CREATE OR REPLACE PACKAGE PC_PRESTAMOS AS
    -- CREATE
    PROCEDURE crear_prestamo(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- READ
    FUNCTION leer_prestamos RETURN SYS_REFCURSOR;
    FUNCTION leer_prestamo(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_prestamo(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- DELETE
    PROCEDURE eliminar_prestamo(p_idPrestamo IN VARCHAR2);
END PC_PRESTAMOS;
/

CREATE OR REPLACE PACKAGE PC_DEVOLUCIONES AS
    -- CREATE
    PROCEDURE crear_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- READ
    FUNCTION leer_devoluciones RETURN SYS_REFCURSOR;
    FUNCTION leer_devolucion(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- DELETE
    PROCEDURE eliminar_devolucion(p_prestamoI IN VARCHAR2);
END PC_DEVOLUCIONES;
/

CREATE OR REPLACE PACKAGE PC_FACTURAS AS
    -- CREATE
    PROCEDURE crear_factura(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );


    -- UPDATE
    PROCEDURE actualizar_factura(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );

    -- DELETE
    PROCEDURE eliminar_factura(p_idFactura IN VARCHAR2);
END PC_FACTURAS;
/

CREATE OR REPLACE PACKAGE PC_MULTAS AS
    -- CREATE
    PROCEDURE crear_multa(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- READ
    FUNCTION leer_multas RETURN SYS_REFCURSOR;
    FUNCTION leer_multa(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_multa(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    -- DELETE
    PROCEDURE eliminar_multa(p_idMulta IN VARCHAR2);

END PC_MULTAS;
/
--------------------------- CRUDI ---------------------------
-- BODY PC_CLIENTES --
CREATE OR REPLACE PACKAGE BODY PC_CLIENTES AS
    -- CREATE --
    PROCEDURE crear_cliente(
        p_tid_cliente   IN VARCHAR2,
        p_id_cliente    OUT     VARCHAR2
    ) IS
    v_new_id CLIENTES.idCliente%TYPE;
    BEGIN 
    INSERT INTO CLIENTES(tidCliente) VALUES(p_tid_cliente)
    RETURNING idCLiente INTO v_new_id;
    p_id_cliente:=v_new_id;
    COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20007, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END crear_cliente;
    -- READ --
    FUNCTION leer_clientes RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
		
	BEGIN
        OPEN v_cursor FOR
        SELECT idCliente, tidCliente FROM CLIENTES;
        RETURN v_cursor;
		EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Ocurrio un error en la lectura de 
                        clientes, datos restablecidos');
    END leer_clientes;

    FUNCTION leer_cliente_con_nombre_usuario(p_tid_cliente IN VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT idCliente, tidCliente FROM CLIENTES WHERE tidCliente = p_tid_cliente ;
            RETURN v_cursor;
            COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20005, 'Ocurrio un error en la lectura de 
                        un cliente, datos restablecidos, verifique los parametros');
        END leer_cliente_con_nombre_usuario;
    -- UPDATE --
    -- DELETE --
END PC_CLIENTES;
/

CREATE OR REPLACE PACKAGE BODY  PC_SUSCRITOS AS
    -- CREATE --
    PROCEDURE crear_suscrito(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2) IS BEGIN
    INSERT INTO SUSCRITOS(clienteI,clienteT,metodoPago,nombre,apellido)
	VALUES(p_clienteI,p_clienteT,p_metodoPago,p_nombre,p_apellido);
	COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Ocurrio un error en la crecion de suscrito, datos restablecidos, verifique sus parametros');
    
    END crear_suscrito;
    -- READ --
    FUNCTION leer_suscritos RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
		BEGIN
            OPEN v_cursor FOR
            SELECT * FROM SUSCRITOS;
            RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
			        RAISE_APPLICATION_ERROR(-20002, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END leer_suscritos;

    FUNCTION leer_suscrito_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR IS 
        v_cursor SYS_REFCURSOR;
	BEGIN
        OPEN v_cursor FOR
        SELECT * FROM SUSCRITOS 
        WHERE clienteI = p_id_suscrito AND clienteT = p_tid_suscrito;
        RETURN v_cursor;
		EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END leer_suscrito_id_tid;
    
    -- UPDATE --
    PROCEDURE actualizar_suscrito(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
        ) IS BEGIN 
            UPDATE SUSCRITOS
            SET metodoPago = p_metodoPago,
                nombre = p_nombre
            WHERE 	clienteI = p_id_suscrito
            AND 	clienteT = p_clienteT;
			COMMIT;
		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Ocurrio un error con la actualizacion
                en suscritos, verifique sus parametros, solo puedo actualizar el nombre y
                el metodo de pago, datos restablecidos');
        END actualizar_suscrito;
    -- DELETE --
    PROCEDURE eliminar_suscrito(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    ) IS BEGIN
        DELETE FROM SUSCRITOS 
        WHERE clienteI = p_id_suscrito
        AND 	clienteT = p_tid_suscrito;
        COMMIT;
		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20000, 'Ocurrio un error con la eliminacion
            en suscritos, verifique sus parametros, solo puedo actualizar el nombre y
            el metodo de pago, datos restablecidos');

	END eliminar_suscrito;
END PC_SUSCRITOS;
/

CREATE OR REPLACE PACKAGE BODY PC_RESERVAS AS
    -- CREATE --
    PROCEDURE crear_reserva(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    ) IS BEGIN
    INSERT INTO RESERVAS(clienteI,clienteT,estado)
	VALUES (p_clienteI,p_clienteT,'D');
	COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20008, 'Ocurrio un error en la crecion de 
            la reserva, datos restablecidos, verifique sus parametros');
    END crear_reserva;
    -- READ --
    
	FUNCTION leer_reserva_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM RESERVAS WHERE clienteI=p_clienteI;
			RETURN v_cursor;
			EXCEPTION
        	WHEN OTHERS THEN
        	ROLLBACK;
        	RAISE_APPLICATION_ERROR(-20009, 'Ocurrio un error en la consulta de 
            la reserva, datos restablecidos, verifique sus parametros');
        END leer_reserva_id;
    
    FUNCTION leer_reservas RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
        	SELECT * FROM RESERVAS;
			RETURN v_cursor;
			EXCEPTION
        	WHEN OTHERS THEN
        	ROLLBACK;
        	RAISE_APPLICATION_ERROR(-20010, 'Ocurrio un error en la consulta de 
            reservas, datos restablecidos');
        END leer_reservas;
    
    
	-- UPDATE --
	PROCEDURE actualizar_reserva(
        p_reservaId IN VARCHAR2,
        p_estado    IN CHAR
    ) IS BEGIN
        UPDATE RESERVAS
        SET estado = p_estado
        WHERE idReserva = p_reservaId;
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20011, 'Ocurrio un error en la actualizacion de 
        reserva, datos restablecidos, verifique sus parametros');
        END actualizar_reserva;
    

	-- DELETE --
    PROCEDURE eliminar_reserva(
        p_reservaId IN VARCHAR2
    ) IS BEGIN 
        DELETE FROM RESERVAS WHERE idReserva =p_reservaId; 
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20012, 'Ocurrio un error en la eliminacion de 
        reserva, datos restablecidos, verifique sus parametros');
        END eliminar_reserva;
END PC_RESERVAS;
/

CREATE OR REPLACE PACKAGE BODY PC_PROVEEDORES AS
    -- CREATE --
    PROCEDURE crear_proveedor(
        p_nombreP IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
		VALUES(p_nombreP,p_clienteI,p_clienteT,p_catalogo,p_correo_electronico);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20013, 'Ocurrio un error en la crecion del
            proveedor, datos restablecidos, verifique sus parametros');
    END crear_proveedor;

    -- READ --
    FUNCTION leer_proveedores RETURN SYS_REFCURSOR IS 
        v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PROVEEDORES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20014, 'Ocurrio un error en la lectura de 
                los proveedores, datos restablecidos');
        	END leer_proveedores;
    
    FUNCTION leer_proveedor_id(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2) 
    RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PROVEEDORES WHERE clienteI =p_id_proveedor 
            AND clienteT = p_tid_proveedor;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20015, 'Ocurrio un error en la lectura de 
                los proveedores, datos restablecidos');
	        END leer_proveedor_id;
    
    -- UPDATE --
    PROCEDURE actualizar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    ) IS BEGIN
        	UPDATE PROVEEDORES 
        	SET correoElectronico =p_correo_electronico,
        	catalogo = p_catalogo,
        	nombreP = p_nombre
        	WHERE clienteI =p_id_proveedor AND clienteT = p_tid_proveedor;
        	COMMIT;
			EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20016, 'Ocurrio un error en la eliminacion de 
                los proveedor, datos restablecidos');
		END actualizar_proveedor;
    
	-- DELETE --
    PROCEDURE eliminar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2
    ) IS BEGIN 
    	DELETE FROM PROVEEDORES WHERE clienteI =p_id_proveedor AND clienteT = p_tid_proveedor;
    END eliminar_proveedor;
END PC_PROVEEDORES;
/

CREATE OR REPLACE PACKAGE BODY PC_VENTAS AS
    -- CREATE --
    PROCEDURE crear_ventas(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE
    ) IS BEGIN
    	INSERT INTO VENTAS(articuloI, clienteI,clienteT, metodoPago,total,fechaCompra)
		VALUES(p_articuloI,p_clienteI,p_clienteT,p_metodoPago,p_total,p_fechaCompra);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20017, 'Ocurrio un error en la crecion del
            venta, datos restablecidos, verifique sus parametros');
    END crear_ventas;

    -- READ --
    FUNCTION leer_ventas RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM VENTAS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20018, 'Ocurrio un error en la lectura de 
                los ventas, datos restablecidos');
        	END leer_ventas;

    	FUNCTION leer_venta(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM VENTAS WHERE idCompra =p_idCompra;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20019, 'Ocurrio un error en la lectura de 
                los ventas, datos restablecidos, verifique parametros');
	        END leer_venta;

    -- UPDATE --
    PROCEDURE actualizar_venta(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE
	
    ) IS BEGIN
        UPDATE	VENTAS
        SET		articuloI = p_articuloI,
        		metodoPago = p_metodoPago,
        		total = p_total,
        		fechaCompra = p_fechaCompra
        WHERE	idCompra = p_idCompra;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020, 'Ocurrio un error en la actualizacion de 
        los ventas, datos restablecidos, verifique parametros');

        END actualizar_venta;

    -- DELETE --
    PROCEDURE eliminar_venta(
        p_idCompra IN VARCHAR2
    ) IS BEGIN
        DELETE FROM VENTAS WHERE idCompra = p_idCompra;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021, 'Ocurrio un error en la eliminacion de 
        los ventas, datos restablecidos, verifique parametros');
        END eliminar_venta;
END PC_VENTAS;
/

CREATE OR REPLACE PACKAGE BODY PC_ARTICULOS AS
    -- CREATE
    PROCEDURE crear_articulo(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    )IS BEGIN
    	INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
        VALUES (p_prestamoI,p_genero,p_descripcion,p_fechaPublicacion,p_nombreArticulo);
        COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20023, 'Ocurrio un error en la crecion del
            venta, datos restablecidos, verifique sus parametros');
    END crear_articulo;

    -- READ
    FUNCTION leer_articulos RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM ARTICULOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20024, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos');
        	END leer_articulos;
    	FUNCTION leer_articulo(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM ARTICULOS WHERE idArticulo =p_idArticulo;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20025, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos, verifique parametros');
	        END leer_articulo;

    -- UPDATE
    PROCEDURE actualizar_articulo(
    p_idArticulo IN VARCHAR2,
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2
    )IS BEGIN
        UPDATE	ARTICULOS
        SET		prestamoI = p_prestamoI,
        		genero = p_genero,
        		descripcion = p_descripcion
        WHERE	idArticulo = p_idArticulo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20026, 'Ocurrio un error en la actualizacion de 
        los articulos, datos restablecidos, verifique parametros');

        END actualizar_articulo;

    -- DELETE
    PROCEDURE eliminar_articulo(p_idArticulo IN VARCHAR2)
        IS BEGIN
        DELETE FROM ARTICULOS WHERE	idArticulo = p_idArticulo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20028, 'Ocurrio un error en la eliminacion de 
        los articulos, datos restablecidos, verifique parametros');
		 
        END eliminar_articulo;
END PC_ARTICULOS;
/
CREATE OR REPLACE PACKAGE BODY PC_FACTURAS AS
    --CREATE
    PROCEDURE crear_Factura(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    ) IS BEGIN
    	INSERT INTO FACTURAS(prestamoI,metodoPago, fecha,total,estado)
    	VALUES(p_prestamoI,p_metodoPago, p_fecha,p_total,p_estado);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20029, 'Ocurrio un error en la crecion de la
            factura, datos restablecidos, verifique sus parametros');
    END crear_factura;
    --UPDATE
    PROCEDURE actualizar_factura(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    )IS BEGIN
        UPDATE	FACTURAS
        SET		fecha = p_fecha,
                total=p_total,
                estado=p_estado
        WHERE	idFactura = p_idFactura;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la actualizacion de 
        la factura, datos restablecidos, verifique parametros');

    END actualizar_factura;
    PROCEDURE eliminar_factura(p_idFactura IN VARCHAR2)
        IS BEGIN
        DELETE FROM FACTURAS WHERE idFactura = p_idFactura;
        END eliminar_factura;
END PC_FACTURAS;
/
CREATE OR REPLACE PACKAGE BODY PC_AUTORES AS
    -- CREATE
    PROCEDURE crear_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    )IS BEGIN
    	INSERT INTO AUTORES(articuloI,autor)
    	VALUES(p_articuloI, p_autor);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20029, 'Ocurrio un error en la crecion del
            autor, datos restablecidos, verifique sus parametros');
    END crear_autor;

    -- READ
    FUNCTION leer_autores RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM AUTORES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20030, 'Ocurrio un error en la lectura de 
                los autores, datos restablecidos');
        	END leer_autores;
    	
		FUNCTION leer_autor(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM AUTORES WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20031, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos, verifique parametros');
	        END leer_autor;

    -- UPDATE
    PROCEDURE actualizar_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    ) IS BEGIN
        UPDATE	AUTORES
        SET		autor = p_autor
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la actualizacion de 
        los autores, datos restablecidos, verifique parametros');

        END actualizar_autor;

    -- DELETE
    PROCEDURE eliminar_autor(p_articuloI IN VARCHAR2,p_autor IN VARCHAR2)
        IS BEGIN
        DELETE FROM AUTORES WHERE autor = p_autor AND	articuloI = p_articuloI;
        END eliminar_autor;
END PC_AUTORES;
/

CREATE OR REPLACE PACKAGE BODY PC_FISICOS AS
    -- CREATE
    PROCEDURE crear_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO FISICOS(articuloI,estado,disponible)
		VALUES(p_articuloI,p_estado,'Y');
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la crecion del
            Fisico, datos restablecidos, verifique sus parametros');
    END crear_fisico;

    -- READ
    FUNCTION leer_fisicos RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM FISICOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20033, 'Ocurrio un error en la lectura de 
                los fisicos, datos restablecidos');
        	END leer_fisicos;

    	FUNCTION leer_fisico(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM FISICOS WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20034, 'Ocurrio un error en la lectura de 
                los articulos fisicos, datos restablecidos, verifique parametros');
	        END leer_fisico;

    -- UPDATE
    PROCEDURE actualizar_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_disponible IN CHAR
    ) IS BEGIN
        UPDATE	FISICOS
        SET		estado = p_estado,
         	disponible = p_disponible
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20035, 'Ocurrio un error en la actualizacion de 
        los articulos fisicos, datos restablecidos, verifique parametros');
        END actualizar_fisico;

    -- DELETE
    PROCEDURE eliminar_fisico(p_articuloI IN VARCHAR2) IS BEGIN
        	DELETE FROM FISICOS WHERE articuloI = p_articuloI;
        END eliminar_fisico;
END PC_FISICOS;
/

CREATE OR REPLACE PACKAGE BODY PC_DIGITALES AS
    -- CREATE
    PROCEDURE crear_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO DIGITALES(articuloI,formato)
		VALUES(p_articuloI,p_formato);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20036, 'Ocurrio un error en la crecion del
            digital, datos restablecidos, verifique sus parametros');
    END crear_digital;

    -- READ
    FUNCTION leer_digitales RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DIGITALES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20037, 'Ocurrio un error en la lectura de 
                los digitales, datos restablecidos');
        	END leer_digitales;

    FUNCTION leer_digital(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DIGITALES WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20038, 'Ocurrio un error en la lectura de 
                los articulos digitales, datos restablecidos, verifique parametros');
	        END leer_digital;

    -- UPDATE
    PROCEDURE actualizar_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    ) IS BEGIN
        UPDATE	DIGITALES
        SET		formato = p_formato
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20039, 'Ocurrio un error en la actualizacion de 
        los articulos fisicos, datos restablecidos, verifique parametros');
        END actualizar_digital;

    -- DELETE
    PROCEDURE eliminar_digital(p_articuloI IN VARCHAR2) IS BEGIN
        	DELETE FROM DIGITALES WHERE articuloI = p_articuloI;
        END eliminar_digital;
END PC_DIGITALES;
/


CREATE OR REPLACE PACKAGE BODY PC_PRESTAMOS AS
    -- CREATE
    PROCEDURE crear_prestamo(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS BEGIN
    	INSERT INTO PRESTAMOS(clienteI,clienteT,reservaI,FechaDevolucionEstimada)
		VALUES (p_clienteI, p_clienteT, p_reservaI,p_fechaDevolucionEstimada);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20039, 'Ocurrio un error en la crecion del
            prestamo, datos restablecidos, verifique sus parametros');
    END crear_prestamo;

    -- READ
    FUNCTION leer_prestamos RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PRESTAMOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20040, 'Ocurrio un error en la lectura de 
                los prestamos, datos restablecidos');
        	END leer_prestamos;

    FUNCTION leer_prestamo(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PRESTAMOS WHERE idPrestamo =p_idPrestamo;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20041, 'Ocurrio un error en la lectura de 
                los prestamos, datos restablecidos, verifique parametros');
	        END leer_prestamo;

    -- UPDATE
    PROCEDURE actualizar_prestamo(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS BEGIN
        UPDATE	PRESTAMOS
        SET		FechaDevolucionEstimada = p_fechaDevolucionEstimada
        WHERE	idPrestamo = p_idPrestamo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20042, 'Ocurrio un error en la actualizacion de 
        la fehca de prestamos, datos restablecidos, verifique parametros');
        END actualizar_prestamo;


    -- DELETE
    PROCEDURE eliminar_prestamo(p_idPrestamo IN VARCHAR2) IS BEGIN
        DELETE FROM PRESTAMOS WHERE idPrestamo = p_idPrestamo;
	COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20043, 'Ocurrio un error en la eliminacion de 
        prestamos, datos restablecidos, verifique parametros');
        END eliminar_prestamo;
END PC_PRESTAMOS;
/

CREATE OR REPLACE PACKAGE BODY PC_DEVOLUCIONES AS
    -- CREATE
    PROCEDURE crear_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    ) IS BEGIN
        INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
        VALUES (p_prestamoI, p_estado, p_fechaDevolucion);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20044, 'Ocurrio un error en la crecion del
            devolucion, datos restablecidos, verifique sus parametros');
    END crear_devolucion;

    -- READ
    FUNCTION leer_devoluciones RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DEVOLUCIONES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20045, 'Ocurrio un error en la lectura de 
                las devoluciones, datos restablecidos');
        	END leer_devoluciones;
    FUNCTION leer_devolucion(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DEVOLUCIONES WHERE prestamoI =p_prestamoI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20046, 'Ocurrio un error en la lectura de 
                las devoluciones, datos restablecidos, verifique parametros');
	        END leer_devolucion;

    -- UPDATE
    PROCEDURE actualizar_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    )
        IS BEGIN
        UPDATE	DEVOLUCIONES
        SET		fechaDevolucion = p_fechaDevolucion,
        		estado = p_estado
        WHERE	prestamoI = p_prestamoI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20047, 'Ocurrio un error en la actualizacion de 
        la devolucion, datos restablecidos, verifique parametros');
        END actualizar_devolucion;

    -- DELETE
    PROCEDURE eliminar_devolucion(p_prestamoI IN VARCHAR2)
        IS BEGIN DELETE FROM DEVOLUCIONES WHERE prestamoI = p_prestamoI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20048, 'Ocurrio un error en la eliminacion de 
        devoluciones, datos restablecidos, verifique parametros');
        END eliminar_devolucion;
END PC_DEVOLUCIONES;
/

CREATE OR REPLACE PACKAGE BODY PC_MULTAS AS
    -- CREATE
    PROCEDURE crear_multa(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
		INSERT INTO MULTAS(facturaI,monto,descripcion)
		VALUES (p_facturaI, p_monto,p_descripcion);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20049, 'Ocurrio un error en la crecion del
            multa, datos restablecidos, verifique sus parametros');
    END crear_multa;

    -- READ
    FUNCTION leer_multas RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM MULTAS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20050, 'Ocurrio un error en la lectura de 
                las multas, datos restablecidos');
        	END leer_multas;

    FUNCTION leer_multa(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM MULTAS WHERE idMulta =p_idMulta;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20051, 'Ocurrio un error en la lectura de 
                la Multa, datos restablecidos, verifique parametros');
	        END leer_multa;

    -- UPDATE
    PROCEDURE actualizar_multa(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
        UPDATE	MULTAS
        SET		monto = p_monto,
        		descripcion = p_descripcion
        WHERE	idMulta = p_idMulta;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20052, 'Ocurrio un error en la actualizacion de 
        la multa, datos restablecidos, verifique parametros');
        END actualizar_multa;

    -- DELETE
    -- DELETE
    PROCEDURE eliminar_multa(p_idMulta IN VARCHAR2)
        IS BEGIN DELETE FROM MULTAS WHERE idMulta = p_idMulta;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20053, 'Ocurrio un error en la eliminacion de 
        devoluciones, datos restablecidos, verifique parametros');
        END eliminar_multa;
END PC_MULTAS;
/


--------------------------- CRUDOK ---------------------------
--------------------------- CRUDOK ---------------------------
--------------------------- CRUDOK ---------------------------


-------------------------- CRUDEnOK --------------------------


--------------------------- XCRUDE ---------------------------
DROP PACKAGE PC_CLIENTES;
DROP PACKAGE PC_SUSCRITOS;
DROP PACKAGE PC_RESERVAS;
DROP PACKAGE PC_PROVEEDORES;
DROP PACKAGE PC_VENTAS;
DROP PACKAGE PC_ARTICULOS;
DROP PACKAGE PC_FACTURAS;
DROP PACKAGE PC_AUTORES;
DROP PACKAGE PC_FISICOS;
DROP PACKAGE PC_DIGITALES;
DROP PACKAGE PC_PRESTAMOS;
DROP PACKAGE PC_DEVOLUCIONES;
DROP PACKAGE PC_MULTAS;
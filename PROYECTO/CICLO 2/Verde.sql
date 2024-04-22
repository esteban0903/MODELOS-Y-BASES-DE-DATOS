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


---La fecha de devolucion estimada debe ser 15 dias despues de la fecha de entrega ---
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA
BEFORE INSERT OR UPDATE ON PRESTAMOS
FOR EACH ROW
DECLARE
    v_diferencia_dias NUMBER;
BEGIN
    v_diferencia_dias := ABS(:NEW.fechaDevolucionEstimada - :OLD.fechaEntrega);
    
    IF v_diferencia_dias < 15 OR v_diferencia_dias > 30 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de devoluci�n debe ser al menos 15 d�as despu�s de la fecha de entrega y no mas de 30 dias.');
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
    
    -- Solo actualiza el total si es una actualizaci�n y el campo total se ha modificado expl�citamente.
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
    IF :NEW.estado!='D' THEN
       RAISE_APPLICATION_ERROR(-20001,'Si el estado de la factura no es denegado, no se puede modificar'); 
    END IF;
END;
/

----------------------------XTRIGGERS----------------------------
DROP TRIGGER TR_SUSCRITOS_nombreUsuario;
DROP TRIGGER TR_PRESTAMOS_INSERT_FECHA;
DROP TRIGGER TR_FACTURAS_total;
DROP TRIGGER TR_FACTURAS_estado;


----------------------------TUPLASOK----------------------------
---T_CREDENCIAL---
--- TIPO TCREDENCIAL---
-- Debe ser de tipo : 
INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C4','CC');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CC','NomUs4','T','Nom4','Ape4');

---FECHA ENTREGA---
-- Dentro del rango estimado de 15 dias, pues su fecha original es: 03/01/2024 --
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = TO_DATE('2024-01-20', 'YYYY-MM-DD')
WHERE idPrestamo = 'P3';

---MODIFICAR FACTURA ---
-- El valor total pasa ser 5 + 1 = 6, porque debe 1 en multas
UPDATE FACTURAS
SET total = 5
WHERE idFactura= 'F2';

-- FACTURA ESTADO --
-- Debe funcionar, pues su estado es 'D' Denegado --
UPDATE FACTURAS
SET fecha = TO_DATE('2024-08-01','YYYY-MM-DD')
WHERE idFactura= 'F2';

----------------------------TUPLASNOK----------------------------
---T_CREDENCIAL---
-- No se puede si no es tipo : 'CC','TI'
UPDATE PRESTAMOS
SET tidCliente = 'NN' 
WHERE idCliente = 'C001';

---FECHA ENTREGA---
--FUERA del rango estimado de 15 dias, pues su fecha original es: 2024-05-20
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = TO_DATE('2024-08-06', 'YYYY-MM-DD')
WHERE idPrestamo = 'P003';

---INMUTABILIDAD ---
-- No va a cambiar si su estado no es 'D'
UPDATE FACTURAS
SET total = 5
WHERE idFactura= 'F001';

---------------------------- Automatizacion de indices con Disparadores----------------------------
-- Secuencias de automatizacion --
CREATE SEQUENCE secuencia_ventas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_articulos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_prestamos START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_facturas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE secuencia_clientes START WITH 1 INCREMENT BY 1;

-- Generar indices de idClientes en Clientes --
CREATE OR REPLACE TRIGGER TR_VENTAS_generar_idCliente
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
---------------------------- XDISPARADORES ----------------------------
--------------------------- DISPARADORESOK ---------------------------
-------------------------- DISPARADORESNoOK --------------------------

---------------------------- VISTAS ----------------------------
-- Solo consultar los clientes --
CREATE VIEW CLIENTES_SUSCRITOS AS SELECT nombre, apellido, clienteI, clienteT FROM SUSCRITOS;

-- Solo consultar las ventas --
CREATE VIEW COMPRAS AS 
SELECT ARTICULOS.nombreArticulo, VENTAS.articuloI, VENTAS.clienteI, VENTAS.total, VENTAS.fechaCompra 
FROM VENTAS 
JOIN ARTICULOS ON VENTAS.articuloI = ARTICULOS.idArticulo;

-- Consultar las facturas de los clientes con multa --
CREATE VIEW FACTURAS_CON_MULTA AS 
SELECT SUSCRITOS.nombre, SUSCRITOS.apellido, FACTURAS.total AS "Total a Pagar", MULTAS.monto AS 'Total de multa', MULTAS.idMulta
FROM FACTURAS 
JOIN PRESTAMOS ON FACTURAS.prestamoI = PRESTAMOS.idPrestamo 
JOIN SUSCRITOS ON SUSCRITOS.clienteI = PRESTAMOS.clienteI AND SUSCRITOS.clienteT = PRESTAMOS.clienteT 
JOIN MULTAS ON MULTAS.facturaI = FACTURAS.idFactura;

CREATE VIEW CLIENTES_SUSCRITOS AS SELECT nombre, apellido, clienteI, clienteT FROM SUSCRITOS;


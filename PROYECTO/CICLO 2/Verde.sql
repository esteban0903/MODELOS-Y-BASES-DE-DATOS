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

-- La fecha de entrega se autogenera el dia en que se hace el prestamo 
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA_AUTO
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
BEGIN
    :NEW.fechaEntrega := SYSDATE;
END;
/

-- La fecha de entrega se autogenera cuando se hace el prestamo, por lo que no debe poder cambiar 
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_UPDATE_FECHA_ENTREGA_INMUTABLE
BEFORE UPDATE ON PRESTAMOS
FOR EACH ROW
BEGIN
    IF :NEW.fechaEntrega != :OLD.fechaEntrega THEN
        RAISE_APPLICATION_ERROR(-20000, 'La fecha de entrega se crea el dia del prestamo, es inmutable');
	END IF;
END;
/


-- La multa debe ser positiva --
CREATE OR REPLACE TRIGGER TR_MULTAS_MONTO_POSITIVO
BEFORE INSERT OR UPDATE ON MULTAS
FOR EACH ROW
BEGIN
    IF :NEW.monto < 0 THEN
        RAISE_APPLICATION_ERROR(-19999, 'Los valores de monto de una multa deben ser positivos');
    END IF;
END;
/

-- El total de la factura debe ser positivo --
CREATE OR REPLACE TRIGGER TR_FACTURAS_TOTAL_POSITIVO
BEFORE INSERT OR UPDATE ON FACTURAS
FOR EACH ROW
BEGIN 
    IF :NEW.total < 0 THEN
        RAISE_APPLICATION_ERROR(-19998, 'Los valores de monto de una multa deben ser positivos');
    END IF;
END;
/




----------------------------XTRIGGERS----------------------------
DROP TRIGGER TR_SUSCRITOS_nombreUsuario;
DROP TRIGGER TR_PRESTAMOS_INSERT_FECHA_DEVOLUCION;
DROP TRIGGER TR_FACTURAS_total;
DROP TRIGGER TR_FACTURAS_estado;
DROP TRIGGER TR_PRESTAMOS_INSERT_FECHA_AUTO;
DROP TRIGGER TR_PRESTAMOS_UPDATE_FECHA_ENTREGA_INMUTABLE;
DROP TRIGGER TR_MULTAS_MONTO_POSITIVO;
DROP TRIGGER TR_FACTURAS_TOTAL_POSITIVO;

----------------------------TUPLASOK----------------------------
---T_CREDENCIAL---
--- TIPO TCREDENCIAL---
-- Debe ser de tipo : 
INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C4','CC');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CC','NomUs4','T','Nom4','Ape4');

---FECHA CREACION---
-- Creacion -- Va a comprobar que la fecha de entrega sea menor a 21 dias cuando se cree el prestamo
INSERT INTO RESERVAS(clienteI, clienteT,idReserva,estado) 
VALUES('C4','CC','RE004','A');
INSERT INTO PRESTAMOS(clienteI, clienteT, idPrestamo, reservaI, fechaEntrega, fechaDevolucionEstimada) 
VALUES('C4','CC','PE004','RE004',TO_DATE('2024-05-20', 'YYYY-MM-DD'),TO_DATE('2024-05-31', 'YYYY-MM-DD'));

---FECHA ENTREGA---
-- Dentro del rango estimado de 15 dias, pues siempre que crea un prestamo, es con la fecha actual --
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = SYSDATE + INTERVAL '15' DAY
WHERE idPrestamo = 'PE004';


-- FACTURA POSITIVA --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('PE004', 'FE0001','T',TO_DATE('2024-04-01', 'YYYY-MM-DD'),0,'D');

-- FACTURA ESTADO --
-- Debe funcionar, pues su estado es 'D' Denegado --
UPDATE FACTURAS
SET fecha = TO_DATE('2024-08-01','YYYY-MM-DD')
WHERE idFactura= 'FE0001';

---MODIFICAR FACTURA ---
-- El valor total pasa ser 0 + 1000 = 1000, porque debe 1 en multas
UPDATE FACTURAS
SET total = 1000
WHERE idFactura= 'FE0001';

-- MULTAS DEBEN SER POSITIVAS --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('FE0001', 'ME001',1000,'Se demoro en la entrega del articulo');


----------------------------TUPLASNOK----------------------------
---T_CREDENCIAL---
-- No se puede si no es tipo : 'CC','TI'
UPDATE PRESTAMOS
SET clienteT = 'NN' 
WHERE clienteI = 'C4';

---FECHA ENTREGA---
--FUERA del rango estimado de 21 dias, pues su fecha original es: Hoy
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = SYSDATE + INTERVAL '21' DAY
WHERE idPrestamo = 'PE004';

---INMUTABILIDAD ---
/* 
* No va a cambiar si su estado no es 'D'
* Ya que su estado es D, lo podemos cambiar, es como si cancelara la factura, 
* despues de cancelarla ya esta pago y no debe poder modificarlo 
*/

UPDATE FACTURAS
SET estado = 'A'
WHERE idFactura= 'FE0001';
/* 
* Ahora que su estado es A, significa que ya fue (pagado) asi su factura 
* sera la misma, y se quedara un registro de su factura y multas pagadas en ella, 
* por eso no debe modificarlo 
*/
UPDATE FACTURAS
SET total = 1500
WHERE idFactura= 'FE0001';


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
---------------------------- XDISPARADORES ----------------------------
DROP SEQUENCE secuencia_ventas;
DROP SEQUENCE secuencia_articulos;
DROP SEQUENCE secuencia_facturas;
DROP SEQUENCE secuencia_prestamos;
DROP SEQUENCE secuencia_clientes;
DROP SEQUENCE secuencia_reservas;
DROP SEQUENCE secuencia_multas;

DROP TRIGGER TR_CLIENTES_generar_idCliente;
DROP TRIGGER TR_VENTAS_generar_idCompra;
DROP TRIGGER TR_ARTICULOS_generar_idArticulo;
DROP TRIGGER TR_FACTURAS_generar_idFactura;
DROP TRIGGER TR_PRESTAMOS_generar_idPrestamo;
DROP TRIGGER TR_RESERVAS_generar_idReserva;
DROP TRIGGER TR_MULTAS_generar_idMulta;
--------------------------- DISPARADORESOK ---------------------------
-- Para probar vamos a eliminar los clientes existentes, y con ello todo sus conexiones.
DELETE FROM CLIENTES WHERE idCliente = 'C4';
/* 
    Generar ID cliente (no tenemos que colocar el tid, se puede generar solo.)
    Esto garantiza que solo sea necesario pedir una identificacion si el cliente
    entra a la biblioteca o usa servicios por el portal web.
*/
INSERT INTO CLIENTES(tidCliente) VALUES('CC');
INSERT INTO CLIENTES(tidCliente) VALUES('TI');
INSERT INTO CLIENTES(tidCliente) VALUES('CC');
INSERT INTO CLIENTES(tidCliente) VALUES('CC');
INSERT INTO CLIENTES(tidCliente) VALUES('TI');
INSERT INTO CLIENTES(tidCliente) VALUES('CE');
-- Para consultar Antes, este es el mismo mecanismo para los demas disparadores --
SELECT * FROM CLIENTES;
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A001', 'P001', 'Literatura clasica','La historia detras de juego de tronos',TO_DATE('2024-03-20', 'YYYY-MM-DD'),'GOT');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo 2','Descripcion ejemplo de automatizacion indices',TO_DATE('2009-04-20', 'YYYY-MM-DD'),'Indice 2');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo 3','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice 3');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo 4','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice 4');
SELECT * FROM ARTICULOS;
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES (NULL, 'Ejemplo','Descripcion ejemplo de automatizacion indices',TO_DATE('1997-04-20', 'YYYY-MM-DD'),'Indice');
SELECT * FROM ARTICULOS ORDER BY IDARTICULO;
---------------- Restaurar los valores de la base de datos ----------------
DELETE FROM ARTICULOS; 
DELETE FROM CLIENTES;

-------------------------- DISPARADORESNoOK --------------------------
--

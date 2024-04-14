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
    
    IF v_diferencia_dias > 15 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de devolución debe ser al menos 15 días después de la fecha de entrega.');
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
    
    -- Solo actualiza el total si es una actualización y el campo total se ha modificado explícitamente.
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
VALUES('C004','CC');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CC','NomUs4','T','Nom4','Ape4');

---FECHA ENTREGA---
-- Dentro del rango estimado de 15 dias, pues su fecha original es: 03/01/24 --
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = TO_DATE('2024-05-20', 'YYYY-MM-DD')
WHERE idPrestamo = 'P003';

---MODIFICAR FACTURA ---
-- El valor total pasa ser 5 + 1 = 6, porque debe 1 en multas
UPDATE FACTURAS
SET total = 5
WHERE idFactura= 'F002';

-- FACTURA ESTADO --
-- Debe funcionar, pues su estado es 'D' Denegado --
UPDATE FACTURAS
SET fecha = TO_DATE('2024-08-01','YYYY-MM-DD')
WHERE idFactura= 'F002';

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



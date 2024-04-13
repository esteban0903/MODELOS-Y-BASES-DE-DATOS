----------------------------TUPLAS----------------------------
--Tipo Tcredencial---
CREATE OR REPLACE TRIGGER TR_SUSCRITOS_nombreUsuario
BEFORE INSERT ON SUSCRITOS
FOR EACH ROW
BEGIN
    :new.nombreUsuario := :new.nombre || '_' || :new.apellido || '_' || :new.clienteI;
END;
/



---La fecha de devolucion estimada debe ser 15 dias despues de la fecha de entrega ---
CREATE OR REPLACE TRIGGER TR_PRESTAMOS_INSERT_FECHA
BEFORE INSERT OR UPDATE ON PRESTAMOS
FOR EACH ROW
BEGIN
    IF (:NEW.fechaDevolucionEstimada - :old.fechaEntrega) < 15 THEN
        RAISE_APPLICATION_ERROR(-20000, 'La fecha de devolución debe ser al menos 15 días después de la fecha de entrega.');
    END IF;
END;
/

---El total de la factura debe ser la suma de lo que ya existe mas el total de la multa---
CREATE OR REPLACE TRIGGER TR_FACTURAS_total
AFTER INSERT OR UPDATE ON FACTURAS
FOR EACH ROW
DECLARE
    v_total_factura NUMBER;
BEGIN
    SELECT NVL(SUM(monto), 0) INTO v_total_factura FROM MULTAS WHERE idMulta = :NEW.idFactura;
    UPDATE factura SET total = (:NEW.total + v_total_factura);
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
INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C004','CC');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CC','NomUs4','T','Nom4','Ape4');

---FECHA ENTREGA---
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = TO_DATE('2024-05-20', 'YYYY-MM-DD')
WHERE idPrestamo = 'P003';

---MODIFICAR FACTURA ---
UPDATE FACTURAS
SET fecha = TO_DATE('2024-09-20', 'YYYY-MM-DD')
WHERE idFactura= 'F001';
----------------------------TUPLASNOK----------------------------
---FECHA ENTREGA---
UPDATE PRESTAMOS
SET FechaDevolucionEstimada = TO_DATE('2024-04-20', 'YYYY-MM-DD')
WHERE idPrestamo = 'P003';

---MODIFICAR FACTURA ---
UPDATE FACTURAS
SET fecha = TO_DATE('2024-08-20', 'YYYY-MM-DD')
WHERE idFactura= 'F001';


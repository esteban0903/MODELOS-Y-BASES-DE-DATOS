----------------------------------- PARTE DE AUTOESTUDIO 4 -----------------------------------
---- CREANDO ------
-- Creando Tabla

CREATE TABLE BOOKING(
BOOKING_ID      NUMBER(11),
BOOKING_DATE    DATE,
ROOM_NO         NUMBER(11),
GUEST_ID        NUMBER(11) NOT NULL,
OCCUPANTS       NUMBER(11) NOT NULL,
ROOM_TYPE_REQUESTED VARCHAR(6),
NIGHTS          NUMBER(11) NOT NULL,
ARRIVAL_TIME    VARCHAR(5)
);

CREATE TABLE GUEST(
ID              NUMBER(11),
FIRST_NAME      VARCHAR(50),
LAST_NAME       VARCHAR(50),
ADDRESS         VARCHAR(50)
);

CREATE TABLE ROOM_TYPE(
ID          VARCHAR(6),
DESCRIPTION     VARCHAR(100)
);

CREATE TABLE RATE(
ROOM_TYPE       VARCHAR(6),
OCCUPANCY       NUMBER(11),
AMOUNT          DECIMAL(10,2)
);

CREATE TABLE ROOM(
ID              NUMBER(11),
ROOM_TYPE       VARCHAR(6),
MAX_OCCUPANCY   NUMBER(11)    
);
------------------------------------- Creando PK's ------------------------------------
--ALTER TABLE EXTRAS
--ADD CONSTRAINT PK_EXTRAS_ID PRIMARY KEY (EXTRAS_ID);
ALTER TABLE BOOKING
ADD CONSTRAINT PK_BOOKING_ID PRIMARY KEY (BOOKING_ID);
ALTER TABLE GUEST
ADD CONSTRAINT PK_ID_GUEST PRIMARY KEY (ID);
ALTER TABLE ROOM_TYPE
ADD CONSTRAINT PK_ID PRIMARY KEY (ID);
ALTER TABLE RATE
ADD CONSTRAINT PK_RATE PRIMARY KEY (ROOM_TYPE, OCCUPANCY);
ALTER TABLE ROOM
ADD CONSTRAINT PK_ID_ROOM PRIMARY KEY (ID);
-- XTABLAS
DROP TABLE "BOOKING" CASCADE CONSTRAINTS PURGE;
DROP TABLE "GUEST" CASCADE CONSTRAINTS PURGE;
DROP TABLE "ROOM_TYPE" CASCADE CONSTRAINTS PURGE;
DROP TABLE "RATE" CASCADE CONSTRAINTS PURGE;
DROP TABLE "ROOM" CASCADE CONSTRAINTS PURGE;
------------------------------------ PARTE A ------------------------------------
-- TABLA
CREATE TABLE EXTRAS (
    EXTRAS_ID NUMBER(11),
    BOOKING_ID      NUMBER(11),
    DESCRIPTION VARCHAR(50) NOT NULL,
    DISCOUNT NUMBER(9),
    AMOUNT          NUMBER(11)
);
-- XTABLA
DROP TABLE EXTRAS;
------------------------------------ Creando Atributos ------------------------------------
-- Esto deberia comprobar que el valor de la PK empiece en 9 --
-- Restriccion para extraSId positivo que inicia en 9
ALTER TABLE EXTRAS ADD CONSTRAINT check_ExtraSIdPositive CHECK (EXTRAS_ID >= 9);
-- Restriccion para discount positivo
ALTER TABLE EXTRAS ADD CONSTRAINT check_DiscountPositive CHECK (DISCOUNT > 0);
-------------------------------------- Validando casos significativos -------------------------------------
-- AtributosOK --
INSERT INTO EXTRAS (EXTRAS_ID, BOOKING_ID, DESCRIPTION, DISCOUNT) VALUES (10, 1, 'Descuento por reserva anticipada', 20);
INSERT INTO EXTRAS (EXTRAS_ID, BOOKING_ID, DESCRIPTION, DISCOUNT) VALUES (9, 2, 'Descuento por ser cliente frecuente', 15);
-- AtributosNoOK --
-- Este caso no cumplira con la Restriccion check_ExtraSIdPositive ya que EXTRAS_ID debe ser mayor o igual a 9. --
INSERT INTO EXTRAS (EXTRAS_ID, BOOKING_ID, DESCRIPTION, DISCOUNT) VALUES (-5, 3, 'Descuento por promoci�n', 10);
-- Este caso no cumplira con la Restriccion check_DiscountPositive ya que DISCOUNT debe ser positivo. --
INSERT INTO EXTRAS (EXTRAS_ID, BOOKING_ID, DESCRIPTION, DISCOUNT) VALUES (11, 4, 'Descuento por ser estudiante', -5);
------------------------------------ PARTE B ------------------------------------
-- ACCIONES --
DROP TABLE EXTRAS;
DROP TABLE BOOKING;
-- RECREAR TABLAS --
CREATE TABLE BOOKING(
BOOKING_ID      NUMBER(11),
BOOKING_DATE    DATE,
ROOM_NO         NUMBER(11),
GUEST_ID        NUMBER(11) NOT NULL,
OCCUPANTS       NUMBER(11) NOT NULL,
ROOM_TYPE_REQUESTED VARCHAR(6),
NIGHTS          NUMBER(11) NOT NULL,
ARRIVAL_TIME    VARCHAR(5)
);
CREATE TABLE EXTRAS (
    EXTRAS_ID       NUMBER(11),
    BOOKING_ID      NUMBER(11),
    DESCRIPTION     VARCHAR(50) NOT NULL,
    DISCOUNT        NUMBER(9),
    AMOUNT          NUMBER(11)
);
-- APLICAR ATRIBUTOS Y PK'S
ALTER TABLE BOOKING
ADD CONSTRAINT PK_BOOKING_ID PRIMARY KEY (BOOKING_ID);
ALTER TABLE EXTRAS
ADD CONSTRAINT PK_EXTRAS_ID PRIMARY KEY (EXTRAS_ID);
ALTER TABLE EXTRAS ADD CONSTRAINT check_ExtraSIdPositive CHECK (EXTRAS_ID >= 9);
-- Restriccion para discount positivo
ALTER TABLE EXTRAS ADD CONSTRAINT check_DiscountPositive CHECK (DISCOUNT > 0);
------------------------------------ Creando FK's ------------------------------------
ALTER TABLE EXTRAS
ADD CONSTRAINT FK_EXTRAS_BOOKING_ID FOREIGN KEY (BOOKING_ID) REFERENCES BOOKING(BOOKING_ID);
-- AccionesOK
-------------------------------------- Validando casos significativos -------------------------------------
INSERT INTO BOOKING (BOOKING_ID, BOOKING_DATE, ROOM_NO, GUEST_ID, OCCUPANTS, ROOM_TYPE_REQUESTED, NIGHTS, ARRIVAL_TIME) VALUES 
(1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 101, 1, 2, 'STD', 3, '14:00');
INSERT INTO BOOKING (BOOKING_ID, BOOKING_DATE, ROOM_NO, GUEST_ID, OCCUPANTS, ROOM_TYPE_REQUESTED, NIGHTS, ARRIVAL_TIME) VALUES 
(2, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 102, 2, 1, 'DLX', 2, '15:00');
INSERT INTO BOOKING (BOOKING_ID, BOOKING_DATE, ROOM_NO, GUEST_ID, OCCUPANTS, ROOM_TYPE_REQUESTED, NIGHTS, ARRIVAL_TIME) VALUES 
(3, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 103, 3, 2, 'STD', 4, '13:00');
------------------------------------ PARTE B ------------------------------------
-- Disparadores
CREATE OR REPLACE TRIGGER trg_ExtraSIdCheck
BEFORE INSERT OR UPDATE ON EXTRAS
FOR EACH ROW
BEGIN
    IF :NEW.EXTRAS_ID < 9 THEN
        :NEW.EXTRAS_ID := 9;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER generar_id_extras
BEFORE INSERT ON EXTRAS
FOR EACH ROW
DECLARE
    v_counter NUMBER;
BEGIN
    -- Obtener el contador actual de registros en la tabla
    SELECT COUNT(*) INTO v_counter FROM EXTRAS;
    
    -- Generar el nuevo ID en el formato 9AAAAMMDDmmss
    :NEW.EXTRAS_ID := TO_NUMBER(TO_CHAR(SYSDATE, 'YYMMDD')) + v_counter;
END;
/
CREATE OR REPLACE TRIGGER TR_EXTRAS_BI
BEFORE INSERT ON EXTRAS
FOR EACH ROW
BEGIN
    -- Controlar el descuento maximo
    IF :NEW.DISCOUNT > (:NEW.AMOUNT * 0.5) THEN
        RAISE_APPLICATION_ERROR(-20001, 'El descuento no puede ser mayor al 50% del precio.');
    END IF;
    
    -- Aplicar descuento automatico si el precio es mayor a 100000 y no se indica descuento
    IF :NEW.AMOUNT > 100000 AND :NEW.DISCOUNT IS NULL THEN
        :NEW.DISCOUNT := 10;
        :NEW.DESCRIPTION := 'CON 10% de descuento automatico';
    END IF;
END;
/
-- XDisparadores
DROP TRIGGER trg_ExtraSIdCheck;
DROP TRIGGER generar_id_extras;
DROP TRIGGER TR_EXTRAS_BI;

-- DISPARADORES OK --
-- Se respetan los triggers de longitud, y autmaticamente se genera una pk con el dia y el acumulador
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(11, 1, 'Un ejemplo de entrada correcta',1,3);
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(12, 2, 'Seundo ejemplo',1,3);
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(111, 3, 'Tercer ejemplo',1,3);
-- DISPARADORES NO OK -- 
-- Este incumple el trigger TR_EXTRAS_BI al ser mayores que el 50%
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(110, 3, 'Error de Descuento',2,3);
-- Este incumple la longitud permitida del ID (a pesar que lo autogenera)
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(123456789111, 3, 'Es demasiado largo el ID',1,3);
-- Este no cumple con la referencia de reservacion en booking (no puede agregar un extra a una reservacion que no existe)
INSERT INTO EXTRAS(extras_id, booking_id, description, discount, amount) VALUES(211, 999, 'No hay referencia a una reservacion con ID 999',1,3);
------------------------------------------ AUTORESTUDIO 5 ------------------------------------------
----------------------------------- PARTE A OFRECIENDO SERVICIOS -----------------------------------
CREATE OR REPLACE PACKAGE PC_EXTRAS AS
    FUNCTION ad(
        description IN VARCHAR,
        amount IN NUMBER,
        discount IN NUMBER,
        booking_id IN NUMBER
    ) RETURN VARCHAR;
    PROCEDURE up_ad_detail(
        detail IN VARCHAR,
        extra_id IN NUMBER
    );
    FUNCTION co(extra_id IN NUMBER) RETURN SYS_REFCURSOR;
    PROCEDURE de(extra_id IN NUMBER);
    FUNCTION co_weeks RETURN SYS_REFCURSOR;
    FUNCTION co_byBooking(booking_id IN NUMBER) RETURN SYS_REFCURSOR;
END PC_EXTRAS;
/
CREATE SEQUENCE EXTRAS_SEQ START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE PACKAGE BODY PC_EXTRAS AS
    FUNCTION ad(
        description IN VARCHAR,
        amount IN NUMBER,
        discount IN NUMBER,
        booking_id IN NUMBER
    ) RETURN VARCHAR IS
    BEGIN
        INSERT INTO EXTRAS (EXTRAS_ID, BOOKING_ID, DESCRIPTION, DISCOUNT, AMOUNT)
        VALUES (EXTRAS_SEQ.NEXTVAL, booking_id, description, discount, amount);
        
        RETURN 'Extra agregado correctamente';
    END ad;
    PROCEDURE up_ad_detail(
        detail IN VARCHAR,
        extra_id IN NUMBER
    ) IS
    BEGIN
        UPDATE EXTRAS
        SET EXTRAS.DESCRIPTION = detail
        WHERE EXTRAS_ID = extra_id;
    END up_ad_detail;
    FUNCTION co(extra_id IN NUMBER) RETURN SYS_REFCURSOR IS
        extras_cursor SYS_REFCURSOR;
    BEGIN
        OPEN extras_cursor FOR
        SELECT * FROM EXTRAS WHERE EXTRAS_ID = extra_id;
        
        RETURN extras_cursor;
    END co;
    PROCEDURE de(extra_id IN NUMBER) IS
    BEGIN
        DELETE FROM EXTRAS WHERE EXTRAS_ID = extra_id;
    END de;
    FUNCTION co_weeks RETURN SYS_REFCURSOR IS
        extras_cursor SYS_REFCURSOR;
    BEGIN
        OPEN extras_cursor FOR
        SELECT * FROM EXTRAS WHERE TRUNC(SYSDATE) - TRUNC((SELECT BOOKING_DATE FROM BOOKING WHERE BOOKING_ID = EXTRAS.BOOKING_ID)) <= 7;
        
        RETURN extras_cursor;
    END co_weeks;
    FUNCTION co_byBooking(booking_id IN NUMBER) RETURN SYS_REFCURSOR IS
        extras_cursor SYS_REFCURSOR;
    BEGIN
        OPEN extras_cursor FOR
        SELECT * FROM EXTRAS WHERE BOOKING_ID = booking_id;
        
        RETURN extras_cursor;
    END co_byBooking;
END PC_EXTRAS;
/

------------------------------------- CRUDOK -------------------------------------
DECLARE
    result VARCHAR2(100);
BEGIN
    result := PC_EXTRAS.ad('Descuento especial', 50, 10, 1);
    DBMS_OUTPUT.PUT_LINE(result);
END;
BEGIN
    PC_EXTRAS.up_ad_detail('Nuevo detalle', 240425);
END;
BEGIN
    PC_EXTRAS.de(1);
END;
-- Para consultar un extra por su ID
DECLARE
    extras_cursor SYS_REFCURSOR;
BEGIN
    extras_cursor := PC_EXTRAS.co(1);
    DBMS_SQL.RETURN_RESULT(extras_cursor);
END;
/
-- Para consultar todos los extras de la semana actual
DECLARE
    extras_cursor SYS_REFCURSOR;
BEGIN
    extras_cursor := PC_EXTRAS.co_weeks;
    DBMS_SQL.RETURN_RESULT(extras_cursor);
END;
/
-- Para consultar todos los extras de una reserva específica
DECLARE
    extras_cursor SYS_REFCURSOR;
BEGIN
    extras_cursor := PC_EXTRAS.co_byBooking(1);
    DBMS_SQL.RETURN_RESULT(extras_cursor);
END;
/
------------------------------------- CRUDNOOK -------------------------------------
DECLARE
    result VARCHAR2(100);
BEGIN
    -- Intentamos agregar un extra con un descuento mayor al 50% del precio
    result := PC_EXTRAS.ad('Descuento especial', 100, 60, 1);
    DBMS_OUTPUT.PUT_LINE(result);
END;
BEGIN
    -- Intentamos actualizar el detalle de un extra que no existe, se ejecuta pero no altera la tabla
    PC_EXTRAS.up_ad_detail('Nuevo detalle', 888);
END;
BEGIN
    -- Intentamos eliminar un extra que no existe, se ejecuta pero no altera la tabla
    PC_EXTRAS.de(999);
END;
------------------------------------- XPAQUETES -------------------------------------
DROP PACKAGE PC_EXTRAS;
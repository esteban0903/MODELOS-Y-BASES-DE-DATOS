/*
En SQL Estándar

------------------------------- INTEGRIDAD DECLARATIVA -------------------------------
1)
CREATE DOMAIN TCREDITOS AS VARCHAR(19)
CONSTRAINT CHECK  (REGEXP_LIKE(tarjetaCredito, '^\d{6}x+\d{4}$'));
2)
CREATE DOMAIN TESTADO AS CHAR
CONSTRAINT CHECK (estado IN ('A','R','P'));
3)
CREATE ASSERTION NOTIFICACIONES_ASSERTION
CHECK (NOT EXISTS((SELECT COUNT(*) AS CANTIDAD 
FROM NOTIFICACIONINCUMPLIMIENTO) > 20));
4)
CREATE ASSERTION BIBLIOTECA_ASSERTION
CHECK (SELECT COUNT(*) FROM CANCIONES >= 1 OR
SELECT COUNT(*) FROM EPISODIOS >= 1
);

------------------------------- INTEGRIDAD PROCEDIMENTAL -------------------------------
ADICIONAR:
1)
TR_NOTIFICACIONINCUMPLIMIENTO 
BEFORE INSERT
Este trigger verifica las fechas de factura de Nofiticación Incumplimiento,
comprobando que la diferencia de las fechas sea mayor o igual a 5 días, además
también comprueba que el estado de factura sea pendiente.
2)
TR_BONOPROMOCIONAL
BEFORE INSERT
Este trigger realiza una concatenación donde la primera posición es el número de meses
sin notificación y la segunda y tercera posición son los últimos dígitos del año en curso.
3)
TR_OYENTEPAGO
BEFORE INSERT
Este trigger verifica si hay una notificación de incumplimiento y en caso de que lo haya 
reinicia el número de meses del oyente pago a cero.

MODIFICAR:
1)
TR_FACTURA
BEFORE UPDATE
Este trigger verifica el estado de la factura y si está en aprobado 
o en proceso no permite que se modifique, además, solo permite modificar el estado y url.
2)
TR_NOTIFICACIONINCUMPLIMIENTO_UPDATE
BEFORE UPDATE
Este trigger no permite modificar una notificación de incumplimiento.
3)
TR_BONOPROMOCIONAL_UPDATE
BEFORE UPDATE
Este trigger solo permite modificar el mensaje del bono promocional

ELIMINAR
1)
TR_BONOPROMOCIONAL_DELETE
BEFORE DELETE
Este trigger no permite eliminar la factura si se elimina el bono promocional.
2)
TR_NOTIFICACIONINCUMPLIMIENTO_DELETE
BEFORE DELETE
Este trigger no permite que se eliminen notificaciones de incumplimiento y facturas.

*/


CREATE TABLE CANCIONES(
    
    nombre VARCHAR(50) NOT NULL,
    bibliotecaI NUMBER NOT NULL,
    bibliotecaN NUMBER(15) NOT NULL,
    bibliotecaT VARCHAR(2) NOT NULL,
    duracion NUMBER NOT NULL,
    fechaCreacion DATE
);

CREATE TABLE EPISODIOS(
    descripcion VARCHAR(100) ,
    titulo VARCHAR(50) NOT NULL,
    bibliotecaI NUMBER NOT NULL,
    bibliotecaN NUMBER(15) NOT NULL,
    bibliotecaT VARCHAR(2) NOT NULL,
);

CREATE TABLE BIBLIOTECAS(
    id NUMBER NOT NULL, 
    oyenteN NUMBER(15) NOT NULL, 
    oyenteT VARCHAR(2) NOT NULL, 
    nombre VARCHAR(59) NOT NULL, 
    clienteN NUMBER(15) NOT NULL, 
    clienteT VARCHAR(2) NOT NULL,
);
    
CREATE TABLE CLIENTES(
    numDoc  NUMBER(15)  NOT NULL,
    tipoDoc VARCHAR(2)  NOT NULL,
    nombreApellido  VARCHAR(200) NOT NULL,
    correoElectronico   VARCHAR(150)    NOT NULL
    
);
    

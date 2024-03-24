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
articuloI VARCHAR(20) NOT NULL,
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
total INT NOT NULL,
fechaCompra DATE NOT NULL
);

CREATE TABLE ARTICULOS(
idArticulo VARCHAR(20) NOT NULL,
prestamoI VARCHAR(20) NOT NULL,
genero VARCHAR(20),
descripcion VARCHAR(100) NOT NULL,
fechaPublicacion DATE 
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
reservaI VARCHAR(20) NOT NULL,
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
total INT NOT NULL,
estado CHAR(1) NOT NULL
);

CREATE TABLE MULTAS(
facturaI VARCHAR(20) NOT NULL,
idMulta VARCHAR(20) NOT NULL,
monto INT NOT NULL,
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

---ALTER TABLE nombreUsuario ADD CONSTRAINT CK_SUSCRITOS_nombreUsuario_Tcredencial;

ALTER TABLE FISICOS ADD CONSTRAINT CK_FISICOS_disponible_Tbooleano CHECK (disponible in ('Y','N'));

ALTER TABLE DIGITALES ADD CONSTRAINT CK_DIGITALES_formato_Tformato CHECK (formato in ('PDF','EPUB','MOBI'));

ALTER TABLE RESERVAS ADD CONSTRAINT CK_RESERVAS_estado_Testado CHECK(estado in('A','D'));
ALTER TABLE DEVOLUCIONES ADD CONSTRAINT CK_DEVOLUCIONES_estado_Testado CHECK(estado in('A','D'));
ALTER TABLE FACTURAS ADD CONSTRAINT CK_FACTURAS_estado_Testado CHECK(estado in('A','D'));


CREATE OR REPLACE TRIGGER TR_SUSCRITOS_nombreUsuario
BEFORE INSERT ON SUSCRITOS
FOR EACH ROW
BEGIN
    :new.nombreUsuario := :new.nombre || '_' || :new.apellido || '_' || :new.clienteI;
END;
/

DROP TRIGGER TR_SUSCRITOS_nombreUsuario;
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

ALTER TABLE PROVEEDORES ADD CONSTRAINT FK_PROVEEDORES_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(idArticulo)
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

---------------------------------------XTABLAS---------------------------------------
drop table "BD1000095983"."ARTICULOS" cascade constraints PURGE;
drop table "BD1000095983"."AUTORES" cascade constraints PURGE;
drop table "BD1000095983"."CLIENTES" cascade constraints PURGE;
drop table "BD1000095983"."DEVOLUCIONES" cascade constraints PURGE;
drop table "BD1000095983"."DIGITALES" cascade constraints PURGE;
drop table "BD1000095983"."FACTURAS" cascade constraints PURGE;
drop table "BD1000095983"."MULTAS" cascade constraints PURGE;
drop table "BD1000095983"."PRESTAMOS" cascade constraints PURGE;
drop table "BD1000095983"."PROVEEDORES" cascade constraints PURGE;
drop table "BD1000095983"."RESERVAS" cascade constraints PURGE;
drop table "BD1000095983"."SUSCRITOS" cascade constraints PURGE;
drop table "BD1000095983"."VENTAS" cascade constraints PURGE;
drop table "BD1000095983"."FISICOS" cascade constraints PURGE;

---------------------------------------CONSULTAS---------------------------------------
---Consultar prestamo---
SELECT * FROM PRESTAMOS
;
---Consultar libros fisicos disponibles---
SELECT * FROM ARTICULOS a
JOIN FISICOS b ON a.idArticulo=b.articuloI
WHERE estado='Y' 
;
---Consultar mis facturas---
SELECT * FROM FACTURAS a
JOIN PRESTAMOS b ON b.reservaI=a.prestamoI
JOIN CLIENTES c ON c.idCliente=b.clienteI and c.tidCliente=b.clienteT
WHERE c.idCliente='123'
;
---Consultar libros disponibles por nombre---
SELECT idArticulo FROM ARTICULOS a
JOIN FISICOS b ON a.idArticulo=b.articuloI
WHERE estado='Y'
;
---Consultar datos de cliente---
SELECT * FROM CLIENTES
;
---Consultar préstamos en mora---
SELECT idPrestamo FROM PRESTAMOS a
JOIN DEVOLUCIONES b ON a.idPrestamo=b.prestamoI
WHERE a.fechaDevolucionEstimada<b.fechaDevolucion
;
---------------------------------------POBLAROK---------------------------------------
INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C001','CC');

INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C002','CE');

INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C003','TI');


INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C001','CC','Nom1_Ape1_C001','T','Nom1','Ape1');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C002','CE','NomUs2','E','Nom2','Ape2');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C003','TI','NomUs3','C','Nom3','Ape3');


INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C001','CC','R001','A');

INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C002','CE','R002','D');

INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C003','TI','R003','A');


INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C001', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C002', 'CE','P002', 'R002',TO_DATE('2024-01-02', 'YYYY-MM-DD'),TO_DATE('2024-02-02', 'YYYY-MM-DD'));

INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C003', 'TI','P003', 'R003',TO_DATE('2024-01-03', 'YYYY-MM-DD'),TO_DATE('2024-02-03', 'YYYY-MM-DD'));


INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P001', 'A',TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P002', 'D',TO_DATE('2024-03-02', 'YYYY-MM-DD'));

INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P003', 'A',TO_DATE('2024-03-03', 'YYYY-MM-DD'));


INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P001', 'F001','T',TO_DATE('2024-04-01', 'YYYY-MM-DD'),1,'A');

INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P002', 'F002','E',TO_DATE('2024-04-02', 'YYYY-MM-DD'),2,'D');

INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P003', 'F003','C',TO_DATE('2024-04-03', 'YYYY-MM-DD'),3,'A');


INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F001', 'M001',1,'Des1');

INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F002', 'M002',1,'Des2');

INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F003', 'M003',1,'Des3');


INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A001', 'P001', 'GEN1','DES1',TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A002', 'P002', 'GEN2','DES2',TO_DATE('2024-03-21', 'YYYY-MM-DD'));

INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A003', 'P003', 'GEN3','DES3',TO_DATE('2024-03-22', 'YYYY-MM-DD'));


INSERT INTO AUTORES(articuloI,autor)
VALUES('A001','Autores1');

INSERT INTO AUTORES(articuloI,autor)
VALUES('A002','Autores2');

INSERT INTO AUTORES(articuloI,autor)
VALUES('A003','Autores3');


INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A001','Est1','Y');

INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A002','Est2','N');

INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A003','Est3','Y');


INSERT INTO DIGITALES(articuloI,formato)
VALUES('A001','PDF');

INSERT INTO DIGITALES(articuloI,formato)
VALUES('A002','EPUB');

INSERT INTO DIGITALES(articuloI,formato)
VALUES('A003','MOBI');


INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A001','C001','CC','Cat1','Correo1');

INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A002','C002','CE','Cat2','Correo2');

INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A003','C003','TI','Cat3','Correo3');


INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A001','C001','CC','IC001','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A002','C002','CE','IC002','E',1,TO_DATE('2024-09-16', 'YYYY-MM-DD'));

INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A003','C003','TI','IC003','C',1,TO_DATE('2024-09-17', 'YYYY-MM-DD'));

---------------------------------------POBLARNOOK---------------------------------------
-- Tabla CLIENTES (Primary Key) --
-- Debería fallar porque se está intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C001','CC');

-- Debería fallar porque se está intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C001','CC');

-- Debería fallar porque se está intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C001','CC');

-- Debería fallar porque se está intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C001','CC');

-- Tabla CLIENTES (Check Constraint) --
-- Debería fallar porque el tipo de documento especificado no está en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C004','OT');

-- Debería fallar porque el tipo de documento especificado no está en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C004','OT');

-- Debería fallar porque el tipo de documento especificado no está en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C004','OT');

-- Debería fallar porque el tipo de documento especificado no está en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C004','OT');

-- Tabla SUSCRITOS (Unique Key) --
-- Debería fallar porque se está intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CE','NomUs3','C','Nom3','Ape3');

-- Debería fallar porque se está intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CE','NomUs3','C','Nom3','Ape3');

-- Debería fallar porque se está intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CE','NomUs3','C','Nom3','Ape3');

-- Debería fallar porque se está intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C004','CE','NomUs3','C','Nom3','Ape3');

-- Tabla RESERVAS (Primary Key) --
-- Debería fallar porque se está intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R001','A');

-- Debería fallar porque se está intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R001','A');

-- Debería fallar porque se está intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R001','A');

-- Debería fallar porque se está intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R001','A');

-- Tabla RESERVAS (Check Constraint) --
-- Debería fallar porque se está intentando insertar una reserva con un estado que no está permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R005','Z');

-- Debería fallar porque se está intentando insertar una reserva con un estado que no está permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R005','Z');

-- Debería fallar porque se está intentando insertar una reserva con un estado que no está permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R005','Z');

-- Debería fallar porque se está intentando insertar una reserva con un estado que no está permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C001','CC','R005','Z');

-- Tabla PROVEEDORES (Unique Key) --
-- Debería fallar porque se está intentando insertar un proveedor con un correo electrónico que ya existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C004','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un correo electrónico que ya existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C004','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un correo electrónico que ya existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C004','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un correo electrónico que ya existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C004','TI','Cat4','Correo3');

-- Tabla PROVEEDORES (Foreign Key) --
-- Debería fallar porque se está intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C009','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C009','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C009','TI','Cat4','Correo3');

-- Debería fallar porque se está intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A004','C009','TI','Cat4','Correo3');


-- Tabla VENTAS (Foreign Key) --
-- Debería fallar porque se está intentando insertar una venta con un artículo que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A009','C005','CC','IC005','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A005','C009','TI','IC009','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A006','C010','TI','IC010','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A007','C011','TI','IC011','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));
-- Tabla PRESTAMOS (Primary Key) --
-- Debería fallar porque se está intentando insertar un préstamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C001', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un préstamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C002', 'CE','P002', 'R002',TO_DATE('2024-01-02', 'YYYY-MM-DD'),TO_DATE('2024-02-02', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un préstamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C003', 'TI','P003', 'R003',TO_DATE('2024-01-03', 'YYYY-MM-DD'),TO_DATE('2024-02-03', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un préstamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C004', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

-- Tabla MULTAS (Primary Key) --
-- Debería fallar porque se está intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F001', 'M001',1,'Des1');

-- Debería fallar porque se está intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F002', 'M002',1,'Des2');

-- Debería fallar porque se está intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F003', 'M003',1,'Des3');

-- Debería fallar porque se está intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F004', 'M001',1,'Des4');

-- Tabla FISICOS (Check Constraint) --
-- Debería fallar porque se está intentando insertar un libro físico con un estado que no es válido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A001','EstadoInvalido','Y');

-- Debería fallar porque se está intentando insertar un libro físico con un estado que no es válido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A002','EstadoInvalido','Y');

-- Debería fallar porque se está intentando insertar un libro físico con un estado que no es válido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A003','EstadoInvalido','Y');

-- Debería fallar porque se está intentando insertar un libro físico con un estado que no es válido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A004','EstadoInvalido','Y');

-- Tabla FACTURAS (Check Constraint) --
-- Debería fallar porque se está intentando insertar una factura con un método de pago que no es válido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P001', 'F001','MetodoInvalido',TO_DATE('2024-04-01', 'YYYY-MM-DD'),1,'A');

-- Debería fallar porque se está intentando insertar una factura con un método de pago que no es válido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P002', 'F002','MetodoInvalido',TO_DATE('2024-04-02', 'YYYY-MM-DD'),2,'D');

-- Debería fallar porque se está intentando insertar una factura con un método de pago que no es válido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P003', 'F003','MetodoInvalido',TO_DATE('2024-04-03', 'YYYY-MM-DD'),3,'A');

-- Debería fallar porque se está intentando insertar una factura con un método de pago que no es válido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P004', 'F004','MetodoInvalido',TO_DATE('2024-04-04', 'YYYY-MM-DD'),4,'A');

-- Tabla DIGITALES (Check Constraint) --
-- Debería fallar porque se está intentando insertar un libro digital con un formato que no es válido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A001','FormatoInvalido');

-- Debería fallar porque se está intentando insertar un libro digital con un formato que no es válido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A002','FormatoInvalido');

-- Debería fallar porque se está intentando insertar un libro digital con un formato que no es válido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A003','FormatoInvalido');

-- Debería fallar porque se está intentando insertar un libro digital con un formato que no es válido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A004','FormatoInvalido');

-- Tabla AUTORES (Primary Key) --
-- Debería fallar porque se está intentando insertar un autor para un artículo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A001','Autor1');

-- Debería fallar porque se está intentando insertar un autor para un artículo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A001','Autor2');

-- Debería fallar porque se está intentando insertar un autor para un artículo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A004','Autor2');

-- Tabla ARTICULOS (Primary Key) --
-- Debería fallar porque se está intentando insertar un artículo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A001', 'P001', 'Genero1','Descripcion1',TO_DATE('2024-03-20', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un artículo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A002', 'P002', 'Genero2','Descripcion2',TO_DATE('2024-03-21', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un artículo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A003', 'P003', 'Genero3','Descripcion3',TO_DATE('2024-03-22', 'YYYY-MM-DD'));

-- Debería fallar porque se está intentando insertar un artículo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion)
VALUES ('A004', 'P004', 'Genero4','Descripcion4',TO_DATE('2024-03-23', 'YYYY-MM-DD'));
---------------------------------------XPOBLAR---------------------------------------

DELETE FROM CLIENTES;
DELETE FROM DEVOLUCIONES;
DELETE FROM DIGITALES;
DELETE FROM FACTURAS;
DELETE FROM FISICOS;
DELETE FROM MULTAS;
DELETE FROM PRESTAMOS;
DELETE FROM PROVEEDORES;
DELETE FROM RESERVAS;
DELETE FROM SUSCRITOS;
DELETE FROM VENTAS;
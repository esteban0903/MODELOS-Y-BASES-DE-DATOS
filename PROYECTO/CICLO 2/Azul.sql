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

---------------------------------------XTABLAS---------------------------------------
drop table "ARTICULOS" cascade constraints PURGE;
drop table "AUTORES" cascade constraints PURGE;
drop table "CLIENTES" cascade constraints PURGE;
drop table "DEVOLUCIONES" cascade constraints PURGE;
drop table "DIGITALES" cascade constraints PURGE;
drop table "FACTURAS" cascade constraints PURGE;
drop table "MULTAS" cascade constraints PURGE;
drop table "PRESTAMOS" cascade constraints PURGE;
drop table "PROVEEDORES" cascade constraints PURGE;
drop table "RESERVAS" cascade constraints PURGE;
drop table "SUSCRITOS" cascade constraints PURGE;
drop table "VENTAS" cascade constraints PURGE;
drop table "FISICOS" cascade constraints PURGE;

---------------------------------------CONSULTAS---------------------------------------
---Consultar prestamo---
SELECT * FROM PRESTAMOS
;
---Consultar libros fisicos disponibles---
SELECT * FROM ARTICULOS a
JOIN FISICOS b ON a.idArticulo=b.articuloI
WHERE disponible='Y' 
;
---Consultar mis facturas---
SELECT * FROM FACTURAS a
JOIN PRESTAMOS b ON b.reservaI=a.prestamoI
JOIN CLIENTES c ON c.idCliente=b.clienteI and c.tidCliente=b.clienteT
WHERE c.idCliente='123'
;
---Consultar libros disponibles por nombre---
SELECT nombreArticulo FROM ARTICULOS a
JOIN FISICOS b ON a.idArticulo=b.articuloI
WHERE disponible='Y'
;
---Consultar datos de cliente---
SELECT * FROM CLIENTES
;
---Consultar prestamos en mora---
SELECT idPrestamo FROM PRESTAMOS a
JOIN DEVOLUCIONES b ON a.idPrestamo=b.prestamoI
WHERE a.fechaDevolucionEstimada<b.fechaDevolucion
;
---------------------------------------POBLAROK---------------------------------------
INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C00D1','CC');

INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C002','CE');

INSERT INTO CLIENTES(idCliente,  tidCliente)
VALUES('C003','TI');


INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C1','CC','NomUs1','T','Nom1','Ape1');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C2','CE','NomUs2','E','Nom2','Ape2');

INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C3','TI','NomUs3','C','Nom3','Ape3');


INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C1','CC','R001','A');

INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C2','CE','R002','D');

INSERT INTO RESERVAS(clienteI,clienteT,idReserva,  estado)
VALUES ('C3','TI','R003','A');


INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C1', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C2', 'CE','P002', 'R002',TO_DATE('2024-01-02', 'YYYY-MM-DD'),TO_DATE('2024-02-02', 'YYYY-MM-DD'));

INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C3', 'TI','P003', 'R003',TO_DATE('2024-01-03', 'YYYY-MM-DD'),TO_DATE('2024-02-03', 'YYYY-MM-DD'));


INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P1', 'A',TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P2', 'D',TO_DATE('2024-03-02', 'YYYY-MM-DD'));

INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
VALUES ('P3', 'A',TO_DATE('2024-03-03', 'YYYY-MM-DD'));


INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P1', 'F001','T',TO_DATE('2024-04-01', 'YYYY-MM-DD'),1,'A');

INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P2', 'F002','E',TO_DATE('2024-04-02', 'YYYY-MM-DD'),2,'D');

INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P3', 'F003','C',TO_DATE('2024-04-03', 'YYYY-MM-DD'),3,'A');


INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F1', 'M001',1,'Des1');

INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F2', 'M002',1,'Des2');

INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F3', 'M003',1,'Des3');


INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A001', 'P1', 'GEN1','DES1',TO_DATE('2024-03-20', 'YYYY-MM-DD'),'GOT');

INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A002', 'P2', 'GEN2','DES2',TO_DATE('2024-03-21', 'YYYY-MM-DD'),'Boulevard');

INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A003', 'P3', 'GEN3','DES3',TO_DATE('2024-03-22', 'YYYY-MM-DD'),'El principe');

INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A004', NULL, 'GEN3','DES3',TO_DATE('2024-03-22', 'YYYY-MM-DD'),'El principe');

INSERT INTO AUTORES(articuloI,autor)
VALUES('A1','Autores1');

INSERT INTO AUTORES(articuloI,autor)
VALUES('A2','Autores2');

INSERT INTO AUTORES(articuloI,autor)
VALUES('A3','Autores3');


INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A1','Est1','Y');

INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A2','Est2','N');

INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A3','Est3','Y');

INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A4','Est4','N');

INSERT INTO DIGITALES(articuloI,formato)
VALUES('A1','PDF');

INSERT INTO DIGITALES(articuloI,formato)
VALUES('A2','EPUB');

INSERT INTO DIGITALES(articuloI,formato)
VALUES('A3','MOBI');


INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Jaun','C1','CC','Cat1','Correo1');

INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Carlos','C2','CE','Cat2','Correo2');

INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Samuel','C3','TI','Cat3','Correo3');


INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A1','C1','CC','IC1','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A2','C2','CE','IC2','E',1,TO_DATE('2024-09-16', 'YYYY-MM-DD'));

INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A3','C3','TI','IC3','C',1,TO_DATE('2024-09-17', 'YYYY-MM-DD'));

---------------------------------------POBLARNOOK---------------------------------------
-- Tabla CLIENTES (Primary Key) --
-- Deberia fallar porque se esta intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C1','CC');

-- Deberia fallar porque se esta intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C1','CC');

-- Deberia fallar porque se esta intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C1','CC');

-- Deberia fallar porque se esta intentando insertar un cliente con una clave primaria que ya existe --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C1','CC');

-- Tabla CLIENTES (Check Constraint) --
-- Deberia fallar porque el tipo de documento especificado no esta en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C4','OT');

-- Deberia fallar porque el tipo de documento especificado no esta en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C4','OT');

-- Deberia fallar porque el tipo de documento especificado no esta en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C4','OT');

-- Deberia fallar porque el tipo de documento especificado no esta en la lista de valores permitidos --
INSERT INTO CLIENTES(idCliente, tidCliente)
VALUES('C4','OT');

-- Tabla SUSCRITOS (Unique Key) --
-- Deberia fallar porque se esta intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CE','NomUs3','C','Nom3','Ape3');

-- Deberia fallar porque se esta intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CE','NomUs3','C','Nom3','Ape3');

-- Deberia fallar porque se esta intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CE','NomUs3','C','Nom3','Ape3');

-- Deberia fallar porque se esta intentando insertar un usuario con un nombre de usuario que ya existe --
INSERT INTO SUSCRITOS(clienteI,clienteT,nombreUsuario,metodoPago,nombre,apellido)
VALUES('C4','CE','NomUs3','C','Nom3','Ape3');

-- Tabla RESERVAS (Primary Key) --
-- Deberia fallar porque se esta intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R001','A');

-- Deberia fallar porque se esta intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R001','A');

-- Deberia fallar porque se esta intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R001','A');

-- Deberia fallar porque se esta intentando insertar una reserva con un ID que ya existe --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R001','A');

-- Tabla RESERVAS (Check Constraint) --
-- Deberia fallar porque se esta intentando insertar una reserva con un estado que no esta permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R005','Z');

-- Deberia fallar porque se esta intentando insertar una reserva con un estado que no esta permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R005','Z');

-- Deberia fallar porque se esta intentando insertar una reserva con un estado que no esta permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R005','Z');

-- Deberia fallar porque se esta intentando insertar una reserva con un estado que no esta permitido --
INSERT INTO RESERVAS(clienteI,clienteT,idReserva, estado)
VALUES ('C1','CC','R005','Z');

-- Tabla PROVEEDORES (Unique Key) --
-- Deberia fallar porque se esta intentando insertar un proveedor con un correo electronico que ya existe --
INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Lex Corp','C4','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un correo electronico que ya existe --
INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Injustice','C4','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un correo electronico que ya existe --
INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('BTS','C4','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un correo electronico que ya existe --
INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('Tesla','C4','TI','Cat4','Correo3');

-- Tabla PROVEEDORES (Foreign Key) --
-- Deberia fallar porque se esta intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A4','C9','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A4','C9','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A4','C9','TI','Cat4','Correo3');

-- Deberia fallar porque se esta intentando insertar un proveedor con un cliente que no existe --
INSERT INTO PROVEEDORES(articuloI,clienteI,clienteT,catalogo,correoElectronico)
VALUES('A4','C9','TI','Cat4','Correo3');


-- Tabla VENTAS (Foreign Key) --
-- Deberia fallar porque se esta intentando insertar una venta con un articulo que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A9','C5','CC','IC5','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A5','C9','TI','IC9','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A6','C010','TI','IC010','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar una venta con un cliente que no existe --
INSERT INTO VENTAS(articuloI, clienteI,clienteT, idCompra,metodoPago,total,fechaCompra)
VALUES('A7','C011','TI','IC011','T',1,TO_DATE('2024-09-15', 'YYYY-MM-DD'));
-- Tabla PRESTAMOS (Primary Key) --
-- Deberia fallar porque se esta intentando insertar un prestamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C1', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar un prestamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C2', 'CE','P002', 'R002',TO_DATE('2024-01-02', 'YYYY-MM-DD'),TO_DATE('2024-02-02', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar un prestamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C3', 'TI','P003', 'R003',TO_DATE('2024-01-03', 'YYYY-MM-DD'),TO_DATE('2024-02-03', 'YYYY-MM-DD'));

-- Deberia fallar porque se esta intentando insertar un prestamo con una ID que ya existe --
INSERT INTO PRESTAMOS(clienteI,clienteT,idPrestamo,reservaI,fechaEntrega,FechaDevolucionEstimada)
VALUES ('C4', 'CC','P001', 'R001',TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

-- Tabla MULTAS (Primary Key) --
-- Deberia fallar porque se esta intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F001', 'M001',1,'Des1');

-- Deberia fallar porque se esta intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F002', 'M002',1,'Des2');

-- Deberia fallar porque se esta intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F003', 'M003',1,'Des3');

-- Deberia fallar porque se esta intentando insertar una multa con una ID que ya existe --
INSERT INTO MULTAS(facturaI,idMulta,monto,descripcion)
VALUES ('F004', 'M001',1,'Des4');

-- Tabla FISICOS (Check Constraint) --
-- Deberia fallar porque se esta intentando insertar un libro fisico con un estado que no es valido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A1','EstadoInvalido','Y');

-- Deberia fallar porque se esta intentando insertar un libro fisico con un estado que no es valido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A2','EstadoInvalido','Y');

-- Deberia fallar porque se esta intentando insertar un libro fisico con un estado que no es valido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A3','EstadoInvalido','Y');

-- Deberia fallar porque se esta intentando insertar un libro fisico con un estado que no es valido --
INSERT INTO FISICOS(articuloI,estado,disponible)
VALUES('A4','EstadoInvalido','Y');

-- Tabla FACTURAS (Check Constraint) --
-- Deberia fallar porque se esta intentando insertar una factura con un metodo de pago que no es valido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P001', 'F001','MetodoInvalido',TO_DATE('2024-04-01', 'YYYY-MM-DD'),1,'A');

-- Deberia fallar porque se esta intentando insertar una factura con un metodo de pago que no es valido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P002', 'F002','MetodoInvalido',TO_DATE('2024-04-02', 'YYYY-MM-DD'),2,'D');

-- Deberia fallar porque se esta intentando insertar una factura con un metodo de pago que no es valido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P003', 'F003','MetodoInvalido',TO_DATE('2024-04-03', 'YYYY-MM-DD'),3,'A');

-- Deberia fallar porque se esta intentando insertar una factura con un metodo de pago que no es valido --
INSERT INTO FACTURAS(prestamoI, idFactura,metodoPago,fecha,total,estado)
VALUES ('P004', 'F004','MetodoInvalido',TO_DATE('2024-04-04', 'YYYY-MM-DD'),4,'A');

-- Tabla DIGITALES (Check Constraint) --
-- Deberia fallar porque se esta intentando insertar un libro digital con un formato que no es valido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A1','FormatoInvalido');

-- Deberia fallar porque se esta intentando insertar un libro digital con un formato que no es valido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A2','FormatoInvalido');

-- Deberia fallar porque se esta intentando insertar un libro digital con un formato que no es valido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A3','FormatoInvalido');

-- Deberia fallar porque se esta intentando insertar un libro digital con un formato que no es valido --
INSERT INTO DIGITALES(articuloI,formato)
VALUES('A4','FormatoInvalido');

-- Tabla AUTORES (Primary Key) --
-- Deberia fallar porque se esta intentando insertar un autor para un articulo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A1','Autor1');

-- Deberia fallar porque se esta intentando insertar un autor para un articulo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A1','Autor2');

-- Deberia fallar porque se esta intentando insertar un autor para un articulo que ya tiene ese autor --
INSERT INTO AUTORES(articuloI,autor)
VALUES('A4','Autor2');

-- Tabla ARTICULOS (Primary Key) --
-- Deberia fallar porque se esta intentando insertar un articulo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A1', 'P001', 'Genero1','Descripcion1',TO_DATE('2024-03-20', 'YYYY-MM-DD'),'El extranjero');

-- Deberia fallar porque se esta intentando insertar un articulo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A2', 'P002', 'Genero2','Descripcion2',TO_DATE('2024-03-21', 'YYYY-MM-DD'),'La divina comedia');

-- Deberia fallar porque se esta intentando insertar un articulo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A3', 'P003', 'Genero3','Descripcion3',TO_DATE('2024-03-22', 'YYYY-MM-DD'),'Pet Sematary');

-- Deberia fallar porque se esta intentando insertar un articulo con una ID que ya existe --
INSERT INTO ARTICULOS(idArticulo,prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
VALUES ('A4', 'P004', 'Genero4','Descripcion4',TO_DATE('2024-03-23', 'YYYY-MM-DD'),'Revival');
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
DELETE FROM ARTICULOS;



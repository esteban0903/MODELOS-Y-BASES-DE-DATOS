/* CICLO 1: TABLAS
Creación de Tablas

CREATE TABLE USUARIOS(
    universidadC    VARCHAR(3) NOT NULL,
    codigo          VARCHAR(3) NOT NULL,
    tid             VARCHAR(50) NOT NULL, -- Reemplazado por VARCHAR(50)
    nid             VARCHAR(3) NOT NULL,
    nombre          VARCHAR(50),
    programa        VARCHAR(20),
    correo          VARCHAR(50) NOT NULL,
    registro        DATE NOT NULL,
    suspension      DATE,
    nSuspensiones   INTEGER
);

CREATE TABLE UNIVERSIDAD(
codigo          VARCHAR(3) NOT NULL,
usuarioTid      VARCHAR(3),
usuarioNid      VARCHAR(3),
representante   VARCHAR(10),
nombre          VARCHAR(20),
direccion       VARCHAR(50)
);

CREATE TABLE CALIFICACIONES(
    usuarioUtid VARCHAR(3) NOT NULL,
    usuarioUnid VARCHAR(3) NOT NULL,
    usuarioCtid VARCHAR(3) NOT NULL,
    usuarioCnid VARCHAR(3) NOT NULL,
    articuloI    INTEGER NOT NULL, -- Reemplazado por INTEGER
    estrellas    INTEGER -- Reemplazado por INTEGER
);

CREATE TABLE ARTICULO(
    id          INTEGER NOT NULL, -- Reemplazado por INTEGER
    usuarioUtid VARCHAR(3) NOT NULL,
    usuarioUnid VARCHAR(3) NOT NULL,
    usuarioCtid VARCHAR(3) NOT NULL,
    usuarioCnid VARCHAR(3) NOT NULL,
    categoriaC  VARCHAR(5) NOT NULL,
    descripcion VARCHAR(20),
    estado      VARCHAR(20), -- Reemplazado por VARCHAR(20)
    foto        VARCHAR(255), -- Reemplazado por VARCHAR(255)
    precio      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    disponible  CHAR(1) -- Reemplazado por CHAR(1)
);

CREATE TABLE PERECEDERO(
    articuloI   INTEGER NOT NULL, -- Reemplazado por INTEGER
    vencimiento DATE
);

CREATE TABLE ROPAS(
    articuloI   INTEGER NOT NULL, -- Reemplazado por INTEGER
    talla       VARCHAR(10), -- Reemplazado por VARCHAR(10)
    material    VARCHAR(10),
    color       VARCHAR(10)
);

CREATE TABLE CARACTERISTICAS(
    articuloI   INTEGER NOT NULL, -- Reemplazado por INTEGER
    caracteristica VARCHAR(20)
);

CREATE TABLE CATEGORIAS(
    codigo      VARCHAR(5) NOT NULL,
    nombre      VARCHAR(20),
    tipo        VARCHAR(20), -- Reemplazado por VARCHAR(20)
    minimo      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    maximo      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    auditoriaI  INTEGER -- Reemplazado por INTEGER
);

CREATE TABLE PERTENEC(
    CategoriaC1 VARCHAR(5) NOT NULL,
    CategoriaC2 VARCHAR(5) NOT NULL
);

CREATE TABLE AUDITORIAS(
    id      INTEGER, -- Reemplazado por INTEGER
    fecha   DATE,
    ACCION  VARCHAR(20), -- Reemplazado por VARCHAR(20)
    nombre  VARCHAR(20)
);

CREATE TABLE EVALUACION(
    a_omes      VARCHAR(20) NOT NULL, -- Reemplazado por VARCHAR(20)
    tid         VARCHAR(50), -- Reemplazado por VARCHAR(50)
    nid         VARCHAR(10),
    fecha       DATE,
    descripcion VARCHAR(255), -- Reemplazado por VARCHAR(255)
    reporte     VARCHAR(255) UNIQUE, -- Reemplazado por VARCHAR(255)
    resultado   VARCHAR(20), -- Reemplazado por VARCHAR(20)
    respuestas  VARCHAR(50),
    auditoriaI  INTEGER -- Reemplazado por INTEGER
);

CREATE TABLE RESPUESTAS(
    evaluacionA_omes    VARCHAR(20) NOT NULL, -- Reemplazado por VARCHAR(20)
    respuesta           VARCHAR(50)
);
*/
-- Los conceptos Grandes son --
/*
Universidad YA
Categoría YA
Usuario YA
Artículo YA 
Calificacion YA 
Auditoría 
Evaluación

*/
-- PoblarOK --

/*
-- Poblando Tabla de Usuarios
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', 'tid001', '001', 'Usuario 1', 'Programa 1', 'usuario1@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '002', 'tid002', '002', 'Usuario 2', 'Programa 2', 'usuario2@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '003', 'tid003', '003', 'Usuario 3', 'Programa 3', 'usuario3@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '004', 'tid004', '004', 'Usuario 4', 'Programa 4', 'usuario4@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

-- Poblando Tabla de Universidad --
INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES
('001', NULL, NULL, 'Rep1', 'Universidad1', 'Dirección1');

INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES
('002', NULL, NULL, 'Rep2', 'Universidad2', 'Dirección2');

INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES
('003', NULL, NULL, 'Rep3', 'Universidad3', 'Dirección3');

INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES
('004', NULL, NULL, 'Rep4', 'Universidad4', 'Dirección4');

-- Poblando Calificaciones --
INSERT INTO CALIFICACIONES (usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, articuloI, estrellas)
VALUES ('001', '001', '002', '002', 123, 4);

INSERT INTO CALIFICACIONES (usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, articuloI, estrellas)
VALUES ('002', '001', '001', '001', 456, 5);

INSERT INTO CALIFICACIONES (usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, articuloI, estrellas)
VALUES ('003', '002', '003', '003', 789, 3);

INSERT INTO CALIFICACIONES (usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, articuloI, estrellas)
VALUES ('004', '003', '004', '004', 1011, 2);

-- Poblacion Articulo --
INSERT INTO ARTICULO (id, usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (1, '001', '002', '003', '003', 'CAT01', 'Descripción 1', 'Nuevo', 'foto1.jpg', 100.00, 'Y');

INSERT INTO ARTICULO (id, usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (2, '002', '002', '001', '001', 'CAT02', 'Descripción 2', 'Usado', 'foto2.jpg', 50.00, 'N');

INSERT INTO ARTICULO (id, usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (3, '003', '001', '004', '004', 'CAT03', 'Descripción 3', 'Reparación', 'foto3.jpg', 75.00, 'Y');

INSERT INTO ARTICULO (id, usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (4, '004', '003', '002', '002', 'CAT01', 'Descripción 4', 'Nuevo', 'foto4.jpg', 120.00, 'N');

-- Poblando CATEGORIAS --
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI)
VALUES ('CAT01', 'Categoría 1', 'Electrónica', 50.00, 200.00, 1);

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI)
VALUES ('CAT02', 'Categoría 2', 'Hogar', 30.00, 150.00, 2);

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI)
VALUES ('CAT03', 'Categoría 3', 'Ropa', 20.00, 100.00, 3);

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI)
VALUES ('CAT04', 'Categoría 4', 'Otro', 10.00, 80.00, 4);

-- Poblando AUDITORIAS --
INSERT INTO AUDITORIAS (id, fecha, ACCION, nombre)
VALUES (1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoría 1');

INSERT INTO AUDITORIAS (id, fecha, ACCION, nombre)
VALUES (2, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Actualizar', 'Auditoría 2');

INSERT INTO AUDITORIAS (id, fecha, ACCION, nombre)
VALUES (3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Eliminar', 'Auditoría 3');

INSERT INTO AUDITORIAS (id, fecha, ACCION, nombre)
VALUES (4, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Crear', 'Auditoría 4');

*/


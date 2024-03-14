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
Auditoría YA
Evaluación 

*/
-- ************ PoblarOK ************ --

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

-- Poblando EVALUACION --
INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Institución', 'tid001', 'nid001', TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Descripción evaluación 1', 'reporte1.pdf', 'Aprobado', 'Respuestas evaluación 1', 1);

INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Estudiante', 'tid002', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Descripción evaluación 2', 'reporte2.pdf', 'Rechazado', 'Respuestas evaluación 2', 2);

INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', NULL, NULL, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripción evaluación 3', 'reporte3.pdf', 'Pendiente', 'Respuestas evaluación 3', 3);

INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Docente', 'tid004', 'nid004', TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Descripción evaluación 4', 'reporte4.pdf', 'Aprobado', 'Respuestas evaluación 4', 4);


-- ************ PoblarNoOk ************ -- 


-- Parte (2) --

La longitud de la pk código debería ser máximo de 3, aquí es de 4, por eso devuelve un error.

INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES ('1234', NULL, NULL, 'nada', 'nada', 'nada');

El formato de fecha no coinside con el especificado en la creación de la tabla USUARIOS

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodebería', 'repetirse', '14-03-20-24' , NULL, 0);

La llave reporte debería ser única, y en este caso al intentar insertar valores repetidos devuelve un error, pues se viola la restricción.

INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripción evaluación 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluación 3', 3);


-- Parte (3) --

En este caso tenemos una universidad que no se referencia a ninún estudiante, pero si repite la PK
que debería ser única y aún así la añadió.

INSERT INTO UNIVERSIDAD (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES
('001', NULL, NULL, 'Rep1', 'Universidad55', 'Calle 17A # 75 ');

En este caso la PK de Usuarios es tid, nid, y se repiten, primer error, además debería comprobar 
que la universidad existiera.

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodebería', 'repetirse', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

Funciona pero no debería, puesto que usa las FK's de tid y nid, debería comprobar que existan en la tabla de Usuarios
y en este caso, esos tid y nid no existen para ningún usuario.

INSERT INTO EVALUACION (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripción evaluación 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluación 3', 3);

--  XPoblar(Eliminar los datos) --

DELETE FROM ARTICULO;
DELETE FROM AUDITORIAS;
DELETE FROM CALIFICACIONES;
DELETE FROM CARACTERISTICAS;
DELETE FROM CATEGORIAS;
DELETE FROM EVALUACION;
DELETE FROM PERECEDERO;
DELETE FROM PERTENEC;
DELETE FROM RESPUESTAS;
DELETE FROM ROPAS;
DELETE FROM UNIVERSIDAD;
DELETE FROM USUARIOS;

-- Punto D PROTEGIENDO --
-- PRIMARIAS --

ALTER TABLE UNIVERSIDAD ADD CONSTRAINT PK_UNIVERSIDAD_
PRIMARY KEY (codigo);

ALTER TABLE USUARIOS ADD CONSTRAINT PK_USUARIOS_
PRIMARY KEY (universidadC, codigo);

ALTER TABLE CALIFICACIONES ADD CONSTRAINT PK_CALIFICACIONES_
PRIMARY KEY (usuarioUtid, usuarioUnid, usuarioCtid, usuarioCnid);

ALTER TABLE ARTICULO ADD CONSTRAINT PK_ARTICULO_
PRIMARY KEY (id);

ALTER TABLE PERECEDERO ADD CONSTRAINT PK_PERECEDERO_
PRIMARY KEY (articuloI);

ALTER TABLE ROPAS ADD CONSTRAINT PK_ROPAS_
PRIMARY KEY (articuloI);

ALTER TABLE CARACTERISTICAS ADD CONSTRAINT PK_CARACTERISTICAS_
PRIMARY KEY (articuloI, caracteristica);

ALTER TABLE CATEGORIAS ADD CONSTRAINT PK_CATEGORIAS_
PRIMARY KEY (codigo);

ALTER TABLE AUDITORIAS ADD CONSTRAINT PK_AUDITORIAS_
PRIMARY KEY (id);

ALTER TABLE EVALUACION ADD CONSTRAINT PK_EVALUACION_
PRIMARY KEY (a_omes);

ALTER TABLE RESPUESTAS ADD CONSTRAINT PK_RESPUESTAS_
PRIMARY KEY (evaluacionA_omes);
*/

-- Creando Atributos (Tipos) --
/*

CREATE TABLE RESPUESTAS(
    evaluacionA_omes    VARCHAR(20) NOT NULL, -- Reemplazado por VARCHAR(20)
    respuesta           VARCHAR(50)
*/






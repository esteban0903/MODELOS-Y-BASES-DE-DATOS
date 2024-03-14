/*
---CICLO 1: TABLAS
---Creacion de Tablas
------------------------------------ COSTRUCCION: CREANDO ------------------------------------
CREATE TABLE USUARIOS(
    universidadC    VARCHAR(3),
    codigo          VARCHAR(3) ,
    tid             VARCHAR(50), -- Reemplazado por VARCHAR(50)
    nid             VARCHAR(3) ,
    nombre          VARCHAR(50),
    programa        VARCHAR(20),
    correo          VARCHAR(50),
    registro        DATE,
    suspension      DATE,
    nSuspensiones   INTEGER
);

CREATE TABLE UNIVERSIDADES(
    codigoUn        VARCHAR(3),
    representante   VARCHAR(10)NOT NULL,
    nombre          VARCHAR(20),
    direccion       VARCHAR(50)
);

CREATE TABLE CALIFICACIONES(
    usuarioU     VARCHAR(3),
    usuarioC     VARCHAR(3),
    articuloI    INTEGER L, -- Reemplazado por INTEGER
    estrellas    INTEGER -- Reemplazado por INTEGER
);

CREATE TABLE ARTICULOS(
    id          INTEGER , -- Reemplazado por INTEGER
    usuarioU    VARCHAR(3),
    usuarioC    VARCHAR(3),
    categoriaC  VARCHAR(5),
    descripcion VARCHAR(20),
    estado      VARCHAR(20), -- Reemplazado por VARCHAR(20)
    foto        VARCHAR(255), -- Reemplazado por VARCHAR(255)
    precio      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    disponible  CHAR(1) -- Reemplazado por CHAR(1)
);

CREATE TABLE PERECEDERO(
    articuloI   INTEGER, -- Reemplazado por INTEGER
    vencimiento DATE
);

CREATE TABLE ROPAS(
    articuloI   INTEGER, -- Reemplazado por INTEGER
    talla       VARCHAR(10), -- Reemplazado por VARCHAR(10)
    material    VARCHAR(10),
    color       VARCHAR(10)
);

CREATE TABLE CARACTERISTICAS(
    articuloI   INTEGER, -- Reemplazado por INTEGER
    caracteristica VARCHAR(20)
);

CREATE TABLE CATEGORIAS(
    codigo      VARCHAR(5),
    nombre      VARCHAR(20),
    tipo        VARCHAR(20), -- Reemplazado por VARCHAR(20)
    minimo      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    maximo      DECIMAL(10, 2), -- Reemplazado por DECIMAL(10, 2)
    auditoriaI  INTEGER, -- Reemplazado por INTEGER
    pertenecimientos  VARCHAR(20)
);



CREATE TABLE AUDITORIAS(
    id      INTEGER, -- Reemplazado por INTEGER
    fecha   DATE,
    accion  VARCHAR(20), -- Reemplazado por VARCHAR(20)
    nombre  VARCHAR(20)
);

CREATE TABLE EVALUACIONES(
    a_omes      VARCHAR(20), -- Reemplazado por VARCHAR(20)
    tid         VARCHAR(50), -- Reemplazado por VARCHAR(50)
    nid         VARCHAR(10),
    fecha       DATE,
    descripcion VARCHAR(255), -- Reemplazado por VARCHAR(255)
    reporte     VARCHAR(255) -- Reemplazado por VARCHAR(255)
    resultado   VARCHAR(20), -- Reemplazado por VARCHAR(20)
    respuestas  VARCHAR(50),
    auditoriaI  INTEGER -- Reemplazado por INTEGER
);

CREATE TABLE RESPUESTAS(
    evaluacionA    VARCHAR(20), -- Reemplazado por VARCHAR(20)
    respuesta      VARCHAR(50)
);
*/
/*
--- Los conceptos Grandes son --

Universidad YA
Categorias YA
Usuario YA
Articulo YA 
Calificacion YA 
Auditorias YA
Evaluacion YA

*/



/*



--- ************ PoblarOK ************ ---

------------------------------------  CONSTRUCCION: POBLANDO PARTE 1 ------------------------------------ 

--------------------- Poblando Tabla de usuarios ---------------------

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', 'tid001', '001', 'Usuario 1', 'Programa 1', 'usuario1@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '002', 'tid002', '002', 'Usuario 2', 'Programa 2', 'usuario2@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '003', 'tid003', '003', 'Usuario 3', 'Programa 3', 'usuario3@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '004', 'tid004', '004', 'Usuario 4', 'Programa 4', 'usuario4@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

--------------------- Poblando Tabla de Universidad ---------------------

INSERT INTO UNIVERSIDADES (codigoUn,representante, nombre, direccion)
VALUES
('001', 'Rep1', 'Universidad1', 'Direccion1');

INSERT INTO UNIVERSIDADES (codigoUn,representante, nombre, direccion)
VALUES
('002','Rep2', 'Universidad2', 'Direccion2');

INSERT INTO UNIVERSIDADES (codigoUn,representante, nombre, direccion)
VALUES
('003', 'Rep3', 'Universidad3', 'Direccion3');

INSERT INTO UNIVERSIDADES (codigoUn,representante, nombre, direccion)
VALUES
('004','Rep4', 'Universidad4', 'Direccion4');

--------------------- Poblando Calificaciones ---------------------

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas)
VALUES ('001', 123,'001', 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas)
VALUES ('002',456,'002', 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas)
VALUES ('003',789,'003', 3);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas)
VALUES ('004',1011,'004', 2);

--------------------- Poblacion Articulo ---------------------
INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (1, '001', '003', 'CAT01', 'Descripcion 1', 'Nuevo', 'foto1.jpg', 100.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (2, '002', '002', '001', '001', 'CAT02', 'Descripcion 2', 'Usado', 'foto2.jpg', 50.00, 'N');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (3, '003', '001', '004', '004', 'CAT03', 'Descripcion 3', 'Reparaci�n', 'foto3.jpg', 75.00, 'Y');

INSERT INTO ARTICULO (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible)
VALUES (4, '004', '003', '002', '002', 'CAT01', 'Descripcion 4', 'Nuevo', 'foto4.jpg', 120.00, 'N');

--------------------- Poblando CATEGORIAS ---------------------
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI,pertenecimientos)
VALUES ('CAT01', 'Categoria 1', 'Electronica', 50.00, 200.00, 1,'pert1');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI,pertenecimientos)
VALUES ('CAT02', 'Categoria 2', 'Hogar', 30.00, 150.00, 2,'pert2');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI,pertenecimientos)
VALUES ('CAT03', 'Categoria 3', 'Ropa', 20.00, 100.00, 3,'pert3');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI,pertenecimientos)
VALUES ('CAT04', 'Categoria 4', 'Otro', 10.00, 80.00, 4,'pert4');

--------------------- Poblando AUDITORIAS ---------------------
INSERT INTO AUDITORIAS (id, fecha, accion, nombre)
VALUES (1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 1');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre)
VALUES (2, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Actualizar', 'Auditoria 2');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre)
VALUES (3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Eliminar', 'Auditoria 3');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre)
VALUES (4, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Crear', 'Auditoria 4');

--------------------- Poblando EVALUACION ---------------------
INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Instituci�n', 'tid001', 'nid001', TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Descripcion evaluacion 1', 'reporte1.pdf', 'Aprobado', 'Respuestas evaluacion  1', 1);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Estudiante', 'tid002', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Descripcion evaluacion 2', 'reporte2.pdf', 'Rechazado', 'Respuestas evaluacion  2', 2);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', NULL, NULL, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripcion evaluacion 3', 'reporte3.pdf', 'Pendiente', 'Respuestas evaluacion  3', 3);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Docente', 'tid004', 'nid004', TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Descripcion evaluacion 4', 'reporte4.pdf', 'Aprobado', 'Respuestas evaluacion  4', 4);

*/

/*
-- ************ PoblarNoOk ************ -- 


------------------------------------   CONSTRUCCION: POBLANDO PARTE 2 ------------------------------------  

--- La longitud de la pk codigo deberia ser maximo de 3, aqui es de 4, por eso devuelve un error. ---

INSERT INTO UNIVERSIDADES (codigoUn,representante, nombre, direccion)
VALUES ('1234', 'Rep1', 'Universidad1', 'Direccion1');

---El formato de fecha no coinside con el especificado en la creaci�n de la tabla USUARIOS---

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodeberia', 'repetirse', '14-03-20-24' , NULL, 0);

--- La llave reporte deberia ser unica, y en este caso al intentar insertar valores repetidos devuelve un error, pues se viola la restriccion.---

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripcion evaluacion 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluacion 3', 3);


------------------------------------    CONSTRUCCION: POBLANDO PARTE 3 ------------------------------------  


--- En este caso tenemos una universidad que no se referencia a ningun estudiante, pero si repite la PK que deberia ser unica ----

INSERT INTO UNIVERSIDADES (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES('001', NULL, NULL, 'Rep1', 'Universidad55', 'Calle 17A # 75 ');

---En este caso la PK de Usuarios es tid, nid, y se repiten, primer error, ademas deberia comprobar que la universidad existiera. ---

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodeberia', 'repetirse', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

---Funciona pero no deberia, puesto que usa las FK's de tid y nid, deber�a comprobar que existan en la tabla de Usuarios y en este caso, esos tid y nid no existen para ningun usuario. ---

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripcion evaluacion 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluacion 3', 3);

*/

/*
--  XPoblar(Eliminar los datos) --

DELETE FROM ARTICULOS;
DELETE FROM AUDITORIAS;
DELETE FROM CALIFICACIONES;
DELETE FROM CARACTERISTICAS;
DELETE FROM CATEGORIAS;
DELETE FROM EVALUACIONES;
DELETE FROM PERECEDERO;
DELETE FROM RESPUESTAS;
DELETE FROM ROPAS;
DELETE FROM UNIVERSIDADES;
DELETE FROM USUARIOS;
*/

/*
------------------------------------CONSTRUCCION: PROTEGIENDO ------------------------------------

--- PRIMARIAS ---

ALTER TABLE UNIVERSIDADES ADD CONSTRAINT PK_UNIVERSIDAD_
PRIMARY KEY (codigoUn);

ALTER TABLE USUARIOS ADD CONSTRAINT PK_USUARIOS_
PRIMARY KEY (universidadC, codigo);

ALTER TABLE CALIFICACIONES ADD CONSTRAINT PK_CALIFICACIONES_
PRIMARY KEY (usuarioU, usuarioC, articuloI);

ALTER TABLE ARTICULOS ADD CONSTRAINT PK_ARTICULO_
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

ALTER TABLE EVALUACIONES ADD CONSTRAINT PK_EVALUACION_
PRIMARY KEY (a_omes);

ALTER TABLE RESPUESTAS ADD CONSTRAINT PK_RESPUESTAS_
PRIMARY KEY (evaluacionA);

*/
/*
--- UNICAS ---

ALTER TABLE ARTICULOS ADD CONSTRAINT UK_ARTICULO
UNIQUE (foto);

ALTER TABLE USUARIOS ADD CONSTRAINT UK_USUARIO_tid
UNIQUE (tid);

ALTER TABLE USUARIOS ADD CONSTRAINT UK_USUARIO_nid
UNIQUE (nid);

ALTER TABLE EVALUACIONES ADD CONSTRAINT UK_EVALUACION
UNIQUE (reporte);
--*/

---/*
--- FORANEAS ---

ALTER TABLE USUARIOS ADD CONSTRAINT FK_USUARIOS_UNIVERSIDADES_universidadC
FOREIGN KEY(universidadC) REFERENCES UNIVERSIDADES(codigoUn);

ALTER TABLE CALIFICACIONES ADD CONSTRAINT FK_CALIFICACIONES_USUARIOS
FOREIGN KEY(usuarioU,usuarioC) REFERENCES USUARIOS(universidadC,codigo);


ALTER TABLE CALIFICACIONES ADD CONSTRAINT FK_CALIFICACIONES_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id);

ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_USUARIOS_usuarioU
FOREIGN KEY(usuarioU,usuarioC) REFERENCES USUARIOS(universidadC,codigo);

ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_CATEGORIAS_categoriaC
FOREIGN KEY(categoriaC) REFERENCES CATEGORIAS(codigo);

ALTER TABLE PERECEDERO ADD CONSTRAINT FK_PERECEDERO_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id);

ALTER TABLE CARACTERISTICAS ADD CONSTRAINT FK_CARACTERISTICAS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id);

ALTER TABLE ROPAS ADD CONSTRAINT FK_ROPAS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id);

ALTER TABLE CATEGORIAS ADD CONSTRAINT FK_CATEGORIAS_AUDITORIAS_auditoriaI
FOREIGN KEY(auditoriaI) REFERENCES AUDITORIAS(id);

ALTER TABLE EVALUACIONES ADD CONSTRAINT FK_EVALUACIONES_AUDITORIAS_auditoriaI
FOREIGN KEY(auditoriaI) REFERENCES AUDITORIAS(id);

ALTER TABLE RESPUESTAS ADD CONSTRAINT FK_RESPUESTAS_EVALUACION_evaluacionA
FOREIGN KEY(evaluacionA) REFERENCES EVALUACIONES(a_omes);


---*/
/*
--- Creando Atributos (Tipos) --


CREATE TABLE RESPUESTAS(
    evaluacionA_omes    VARCHAR(20) NOT NULL, -- Reemplazado por VARCHAR(20)
    respuesta           VARCHAR(50)
*/



-- ALTER TABLE ROPAS ADD CONSTRAINT checkTalla CHECK (talla IN ('S', 'M', 'L')); --





-- INSERT INTO ROPAS(articuloI, talla, material, color) VALUES(1, 'S', 'asdf', 'red'); --
-- DELETE FROM ROPAS WHERE articuloI = 1; --


/*
---CICLO 1: TABLAS
---Creacion de Tablas
------------------------------------ COSTRUCCION: CREANDO ------------------------------------
CREATE TABLE USUARIOS(
    universidadC    VARCHAR(3),
    codigo          VARCHAR(3) ,
    tid             VARCHAR(50),
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
    representante   VARCHAR(10),
    nombre          VARCHAR(20),
    direccion       VARCHAR(50)
);

CREATE TABLE CALIFICACIONES(
    usuarioU     VARCHAR(3),
    usuarioC     VARCHAR(3),
    articuloI    INTEGER L,
    estrellas    INTEGER
);

CREATE TABLE ARTICULOS(
    id          INTEGER ,
    usuarioU    VARCHAR(3),
    usuarioC    VARCHAR(3),
    categoriaC  VARCHAR(5),
    descripcion VARCHAR(20),
    estado      VARCHAR(20),
    foto        VARCHAR(255),
    precio      DECIMAL(10, 2),
    disponible  CHAR(1)
);

CREATE TABLE PERECEDERO(
    articuloI   INTEGER,
    vencimiento DATE
);

CREATE TABLE ROPAS(
    articuloI   INTEGER,
    talla       VARCHAR(10),
    material    VARCHAR(10),
    color       VARCHAR(10)
);

CREATE TABLE CARACTERISTICAS(
    articuloI   INTEGER,
    caracteristica VARCHAR(20)
);

CREATE TABLE CATEGORIAS(
    codigo      VARCHAR(5),
    nombre      VARCHAR(20),
    tipo        VARCHAR(20),
    minimo      DECIMAL(10, 2),
    maximo      DECIMAL(10, 2),
    auditoriaI  INTEGER,
    pertenecimientos  VARCHAR(20)
);



CREATE TABLE AUDITORIAS(
    id      INTEGER, -- Reemplazado por INTEGER
    fecha   DATE,
    accion  VARCHAR(20),
    nombre  VARCHAR(20)
);

CREATE TABLE EVALUACIONES(
    a_omes      VARCHAR(20),
    tid         VARCHAR(50),
    nid         VARCHAR(10),
    fecha       DATE,
    descripcion VARCHAR(255),
    reporte     VARCHAR(255)
    resultado   VARCHAR(20),
    respuestas  VARCHAR(50),
    auditoriaI  INTEGER
);

CREATE TABLE RESPUESTAS(
    evaluacionA    VARCHAR(20),
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
VALUES (3, '003', '001', '004', '004', 'CAT03', 'Descripcion 3', 'Reparaciï¿½n', 'foto3.jpg', 75.00, 'Y');

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
VALUES ('Instituciï¿½n', 'tid001', 'nid001', TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Descripcion evaluacion 1', 'reporte1.pdf', 'Aprobado', 'Respuestas evaluacion  1', 1);

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

---El formato de fecha no coinside con el especificado en la creaciï¿½n de la tabla USUARIOS---

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

---Funciona pero no deberia, puesto que usa las FK's de tid y nid, deberï¿½a comprobar que existan en la tabla de Usuarios y en este caso, esos tid y nid no existen para ningun usuario. ---

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
/*

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
*/

/*
--- Creando Atributos (Tipos) --


ALTER TABLE USUARIOS ADD CONSTRAINT CHECK_CORREO CHECK (CORREO LIKE ('%@%'));
ALTER TABLE CALIFICACIONES ADD CONSTRAINT CHECK_ESTRELLAS CHECK (estrellas BETWEEN 1 AND 5);
ALTER TABLE ARTICULOS ADD CONSTRAINT CHECK_TESTADO_ARTICULO CHECK (ESTADO IN ('NUEVO', 'USADO'));
ALTER TABLE ARTICULOS ADD CONSTRAINT CHECK_TURL CHECK (FOTO LIKE ('%.jpg') OR 
FOTO LIKE ('%.jpg') 
OR FOTO LIKE ('%.jpeg') 
OR FOTO LIKE ('%.png'));
ALTER TABLE ROPAS ADD CONSTRAINT CHECK_TALLA CHECK (TALLA IN ('S', 'M', 'L', 'XL', 'XS', 'XXL'));
ALTER TABLE EVALUACIONES ADD CONSTRAINT CHECK_TDESCRIPTION CHECK (DESCRIPCION IN ('A', 'M', 'B')); 
ALTER TABLE EVALUACIONES ADD CONSTRAINT CHECK_TRESULTADO CHECK(RESULTADO IN ('AP', 'PE'));
ALTER TABLE EVALUACIONES ADD CONSTRAINT CHECK_TID_E CHECK (TID IN ('CC', 'CD')); 
ALTER TABLE CATEGORIAS 
ADD CONSTRAINT CHECK_TMONEDA_C1 CHECK (MINIMO > 0);

ALTER TABLE CATEGORIAS 
ADD CONSTRAINT CHECK_TMONEDA_C2 CHECK (MAXIMO > 0);
*/


/*

-- Solo pudimos con Trigger --
-- Que sea consecutivo implica que el maximo de la tabla + 1 es igual al ID, de no haber valores pues se deja en 1 el primer valor --
CREATE OR REPLACE TRIGGER trg_check_consecutivo
BEFORE INSERT ON AUDITORIAS
FOR EACH ROW
DECLARE
    v_max_id NUMBER;
BEGIN
    SELECT MAX(ID) INTO v_max_id FROM AUDITORIAS;
    
    IF v_max_id IS NULL THEN
        :NEW.ID := 1;
    ELSE
        :NEW.ID := v_max_id + 1;
    END IF;
END;
/

ALTER TABLE EVALUACIONES ADD CONSTRAINT CHECK_TURL_E CHECK (
    SUBSTR(REPORTE, 1, 8) = 'https://'
    AND LENGTH(REPORTE) <= 100
);

*/


------------------------- CONSTRUCCION: NUEVAMENTE POBLANDO -------------------------
/*
--- POBLANDO UNIVERSIDADES ---


INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('1', 'Rep1', 'Uni1', 'Direccion1');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('2', 'Rep2', 'Uni2', 'Direccion2');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('3', 'Rep3', 'Uni3', 'Direccion3');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('4', 'Rep4', 'Uni4', 'Direccion4');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('5', 'Rep5', 'Uni5', 'Direccion5');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('6', 'Rep6', 'Uni6', 'Direccion6');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('7', 'Rep7', 'Uni7', 'Direccion7');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('8', 'Rep8', 'Uni8', 'Direccion8');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('9', 'Rep9', 'Uni9', 'Direccion9');

INSERT INTO UNIVERSIDADES (codigoUn, representante, nombre, direccion)
VALUES ('10', 'Rep10', 'Uni10', 'Direccion10');

--- POBLANDO USUARIOS ---
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('1', '123', 'CC1', '1', 'Usuario 1', 'Programa 1', 'usuario1@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('2', '124', 'CC2', '2', 'Usuario 2', 'Programa 2', 'usuario2@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('3', '125', 'CC3', '3', 'Usuario 3', 'Programa 3', 'usuario3@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('4', '126', 'CC4', '4', 'Usuario 4', 'Programa 4', 'usuario4@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('5', '127', 'CD5', '5', 'Usuario 5', 'Programa 5', 'usuario5@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('6', '128', 'CD6', '6', 'Usuario 6', 'Programa 6', 'usuario6@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('7', '129', 'CD7', '7', 'Usuario 7', 'Programa 7', 'usuario7@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('8', '130', 'CD8', '8', 'Usuario 8', 'Programa 8', 'usuario8@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('9', '131', 'CD9', '9', 'Usuario 9', 'Programa 9', 'usuario9@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('10', '132', 'CD10', '10', 'Usuario 10', 'Programa 10', 'usuarin1@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);


--- POBLANDO AUDITORIAS ---

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 1');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (2, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Modificar', 'Auditoria 2');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Eliminar', 'Auditoria 3');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (4, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Crear', 'Auditoria 4');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (5, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Modificar', 'Auditoria 5');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (6, TO_DATE('2024-03-19', 'YYYY-MM-DD'), 'Eliminar', 'Auditoria 6');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (7, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Crear', 'Auditoria 7');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (8, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Modificar', 'Auditoria 8');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (9, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Eliminar', 'Auditoria 9');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre) 
VALUES (10, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Crear', 'Auditoria 10');


--- POBLANDO EVALUACIONES ---
INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci n', 'CC', 'nid001', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte1.pdf', 'AP', 'Respuestas evaluacion 1', 1);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci1n', 'CC', 'nid002', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'A', 'https://reporte2.pdf', 'PE', 'Respuestas evaluacion 2', 2);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Institucin2', 'CC', 'nid003', TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'A', 'https://reporte3.pdf', 'AP', 'Respuestas evaluacion 3', 3);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci3', 'CD', 'nid004', TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'M', 'https://reporte4.pdf', 'PE', 'Respuestas evaluacion 4', 4);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci4', 'CD', 'nid005', TO_DATE('2024-03-19', 'YYYY-MM-DD'), 'M', 'https://reporte5.pdf', 'AP', 'Respuestas evaluacion 5', 5);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci5', 'CC', 'nid006', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'M', 'https://reporte6.pdf', 'PE', 'Respuestas evaluacion 6', 6);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci6', 'CD', 'nid007', TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'M', 'https://reporte7.pdf', 'PE', 'Respuestas evaluacion 7', 7);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci7', 'CD', 'nid008', TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'B', 'https://reporte8.pdf', 'AP', 'Respuestas evaluacion 8', 8);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci8', 'CC', 'nid009', TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'B', 'https://reporte9.pdf', 'AP', 'Respuestas evaluacion 9', 9);

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI) 
VALUES ('Instituci9', 'CC', 'nid010', TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'B', 'https://reporte10.pdf', 'AP', 'Respuestas evaluacion 10', 10);

--- POBLANDO CATEGORIAS ---


INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT01', 'Categoria 1', 'Electronica', 50.00, 200.00, 1, 'pert1');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT02', 'Categoria 2', 'Moda', 20.00, 150.00, 2, 'pert2');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT03', 'Categoria 3', 'Hogar', 30.00, 300.00, 3, 'pert3');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT04', 'Categoria 4', 'Electrodomesticos', 100.00, 500.00, 4, 'pert4');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT05', 'Categoria 5', 'Deporte', 10.00, 250.00, 5, 'pert5');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT06', 'Categoria 6', 'Libros', 5.00, 100.00, 6, 'pert6');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT07', 'Categoria 7', 'Juguetes', 2.00, 50.00, 7, 'pert7');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT08', 'Categoria 8', 'Muebles', 150.00, 1000.00, 8, 'pert8');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT09', 'Categoria 9', 'Arte', 50.00, 500.00, 9, 'pert9');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, auditoriaI, pertenecimientos) 
VALUES ('CAT10', 'Categoria 10', 'Instrumentos ', 80.00, 700.00, 10, 'pert10');

--- POBLANDO ARTICULOS ---


INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (1, '1', '123', 'CAT01', 'Descripcion 1', 'NUEVO', 'foto1.jpg', 100.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (2, '2', '124', 'CAT02', 'Descripcion 2', 'NUEVO', 'foto2.jpg', 150.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (3, '3', '125', 'CAT03', 'Descripcion 3', 'NUEVO', 'foto3.jpg', 50.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (4, '4', '126', 'CAT04', 'Descripcion 4', 'NUEVO', 'foto4.png', 200.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (5, '5', '127', 'CAT05', 'Descripcion 5', 'NUEVO', 'foto5.jpg', 120.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (6, '6', '128', 'CAT06', 'Descripcion 6', 'USADO', 'foto6.jpeg', 80.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (7, '7', '129', 'CAT07', 'Descripcion 7', 'USADO', 'foto7.jpeg', 90.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (8, '8', '130', 'CAT08', 'Descripcion 8', 'USADO', 'foto8.png', 180.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (9, '9', '131', 'CAT09', 'Descripcion 9', 'USADO', 'foto9.png', 70.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (10, '10', '132', 'CAT10', 'Descripcion 10', 'USADO', 'foto10.jpg', 160.00, 'Y');



--- POBLANDO CALIFICACIONES ---

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('1', 123, '1', 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('2', 124, '2', 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('3', 125, '3', 3);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('4', 126, '4', 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('5', 127, '5', 2);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('6', 128, '6', 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('7', 129, '7', 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('8', 130, '8', 3);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('9', 131, '9', 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('10', 132, '10', 5);




===============================
*/




-- Consultar las categorías con mas artículos: 
SELECT c.nombre AS categoria, COUNT(*) AS cantidad_articulos
FROM ARTICULOS a
JOIN CATEGORIAS c ON a.categoriac = c.codigo
GROUP BY a.categoriac
ORDER BY cantidad_articulos




























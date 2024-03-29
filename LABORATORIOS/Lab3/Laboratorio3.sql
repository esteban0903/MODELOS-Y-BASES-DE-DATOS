
------------------------------------------ TABLAS------------------------------------------
CREATE TABLE USUARIOS(
    universidadC    VARCHAR(3) NOT NULL,
    codigo          VARCHAR(3) NOT NULL,
    tid             VARCHAR(50)NOT NULL,
    nid             VARCHAR(3) NOT NULL,
    nombre          VARCHAR(50)NOT NULL,
    programa        VARCHAR(20)NOT NULL,
    correo          VARCHAR(50)NOT NULL,
    registro        DATE NOT NULL,
    suspension      DATE,
    nSuspensiones   INTEGER NOT NULL
);

CREATE TABLE UNIVERSIDADES(
    codigoUn        VARCHAR(3)NOT NULL,
    representanteU   VARCHAR(10),
    representanteC   VARCHAR(10),
    nombre          VARCHAR(20)NOT NULL,
    direccion       VARCHAR(50) NOT NULL
);

CREATE TABLE CALIFICACIONES(
    usuarioU     VARCHAR(3)NOT NULL,
    usuarioC     VARCHAR(3)NOT NULL,
    articuloI    INTEGER NOT NULL,
    estrellas    INTEGER NOT NULL
);

CREATE TABLE ARTICULOS(
    id          INTEGER NOT NULL,
    usuarioU    VARCHAR(3)NOT NULL,
    usuarioC    VARCHAR(3)NOT NULL,
    categoriaC  VARCHAR(5)NOT NULL,
    descripcion VARCHAR(20)NOT NULL,
    estado      VARCHAR(20)NOT NULL,
    foto        VARCHAR(255)NOT NULL,
    precio      DECIMAL(10, 2)NOT NULL,
    disponible  CHAR(1)NOT NULL
);

CREATE TABLE PERECEDERO(
    articuloI   INTEGER NOT NULL,
    vencimiento DATE NOT NULL
);

CREATE TABLE ROPAS(
    articuloI   INTEGER NOT NULL,
    talla       VARCHAR(10) NOT NULL,
    material    VARCHAR(10) NOT NULL,
    color       VARCHAR(10) NOT NULL
);

CREATE TABLE CARACTERISTICAS(
    articuloI   INTEGER NOT NULL,
    caracteristica VARCHAR(20) NOT NULL
);

CREATE TABLE CATEGORIAS(
    codigo      VARCHAR(5) NOT NULL,
    nombre      VARCHAR(20) NOT NULL,
    tipo        VARCHAR(20) NOT NULL,
    minimo      DECIMAL(10, 2) NOT NULL,
    maximo      DECIMAL(10, 2) NOT NULL,
    perteneceC VARCHAR(20) 
);



CREATE TABLE AUDITORIAS(
    id      INTEGER NOT NULL, -- Reemplazado por INTEGER
    fecha   DATE NOT NULL,
    accion  VARCHAR(20) NOT NULL,
    nombre  VARCHAR(20) NOT NULL,
    categoriaC VARCHAR(5) NOT NULL,
    evaluacionA VARCHAR(20) NOT NULL
);

CREATE TABLE EVALUACIONES(
    a_omes      VARCHAR(20) NOT NULL,
    tid         VARCHAR(50) NOT NULL,
    nid         VARCHAR(10) NOT NULL,
    fecha       DATE  NOT NULL,
    descripcion VARCHAR(255),
    reporte     VARCHAR(255) NOT NULL,
    resultado   VARCHAR(20) NOT NULL
);

CREATE TABLE RESPUESTAS(
    evaluacionA    VARCHAR(20) NOT NULL,
    respuesta      VARCHAR(50)
);


--- Los conceptos Grandes son --

---Universidad YA
---Categorias YA
---Usuario YA
---Articulo YA 
---Calificacion YA 
---Auditorias YA
---Evaluacion YA





------------------------------------------ ATRIBUTOS ------------------------------------------

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

---- Solo pudimos con Trigger ----
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




------------------------------------------ PRIMARIAS ------------------------------------------

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



------------------------------------------UNICAS ------------------------------------------

ALTER TABLE ARTICULOS ADD CONSTRAINT UK_ARTICULO
UNIQUE (foto);

ALTER TABLE USUARIOS ADD CONSTRAINT UK_USUARIO_tid
UNIQUE (tid);

ALTER TABLE USUARIOS ADD CONSTRAINT UK_USUARIO_nid
UNIQUE (nid);

ALTER TABLE EVALUACIONES ADD CONSTRAINT UK_EVALUACION
UNIQUE (reporte);




------------------------------------------ FORANEAS ------------------------------------------


ALTER TABLE USUARIOS ADD CONSTRAINT FK_USUARIOS_UNIVERSIDADES_universidadC
FOREIGN KEY(universidadC) REFERENCES UNIVERSIDADES(codigoUn);

ALTER TABLE UNIVERSIDADES ADD CONSTRAINT FK_UNIVERSIDADES_USUARIOS_representanteU_representanteC
FOREIGN KEY(representanteU,representanteC) REFERENCES USUARIOS(universidadC,codigo);

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

ALTER TABLE AUDITORIAS ADD CONSTRAINT FK_AUDITORIAS_CATEGORIAS_categoriaC
FOREIGN KEY(categoriaC) REFERENCES CATEGORIAS(codigo);

ALTER TABLE AUDITORIAS ADD CONSTRAINT FK_AUDITORIAS_EVALUACIONES_evaluacionA
FOREIGN KEY(evaluacionA) REFERENCES EVALUACIONES(a_omes);

ALTER TABLE CATEGORIAS ADD CONSTRAINT FK_CATEGORIAS_CATEGORIAS_perteneceC
FOREIGN KEY(perteneceC) REFERENCES CATEGORIAS(codigo);


ALTER TABLE RESPUESTAS ADD CONSTRAINT FK_RESPUESTAS_EVALUACION_evaluacionA
FOREIGN KEY(evaluacionA) REFERENCES EVALUACIONES(a_omes);
------------------------------------------ XTABLAS------------------------------------------
drop table "BD1000095983"."ARTICULOS" cascade constraints PURGE;
drop table "BD1000095983"."AUDITORIAS" cascade constraints PURGE;
drop table "BD1000095983"."CALIFICACIONES" cascade constraints PURGE;
drop table "BD1000095983"."CARACTERISTICAS" cascade constraints PURGE;
drop table "BD1000095983"."CATEGORIAS" cascade constraints PURGE;
drop table "BD1000095983"."EVALUACIONES" cascade constraints PURGE;
drop table "BD1000095983"."PERECEDERO" cascade constraints PURGE;
drop table "BD1000095983"."RESPUESTAS" cascade constraints PURGE;
drop table "BD1000095983"."ROPAS" cascade constraints PURGE;
drop table "BD1000095983"."UNIVERSIDADES" cascade constraints PURGE;
drop table "BD1000095983"."USUARIOS" cascade constraints PURGE;
------------------------------------------ CONSULTAS------------------------------------------
-- Consultar las categor�as con mas art�culos: 

SELECT c.nombre AS categoria, COUNT(*) AS cantidad_articulos
FROM ARTICULOS a
JOIN CATEGORIAS c ON a.categoriac = c.codigo
GROUP BY c.nombre
ORDER BY cantidad_articulos DESC;
-- Consultar las calificaciones de los articulos del �ltimo mes
SELECT a.id, c.estrellas, d.fecha
FROM ARTICULOS a
JOIN CALIFICACIONES c ON a.id = c.articuloI
JOIN CATEGORIAS b ON a.categoriac = b.codigo
JOIN AUDITORIAS d ON b.auditoriaI = d.id
WHERE EXTRACT(YEAR FROM d.fecha) = EXTRACT(YEAR FROM CURRENT_DATE)
AND EXTRACT(MONTH FROM d.fecha) = EXTRACT(MONTH FROM CURRENT_DATE);
-- Consulta inventada:
-- Mirar los reportes por fechas y ordenarlos de menor a mayor
SELECT a.reporte, b.fecha 
FROM EVALUACIONES a 
JOIN AUDITORIAS b ON b.id = a.auditoriaI 
ORDER BY b.fecha;

------------------------------------------ PoblarOK ------------------------------------------

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
------------------------------------------ PoblarNoOk ------------------------------------------

---El caso del insert en la tabla UNIVERSIDADES donde la PK se repite deber�a ser protegido por la restricci�n de unicidad de la PK PK_UNIVERSIDAD_.

INSERT INTO UNIVERSIDADES (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES('001', NULL, NULL, 'Rep1', 'Universidad55', 'Calle 17A # 75 ');


---El caso del insert en la tabla USUARIOS donde la PK de tid y nid se repiten deber�a ser protegido por las restricciones de unicidad de las 
PK UK_USUARIO_tid y UK_USUARIO_nid.

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodeberia', 'repetirse', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);



---El caso del insert en la tabla EVALUACIONES donde se hacen referencias a tid y nid inexistentes, deber�a ser protegido por la 
---restricci�n de integridad referencial FK_EVALUACIONES_AUDITORIAS_auditoriaI. Aunque esta restricci�n no verifica directamente la 
---existencia de tid y nid, protege la integridad referencial entre las tablas EVALUACIONES y AUDITORIAS, lo que indirectamente podr�a ayudar 
---a prevenir este tipo de errores.

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripcion evaluacion 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluacion 3', 3);


---Si se intenta insertar en la tabla articulo un dato en el atributo foto que sea NULL, generar error ya que es UNIQUE
INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (1, '1', '123', 'CAT01', 'Descripcion 1', 'NUEVO', NULL, 100.00, 'Y');

---Si se intenta eliminar alg�n codigoUn (primary key tabla UNIVERSIDADES)  que este presente en la tabla USUARIOS. Va generar error ya que no esta definido como cascade ni null, esta por defecto.
DELETE FROM UNIVERSIDADES WHERE codigoUn= '1';

---Si se trata de insertar un id (primary key)en la tabla ARTICULOS con valor nulo, genera error ya que las llaves principales no pueden ser nulas
INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (NULL, '11', '140', 'CAT11', 'Descripcion 11', 'USADO', 'foto11.png', 210.00, 'Y')

------------------------------------------ XPoblar ------------------------------------------

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




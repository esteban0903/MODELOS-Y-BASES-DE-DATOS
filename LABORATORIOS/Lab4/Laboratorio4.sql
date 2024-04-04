
------------------------------------------ TABLAS------------------------------------------
-- Si hubo cambios --
CREATE TABLE USUARIOS( 
    universidadC    VARCHAR(3) NOT NULL,
    codigo          VARCHAR(3) NOT NULL,
    tid             VARCHAR(50)NOT NULL,
    nid             VARCHAR(3) NOT NULL,
    nombre          VARCHAR(50)NOT NULL,
    programa        VARCHAR(20)NOT NULL,
    correo          VARCHAR(50)NOT NULL,
    registro        DATE NOT NULL,
    suspension      DATE, -- Agregamos que esta podría ser nula -- 
    nSuspensiones   INTEGER NOT NULL
);

-- Si hubo cambios --
CREATE TABLE UNIVERSIDADES(
    codigoUn        VARCHAR(3) NOT NULL,
    representanteU   VARCHAR(10),-- Agregamos que esta podría ser nula -- 
    representanteC   VARCHAR(10),-- Agregamos que esta podría ser nula -- 
    nombre          VARCHAR(20)NOT NULL,
    direccion       VARCHAR(50) NOT NULL
);

CREATE TABLE CALIFICACIONES(
    usuarioU     VARCHAR(3)NOT NULL,
    usuarioC     VARCHAR(3)NOT NULL,
    articuloI    INTEGER NOT NULL,
    estrellas    INTEGER NOT NULL
);

 -- Si hubo cambios --
CREATE TABLE ARTICULOS(
    id          INTEGER NOT NULL,
    usuarioU    VARCHAR(3)NOT NULL,
    usuarioC    VARCHAR(3)NOT NULL,
    categoriaC  VARCHAR(5)NOT NULL,
    descripcion VARCHAR(20) NOT NULL,
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

-- Si hubo cambios --
CREATE TABLE CATEGORIAS(
    codigo      VARCHAR(5) NOT NULL,
    nombre      VARCHAR(20) NOT NULL,
    tipo        VARCHAR(20) NOT NULL,
    minimo      DECIMAL(10, 2) NOT NULL,
    maximo      DECIMAL(10, 2) NOT NULL,
    perteneceC VARCHAR(20) -- Agregamos que esta podría ser nula -- 
);

CREATE TABLE AUDITORIAS(
    id      INTEGER NOT NULL,
    fecha   DATE NOT NULL,
    accion  VARCHAR(20) NOT NULL,
    nombre  VARCHAR(40) NOT NULL,
    categoriaC VARCHAR(5) NOT NULL,
    evaluacionA VARCHAR(20) -- Agregamos que esta podría ser nula -- 
);

-- Si hubo cambios --
CREATE TABLE EVALUACIONES( 
    a_omes      VARCHAR(20) NOT NULL,
    tid         VARCHAR(50) NOT NULL,
    nid         VARCHAR(10) NOT NULL,
    fecha       DATE  NOT NULL,
    descripcion VARCHAR(255), -- Agregamos que esta podría ser nula -- 
    reporte     VARCHAR(255) NOT NULL,
    resultado   VARCHAR(20) NOT NULL
);

CREATE TABLE RESPUESTAS(
    evaluacionA    VARCHAR(20) NOT NULL,
    respuesta      VARCHAR(50) NOT NULL -- Agregamos que esta NO podría ser nula -- 
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
ALTER TABLE ARTICULOS ADD CONSTRAINT CHECK_TURL CHECK (FOTO LIKE ('%.jpg') OR FOTO LIKE ('%.jpg')  OR FOTO LIKE ('%.jpeg') OR FOTO LIKE ('%.png'));
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

CREATE OR REPLACE TRIGGER trg_create_TID_U
BEFORE INSERT ON USUARIOS
FOR EACH ROW
BEGIN
    :new.tid := :new.tid || '_' || TO_CHAR(:new.nid);
END;
/

ALTER TABLE EVALUACIONES ADD CONSTRAINT CHECK_TURL_E CHECK (
    SUBSTR(REPORTE, 1, 8) = 'https://'
    AND LENGTH(REPORTE) <= 100
);

------------------------------------------ PRIMARIAS ------------------------------------------

ALTER TABLE UNIVERSIDADES ADD CONSTRAINT PK_UNIVERSIDAD_
PRIMARY KEY (codigoUn);
-- Error --
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
FOREIGN KEY(universidadC) REFERENCES UNIVERSIDADES(codigoUn)
ON DELETE CASCADE;

ALTER TABLE UNIVERSIDADES ADD CONSTRAINT FK_UNIVERSIDADES_USUARIOS_representanteU_representanteC
FOREIGN KEY(representanteU,representanteC) REFERENCES USUARIOS(universidadC,codigo)
ON DELETE CASCADE;

ALTER TABLE CALIFICACIONES ADD CONSTRAINT FK_CALIFICACIONES_USUARIOS
FOREIGN KEY(usuarioU,usuarioC) REFERENCES USUARIOS(universidadC,codigo)
ON DELETE CASCADE;

ALTER TABLE CALIFICACIONES ADD CONSTRAINT FK_CALIFICACIONES_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id)
ON DELETE CASCADE;

ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_USUARIOS_usuarioU
FOREIGN KEY(usuarioU,usuarioC) REFERENCES USUARIOS(universidadC,codigo)
ON DELETE CASCADE;

ALTER TABLE ARTICULOS ADD CONSTRAINT FK_ARTICULOS_CATEGORIAS_categoriaC
FOREIGN KEY(categoriaC) REFERENCES CATEGORIAS(codigo)
ON DELETE CASCADE;

ALTER TABLE PERECEDERO ADD CONSTRAINT FK_PERECEDERO_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id)
ON DELETE CASCADE;

ALTER TABLE CARACTERISTICAS ADD CONSTRAINT FK_CARACTERISTICAS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id)
ON DELETE CASCADE;

ALTER TABLE ROPAS ADD CONSTRAINT FK_ROPAS_ARTICULOS_articuloI
FOREIGN KEY(articuloI) REFERENCES ARTICULOS(id)
ON DELETE CASCADE;


ALTER TABLE AUDITORIAS ADD CONSTRAINT FK_AUDITORIAS_CATEGORIAS_categoriaC
FOREIGN KEY(categoriaC) REFERENCES CATEGORIAS(codigo)
ON DELETE CASCADE;

ALTER TABLE AUDITORIAS ADD CONSTRAINT FK_AUDITORIAS_EVALUACIONES_evaluacionA
FOREIGN KEY(evaluacionA) REFERENCES EVALUACIONES(a_omes)
ON DELETE CASCADE;

ALTER TABLE CATEGORIAS ADD CONSTRAINT FK_CATEGORIAS_CATEGORIAS_perteneceC
FOREIGN KEY(perteneceC) REFERENCES CATEGORIAS(codigo);


ALTER TABLE RESPUESTAS ADD CONSTRAINT FK_RESPUESTAS_EVALUACION_evaluacionA
FOREIGN KEY(evaluacionA) REFERENCES EVALUACIONES(a_omes)
ON DELETE CASCADE;
-------------------------------- XTABLAS --------------------------------
------- ESTEBAN-------
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
------- MIGUEL -------
drop table "BD1000095256"."ARTICULOS" cascade constraints PURGE;
drop table "BD1000095256"."AUDITORIAS" cascade constraints PURGE;
drop table "BD1000095256"."CALIFICACIONES" cascade constraints PURGE;
drop table "BD1000095256"."CARACTERISTICAS" cascade constraints PURGE;
drop table "BD1000095256"."CATEGORIAS" cascade constraints PURGE;
drop table "BD1000095256"."EVALUACIONES" cascade constraints PURGE;
drop table "BD1000095256"."PERECEDERO" cascade constraints PURGE;
drop table "BD1000095256"."RESPUESTAS" cascade constraints PURGE;
drop table "BD1000095256"."ROPAS" cascade constraints PURGE;
drop table "BD1000095256"."UNIVERSIDADES" cascade constraints PURGE;
drop table "BD1000095256"."USUARIOS" cascade constraints PURGE;

------------------------------------------ CONSULTAS------------------------------------------
-- Consultar las categorías con mas artículos: 
/*
SELECT c.nombre AS categoria, COUNT(*) AS cantidad_articulos
FROM ARTICULOS a
JOIN CATEGORIAS c ON a.categoriac = c.codigo
GROUP BY c.nombre
ORDER BY cantidad_articulos DESC;
-- Consultar las calificaciones de los articulos del último mes
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
*/
------------------------------------------ TUPLAS ------------------------------------------
-----CASO DE USO 2 -----
---ADICIONAR---
-- La fecha de la evaluación se genera automáticamente y debe ser posterior al año-mes evaluado
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_fecha
BEFORE INSERT ON EVALUACIONES
FOR EACH ROW
DECLARE
    año_aomes INT;
    mes_aomes INT;
BEGIN
    año_aomes := TO_NUMBER(SUBSTR(:NEW.a_omes, 1, 4));
    mes_aomes := TO_NUMBER(SUBSTR(:NEW.a_omes, 5, 2));
    
    IF EXTRACT(YEAR FROM :NEW.fecha) < año_aomes OR 
       (EXTRACT(YEAR FROM :NEW.fecha) = año_aomes AND EXTRACT(MONTH FROM :NEW.fecha) <= mes_aomes) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de evaluación debe ser posterior al año-mes evaluado');
    END IF;
END;
/

---Los registros asociados son los correspondientes al año-mes definido.---

---MODIFICAR---
---El único dato que se puede modificar es el resultado de las auditorías.
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_resultado
BEFORE UPDATE ON EVALUACIONES
FOR EACH ROW
BEGIN
    IF :old.a_omes != :new.a_omes OR :old.tid != :new.tid OR :old.nid != :new.nid OR :old.fecha != :new.fecha OR :old.descripcion != :new.descripcion
        OR :old.reporte != :new.reporte THEN
        RAISE_APPLICATION_ERROR(-20004, 'El único dato que se puede modificar es el resultado');
    END IF;
END;
/
---Solo es posible adicionar respuestas de las anomalías si el estado de la auditoría es pendiente
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_RESPUESTAS
BEFORE UPDATE ON RESPUESTAS 
FOR EACH ROW
DECLARE
    v_estado EVALUACIONES.resultado%TYPE;
BEGIN
    SELECT resultado into v_estado FROM EVALUACIONES WHERE a_omes= :new.evaluacionA ;
    IF v_estado <> 'PE' THEN
        RAISE_APPLICATION_ERROR(-20008, 'No se puede modificar el resultado de la auditoría si el estado no es pendiente');
    END IF;
END;
---ELIMINAR---
---Las evaluaciones se pueden eliminar si no tienen anomalías. 
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_descripcion
BEFORE DELETE ON EVALUACIONES 
FOR EACH ROW
BEGIN
    IF :old.descripcion IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20009, 'No se puede eliminar la evaluación si existen respuestas asociadas');
    END IF;
END;
/

------------------------------------------ ACCIONES ------------------------------------------
--------------------------CASO DE USO 1--------------------------
-- Adicionar --
-- Los códigos deben iniciar con una letra mayúscula, en el caso de empezar por una letra minúscula, la cambia a mayúscula --
CREATE OR REPLACE TRIGGER trg_codigo_uppercase
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF REGEXP_LIKE(:new.codigo, '^[a-z].*') THEN
        :new.codigo := UPPER(SUBSTR(:new.codigo, 1, 1)) || SUBSTR(:new.codigo, 2);
    ELSIF NOT REGEXP_LIKE(:new.codigo, '^[A-Z].*') THEN
        RAISE_APPLICATION_ERROR(-20001, 'El código debe comenzar con una letra mayúscula.');
    END IF;
END;
/

-- Si no se indica el nombre se le asigna. ‘Nombre de ‘<codigo> --
CREATE OR REPLACE TRIGGER trg_assign_codigo
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW 
BEGIN
	IF :new.nombre IS NULL THEN
    	:new.nombre := 'Nombre de ' || :new.codigo;
    END IF;
END;
/

-- El precio mínimo debe ser menor que el máximo -- 
CREATE OR REPLACE TRIGGER trg_precio_minimo_maximo
BEFORE INSERT OR UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :new.minimo >= :new.maximo THEN
        RAISE_APPLICATION_ERROR(-20002, 'El precio mínimo debe ser menor que el precio máximo.');
    END IF;
END;
/

-- Si no se indica el precio máximo se supone que es el doble del mínimo -- 
CREATE OR REPLACE TRIGGER trg_precio_maximo_predeterminado
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :new.maximo IS NULL THEN
        :new.maximo := :new.minimo * 2;
    END IF;
END;
/


-- MODIFICAR --
-- Los únicos datos que se pueden modificar son el mínimo y el máximo. Únicamente pueden aumentar. --
CREATE OR REPLACE TRIGGER trg_inmutabilidad_datos
BEFORE UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :old.codigo != :new.codigo OR :old.nombre != :new.nombre OR :old.tipo != :new.tipo OR :old.perteneceC != :new.perteneceC THEN
        RAISE_APPLICATION_ERROR(-20004, 'Los únicos datos que se pueden modificar son el mínimo y el máximo.');
    ELSIF :new.minimo >= :new.maximo THEN
        RAISE_APPLICATION_ERROR(-20005, 'El precio mínimo debe ser menor que el precio máximo.');
	END IF;
END;
/


-- Si se modifica el mínimo, el máximo debe modificarse en el mismo valor. -- 
CREATE OR REPLACE TRIGGER trg_actualizar_maximo
BEFORE UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :old.minimo != :new.minimo THEN
        :new.maximo := :old.maximo + :new.minimo - :old.minimo;
    END IF;
END;
/
-- ELIMINAR --
-- Únicamente se pueden eliminar los que no tienen artículos asociados.--
CREATE OR REPLACE TRIGGER trg_eliminar_categoria
BEFORE DELETE ON CATEGORIAS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM ARTICULOS
    WHERE categoriaC = :old.codigo;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'No se puede eliminar la categoría porque tiene artículos asociados.');
    END IF;
END;
/

-- CREAR AUDITORIAS --
CREATE OR REPLACE TRIGGER trg_creacion_categoria_auditoria
AFTER INSERT ON CATEGORIAS
FOR EACH ROW
DECLARE 
    v_id NUMBER;
BEGIN
    SELECT MAX(id) INTO v_id FROM AUDITORIAS;
    INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, evaluacionA)
    VALUES (v_id+1, SYSDATE, 'ACCION PENDIENTE', 'Nombre ' || :new.nombre, :new.codigo, NULL);
END;
/

--------------------------CASO DE USO 2--------------------------
---ADICIONAR---
-- El tipo de documento por defecto de los auditores de no informarse es: CC --
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_tipo
BEFORE INSERT ON EVALUACIONES
FOR EACH ROW
BEGIN 
    IF :new.tid IS NULL THEN :new.tid :='CC';
    END IF;
END;
/





------------------------------------------ XTRIGGERS ------------------------------------------
DROP TRIGGER TR_EVALUACIONES_fecha;
DROP TRIGGER TR_EVALUACIONES_tipo;
DROP TRIGGER TR_EVALUACIONES_resultado;
DROP TRIGGER TR_EVALUACIONES_RESPUESTAS;
DROP TRIGGER TR_EVALUACIONES_descripcion;
------------------------------------------ TUPLASOK ------------------------------------------
--------------------------CASO DE USO 2--------------------------
--- Insertar una fecha correcta que no sea posterior, una fecha igual ---
INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado)

VALUES ('202305', 'CC', 'EjemNID', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'A', 'https://www.ejemplo.com', 'AP');
--- Comprobar que no se puede modificar nada aparte de resultado ---
UPDATE EVALUACIONES
SET descripcion = 'M'
WHERE a_omes = '202306';

UPDATE EVALUACIONES
SET resultado = 'PE'
WHERE a_omes = '202306';
--- Insertar respuestas con aprobacion que no sea pendiente ---
INSERT INTO RESPUESTAS (evaluacionA,respuesta)
VALUES ('202306', 'Resp1');

UPDATE RESPUESTAS
SET respuesta = 'Esta es una respuesta modificada'
WHERE evaluacionA = '202306';

--- Intentar eliminar una evaluacion que tiene anomalias
INSERT INTO EVALUACIONES (a_omes, nid, fecha, descripcion, reporte, resultado)
VALUES ('202307', 'EjemNID3', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'A', 'https://www.ejemplo3.com', 'AP');

INSERT INTO RESPUESTAS (evaluacionA,respuesta)
VALUES ('202307', 'Resp1');

DELETE FROM EVALUACIONES WHERE a_omes = '202307';

------------------------------------------ ACCIONESOK ------------------------------------------
--------------------------CASO DE USO 1 --------------------------
-- Insertar una nueva fila en la tabla CATEGORIAS con un código en minúscula
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
VALUES ('a001', 'Categoría de prueba', 'Tipo Ejemplo', 50.00, 100.00, NULL);

-- Insertar una nueva fila en la tabla CATEGORIAS con un código que no es letra
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
VALUES ('#001', 'Categoría de prueba', 'Tipo Ejemplo', 50.00, 100.00, NULL);

-- Insertar una nueva fila en la tabla CATEGORIAS sin nombre
INSERT INTO CATEGORIAS (codigo, tipo, minimo, maximo, perteneceC)
VALUES ('A002', 'Tipo Ejemplo', 60.00, 120.00, NULL);

-- Insertar una nueva fila en la tabla CATEGORIAS con precio CORRECTO
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
VALUES ('A003', 'Categoría de prueba', 'Tipo Ejemplo', 100.00, 180.00, NULL);

-- Insertar una nueva fila en la tabla CATEGORIAS con precio mínimo mayor o igual al precio máximo
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
VALUES ('A0031', 'Categoría de prueba', 'Tipo Ejemplo', 100.00, 80.00, NULL);

-- Insertar una nueva fila en la tabla CATEGORIAS sin precio máximo
INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
VALUES ('A004', 'Categoría de prueba', 'Tipo Ejemplo', 70.00, NULL, NULL);

-- Intentar modificar otros datos que no sean el mínimo o el máximo
UPDATE CATEGORIAS
SET nombre = 'Nueva Categoría', tipo = 'Nuevo Tipo'
WHERE codigo = 'A001';

-- Intentar modificar el mínimo para que el trigger actualice automáticamente el máximo
UPDATE CATEGORIAS
SET minimo = 80.00
WHERE codigo = 'A004';
SELECT * FROM CATEGORIAS WHERE CODIGO = 'A004';

-- Intentar eliminar una categoría que tiene artículos asociados
DELETE FROM CATEGORIAS
WHERE codigo = 'A001';
--------------------------CASO DE USO 2--------------------------
--- Insertar correctamente, sin proporcionar valor para tid---
INSERT INTO EVALUACIONES (a_omes, nid, fecha, descripcion, reporte, resultado)
VALUES ('202306', 'EjemNID2', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'A', 'https://www.ejemplo2.com', 'AP');
---------------------------------------------------- PoblarOK ---------------------------------------------------
--------------------------------------- Poblando Universidades y Usuarios ---------------------------------------
/*
    En este caso tenemos que crear la universidad con un representante nulo, después de eso se crea el estudiante referenciando
    la universidad, para posteriormente actualizar el representante de la universidad.
*/
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('001', 'Universidad Ejemplo', 'Calle Ejemplo #123');

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('001', '001', 'CD', '001', 'Juan Pérez', 'Ing. Informática', 'juan@example.com', TO_DATE('14-03-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('001', '002', 'CD', '002', 'María López', 'Medicina', 'maria@example.com', TO_DATE('28-03-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '001', representanteC = '001'
WHERE codigoUn = '001';


-- Insertar una nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('002', 'Otra Universidad', 'Avenida Principal #456');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('002', '001', 'CC', '003', 'Carlos García', 'Arquitectura', 'carlos@example.com', TO_DATE('15-04-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('002', '002', 'CC', '004', 'Ana Martínez', 'Derecho', 'ana@example.com', TO_DATE('20-04-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '002', representanteC = '001'
WHERE codigoUn = '002';

-- Insertar otra nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('003', 'Universidad Tercera', 'Calle Secundaria #789');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('003', '001', 'CC', '005', 'Pedro Rodríguez', 'Biología', 'pedro@example.com', TO_DATE('25-05-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('003', '002', 'CD', '006', 'Laura Ramírez', 'Psicología', 'laura@example.com', TO_DATE('30-05-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '003', representanteC = '002'
WHERE codigoUn = '003';

-- Insertar una nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('004', 'Universidad Cuarta', 'Avenida Cuarta #101');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('004', '001', 'CC', '007', 'Sofía Hernández', 'Economía', 'sofia@example.com', TO_DATE('10-06-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('004', '002', 'CC', '008', 'Diego Fernández', 'Historia', 'diego@example.com', TO_DATE('15-06-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '004', representanteC = '001'
WHERE codigoUn = '004';

-- Insertar otra nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('005', 'Universidad Quinta', 'Calle Quinta #202');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('005', '001', 'CC', '009', 'Andrés Pérez', 'Química', 'andres@example.com', TO_DATE('20-07-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('005', '010', 'CD', '010', 'Lucía Gómez', 'Matemáticas', 'lucia@example.com', TO_DATE('25-07-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '005', representanteC = '010'
WHERE codigoUn = '005';

-- Insertar otra nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('006', 'Universidad Sexta', 'Avenida Sexta #303');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('006', '012', 'CC', '011', 'Marta Martínez', 'Física', 'marta@example.com', TO_DATE('30-08-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('006', '002', 'CD', '012', 'Javier López', 'Ciencias Políticas', 'javier@example.com', TO_DATE('05-09-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '006', representanteC = '012'
WHERE codigoUn = '006';

-- Insertar una nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('007', 'Universidad Séptima', 'Calle Séptima #404');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('007', '001', 'CD', '013', 'Luisa Sánchez', 'Ingeniería Civil', 'luisa@example.com', TO_DATE('10-10-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('007', '002', 'CC', '014', 'Roberto Gutiérrez', 'Arquitectura', 'roberto@example.com', TO_DATE('15-10-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '007', representanteC = '002'
WHERE codigoUn = '007';

-- Insertar otra nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('008', 'Universidad Octava', 'Avenida Octava #505');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('008', '001', 'CC', '015', 'Elena López', 'Biomedicina', 'elena@example.com', TO_DATE('20-11-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('008', '002', 'CD', '016', 'Mario García', 'Psicología', 'mario@example.com', TO_DATE('25-11-2024', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '008', representanteC = '002'
WHERE codigoUn = '008';

-- Insertar otra nueva universidad
INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
VALUES ('009', 'Universidad Novena', 'Calle Novena #606');

-- Insertar un usuario y relacionarlo con una universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('009', '001', 'CC', '017', 'Laura Martínez', 'Medicina', 'laura@example.com', TO_DATE('30-12-2024', 'DD-MM-YYYY'), 0);

-- Insertar otro usuario y relacionarlo con la misma universidad existente
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
VALUES ('009', '002', 'CC', '018', 'Carlos Rodríguez', 'Derecho', 'carlos@example.com', TO_DATE('05-01-2025', 'DD-MM-YYYY'), 0);

-- Actualizar la universidad para establecer representantes
UPDATE UNIVERSIDADES
SET representanteU = '009', representanteC = '002'
WHERE codigoUn = '009';

---------------------------------------------------- POBLANDO CATEGORIAS ----------------------------------------------------

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT01', 'Categoria 1', 'Electronica', 50.00, 200.00, 'CAT01');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT02', 'Categoria 2', 'Moda', 20.00, 150.00, 'CAT02');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT03', 'Categoria 3', 'Hogar', 30.00, 300.00, 'CAT01');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT04', 'Categoria 4', 'Electrodomesticos', 100.00, 500.00, 'CAT03');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT05', 'Categoria 5', 'Deporte', 10.00, 250.00, 'CAT03');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT06', 'Categoria 6', 'Libros', 5.00, 100.00, NULL);

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT07', 'Categoria 7', 'Juguetes', 2.00, 50.00, NULL);

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT08', 'Categoria 8', 'Muebles', 150.00, 1000.00, 'CAT01');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT09', 'Categoria 9', 'Arte', 50.00, 500.00, 'CAT09');

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('CAT10', 'Categoria 10', 'Instrumentos ', 80.00, 700.00, 'CAT09');


---------------------------------------------------- POBLANDO EVALUACIONES ----------------------------------------------------

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('InstituciOn', 'CC', 'nid001', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte1.pdf', 'AP');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci1n', 'CC', 'nid002', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'A', 'https://reporte2.pdf', 'PE');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Institucin2', 'CC', 'nid003', TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'A', 'https://reporte3.pdf', 'AP');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci3', 'CD', 'nid004', TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'M', 'https://reporte4.pdf', 'PE');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci4', 'CD', 'nid005', TO_DATE('2024-03-19', 'YYYY-MM-DD'), 'M', 'https://reporte5.pdf', 'AP');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci5', 'CC', 'nid006', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'M', 'https://reporte6.pdf', 'PE');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci6', 'CD', 'nid007', TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'M', 'https://reporte7.pdf', 'PE');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci7', 'CD', 'nid008', TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'B', 'https://reporte8.pdf', 'AP');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci8', 'CC', 'nid009', TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'B', 'https://reporte9.pdf', 'AP');

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('Instituci9', 'CC', 'nid010', TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'B', 'https://reporte10.pdf', 'AP');


---------------------------------------------------- POBLANDO AUDITORIAS ----------------------------------------------------

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA) 
VALUES (1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 1','CAT01','Instituci1n');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (2, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Crear', 'Auditoria 2', 'CAT02', 'Instituci3');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (3, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Crear', 'Auditoria 3', 'CAT03', 'Instituci4');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (4, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 'Crear', 'Auditoria 4', 'CAT04', 'Instituci5');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (5, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Crear', 'Auditoria 5', 'CAT05', 'Instituci6');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (6, TO_DATE('2024-03-19', 'YYYY-MM-DD'), 'Crear', 'Auditoria 6', 'CAT06', 'Instituci7');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (7, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Crear', 'Auditoria 7', 'CAT07', 'Instituci8');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (8, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Crear', 'Auditoria 8', 'CAT08', 'Instituci9');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (9, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Crear', 'Auditoria 9', 'CAT09', 'InstituciOn');

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA)
VALUES (10, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Crear', 'Auditoria 10', 'CAT10', 'Institucin2');


---------------------------------------------------- POBLANDO ARTICULOS ----------------------------------------------------

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (1, '001', '001', 'CAT01', 'Descripcion 1', 'NUEVO', 'foto1.jpg', 100.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (2, '001', '002', 'CAT02', 'Descripción 2', 'NUEVO', 'foto2.jpg', 120.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (3, '002', '001', 'CAT03', 'Descripción 3', 'NUEVO', 'foto3.jpg', 150.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (4, '002', '002', 'CAT04', 'Descripción 4', 'NUEVO', 'foto4.jpg', 200.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (5, '003', '001', 'CAT05', 'Descripción 5', 'NUEVO', 'foto5.jpg', 80.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (6, '003', '002', 'CAT06', 'Descripción 6', 'NUEVO', 'foto6.jpg', 90.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (7, '004', '001', 'CAT07', 'Descripción 7', 'NUEVO', 'foto7.jpg', 110.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (8, '004', '002', 'CAT08', 'Descripción 8', 'NUEVO', 'foto8.jpg', 130.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (9, '005', '001', 'CAT09', 'Descripción 9', 'NUEVO', 'foto9.jpg', 180.00, 'Y');

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (10, '005', '010', 'CAT10', 'Descripción 10', 'NUEVO', 'foto10.jpg', 250.00, 'Y');

---------------------------------------------------- POBLANDO CALIFICACIONES ----------------------------------------------------

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('001', '001', 1, 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('001', '002', 2, 3);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('002', '001', 3, 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('002', '002', 4, 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('003', '001', 5, 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('003', '002', 6, 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('004', '001', 7, 3);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('004', '002', 8, 4);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('005', '001', 9, 5);

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('005', '010', 10, 3);


------------------------------------------ PoblarNoOk ------------------------------------------

---El caso del insert en la tabla UNIVERSIDADES donde la PK se repite debería ser protegido por la restricción de unicidad de la PK PK_UNIVERSIDAD_.

INSERT INTO UNIVERSIDADES (codigo, usuarioTid, usuarioNid, representante, nombre, direccion)
VALUES('001', NULL, NULL, 'Rep1', 'Universidad55', 'Calle 17A # 75 ');


---El caso del insert en la tabla USUARIOS donde la PK de tid y nid se repiten debería ser protegido por las restricciones de unicidad de las 
-- PK UK_USUARIO_tid y UK_USUARIO_nid. -- 

INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('Uni', '001', '001', '001', 'MismasPK', 'Nodeberia', 'repetirse', TO_DATE('14-03-2024', 'DD-MM-YYYY'), NULL, 0);


/*
    El caso del insert en la tabla EVALUACIONES donde se hacen referencias a tid y nid inexistentes, debería ser protegido por la 
    restricción de integridad referencial FK_EVALUACIONES_AUDITORIAS_auditoriaI. Aunque esta restricción no verifica directamente la 
    existencia de tid y nid, protege la integridad referencial entre las tablas EVALUACIONES y AUDITORIAS, lo que indirectamente podría ayudar 
    a prevenir este tipo de errores.
*/

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado, respuestas, auditoriaI)
VALUES ('Administrativo', '001', '999', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 'Descripcion evaluacion 3', 'reporte44.pdf', 'Por hacer', 'Respuestas evaluacion 3', 3);

---Si se intenta insertar en la tabla articulo un dato en el atributo foto que sea NULL, generar error ya que es UNIQUE
INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (1, '1', '123', 'CAT01', 'Descripcion 1', 'NUEVO', NULL, 100.00, 'Y');

---Si se intenta eliminar algún codigoUn (primary key tabla UNIVERSIDADES)  que este presente en la tabla USUARIOS. Va generar error ya que no esta definido como cascade ni null, esta por defecto.
DELETE FROM UNIVERSIDADES WHERE codigoUn= '1';

---Si se trata de insertar un id (primary key)en la tabla ARTICULOS con valor nulo, genera error ya que las llaves principales no pueden ser nulas
INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (NULL, '11', '140', 'CAT11', 'Descripcion 11', 'USADO', 'foto11.png', 210.00, 'Y');

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


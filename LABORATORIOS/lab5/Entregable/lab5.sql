
------------------------------------------ TABLAS------------------------------------------
-- Si hubo cambios --
CREATE TABLE USUARIOS( 
    universidadC    VARCHAR(3) NOT NULL,
    codigo          VARCHAR(3) NOT NULL,
    tid             VARCHAR(3)NOT NULL,
    nid             VARCHAR(50) NOT NULL,
    nombre          VARCHAR(50)NOT NULL,
    programa        VARCHAR(20)NOT NULL,
    correo          VARCHAR(50)NOT NULL,
    registro        DATE NOT NULL,
    suspension      DATE, -- Agregamos que esta podr�a ser nula -- 
    nSuspensiones   INTEGER NOT NULL
);

-- Si hubo cambios --
CREATE TABLE UNIVERSIDADES(
    codigoUn        VARCHAR(3) NOT NULL,
    representanteU   VARCHAR(10),-- Agregamos que esta podr�a ser nula -- 
    representanteC   VARCHAR(10),-- Agregamos que esta podr�a ser nula -- 
    nombre          VARCHAR(50)NOT NULL,
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
    perteneceC VARCHAR(20) -- Agregamos que esta podr�a ser nula -- 
);

CREATE TABLE AUDITORIAS(
    id      INTEGER NOT NULL,
    fecha   DATE NOT NULL,
    accion  VARCHAR(20) NOT NULL,
    nombre  VARCHAR(40) NOT NULL,
    categoriaC VARCHAR(5) NOT NULL,
    evaluacionA VARCHAR(20) -- Agregamos que esta podr�a ser nula -- 
);

-- Si hubo cambios --
CREATE TABLE EVALUACIONES( 
    a_omes      VARCHAR(20) NOT NULL,
    tid         VARCHAR(2) NOT NULL,
    nid         VARCHAR(10) NOT NULL,
    fecha       DATE  NOT NULL,
    descripcion VARCHAR(255), -- Agregamos que esta podr�a ser nula -- 
    reporte     VARCHAR(255) NOT NULL,
    resultado   VARCHAR(20) NOT NULL
);

CREATE TABLE RESPUESTAS(
    evaluacionA    VARCHAR(20) NOT NULL,
    respuesta      VARCHAR(50) NOT NULL -- Agregamos que esta NO podr�a ser nula -- 
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
drop table "ARTICULOS" cascade constraints PURGE;
drop table "AUDITORIAS" cascade constraints PURGE;
drop table "CALIFICACIONES" cascade constraints PURGE;
drop table "CARACTERISTICAS" cascade constraints PURGE;
drop table "CATEGORIAS" cascade constraints PURGE;
drop table "EVALUACIONES" cascade constraints PURGE;
drop table "PERECEDERO" cascade constraints PURGE;
drop table "RESPUESTAS" cascade constraints PURGE;
drop table "ROPAS" cascade constraints PURGE;
drop table "UNIVERSIDADES" cascade constraints PURGE;
drop table "USUARIOS" cascade constraints PURGE;

------------------------------------------ TUPLAS ------------------------------------------
-----CASO DE USO 2 -----
---ADICIONAR---
-- La fecha de la evaluaci�n se genera autom�ticamente y debe ser posterior al a�o-mes evaluado
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_fecha
BEFORE INSERT ON EVALUACIONES
FOR EACH ROW
DECLARE
    a�o_aomes INT;
    mes_aomes INT;
BEGIN
    a�o_aomes := TO_NUMBER(SUBSTR(:NEW.a_omes, 1, 4));
    mes_aomes := TO_NUMBER(SUBSTR(:NEW.a_omes, 5, 2));
    
    IF EXTRACT(YEAR FROM :NEW.fecha) < a�o_aomes OR 
       (EXTRACT(YEAR FROM :NEW.fecha) = a�o_aomes AND EXTRACT(MONTH FROM :NEW.fecha) <= mes_aomes) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de evaluaci�n debe ser posterior al a�o-mes evaluado');
    END IF;
END;
/

---Los registros asociados son los correspondientes al a�o-mes definido.---

---MODIFICAR---
---El �nico dato que se puede modificar es el resultado de las auditor�as.
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_resultado
BEFORE UPDATE ON EVALUACIONES
FOR EACH ROW
BEGIN
    IF :old.a_omes != :new.a_omes OR :old.tid != :new.tid OR :old.nid != :new.nid OR :old.fecha != :new.fecha OR :old.descripcion != :new.descripcion
        OR :old.reporte != :new.reporte THEN
        RAISE_APPLICATION_ERROR(-20004, 'El �nico dato que se puede modificar es el resultado');
    END IF;
END;
/
---Solo es posible adicionar respuestas de las anomal�as si el estado de la auditor�a es pendiente
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_RESPUESTAS
BEFORE UPDATE ON RESPUESTAS 
FOR EACH ROW
DECLARE
    v_estado VARCHAR(20);
BEGIN
    SELECT resultado into v_estado FROM EVALUACIONES WHERE a_omes= :new.evaluacionA ;
    IF v_estado <> 'PE' THEN    
        RAISE_APPLICATION_ERROR(-20008, 'No se puede modificar el resultado de la auditor�a si el estado no es pendiente');
    END IF;
END;
/
---ELIMINAR---
---Las evaluaciones se pueden eliminar si no tienen anomal�as. 
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_descripcion
BEFORE DELETE ON EVALUACIONES 
FOR EACH ROW
BEGIN
    IF :old.descripcion IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20009, 'No se puede eliminar la evaluaci�n si existen respuestas asociadas');
    END IF;
END;
/

------------------------------------------ ACCIONES ------------------------------------------
--------------------------CASO DE USO 1--------------------------
-- Adicionar --
-- Los c�digos deben iniciar con una letra may�scula, en el caso de empezar por una letra min�scula, la cambia a may�scula --
CREATE OR REPLACE TRIGGER TR_codigo_uppercase
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF REGEXP_LIKE(:new.codigo, '^[a-z].*') THEN
        :new.codigo := UPPER(SUBSTR(:new.codigo, 1, 1)) || SUBSTR(:new.codigo, 2);
    ELSIF NOT REGEXP_LIKE(:new.codigo, '^[A-Z].*') THEN
        RAISE_APPLICATION_ERROR(-20001, 'El c�digo debe comenzar con una letra may�scula.');
    END IF;
END;
/

-- Si no se indica el nombre se le asigna. �Nombre de �<codigo> --
CREATE OR REPLACE TRIGGER TR_assign_codigo
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW 
BEGIN
	IF :new.nombre IS NULL THEN
    	:new.nombre := 'Nombre de ' || :new.codigo;
    END IF;
END;
/

-- El precio m�nimo debe ser menor que el m�ximo -- 
CREATE OR REPLACE TRIGGER TR_precio_minimo_maximo
BEFORE INSERT OR UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :new.minimo >= :new.maximo THEN
        RAISE_APPLICATION_ERROR(-20002, 'El precio m�nimo debe ser menor que el precio m�ximo.');
    END IF;
END;
/

-- Si no se indica el precio m�ximo se supone que es el doble del m�nimo -- 
CREATE OR REPLACE TRIGGER TR_precio_maximo_predeterminado
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :new.maximo IS NULL THEN
        :new.maximo := :new.minimo * 2;
    END IF;
END;
/


-- MODIFICAR --
-- Los �nicos datos que se pueden modificar son el m�nimo y el m�ximo. �nicamente pueden aumentar. --
CREATE OR REPLACE TRIGGER TR_inmutabilidad_datos
BEFORE UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :old.codigo != :new.codigo OR :old.nombre != :new.nombre OR :old.tipo != :new.tipo OR :old.perteneceC != :new.perteneceC THEN
        RAISE_APPLICATION_ERROR(-20004, 'Los �nicos datos que se pueden modificar son el m�nimo y el m�ximo.');
    ELSIF :new.minimo >= :new.maximo THEN
        RAISE_APPLICATION_ERROR(-20005, 'El precio m�nimo debe ser menor que el precio m�ximo.');
	END IF;
END;
/


-- Si se modifica el m�nimo, el m�ximo debe modificarse en el mismo valor. -- 
CREATE OR REPLACE TRIGGER TR_actualizar_maximo
BEFORE UPDATE ON CATEGORIAS
FOR EACH ROW
BEGIN
    IF :old.minimo != :new.minimo THEN
        :new.maximo := :old.maximo + :new.minimo - :old.minimo;
    END IF;
END;
/


-- CREAR AUDITORIAS --
CREATE OR REPLACE TRIGGER TR_creacion_categoria_auditoria
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
--------------------------CASO DE USO 1--------------------------
DROP TRIGGER TR_codigo_uppercase;
DROP TRIGGER TR_assign_codigo;
DROP TRIGGER TR_precio_minimo_maximo;
DROP TRIGGER TR_precio_maximo_predeterminado;
DROP TRIGGER TR_inmutabilidad_datos;
DROP TRIGGER TR_actualizar_maximo;
DROP TRIGGER TR_creacion_categoria_auditoria;
--------------------------CASO DE USO 2--------------------------
DROP TRIGGER TR_EVALUACIONES_fecha;
DROP TRIGGER TR_EVALUACIONES_tipo;
DROP TRIGGER TR_EVALUACIONES_resultado;
DROP TRIGGER TR_EVALUACIONES_RESPUESTAS;
DROP TRIGGER TR_EVALUACIONES_descripcion;
---------------------------------------------------- POBLANDO CATEGORIAS ----------------------------------------------------

INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC) 
VALUES ('A1', 'Categoria 1', 'Electronica', 50.00, 200.00, 'A1');


-----------------------------------------  POBLANDO EVALUACIONES ----------------------------------------- 

INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado) 
VALUES ('202301', 'CC', 'nid001', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte1.pdf', 'AP');


-----------------------------------------  POBLANDO AUDITORIAS ----------------------------------------- 

INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, EvaluacionA) 
VALUES (1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 1','A1','202301');
-----------------------------------------  POBLANDO ARTICULOS ----------------------------------------- 

INSERT INTO ARTICULOS (id, usuarioU, usuarioC, categoriaC, descripcion, estado, foto, precio, disponible) 
VALUES (1, '001', '001', 'A1', 'Descripcion 1', 'NUEVO', 'foto1.jpg', 100.00, 'Y');
----------------------------------------- POBLANDO CALIFICACIONES ----------------------------------------- 

INSERT INTO CALIFICACIONES (usuarioU, usuarioC, articuloI, estrellas) 
VALUES ('001', '001', 1, 4);
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


------------------------------------------ LAB 5 ------------------------------------------ 
----------------------------------- EXTENDIENDO USUARIOS ----------------------------------
INSERT INTO mbda.DATA (UCODIGO,UNOMBRE,UDIRECCION,NID,NOMBRES)
VALUES (111,'ESCUELA',  'AK 45 (Autonorte) #205/59',1000095983,'Esteban Aguilera Contreras');

INSERT INTO mbda.DATA (UCODIGO,UNOMBRE,UDIRECCION,NID,NOMBRES)
VALUES (111,'ESCUELA','AK 45 (Autonorte) #205/59',1000095256,'Miguel Angel Motta');

SELECT NOMBRES FROM MBDA.DATA WHERE NID = 1000095983 OR NID = 1000095256 GROUP BY NOMBRES;

GRANT DELETE ON MBDA.DATA TO BD1000095983 WITH GRANT OPTION;

DELETE FROM mbda.DATA WHERE NID=1000095983;
DELETE FROM mbda.DATA WHERE NID=1000095256;



CREATE OR REPLACE PACKAGE data_a_universidades  AS
    
    PROCEDURE MIGRAR_DATA_UNIVERSIDADES;
    END data_a_universidades;
/

/* Este paquete contiene la transaccion de MBDA.DATA  universidade y usuarios 
* de nuestra base de datos.
*/
CREATE OR REPLACE PACKAGE BODY data_a_universidades AS 
    PROCEDURE MIGRAR_DATA_UNIVERSIDADES IS
    /* Inicia la transaccion*/
    BEGIN
        /* Inician las operaciones de migracion*/
        BEGIN   
            INSERT INTO UNIVERSIDADES (codigoUn, nombre, direccion)
            SELECT codigoUn, nombre, direccion
            FROM (
                SELECT TO_CHAR(UCODIGO) AS codigoUn, 
                TRIM(UPPER(UNOMBRE)) AS nombre, 
                UDIRECCION AS direccion,
                ROW_NUMBER() OVER (PARTITION BY TRIM(UPPER(UNOMBRE)) ORDER BY UCODIGO) AS row_num
                FROM mbda.DATA
                    ) subquery
                WHERE row_num = 1
                AND TRIM(nombre) IS NOT NULL AND LENGTH(TRIM(nombre)) > 0
                ;
            /*Confirmar los cambios*/
            COMMIT; 
            /*Si ocurre un error durante la transaccion que regrese a su estado correcto*/
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE;
                END;
            END MIGRAR_DATA_UNIVERSIDADES;
        END data_a_universidades;
/

/*============================================================================*/
/*Compilar el paquete de DATA a UNIVERSIDADES*/

BEGIN
  data_a_universidades.MIGRAR_DATA_UNIVERSIDADES;
END;
/
-- INSERTAR USUARIOS
INSERT INTO USUARIOS (universidadC, codigo, tid, nid, nombre, programa, correo, registro, nSuspensiones)
SELECT 
    UCODIGO AS universidadC,
    UPPER(DBMS_RANDOM.string('U', 3)) AS codigo,
    'CC' AS tid,
    NID AS nid,
    NOMBRES AS nombre,
    CASE
        WHEN UCODIGO = '111' THEN 'Ingenier�a'
        WHEN UCODIGO = '112' THEN 'Derecho'
        WHEN UCODIGO = '113' THEN 'Medicina'
        ELSE 'Por definir'
    END AS programa,
    substr(NOMBRES, 1, (INSTR(NOMBRES, ' '))-1) || lower(substr(NOMBRES, 1, 7)) || '@edu.co' AS correo,
    CURRENT_DATE AS registro,
    0 AS nSuspensiones
FROM mbda.DATA
ORDER BY nid;

/*----------------------------------------------------------------------------------------------*/




--paquete evaluaciones---
----------------------------------CRUDE------------------------------------
-----------CATEGORIAS CREACION -----------
CREATE OR REPLACE PACKAGE PC_CATEGORIAS AS
    --- ADICIONAR ---
    PROCEDURE crear_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    );

    --- LEER ---
    FUNCTION leer_categoria(
        p_codigo IN VARCHAR2
    ) RETURN SYS_REFCURSOR;

    --- ACTUALIZAR ---
    PROCEDURE actualizar_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    );

    --- ELIMINAR ---
    PROCEDURE eliminar_categoria(
        p_codigo IN VARCHAR2
    );
END PC_CATEGORIAS;
/


-----------AUDITORIAS CREACION--------------
CREATE OR REPLACE PACKAGE PC_AUDITORIAS AS
    --- ADICIONAR ---
    PROCEDURE crear_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    );

    --- LEER ---
    FUNCTION leer_auditoria(
        p_id IN INTEGER
    ) RETURN SYS_REFCURSOR;

    --- ACTUALIZAR ---
    PROCEDURE actualizar_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    );

    --- ELIMINAR ---
    PROCEDURE eliminar_auditoria(
        p_id IN INTEGER
    );
END PC_AUDITORIAS;
/


-----------EVALUACIONES CREACION -----------
CREATE OR REPLACE PACKAGE PC_EVALUACIONES AS
    -- ADICIONAR---
    PROCEDURE crear_evaluacion(
        p_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_fecha IN DATE,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    );
    --- LEER---
  FUNCTION leer_evaluaciones(a_omes_in IN EVALUACIONES.a_omes%TYPE) RETURN SYS_REFCURSOR;
END PC_EVALUACIONES;
/



-----------RESPUESTAS CREACION-----------
CREATE OR REPLACE PACKAGE PC_RESPUESTAS AS
    --- ADICIONAR ---
    PROCEDURE crear_respuesta(
        p_evaluacionA IN VARCHAR2,
        p_respuesta IN VARCHAR2
    );

    ---LEER ---
    FUNCTION leer_respuesta(
        p_evaluacionA IN VARCHAR2
    ) RETURN SYS_REFCURSOR;

    --- ACTUALIZAR ---
    PROCEDURE actualizar_respuesta(
        p_evaluacionA IN VARCHAR2,
        p_respuesta IN VARCHAR2
    );

    --- ELIMINAR ---
    PROCEDURE eliminar_respuesta(
        p_evaluacionA IN VARCHAR2
    );
END PC_RESPUESTAS;
/
----------------------------------CRUDI------------------------------------
-----------CATEGORIAS BODY -----------
CREATE OR REPLACE PACKAGE BODY PC_CATEGORIAS AS
    --- ADICIONAR BODY ---
    PROCEDURE crear_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    ) IS
    BEGIN
        INSERT INTO CATEGORIAS (codigo, nombre, tipo, minimo, maximo, perteneceC)
        VALUES (p_codigo, p_nombre, p_tipo, p_minimo, p_maximo, p_perteneceC);
        COMMIT;
    END crear_categoria;

    --- LEER BODY ---
    FUNCTION leer_categoria(
        p_codigo IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT codigo, nombre, tipo, minimo, maximo, perteneceC
        FROM CATEGORIAS
        WHERE codigo = p_codigo;
        RETURN v_cursor;
    END leer_categoria;

    --- ACTUALIZAR BODY ---
    PROCEDURE actualizar_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    ) IS
    BEGIN
        UPDATE CATEGORIAS SET
            nombre = p_nombre,
            tipo = p_tipo,
            minimo = p_minimo,
            maximo = p_maximo,
            perteneceC = p_perteneceC
        WHERE codigo = p_codigo;
        COMMIT;
    END actualizar_categoria;

    --- ELIMINAR BODY ---
    PROCEDURE eliminar_categoria(
        p_codigo IN VARCHAR2
    ) IS
    BEGIN
        DELETE FROM CATEGORIAS WHERE codigo = p_codigo;
        COMMIT;
    END eliminar_categoria;
END PC_CATEGORIAS;
/

-----------AUDITORIAS BODY------------------
CREATE OR REPLACE PACKAGE BODY PC_AUDITORIAS AS
    --- ADICIONAR ---
    PROCEDURE crear_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    ) IS
    BEGIN
        INSERT INTO AUDITORIAS (id, fecha, accion, nombre, categoriaC, evaluacionA)
        VALUES (p_id, p_fecha, p_accion, p_nombre, p_categoriaC, p_evaluacionA);
        COMMIT;
    END crear_auditoria;

    --- LEER ---
    FUNCTION leer_auditoria(
        p_id IN INTEGER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, fecha, accion, nombre, categoriaC, evaluacionA
        FROM AUDITORIAS
        WHERE id = p_id;
        RETURN v_cursor;
    END leer_auditoria;

    --- ACTUALIZAR ---
    PROCEDURE actualizar_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    ) IS
    BEGIN
        UPDATE AUDITORIAS SET
            fecha = p_fecha,
            accion = p_accion,
            nombre = p_nombre,
            categoriaC = p_categoriaC,
            evaluacionA = p_evaluacionA
        WHERE id = p_id;
        COMMIT;
    END actualizar_auditoria;

    --- ELIMINAR  ---
    PROCEDURE eliminar_auditoria(
        p_id IN INTEGER
    ) IS
    BEGIN
        DELETE FROM AUDITORIAS WHERE id = p_id;
        COMMIT;
    END eliminar_auditoria;
END PC_AUDITORIAS;
/


-----------EVALUACIONES BODY-----------
CREATE OR REPLACE PACKAGE BODY PC_EVALUACIONES AS
    --- ADICIONAR BODY---
    PROCEDURE crear_evaluacion(
        p_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_fecha IN DATE,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO EVALUACIONES (a_omes, tid, nid, fecha, descripcion, reporte, resultado)
        VALUES (p_omes, p_tid, p_nid, p_fecha, p_descripcion, p_reporte, p_resultado);
        COMMIT;
    END crear_evaluacion;
    
    ---LEER BODY---
    
    FUNCTION leer_evaluaciones(a_omes_in IN EVALUACIONES.a_omes%TYPE) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT a_omes, tid, nid, fecha, descripcion, reporte, resultado
        FROM EVALUACIONES
        WHERE a_omes = a_omes_in; -- Filtrar por el valor de a_omes proporcionado
        RETURN v_cursor;
    END leer_evaluaciones;
END PC_EVALUACIONES;
/


-----------RESPUESTAS BODY  -----------
CREATE OR REPLACE PACKAGE BODY PC_RESPUESTAS AS
    --- ADICIONAR ---
    PROCEDURE crear_respuesta(
        p_evaluacionA IN VARCHAR2,
        p_respuesta IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO RESPUESTAS (evaluacionA, respuesta)
        VALUES (p_evaluacionA, p_respuesta);
        COMMIT;
    END crear_respuesta;

    --- LEER ---
    FUNCTION leer_respuesta(
        p_evaluacionA IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT evaluacionA, respuesta
        FROM RESPUESTAS
        WHERE evaluacionA = p_evaluacionA;
        RETURN v_cursor;
    END leer_respuesta;

    --- ACTUALIZAR ---
    PROCEDURE actualizar_respuesta(
        p_evaluacionA IN VARCHAR2,
        p_respuesta IN VARCHAR2
    ) IS
    BEGIN
        UPDATE RESPUESTAS SET
            respuesta = p_respuesta
        WHERE evaluacionA = p_evaluacionA;
        COMMIT;
    END actualizar_respuesta;

    --- ELIMINAR ---
    PROCEDURE eliminar_respuesta(
        p_evaluacionA IN VARCHAR2
    ) IS
    BEGIN
        DELETE FROM RESPUESTAS WHERE evaluacionA = p_evaluacionA;
        COMMIT;
    END eliminar_respuesta;
END PC_RESPUESTAS;
/



----------------------------------CRUDOK------------------------------------
----Crear una nueva categor�a y leerla ----
BEGIN
    PC_CATEGORIAS.crear_categoria('A1', 'Categoria 2', 'Electr�nica', 50, 60, 'A1');
END;
/

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PC_CATEGORIAS.leer_categoria('A1');
END;
/


---Crear una nueva evaluacion ---
BEGIN
    PC_EVALUACIONES.crear_evaluacion('202302', 'CC', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte2.pdf', 'AP');
END;
/


---Crear una nueva respuesta y leerla ---
BEGIN
    PC_RESPUESTAS.crear_respuesta('202302', 'Respuesta para Evaluacion 202302');
END;
/

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PC_RESPUESTAS.leer_respuesta('202302');
    
END;
/

---CREAR AUDITORIA Y ACTUALIZARLA ---

BEGIN
    PC_AUDITORIAS.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 2', 'A1', '202302');
END;
/

BEGIN
    PC_AUDITORIAS.actualizar_auditoria(2, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'Modificar', 'Auditoria 2 Modificada', 'A1', '202302');
END;
/



--- ELIMINAR UNA CATEGORIA ---
BEGIN
    PC_CATEGORIAS.eliminar_categoria('A1');
END;
/

----------------------------------CRUDnOK------------------------------------

---INTENTAR CREAR UNA EVALUACION QUE YA EXISTE----
BEGIN
    PC_EVALUACIONES.crear_evaluacion('202302', 'CC', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte2.pdf', 'AP');
END;
/
--- CREAR UNA RESPUESTA QUE NO TIENE ASOCIADA UNA EVALUACION ---
BEGIN
    PC_RESPUESTAS.crear_respuesta('23213123', 'Respuesta sin evaluaci�n asociada');
END;
/

--- CREAR UNA AUDITORIA CON UN ID CON CODIGO QUE NO CUMPLA CON EL TIPO DE DATO PERMITIDO---
BEGIN
    PC_CATEGORIAS.crear_categoria('A1232132132131231232132131', 'Categoria 2', 'Electr�nica', 50, 60, 'A1');
END;
/



---------------------------------- XCRUD ------------------------------------
-- Para PC_CATEGORIAS
DROP PACKAGE PC_CATEGORIAS;

-- Para PC_AUDITORIAS
DROP PACKAGE PC_AUDITORIAS;

-- Para PC_EVALUACIONES
DROP PACKAGE PC_EVALUACIONES;

-- Para PC_RESPUESTAS
DROP PACKAGE PC_RESPUESTAS;

---------------------------------- ACTORES ------------------------------------
-------------------------------------ACTORESE---------------------------------------

CREATE OR REPLACE PACKAGE PA_AUDITOR AS
    --- ADICIONAR EN EVALUACIONES ---
    PROCEDURE crear_evaluacion(
        p_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_fecha IN DATE,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    );
    
    --- CONSULTAR EN EVALUACIONES ---
    FUNCTION consultar_evaluacion(
        p_omes IN VARCHAR2
    ) RETURN SYS_REFCURSOR;
    
    --- ACTUALIZAR EN AUDITORIAS ---
    PROCEDURE actualizar_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    );
END PA_AUDITOR;
/

CREATE OR REPLACE PACKAGE PA_ADMINISTRADOR AS
    --- CREAR EN AUDITORIAS ---
    PROCEDURE crear_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    );

    --- CREAR EN CATEGORIAS ---
    PROCEDURE crear_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    );

    --- LEER EN CATEGORIAS ---
    FUNCTION leer_categoria(
        p_codigo IN VARCHAR2
    ) RETURN SYS_REFCURSOR;

    --- ACTUALIZAR EN CATEGORIAS ---
    PROCEDURE actualizar_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    );

    --- ELIMINAR EN CATEGORIAS ---
    PROCEDURE eliminar_categoria(
        p_codigo IN VARCHAR2
    );
END PA_ADMINISTRADOR;
/

-------------------------------------ACTORESI---------------------------------------
-- PAQUETE DE AUDITOR --
CREATE OR REPLACE PACKAGE BODY PA_AUDITOR AS
    --- ADICIONAR EN EVALUACIONES ---
    PROCEDURE crear_evaluacion(
        p_omes IN VARCHAR2,
        p_tid IN VARCHAR2,
        p_nid IN VARCHAR2,
        p_fecha IN DATE,
        p_descripcion IN VARCHAR2,
        p_reporte IN VARCHAR2,
        p_resultado IN VARCHAR2
    ) IS
    BEGIN
        -- Llamar al procedimiento de creaci�n de evaluaci�n del paquete PC_EVALUACIONES
        PC_EVALUACIONES.crear_evaluacion(
            p_omes,
            p_tid,
            p_nid,
            p_fecha,
            p_descripcion,
            p_reporte,
            p_resultado
        );
    END crear_evaluacion;
    
    --- CONSULTAR EN EVALUACIONES ---
    FUNCTION consultar_evaluacion(
        p_omes IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Llamar a la funci�n de consulta de evaluaci�n del paquete PC_EVALUACIONES
        v_cursor := PC_EVALUACIONES.leer_evaluaciones(p_omes);
        RETURN v_cursor;
    END consultar_evaluacion;
    
    --- ACTUALIZAR EN AUDITORIAS ---
    PROCEDURE actualizar_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    ) IS
    BEGIN
        -- Llamar al procedimiento de actualizaci�n de auditor�a del paquete PC_AUDITORIAS
        PC_AUDITORIAS.actualizar_auditoria(
            p_id,
            p_fecha,
            p_accion,
            p_nombre,
            p_categoriaC,
            p_evaluacionA
        );
    END actualizar_auditoria;
END PA_AUDITOR;
/
-- PAQUETE DE ADMINISTRADOR --
CREATE OR REPLACE PACKAGE BODY PA_ADMINISTRADOR AS
    --- CREAR EN AUDITORIAS ---
    PROCEDURE crear_auditoria(
        p_id IN INTEGER,
        p_fecha IN DATE,
        p_accion IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_categoriaC IN VARCHAR2,
        p_evaluacionA IN VARCHAR2 := NULL
    ) IS
    BEGIN
        -- Llamar al procedimiento de creaci�n de auditor�a del paquete PC_AUDITORIAS
        PC_AUDITORIAS.crear_auditoria(
            p_id,
            p_fecha,
            p_accion,
            p_nombre,
            p_categoriaC,
            p_evaluacionA
        );
    END crear_auditoria;

    --- CREAR EN CATEGORIAS ---
    PROCEDURE crear_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    ) IS
    BEGIN
        -- Llamar al procedimiento de creaci�n de categor�a del paquete PC_CATEGORIAS
        PC_CATEGORIAS.crear_categoria(
            p_codigo,
            p_nombre,
            p_tipo,
            p_minimo,
            p_maximo,
            p_perteneceC
        );
    END crear_categoria;

    --- LEER EN CATEGORIAS ---
    FUNCTION leer_categoria(
        p_codigo IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Llamar a la funci�n de consulta de categor�a del paquete PC_CATEGORIAS
        v_cursor := PC_CATEGORIAS.leer_categoria(p_codigo);
        RETURN v_cursor;
    END leer_categoria;

    --- ACTUALIZAR EN CATEGORIAS ---
    PROCEDURE actualizar_categoria(
        p_codigo IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_minimo IN DECIMAL,
        p_maximo IN DECIMAL,
        p_perteneceC IN VARCHAR2 := NULL
    ) IS
    BEGIN
        -- Llamar al procedimiento de actualizaci�n de categor�a del paquete PC_CATEGORIAS
        PC_CATEGORIAS.actualizar_categoria(
            p_codigo,
            p_nombre,
            p_tipo,
            p_minimo,
            p_maximo,
            p_perteneceC
        );
    END actualizar_categoria;

    --- ELIMINAR EN CATEGORIAS ---
    PROCEDURE eliminar_categoria(
        p_codigo IN VARCHAR2
    ) IS
    BEGIN
        -- Llamar al procedimiento de eliminaci�n de categor�a del paquete PC_CATEGORIAS
        PC_CATEGORIAS.eliminar_categoria(p_codigo);
    END eliminar_categoria;
END PA_ADMINISTRADOR;
/

----------------------------------ACTORESOK------------------------------------
---- CREAR AUDITORIA Y LEERLA ----

BEGIN
    PA_ADMINISTRADOR.crear_categoria('A3', 'Categoria 3', 'Electr�nica', 50, 60, 'A3');
END;
/

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PA_ADMINISTRADOR.leer_categoria('A3');
END;
/

-- CREAR AUDITORIA Y ACTUALIZARLA --
-- La evaluacion debe existir --
BEGIN
    PC_EVALUACIONES.crear_evaluacion('202307', 'CC', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte3.pdf', 'AP');
END;
/

BEGIN
    PA_ADMINISTRADOR.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'Auditoria 2', 'A3', '202307');
END;
/

BEGIN
    PA_ADMINISTRADOR.actualizar_categoria('A3', 'Categoria 3', 'Electr�nica', 50, 70, 'A3');
END;
/

--- ELIMINAR CATEGORIA --
BEGIN
    PA_ADMINISTRADOR.eliminar_categoria('A3');
END;
/
--- AUDITOR  --
--- CREAR EVALUACION --
BEGIN
    PA_AUDITOR.crear_evaluacion('202308', 'CC', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte4.pdf', 'AP');
END;
/

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PA_AUDITOR.consultar_evaluacion('202302');
END;
/
--Crear una nueva respuesta y leerla:--
/*Para esto ya debe estar creada la autidoria, que se encarga de crear el administrador*/
BEGIN
    PA_ADMINISTRADOR.crear_categoria('A4', 'Para Auditor', 'Electr�nica', 50, 60, 'A4');
END;
/
BEGIN
    PA_ADMINISTRADOR.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'A para Auditor', 'A4', '202308');
END;
/

BEGIN
    PA_AUDITOR.actualizar_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Se modifico', 'Auditor Modificada', 'A4', '202308'); ---asdfasdfasdfsadfsadfsadf
END;
/
----------------------------------ACTORESnOK------------------------------------
-- Intentar crear una evaluacion con un reporte que ya existe (debe ser unico) ---
BEGIN
    PA_AUDITOR.crear_evaluacion('202308', 'CC', 'nid002', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporte4.pdf', 'AP');
END;
/

-- Deberia fallar si se intenta crear una auditoria con una Categoria que no esta definida --
BEGIN
    PA_ADMINISTRADOR.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'A para Auditor', 'A99', '202308');
END;
/

-- Deberia fallar si se intenta crear una auditoria y la evaluacion de referencia no existe (se puede crear una auditoria con evaluacion nula) --
BEGIN
    PA_ADMINISTRADOR.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Crear', 'A para Auditor', 'A4', '00000');
END;
/
---------------------------------- XACTORES ------------------------------------
-- Para PC_CATEGORIAS
DROP PACKAGE PA_AUDITOR;

-- Para PC_AUDITORIAS
DROP PACKAGE PA_ADMINISTRADOR;  
---------------------------------- SEGURIDAD ------------------------------------
-- CREAR LOS USUARIOS --
CREATE ROLE AUDITOR_GRUPO2_M_Y_E;
CREATE ROLE ADMINISTRADOR_GRUPO2_M_Y_E;
-- PERMISOS PARA ADMINISTRADOR --
GRANT EXECUTE ON PA_ADMINISTRADOR TO ADMINISTRADOR_GRUPO2_M_Y_E;
GRANT EXECUTE ON PC_AUDITORIAS TO ADMINISTRADOR_GRUPO2_M_Y_E;
GRANT EXECUTE ON PC_CATEGORIAS TO ADMINISTRADOR_GRUPO2_M_Y_E;

GRANT INSERT ON AUDITORIAS TO ADMINISTRADOR_GRUPO2_M_Y_E;
GRANT SELECT, INSERT, UPDATE, DELETE ON CATEGORIAS TO ADMINISTRADOR_GRUPO2_M_Y_E;

-- PERMISOS PARA AUDITOR --
GRANT EXECUTE ON PA_AUDITOR TO AUDITOR_GRUPO2_M_Y_E;
GRANT EXECUTE ON PC_AUDITORIAS TO AUDITOR_GRUPO2_M_Y_E;
GRANT EXECUTE ON PC_EVALUACIONES TO AUDITOR_GRUPO2_M_Y_E;
GRANT EXECUTE ON PC_EVALUACIONES TO AUDITOR_GRUPO2_M_Y_E;


GRANT SELECT, INSERT ON EVALUACIONES TO AUDITOR_GRUPO2_M_Y_E;
GRANT UPDATE ON AUDITORIAS TO AUDITOR_GRUPO2_M_Y_E;

GRANT ADMINISTRADOR TO bd1000095983;

---------------------------------- PRUEBAS ------------------------------------

--- Mar�a es una estudiante universitaria entusiasta que recientemente se uni� a una plataforma en l�nea donde puede comprar y evaluar art�culos. 
--- Hoy, Mar�a ha comprado un art�culo y est� emocionada de dejar una evaluaci�n sobre su experiencia.

---1.Para esto , maria quiere crear una evaluaci�n de su experiencia:
BEGIN
    PC_EVALUACIONES.crear_evaluacion('202100', 'CC', 'nidMariaa', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'A', 'https://reporteMaria.pdf', 'PE');
END;
/

---2. Ya teniendo su registro de evaluaci�n creado, maria quiere dejar sus comentarios y su experiencia

BEGIN
    PC_RESPUESTAS.crear_respuesta('202100', 'Mi experiencia fue muy agradable, estoy feliz');
END;
/

---3.Maria ya creada su evaluaci�n, quiere ver en el sistema si se creo, por lo que quiere leerlo.
DECLARE
    v_cursor SYS_REFCURSOR;
    v_a_omes EVALUACIONES.a_omes%TYPE := '202100'; -- Especifica el valor de a_omes que deseas utilizar
BEGIN
    v_cursor := PC_EVALUACIONES.leer_evaluaciones(v_a_omes); -- Llama a la funci�n leer_evaluaciones con el valor de a_omes

    DBMS_SQL.RETURN_RESULT(v_cursor); -- Imprime el resultado del cursor
END;
/



---3. Minutos despues, Maria se dio cuenta que queria cambiar cosas a su respuesta , por lo que decidio actualizarla---
BEGIN
    PC_RESPUESTAS.actualizar_respuesta('202100', 'Mi experiencia fue buena');
END;
/

---4. Maria quiere ver como quedo su respuesta para ver si deja esa o la cambia por otra, por lo que decide leerla
DECLARE
    v_cursor SYS_REFCURSOR;
    v_evaluacionA RESPUESTAS.evaluacionA%TYPE := '202100'; -- Especifica el valor de a_omes que deseas utilizar
BEGIN
    v_cursor := PC_RESPUESTAS.leer_respuesta(v_evaluacionA); -- Llama a la funci�n leer_evaluaciones con el valor de a_omes

    DBMS_SQL.RETURN_RESULT(v_cursor); -- Imprime el resultado del cursor
END;
/
---5. Al ver la  respuesta maria volvio a cambiar de opini�n y decidio que no queria dejar ninguna respuesta. Le parece algo innecesario, por lo que quiere eliminarla
BEGIN
    PC_RESPUESTAS.eliminar_respuesta('202100');
END;
/
---6. Maria elimino su respuesta, pues se dio cuenta que el producto no era malo pero le faltaban caracteristicas, asi que ella quiere hacer
--- un articulo basado en ese, pero para eso necesita una nueva categoria, por lo que fue y se lo comento al administrador. 
--- El administrador crea una nueva categoria para Maria

BEGIN
    PA_ADMINISTRADOR.crear_categoria('A11', 'Para Auditor', 'Articulo de Belleza', 50, 60, 'A11');
END;
/
--- 7. Maria le dice que no era un articulo de belleza , era un articulo de limpieza.  El administrador, luego de evaluar la peticion de Maria, 
--- va a permitir la actualizacion de la categoria.

BEGIN
    PA_ADMINISTRADOR.actualizar_categoria('A11', 'Para Auditor', 'Articulo de limpieza', 50, 60, 'A11');
END;
/

--- 8. Luego de ello, el Administrador quiere llevar un seguimiento, asi que va a crear una auditoria para monitorear el comportamiento que llegue a tener.

BEGIN
    PA_ADMINISTRADOR.crear_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Monitoreo Para Maria', 'Auditoria M', 'A11', '202100');
END;
/

--- 9. En ese momento el Administrador llama a su asistente, con el objetivo que monitoree la auditoria. El asistente consulta la auditoria para ver si esta correcta.
DECLARE
    v_cursor SYS_REFCURSOR;
    v_id AUDITORIAS.id%TYPE := 2; -- Especifica el valor de a_omes que deseas utilizar
BEGIN
    v_cursor := PC_AUDITORIAS.leer_auditoria(v_id); -- Llama a la funci�n leer_evaluaciones con el valor de a_omes

    DBMS_SQL.RETURN_RESULT(v_cursor); -- Imprime el resultado del cursor
END;
/


--- 10. Finalmente el Auditor se da cuenta que la auditoria es correcta y actualiza el nombre

BEGIN
    PA_AUDITOR.actualizar_auditoria(2, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 'Modificado', 'Auditoria terminada', 'A11', '202020');
END;
/
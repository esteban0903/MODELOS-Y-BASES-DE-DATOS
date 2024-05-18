-------------------------------- ACTORESE --------------------------------}
/*
    El administrador esta encargado de llevar el registro de inventario de 
    articulos que maneja la biblioteca, tanto fisicos como digitales, registra 
    las compras con los proveedores y tiene bajo su responsabilidad manejar este
    area garantizando que los articulos queden correctamente inventariados
*/

CREATE OR REPLACE PACKAGE PC_ADMINISTRADOR AS
    -------------- CRUD VENTAS --------------
    -- CREATE --
    PROCEDURE ventasCrear(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- READ --
    FUNCTION ventasLeer RETURN SYS_REFCURSOR;
    FUNCTION ventaLeer(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- UPDATE --
    PROCEDURE ventaActualizar(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- DELETE --
    PROCEDURE ventaEliminar(
        p_idCompra IN VARCHAR2
    );
    
    -------------- CRUD ARTICULOS --------------
    -- CREATE
    PROCEDURE articuloCrear(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    );

    -- READ
    FUNCTION articulosLeer RETURN SYS_REFCURSOR;
    FUNCTION articuloLeer(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE articuloActualizar(
    p_idArticulo IN VARCHAR2,
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    PROCEDURE articuloEliminar(p_idArticulo IN VARCHAR2);    
    
    ------------- CRUD PROVEEDORES --------------
    -- CREATE --
    PROCEDURE proveedorCrear(
        p_nombreP IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    );
    -- READ --
    FUNCTION proveedoresLeer RETURN SYS_REFCURSOR;
    
    FUNCTION proveedorLeer_id(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE proveedorActualizar(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE proveedorEliminar(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2
    );


    ------------- CRUD FISICOS --------------
    -- CREATE
    PROCEDURE fisicoCrear(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2
    );

    -- READ
    FUNCTION fisicosLeer RETURN SYS_REFCURSOR;
    FUNCTION fisicoLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE fisicoActualizar(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_disponible IN CHAR
    );

    -- DELETE
    PROCEDURE fisicoEliminar(p_articuloI IN VARCHAR2);
    
    ------------- CRUD DIGITALES --------------
    -- CREATE
    PROCEDURE digitalCrear(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- READ
    FUNCTION digitalesLeer RETURN SYS_REFCURSOR;
    FUNCTION digitalLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE digitalActualizar(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- DELETE
    PROCEDURE digitalEliminar(p_articuloI IN VARCHAR2);

    ------------- CRUD AUTORES --------------
    -- CREATE
    PROCEDURE autorCrear(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- READ
    FUNCTION autoresLeer RETURN SYS_REFCURSOR;
    FUNCTION autorLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE autorActualizar(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- DELETE
    PROCEDURE autorEliminar(p_articuloI IN VARCHAR2,p_autor IN VARCHAR2);
END PC_ADMINISTRADOR;
/
/*
    El Bibliotecario es un funcionario de la biblioteca, interactua con los clientes
    y bajo su cargo esta llevar el registro de los mismos, el puede hacer la eliminacion
    de sus cuentas, pero debe ser el, verificando que no tengan cuentas pendiente, 
    prestamos activos y verificar que es la persona efectivamente.
    
    Se encarga de manejar los prestamos, las multas y las facturas, su labor es llevar 
    el seguimiento de las personas que tienen prestamos, atender los clientes proporcionando
    informacion de los articulos de la biblioteca y de sus estados de cuenta (respecto a 
    sus deudas, facturas, multas o cualquier inqueitud que tengan referente a la biblioteca)
    
    Puede su trabajo no debe poder acceder a informacion de ventas o proveedores.
    Su alcance es meramente hacia el cliente
*/

CREATE OR REPLACE PACKAGE PC_BIBLIOTECARIO AS
    ------------- CRUD SUSCRITOS --------------
    -- CREATE --
    PROCEDURE suscritoCrear(
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    );

    -- READ --
    FUNCTION suscritosLeer RETURN SYS_REFCURSOR;
    
    FUNCTION suscritoLeer_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE suscritoActualizar(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE suscritoEliminar(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    );

    ------------- CRUD PRESTAMOS --------------
    -- CREATE
    PROCEDURE prestamosCrear(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- READ
    FUNCTION prestamosLeer RETURN SYS_REFCURSOR;
    FUNCTION leer_prestamo(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE prestamoActualizar(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- DELETE
    PROCEDURE prestamoEliminar(p_idPrestamo IN VARCHAR2);

    ------------- CRUD FACTURAS --------------
    -- CREATE
    PROCEDURE facturaCrear(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );

    -- READ
    FUNCTION facturasLeer RETURN SYS_REFCURSOR;
    FUNCTION facturaLeer(p_idFactura IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE facturaActualizar(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );

    -- DELETE
    PROCEDURE facturaEliminar(p_idFactura IN VARCHAR2);

    ------------- CRUD MULTAS --------------
    -- CREATE
    PROCEDURE multaCrear(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- READ
    FUNCTION multasLeer RETURN SYS_REFCURSOR;
    FUNCTION multaLeer(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE multaActualizar(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    PROCEDURE multaEliminar(p_idMulta IN VARCHAR2);
    
    ------------- CRUD DEVOLUCIONES --------------
    -- CREATE
    PROCEDURE devolucionCrear(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- READ
    FUNCTION devolucionesLeer RETURN SYS_REFCURSOR;
    FUNCTION devolucionLeer(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE devolucionActualizar(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- DELETE -- 
    PROCEDURE devolucionEliminar(p_prestamoI IN VARCHAR2);

    ------------- CONSULTAS OPERACIONALES --------------
    -- RESERVAS --
    FUNCTION reservaLeer(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR;
    FUNCTION reservasLeer RETURN SYS_REFCURSOR;
    
    -- ARTICULOS --
    FUNCTION articulosLeer RETURN SYS_REFCURSOR;
    FUNCTION articuloLeer(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- FISICOS --
    FUNCTION fisicosLeer RETURN SYS_REFCURSOR;
    FUNCTION fisicoLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- DIGITALES --
    FUNCTION digitalesLeer RETURN SYS_REFCURSOR;
    FUNCTION digitalLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;
    
END PC_BIBLIOTECARIO;
/

/*
    El cliente no es funcionario de la biblioteca, pero si se suscribe tiene
    acceso a las funcionalidades que ofrece. Para suscribirse lo puede hacer desde
    el portal web o pidiendole a un bibliotecario.
    
    El cliente suscrito tiene autonomia de su cuenta, pero por seguridad, no se permite
    que el cliente la elimine, puede hacerlo el bibliotecario en uno de los puntos de 
    atencion, esto con el fin de garantizar que el cliente no pueda borrar su cuenta
    si tiene multas por pagar, articulos por devolver o por confirmar que la persona
    que lo creo sea efectivamente quien lo quiere cancelar.
*/
CREATE OR REPLACE PACKAGE PC_CLIENTE AS
    ------------- CRUD RESERVAS --------------
    -- CREATE --
    PROCEDURE reservaCrear(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    );
    -- READ --
    FUNCTION reservaLeer_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR;
    FUNCTION leer_reservas RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE reservaLeer(
        p_reservaId IN VARCHAR2,
        p_estado    IN CHAR
    );
    -- DELETE -- SE COMPRUEBA QUE NO TENGA NINGUN PRESTAMO CREADO CON ESA RESERVA
    PROCEDURE reservaEliminar(
        p_reservaId IN VARCHAR2
    );

    ------------- CRU SUSCRITO --------------
    -- CREATE --
    PROCEDURE suscritoCrear(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    );

    -- READ --
    FUNCTION suscritosLeer RETURN SYS_REFCURSOR;
    FUNCTION suscritoLeer_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE suscritoActualizar(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    ------------- CONSULTAS OPERACIONALES --------------
    -- PRESTAMOS --
    FUNCTION prestamoLeer(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- FISICOS --
    FUNCTION fisicosLeer RETURN SYS_REFCURSOR;
    FUNCTION fisicoLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- FACTURAS -- SOLO LAS DE ESTE USUARIO --
    FUNCTION facturasLeer_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    FUNCTION facturaLeer(p_idFactura IN VARCHAR2) RETURN SYS_REFCURSOR;

END PC_CLIENTE;
/
/*
    El gerente tiene acceso a consultas hechas para mostrarle especificamente la 
    informacion relevante en general de la biblioteca, incluyendo las flujas con multa
    el total de facturas y las ventas efectuadas.
*/
CREATE OR REPLACE PACKAGE PC_GERENTE AS
    -- Aun tengo que definir este usando vistas especiales solo para este.

END PC_GERENTE;
/



-------------------------------- ACTORESI --------------------------------



CREATE OR REPLACE PACKAGE BODY PC_ADMINISTRADOR AS 
	--------------- CRUD ARTICULOS --------------
	PROCEDURE articuloCrear(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    ) IS
BEGIN
    PC_ARTICULOS.crear_articulo(p_prestamoI, p_genero, p_descripcion, p_fechaPublicacion, p_nombreArticulo);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20102, 'Se presentó un error al crear el Artículo, por favor verifique los parámetros e inténtelo nuevamente');
END articuloCrear;

    FUNCTION articulosLeer RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_ARTICULOS.leer_articulos;
    END articulosLeer;
    
    FUNCTION articuloLeer(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_ARTICULOS.leer_articulo(p_idArticulo);
    END articuloLeer;
    
    PROCEDURE articuloActualizar(
        p_idArticulo IN VARCHAR2,
        p_prestamoI IN VARCHAR2,
        p_genero IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) IS
    BEGIN
        PC_ARTICULOS.actualizar_articulo(p_idArticulo, p_prestamoI, p_genero, p_descripcion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20103, 'Se presentó un error al actualizar el Artículo, por favor verifique los parámetros e inténtelo nuevamente');
    END articuloActualizar;
    
    PROCEDURE articuloEliminar(p_idArticulo IN VARCHAR2) IS
    BEGIN
        PC_ARTICULOS.eliminar_articulo(p_idArticulo);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20104, 'Se presentó un error al eliminar el Artículo, por favor verifique los parámetros e inténtelo nuevamente');
    END articuloEliminar;
        ------------- CRUD PROVEEDORES --------------
    PROCEDURE proveedorCrear(
        p_nombreP IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    ) IS  id_cliente CLIENTES.idCliente%TYPE;
    BEGIN
        PC_CLIENTES.crear_cliente(p_clienteT,id_cliente);
        PC_PROVEEDORES.crear_proveedor(p_nombreP, id_cliente, p_clienteT, p_catalogo, p_correo_electronico);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20105, 'Se presentó un error al crear el Proveedor, por favor verifique los parámetros e inténtelo nuevamente');
    END proveedorCrear;
    
    FUNCTION proveedoresLeer RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_PROVEEDORES.leer_proveedores;
    END proveedoresLeer;
    
    FUNCTION proveedorLeer_id(
        p_id_proveedor IN VARCHAR2,
        p_tid_proveedor IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_PROVEEDORES.leer_proveedor_id(p_id_proveedor, p_tid_proveedor);
    END proveedorLeer_id;
    
    PROCEDURE proveedorActualizar(
        p_id_proveedor IN VARCHAR2,
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    ) IS
    BEGIN
        PC_PROVEEDORES.actualizar_proveedor(p_id_proveedor, p_tid_proveedor, p_correo_electronico, p_catalogo, p_nombre);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20106, 'Se presentó un error al actualizar el Proveedor, por favor verifique los parámetros e inténtelo nuevamente');
    END proveedorActualizar;
    
    PROCEDURE proveedorEliminar(
        p_id_proveedor IN VARCHAR2,
        p_tid_proveedor IN VARCHAR2
    ) IS
    BEGIN
        PC_PROVEEDORES.eliminar_proveedor(p_id_proveedor, p_tid_proveedor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20107, 'Se presentó un error al eliminar el Proveedor, por favor verifique los parámetros e inténtelo nuevamente');
    END proveedorEliminar;
	------------- CRUD VENTAS -------------
    PROCEDURE ventasCrear(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE
    )IS BEGIN 
	PC_VENTAS.crear_VENTAS(p_articuloI,p_clienteI,p_clienteT,p_metodoPago,p_total,p_fechaCompra);
	COMMIT;
	EXCEPTION 
    WHEN OTHERS THEN 
        ROLLBACK;
		RAISE_APPLICATION_ERROR(-20101, 'Se presento un error, al crear la Venta, por favor verifique los parametros e intentelo nuevamente');
    END ventasCrear;

    FUNCTION ventasLeer RETURN SYS_REFCURSOR IS
        BEGIN 
        RETURN PC_VENTAS.leer_ventas;
        END ventasLeer;

	FUNCTION ventaLeer(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR
        IS BEGIN
        RETURN PC_VENTAS.leer_venta(p_idCompra);
        END ventaLeer;

	PROCEDURE ventaActualizar(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    ) IS BEGIN 
        PC_VENTAS.actualizar_venta(p_idCompra,p_articuloI,p_metodoPago,p_total,p_fechaCompra);
		COMMIT;
		EXCEPTION 
        WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20102, 'Se presento un error, al actualizar la Venta como administrador, datos restablecidos');
        END ventaActualizar;

	PROCEDURE ventaEliminar(
        p_idCompra IN VARCHAR2
    ) IS BEGIN
        PC_VENTAS.eliminar_venta(p_idCompra);
        COMMIT;
		EXCEPTION 
            WHEN OTHERS THEN
            ROLLBACK;
			RAISE_APPLICATION_ERROR(-20101, 'Se presentó un error al eliminar la venta, por favor verifique los parámetros e inténtelo nuevamente');	
        END ventaEliminar;
        ------------- CRUD FISICOS --------------
    PROCEDURE fisicoCrear(
        p_articuloI IN VARCHAR2,
        p_estado IN VARCHAR2
    ) IS
    BEGIN
        PC_FISICOS.crear_fisico(p_articuloI, p_estado);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20108, 'Se presentó un error al crear el Físico, por favor verifique los parámetros e inténtelo nuevamente');
    END fisicoCrear;

    FUNCTION fisicosLeer RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_FISICOS.leer_fisicos;
    END fisicosLeer;
    
    FUNCTION fisicoLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_FISICOS.leer_fisico(p_articuloI);
    END fisicoLeer;
    
    PROCEDURE fisicoActualizar(
        p_articuloI IN VARCHAR2,
        p_estado IN VARCHAR2,
        p_disponible IN CHAR
    ) IS
    BEGIN
        PC_FISICOS.actualizar_fisico(p_articuloI, p_estado, p_disponible);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20109, 'Se presentó un error al actualizar el Físico, por favor verifique los parámetros e inténtelo nuevamente');
    END fisicoActualizar;
    
    PROCEDURE fisicoEliminar(p_articuloI IN VARCHAR2) IS
    BEGIN
        PC_FISICOS.eliminar_fisico(p_articuloI);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20110, 'Se presentó un error al eliminar el Físico, por favor verifique los parámetros e inténtelo nuevamente');
    END fisicoEliminar;
        ------------- CRUD DIGITALES --------------
    PROCEDURE digitalCrear(
        p_articuloI IN VARCHAR2,
        p_formato IN VARCHAR2
    ) IS
    BEGIN
        PC_DIGITALES.crear_digital(p_articuloI, p_formato);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20111, 'Se presentó un error al crear el Digital, por favor verifique los parámetros e inténtelo nuevamente');
    END digitalCrear;
    
    FUNCTION digitalesLeer RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_DIGITALES.leer_digitales;
    END digitalesLeer;
    
    FUNCTION digitalLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_DIGITALES.leer_digital(p_articuloI);
    END digitalLeer;
    
    PROCEDURE digitalActualizar(
        p_articuloI IN VARCHAR2,
        p_formato IN VARCHAR2
    ) IS
    BEGIN
        PC_DIGITALES.actualizar_digital(p_articuloI, p_formato);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20112, 'Se presentó un error al actualizar el Digital, por favor verifique los parámetros e inténtelo nuevamente');
    END digitalActualizar;
    
    PROCEDURE digitalEliminar(p_articuloI IN VARCHAR2) IS
    BEGIN
        PC_DIGITALES.eliminar_digital(p_articuloI);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20113, 'Se presentó un error al eliminar el Digital, por favor verifique los parámetros e inténtelo nuevamente');
    END digitalEliminar;
        ------------- CRUD AUTORES --------------
    PROCEDURE autorCrear(
        p_articuloI IN VARCHAR2,
        p_autor IN VARCHAR2
    ) IS
    BEGIN
        PC_AUTORES.crear_autor(p_articuloI, p_autor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20114, 'Se presentó un error al crear el Autor, por favor verifique los parámetros e inténtelo nuevamente');
    END autorCrear;
    
    FUNCTION autoresLeer RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_AUTORES.leer_autores;
    END autoresLeer;
    
    FUNCTION autorLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR IS
    BEGIN
        RETURN PC_AUTORES.leer_autor(p_articuloI);
    END autorLeer;
    
    PROCEDURE autorActualizar(
        p_articuloI IN VARCHAR2,
        p_autor IN VARCHAR2
    ) IS
    BEGIN
        PC_AUTORES.actualizar_autor(p_articuloI, p_autor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20115, 'Se presentó un error al actualizar el Autor, por favor verifique los parámetros e inténtelo nuevamente');
    END autorActualizar;
    
    PROCEDURE autorEliminar(
        p_articuloI IN VARCHAR2,
        p_autor IN VARCHAR2
    ) IS
    BEGIN
        PC_AUTORES.eliminar_autor(p_articuloI, p_autor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20116, 'Se presentó un error al eliminar el Autor, por favor verifique los parámetros e inténtelo nuevamente');
    END autorEliminar;
END PC_ADMINISTRADOR;
/

CREATE OR REPLACE PACKAGE BODY PC_BIBLIOTECARIO AS

END PC_BIBLIOTECARIO;
/
-------------------------------- SEGURIDAD --------------------------------
-------------------------------- SEGURIDAD OK --------------------------------
BEGIN
PC_ADMINISTRADOR.articuloCrear(null, 'Terror', 'Una historia de Terror',TO_DATE('1964-12-05', 'YYYY-MM-DD'),'Entre la Fe y la Locura');
END;
/
BEGIN
PC_ADMINISTRADOR.articuloCrear(null, 'Terror', 'Una historia de Terror 2.0',TO_DATE('1974-12-05', 'YYYY-MM-DD'),'Sombras de Redención');
END;
/
BEGIN
PC_ADMINISTRADOR.articuloCrear(null, 'Terror', 'Una historia de Terror 3.0',TO_DATE('1984-12-05', 'YYYY-MM-DD'),'Máscaras de Desesperación');
END;
/

-- Leer  Articulos --
DECLARE
    v_cursor SYS_REFCURSOR;
    v_registro ARTICULOS%ROWTYPE; -- Asumiendo que VENTAS es el nombre de tu tabla
BEGIN
    v_cursor := PC_ADMINISTRADOR.articulosLeer;
    LOOP
        FETCH v_cursor INTO v_registro;
        EXIT WHEN v_cursor%NOTFOUND;
        -- Aquí puedes procesar los datos de cada registro de la tabla VENTAS
        DBMS_OUTPUT.PUT_LINE('Datos de la articulos: ' || v_registro.IDARTICULO || ' ' || v_registro.PRESTAMOI || ' ' || v_registro.GENERO|| ' ' || v_registro.DESCRIPCION|| ' ' || v_registro.FECHAPUBLICACION|| ' ' || v_registro.NOMBREARTICULO);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- Leer Articulo Especifico --
DECLARE
    v_cursor SYS_REFCURSOR;
    v_registro ARTICULOS%ROWTYPE; -- Asumiendo que VENTAS es el nombre de tu tabla
BEGIN
    v_cursor := PC_ADMINISTRADOR.articuloLeer('A1');
        FETCH v_cursor INTO v_registro;
        -- Aquí puedes procesar los datos de cada registro de la tabla VENTAS
        DBMS_OUTPUT.PUT_LINE('Datos de la articulos: ' || v_registro.IDARTICULO || ' ' || v_registro.PRESTAMOI || ' ' || v_registro.GENERO|| ' ' || v_registro.DESCRIPCION|| ' ' || v_registro.FECHAPUBLICACION|| ' ' || v_registro.NOMBREARTICULO);
    CLOSE v_cursor;
END;
/
-- Actualizar articulo especifico --
BEGIN
	PC_ADMINISTRADOR.articuloActualizar('A1',null,'Suspenso','Una historia de y suspenso');
    END;
/
BEGIN
	PC_ADMINISTRADOR.articuloActualizar('A1',null,'Terror y Suspenso','Una historia de terror y suspenso');
    END;
/
-- Eliminar Articulo --
BEGIN
	PC_ADMINISTRADOR.articuloEliminar('A1');
    END;
/
-- Crear proveedor ---
BEGIN
	PC_ADMINISTRADOR.proveedorCrear('Henry','CE','Libros y revistas de ciencia ficcion','henryAllen@hotmail.com');
END;
/
BEGIN
	PC_ADMINISTRADOR.proveedorCrear('Jonathan','CC','Libros de Terror','jonthanT@hotmail.com');
END;
/

-- Leer Proveedores --
DECLARE
    v_cursor SYS_REFCURSOR;
    v_registro PROVEEDORES%ROWTYPE; -- Asumiendo que VENTAS es el nombre de tu tabla
BEGIN
    v_cursor := PC_ADMINISTRADOR.proveedoresLeer;
    LOOP
        FETCH v_cursor INTO v_registro;
        EXIT WHEN v_cursor%NOTFOUND;
        -- Aquí puedes procesar los datos de cada registro de la tabla VENTAS
        DBMS_OUTPUT.PUT_LINE('Datos de la articulos: '||' ' ||v_registro.NOMBREP||' ' ||v_registro.CLIENTEI||' ' ||v_registro.CLIENTET||' ' ||v_registro.CATALOGO||' ' ||v_registro.CORREOELECTRONICO);
    END LOOP;
    CLOSE v_cursor;
END;
/
-- Leer Proveedor Especifico --
DECLARE
    v_cursor SYS_REFCURSOR;
    v_registro PROVEEDORES%ROWTYPE; -- Asumiendo que VENTAS es el nombre de tu tabla
BEGIN
    v_cursor := PC_ADMINISTRADOR.proveedorLeer_id('C2','CC');
        FETCH v_cursor INTO v_registro;
        -- Aquí puedes procesar los datos de cada registro de la tabla VENTAS
        DBMS_OUTPUT.PUT_LINE('Datos de la articulos: '||' ' ||v_registro.NOMBREP||' ' ||v_registro.CLIENTEI||' ' ||v_registro.CLIENTET||' ' ||v_registro.CATALOGO||' ' ||v_registro.CORREOELECTRONICO);
    CLOSE v_cursor;
END;
/

-- Actualizar proveedor especifico --
BEGIN
 	PC_ADMINISTRADOR.proveedorActualizar('C2','CC','jonathan2@live.com','Articulos de Terror', 'Jonathan');
    END;
/

BEGIN
 	PC_ADMINISTRADOR.proveedorEliminar('C2','CC');
    END;
/


-------------------------------- XSEGURIDAD --------------------------------

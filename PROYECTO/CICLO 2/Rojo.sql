-------------------------------- ACTORESE --------------------------------}
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
    p_idArticulo IN VARCHAR2,
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
        p_clienteI IN VARCHAR2,
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
    PROCEDURE crear_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- READ
    FUNCTION leer_autores RETURN SYS_REFCURSOR;
    FUNCTION leer_autor(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_autor(p_articuloI IN VARCHAR2,p_autor IN VARCHAR2);


END PC_ADMINISTRADOR;
/    
-------------------------------- ACTORESI --------------------------------

-------------------------------- SEGURIDAD --------------------------------

-------------------------------- XSEGURIDAD --------------------------------

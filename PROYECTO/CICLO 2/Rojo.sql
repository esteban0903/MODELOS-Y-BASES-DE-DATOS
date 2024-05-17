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
    atencion, esto con el fin de garantizar que el cliente no pueda borrar si cuenta
    si tiene multas por pagar, articulos por devolver o 
*/













-------------------------------- ACTORESI --------------------------------

-------------------------------- SEGURIDAD --------------------------------

-------------------------------- XSEGURIDAD --------------------------------

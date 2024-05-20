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
    FUNCTION prestamoLeer(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR;

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
    FUNCTION leer_reservass RETURN SYS_REFCURSOR;
    
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
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    );

    -- READ --
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

END PC_CLIENTE;
/
/*
    El gerente tiene acceso a consultas hechas para mostrarle especificamente la 
    informacion relevante en general de la biblioteca, incluyendo las flujas con multa
    el total de facturas y las ventas efectuadas.
*/
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
    END articuloActualizar;
    
    PROCEDURE articuloEliminar(p_idArticulo IN VARCHAR2) IS
    BEGIN
        PC_ARTICULOS.eliminar_articulo(p_idArticulo);
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
    END proveedorActualizar;
    
    PROCEDURE proveedorEliminar(
        p_id_proveedor IN VARCHAR2,
        p_tid_proveedor IN VARCHAR2
    ) IS
    BEGIN
        PC_PROVEEDORES.eliminar_proveedor(p_id_proveedor, p_tid_proveedor);
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
    END ventaActualizar;

	PROCEDURE ventaEliminar(
        p_idCompra IN VARCHAR2
    ) IS BEGIN
        PC_VENTAS.eliminar_venta(p_idCompra);
    END ventaEliminar;
        ------------- CRUD FISICOS --------------
    PROCEDURE fisicoCrear(
        p_articuloI IN VARCHAR2,
        p_estado IN VARCHAR2
    ) IS
    BEGIN
        PC_FISICOS.crear_fisico(p_articuloI, p_estado);
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
    END fisicoActualizar;
    
    PROCEDURE fisicoEliminar(p_articuloI IN VARCHAR2) IS
    BEGIN
        PC_FISICOS.eliminar_fisico(p_articuloI);
    END fisicoEliminar;
        ------------- CRUD DIGITALES --------------
    PROCEDURE digitalCrear(
        p_articuloI IN VARCHAR2,
        p_formato IN VARCHAR2
    ) IS
    BEGIN
        PC_DIGITALES.crear_digital(p_articuloI, p_formato);
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
    END digitalActualizar;
    
    PROCEDURE digitalEliminar(p_articuloI IN VARCHAR2) IS
    BEGIN
        PC_DIGITALES.eliminar_digital(p_articuloI);
    END digitalEliminar;
        ------------- CRUD AUTORES --------------
    PROCEDURE autorCrear(
        p_articuloI IN VARCHAR2,
        p_autor IN VARCHAR2
    ) IS
    BEGIN
        PC_AUTORES.crear_autor(p_articuloI, p_autor);
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
    END autorActualizar;
    
    PROCEDURE autorEliminar(
        p_articuloI IN VARCHAR2,
        p_autor IN VARCHAR2
    ) IS
    BEGIN
        PC_AUTORES.eliminar_autor(p_articuloI, p_autor);
    END autorEliminar;
END PC_ADMINISTRADOR;
/

CREATE OR REPLACE PACKAGE BODY PC_BIBLIOTECARIO AS
	------------- CRUD SUSCRITOS --------------
    -- CREATE --
    PROCEDURE suscritoCrear(
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    ) IS p_clienteI CLIENTES.idCliente%TYPE;
    BEGIN
        PC_CLIENTES.crear_cliente(p_clienteT,p_clienteI);
    	PC_SUSCRITOS.crear_suscrito(p_clienteI,p_clienteT,p_metodoPago,p_nombre,p_apellido);
    END suscritoCrear;

    -- READ --
    FUNCTION suscritosLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_SUSCRITOS.leer_suscritos;
    END suscritosLeer;

    FUNCTION suscritoLeer_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_SUSCRITOS.leer_suscrito_id_tid(p_id_suscrito, p_tid_suscrito);
        END suscritoLeer_id_tid;
    
    -- UPDATE --
    PROCEDURE suscritoActualizar(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    ) IS BEGIN
        PC_SUSCRITOS.actualizar_suscrito(p_id_suscrito ,p_clienteT ,p_metodoPago,p_nombre );
        END suscritoActualizar;

    -- DELETE --
    PROCEDURE suscritoEliminar(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    ) IS BEGIN
        PC_SUSCRITOS.eliminar_suscrito(p_id_suscrito,p_tid_suscrito);
	END suscritoEliminar;

    ------------- CRUD PRESTAMOS --------------
    -- CREATE
    PROCEDURE prestamosCrear(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS
    BEGIN
        PC_PRESTAMOS.crear_prestamo(p_clienteI, p_clienteT, p_reservaI, p_fechaDevolucionEstimada);
    END prestamosCrear;

    -- READ
    FUNCTION prestamosLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_PRESTAMOS.leer_prestamos;
        END prestamosLeer;

    FUNCTION prestamoLeer(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_PRESTAMOS.leer_prestamo(p_idPrestamo);
        END prestamoLeer;

    -- UPDATE
    PROCEDURE prestamoActualizar(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS BEGIN
        PC_PRESTAMOS.actualizar_prestamo(p_idPrestamo,p_fechaDevolucionEstimada);
    END prestamoActualizar;

    -- DELETE
    PROCEDURE prestamoEliminar(p_idPrestamo IN VARCHAR2) IS BEGIN
        PC_PRESTAMOS.eliminar_prestamo(p_idPrestamo);
    END prestamoEliminar;

    ------------- CRUD FACTURAS --------------
    -- CREATE
    PROCEDURE facturaCrear(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    ) IS BEGIN
        PC_FACTURAS.crear_factura(p_prestamoI,p_metodoPago,p_fecha,p_total,p_estado);
    END facturaCrear;

    -- READ
    FUNCTION facturasLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_FACTURAS.leer_facturas;
        END facturasLeer;

    FUNCTION facturaLeer(p_idFactura IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_FACTURAS.leer_factura(p_idFactura);
        END facturaLeer;

    -- UPDATE
    PROCEDURE facturaActualizar(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    ) IS BEGIN 
        PC_FACTURAS.actualizar_factura(p_idFactura,p_fecha,p_total,p_estado);
    END facturaActualizar;

    -- DELETE
    PROCEDURE facturaEliminar(p_idFactura IN VARCHAR2) IS BEGIN
        PC_FACTURAS.eliminar_factura(p_idFactura);
    END facturaEliminar;

    ------------- CRUD MULTAS --------------
    -- CREATE
    PROCEDURE multaCrear(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
        PC_MULTAS.crear_multa(p_facturaI, p_monto, p_descripcion);
    END multaCrear;

    -- READ
    FUNCTION multasLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_MULTAS.leer_multas;
        END multasLeer;
    FUNCTION multaLeer(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_MULTAS.leer_multa(p_idMulta);
        END multaLeer;

    -- UPDATE
    PROCEDURE multaActualizar(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
        PC_MULTAS.actualizar_multa(p_idMulta,p_monto,p_descripcion);
    END multaActualizar;

    -- DELETE
    PROCEDURE multaEliminar(p_idMulta IN VARCHAR2) IS BEGIN
        PC_MULTAS.eliminar_multa(p_idMulta);
    END multaEliminar;
    
    ------------- CRUD DEVOLUCIONES --------------
    -- CREATE
    PROCEDURE devolucionCrear(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    ) IS BEGIN
        PC_DEVOLUCIONES.crear_devolucion(p_prestamoI,p_estado,p_fechaDevolucion);
    END devolucionCrear;

    -- READ
    FUNCTION devolucionesLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_DEVOLUCIONES.leer_devoluciones;
        END devolucionesLeer;
    FUNCTION devolucionLeer(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_DEVOLUCIONES.leer_devolucion(p_prestamoI);
        END devolucionLeer;

    -- UPDATE
    PROCEDURE devolucionActualizar(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    ) IS BEGIN 
        PC_DEVOLUCIONES.actualizar_devolucion(p_prestamoI,p_estado,p_fechaDevolucion);
    END devolucionActualizar;

    -- DELETE -- 
    PROCEDURE devolucionEliminar(p_prestamoI IN VARCHAR2) IS BEGIN
        PC_DEVOLUCIONES.eliminar_devolucion(p_prestamoI);
    END devolucionEliminar;

    ------------- CONSULTAS OPERACIONALES --------------
    -- RESERVAS --
    FUNCTION reservaLeer(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN 
        RETURN PC_RESERVAS.leer_reserva_id(p_clienteI);
        END reservaLeer;
    FUNCTION reservasLeer RETURN SYS_REFCURSOR IS BEGIN 
        RETURN PC_RESERVAS.leer_reservas;
        END reservasLeer;
    
    -- ARTICULOS --
    FUNCTION articulosLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_ARTICULOS.leer_articulos;
        END articulosLeer;
    FUNCTION articuloLeer(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_ARTICULOS.leer_articulo(p_idArticulo);
        END articuloLeer;

    -- FISICOS --
    FUNCTION fisicosLeer RETURN SYS_REFCURSOR IS BEGIN
            RETURN PC_FISICOS.leer_fisicos;
        END fisicosLeer;
    FUNCTION fisicoLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_FISICOS.leer_fisico(p_articuloI);
        END fisicoLeer;

    -- DIGITALES --
    FUNCTION digitalesLeer RETURN SYS_REFCURSOR IS BEGIN
        RETURN PC_DIGITALES.leer_digitales;
        END digitalesLeer;
    FUNCTION digitalLeer(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR IS BEGIN
            RETURN PC_DIGITALES.leer_digital(p_articuloI);
        END digitalLeer;
END PC_BIBLIOTECARIO;
/


CREATE OR REPLACE PACKAGE BODY PC_CLIENTE AS
---------------------RESERVAS---------------------
    ---CREAR---
    PROCEDURE reservaCrear( p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    )
    IS BEGIN
        PC_RESERVAS.crear_reserva(p_clienteI,p_clienteT);
    END reservaCrear;
    ---LEER---
    
    FUNCTION leer_reservass RETURN SYS_REFCURSOR 
    IS 
    BEGIN 
        RETURN PC_RESERVAS.leer_reservas;
    END leer_reservass;
    --- LEER CON ID ---
    FUNCTION reservaLeer_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR 
    IS 
    BEGIN 
        RETURN PC_RESERVAS.leer_reserva_id(p_clienteI);
    END reservaLeer_id;
    --- ACTUALIZAR ---
    PROCEDURE reservaLeer( p_reservaId IN VARCHAR2, p_estado IN CHAR)
    IS BEGIN
        PC_RESERVAS.actualizar_reserva(p_reservaId, p_estado);
    END reservaLeer;
    --- ELIMINAR ---
    PROCEDURE reservaEliminar( p_reservaId IN VARCHAR2)
    IS BEGIN
        PC_RESERVAS.eliminar_reserva(p_reservaId);
    END reservaEliminar;
---------------------SUSCRITOS---------------------
    ---CREAR---
    PROCEDURE suscritoCrear(
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    )IS p_clienteI CLIENTES.idCliente%TYPE;
    BEGIN
        PC_CLIENTES.crear_cliente(p_clienteT,p_clienteI);
        PC_SUSCRITOS.crear_suscrito(p_clienteI,p_clienteT,p_metodoPago,p_nombre,p_apellido);
    END suscritoCrear;
    ---LEER CON ID---
    
    FUNCTION suscritoLeer_id_tid(p_id_suscrito IN VARCHAR2, p_tid_suscrito IN VARCHAR2) RETURN SYS_REFCURSOR 
    IS 
    BEGIN 
        RETURN PC_SUSCRITOS.leer_suscrito_id_tid(p_id_suscrito, p_tid_suscrito);
    END suscritoLeer_id_tid;
    
    --- ACTUALIZAR ---
     PROCEDURE suscritoActualizar( p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    )
    IS BEGIN
        PC_SUSCRITOS.actualizar_suscrito(p_id_suscrito,p_clienteT,p_metodoPago,p_nombre);
    END suscritoActualizar;
    
END PC_CLIENTE;
/
        
------------------------------- SEGURIDAD -------------------------------
CREATE ROLE administrador_role;
CREATE ROLE bibliotecario_role;
CREATE ROLE cliente_role;

GRANT EXECUTE ON PC_ADMINISTRADOR TO administrador_role;
GRANT EXECUTE ON PC_BIBLIOTECARIO TO bibliotecario_role;
GRANT EXECUTE ON PC_CLIENTE TO cliente_role;


CREATE USER usuario_admin IDENTIFIED BY password_admin;
CREATE USER usuario_bibliotecario IDENTIFIED BY password_bibliotecario;
CREATE USER usuario_cliente IDENTIFIED BY password_cliente;

GRANT admin_role TO usuario_admin;
GRANT bibliotecario_role TO usuario_bibliotecario;
GRANT cliente_role TO usuario_cliente; 

-------------------------------XSEGURIDAD-------------------------------
DROP ROLE administrador_role;
DROP ROLE bibliotecario_role;
DROP ROLE cliente_role;

DROP PACKAGE PC_ADMINISTRADOR;
DROP PACKAGE PC_BIBLIOTECARIO;
DROP PACKAGE PC_CLIENTE;
-------------------------------- SEGURIDADOK --------------------------------
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

-----------USUARIOS----------------
----------RESERVAS----------
---CREAR RESERVA---
BEGIN
    PC_CLIENTE.reservaCrear( 'C1','CC');
    END;
/
---LEER RESERVA---
SELECT PC_CLIENTE.leer_reservass() FROM DUAL;
---LEER RESERVA CON ID---
SELECT PC_CLIENTE.reservaLeer_id('C1') FROM DUAL;
---ACTUALIZAR RESERVA---
BEGIN
    PC_CLIENTE.reservaLeer( 'R1','A');
    END;
/
---ELIMINAR RESERVA---
BEGIN
    PC_CLIENTE.reservaEliminar( 'R1');
    END;
/
----------SUSCRITOS----------
---CREAR SUSCRITO---

BEGIN
    PC_CLIENTE.suscritoCrear('CC','T','Esteban','Aguilera');
    END;
/
---LEER SUSCRITOS---
SELECT PC_CLIENTE.suscritoLeer_id_tid( 'C4','CC') FROM dual;
---ACTUALIZAR SUSCRITOS---
BEGIN
    PC_CLIENTE.suscritoActualizar('Esteban_Aguilera_C4','TI','T','Esteban');
    END;
/



--------------------------- CRUDE ---------------------------
CREATE OR REPLACE PACKAGE PC_CLIENTES AS
    -- CREATE --
    PROCEDURE crear_cliente(
        p_tid_cliente   IN VARCHAR2,
        p_id_cliente    OUT     VARCHAR2
    );
    -- READ --
    FUNCTION leer_clientes RETURN SYS_REFCURSOR;
    FUNCTION leer_cliente_con_nombre_usuario(p_tid_cliente IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- UPDATE --
    -- DELETE --
END PC_CLIENTES;
/

CREATE OR REPLACE PACKAGE PC_SUSCRITOS AS
    -- CREATE --
    PROCEDURE crear_suscrito(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2
    );

    -- READ --
    FUNCTION leer_suscritos RETURN SYS_REFCURSOR;
    
    FUNCTION leer_suscrito_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_suscrito(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE eliminar_suscrito(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    );
END PC_SUSCRITOS;
/

CREATE OR REPLACE PACKAGE PC_RESERVAS AS
    -- CREATE --
    PROCEDURE crear_reserva(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    );
    -- READ --
    FUNCTION leer_reserva_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR;
    
    FUNCTION leer_reservas RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_reserva(
        p_reservaId IN VARCHAR2,
        p_estado    IN CHAR
    );
    -- DELETE --
    PROCEDURE eliminar_reserva(
        p_reservaId IN VARCHAR2
    );
END PC_RESERVAS;
/

CREATE OR REPLACE PACKAGE PC_PROVEEDORES AS
    -- CREATE --
    PROCEDURE crear_proveedor(
        p_nombreP IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    );
    -- READ --
    FUNCTION leer_proveedores RETURN SYS_REFCURSOR;
    
    FUNCTION leer_proveedor_id(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2) 
    RETURN SYS_REFCURSOR;
    
    -- UPDATE --
    PROCEDURE actualizar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    );
    -- DELETE --
    PROCEDURE eliminar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2
    );
END PC_PROVEEDORES;
/


CREATE OR REPLACE PACKAGE PC_VENTAS AS
    -- CREATE --
    PROCEDURE crear_ventas(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- READ --
    FUNCTION leer_ventas RETURN SYS_REFCURSOR;
    FUNCTION leer_venta(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR;
    -- UPDATE --
    PROCEDURE actualizar_venta(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE

    );
    -- DELETE --
    PROCEDURE eliminar_venta(
        p_idCompra IN VARCHAR2
    );
END PC_VENTAS;
/

CREATE OR REPLACE PACKAGE PC_ARTICULOS AS
    -- CREATE
    PROCEDURE crear_articulo(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    );

    -- READ
    FUNCTION leer_articulos RETURN SYS_REFCURSOR;
    FUNCTION leer_articulo(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_articulo(
    p_idArticulo IN VARCHAR2,
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_articulo(p_idArticulo IN VARCHAR2);
END PC_ARTICULOS;
/

CREATE OR REPLACE PACKAGE PC_AUTORES AS
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
END PC_AUTORES;
/

CREATE OR REPLACE PACKAGE PC_FISICOS AS
    -- CREATE
    PROCEDURE crear_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2
    );

    -- READ
    FUNCTION leer_fisicos RETURN SYS_REFCURSOR;
    FUNCTION leer_fisico(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_disponible IN CHAR
    );

    -- DELETE
    PROCEDURE eliminar_fisico(p_articuloI IN VARCHAR2);
END PC_FISICOS;
/

CREATE OR REPLACE PACKAGE PC_DIGITALES AS
    -- CREATE
    PROCEDURE crear_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- READ
    FUNCTION leer_digitales RETURN SYS_REFCURSOR;
    FUNCTION leer_digital(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    );

    -- DELETE
    PROCEDURE eliminar_digital(p_articuloI IN VARCHAR2);
END PC_DIGITALES;
/

CREATE OR REPLACE PACKAGE PC_PRESTAMOS AS
    -- CREATE
    PROCEDURE crear_prestamo(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- READ
    FUNCTION leer_prestamos RETURN SYS_REFCURSOR;
    FUNCTION leer_prestamo(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_prestamo(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    );

    -- DELETE
    PROCEDURE eliminar_prestamo(p_idPrestamo IN VARCHAR2);
END PC_PRESTAMOS;
/

CREATE OR REPLACE PACKAGE PC_DEVOLUCIONES AS
    -- CREATE
    PROCEDURE crear_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- READ
    FUNCTION leer_devoluciones RETURN SYS_REFCURSOR;
    FUNCTION leer_devolucion(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    );

    -- DELETE
    PROCEDURE eliminar_devolucion(p_prestamoI IN VARCHAR2);
END PC_DEVOLUCIONES;
/

CREATE OR REPLACE PACKAGE PC_FACTURAS AS
    -- CREATE
    PROCEDURE crear_factura(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );


    -- UPDATE
    PROCEDURE actualizar_factura(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    );

    -- DELETE
    PROCEDURE eliminar_factura(p_idFactura IN VARCHAR2);
END PC_FACTURAS;
/

CREATE OR REPLACE PACKAGE PC_MULTAS AS
    -- CREATE
    PROCEDURE crear_multa(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- READ
    FUNCTION leer_multas RETURN SYS_REFCURSOR;
    FUNCTION leer_multa(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR;

    -- UPDATE
    PROCEDURE actualizar_multa(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    );

    -- DELETE
    -- DELETE
    PROCEDURE eliminar_multa(p_idMulta IN VARCHAR2);

END PC_MULTAS;
/
--------------------------- CRUDI ---------------------------
-- BODY PC_CLIENTES --
CREATE OR REPLACE PACKAGE BODY PC_CLIENTES AS
    -- CREATE --
    PROCEDURE crear_cliente(
        p_tid_cliente   IN VARCHAR2,
        p_id_cliente    OUT     VARCHAR2
    ) IS
    v_new_id CLIENTES.idCliente%TYPE;
    BEGIN 
    INSERT INTO CLIENTES(tidCliente) VALUES(p_tid_cliente)
    RETURNING idCLiente INTO v_new_id;
    p_id_cliente:=v_new_id;
    COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20007, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END crear_cliente;
    -- READ --
    FUNCTION leer_clientes RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
		
	BEGIN
        OPEN v_cursor FOR
        SELECT idCliente, tidCliente FROM CLIENTES;
        RETURN v_cursor;
		EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Ocurrio un error en la lectura de 
                        clientes, datos restablecidos');
    END leer_clientes;

    FUNCTION leer_cliente_con_nombre_usuario(p_tid_cliente IN VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT idCliente, tidCliente FROM CLIENTES WHERE tidCliente = p_tid_cliente ;
            RETURN v_cursor;
            COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20005, 'Ocurrio un error en la lectura de 
                        un cliente, datos restablecidos, verifique los parametros');
        END leer_cliente_con_nombre_usuario;
    -- UPDATE --
    -- DELETE --
END PC_CLIENTES;
/

CREATE OR REPLACE PACKAGE BODY  PC_SUSCRITOS AS
    -- CREATE --
    PROCEDURE crear_suscrito(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2,
        p_apellido IN VARCHAR2) IS BEGIN
    INSERT INTO SUSCRITOS(clienteI,clienteT,metodoPago,nombre,apellido)
	VALUES(p_clienteI,p_clienteT,p_metodoPago,p_nombre,p_apellido);
	COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Ocurrio un error en la crecion de suscrito, datos restablecidos, verifique sus parametros');
    
    END crear_suscrito;
    -- READ --
    FUNCTION leer_suscritos RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
		BEGIN
            OPEN v_cursor FOR
            SELECT * FROM SUSCRITOS;
            RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
			        RAISE_APPLICATION_ERROR(-20002, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END leer_suscritos;

    FUNCTION leer_suscrito_id_tid(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2) 
    RETURN SYS_REFCURSOR IS 
        v_cursor SYS_REFCURSOR;
	BEGIN
        OPEN v_cursor FOR
        SELECT * FROM SUSCRITOS 
        WHERE clienteI = p_id_suscrito AND clienteT = p_tid_suscrito;
        RETURN v_cursor;
		EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Ocurrio un error en la lectura de 
                        suscritos, datos restablecidos');
    END leer_suscrito_id_tid;
    
    -- UPDATE --
    PROCEDURE actualizar_suscrito(
        p_id_suscrito IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_nombre IN VARCHAR2
        ) IS BEGIN 
            UPDATE SUSCRITOS
            SET metodoPago = p_metodoPago,
                nombre = p_nombre
            WHERE 	clienteI = p_id_suscrito
            AND 	clienteT = p_clienteT;
			COMMIT;
		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Ocurrio un error con la actualizacion
                en suscritos, verifique sus parametros, solo puedo actualizar el nombre y
                el metodo de pago, datos restablecidos');
        END actualizar_suscrito;
    -- DELETE --
    PROCEDURE eliminar_suscrito(
        p_id_suscrito IN VARCHAR2, 
        p_tid_suscrito IN VARCHAR2
    ) IS BEGIN
        DELETE FROM SUSCRITOS 
        WHERE clienteI = p_id_suscrito
        AND 	clienteT = p_tid_suscrito;
        COMMIT;
		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20000, 'Ocurrio un error con la eliminacion
            en suscritos, verifique sus parametros, solo puedo actualizar el nombre y
            el metodo de pago, datos restablecidos');

	END eliminar_suscrito;
END PC_SUSCRITOS;
/

CREATE OR REPLACE PACKAGE BODY PC_RESERVAS AS
    -- CREATE --
    PROCEDURE crear_reserva(
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2
    ) IS BEGIN
    INSERT INTO RESERVAS(clienteI,clienteT,estado)
	VALUES (p_clienteI,p_clienteT,'D');
	COMMIT;
	EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20008, 'Ocurrio un error en la crecion de 
            la reserva, datos restablecidos, verifique sus parametros');
    END crear_reserva;
    -- READ --
    
	FUNCTION leer_reserva_id(p_clienteI IN VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM RESERVAS WHERE clienteI=p_clienteI;
			RETURN v_cursor;
			EXCEPTION
        	WHEN OTHERS THEN
        	ROLLBACK;
        	RAISE_APPLICATION_ERROR(-20009, 'Ocurrio un error en la consulta de 
            la reserva, datos restablecidos, verifique sus parametros');
        END leer_reserva_id;
    
    FUNCTION leer_reservas RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
        	SELECT * FROM RESERVAS;
			RETURN v_cursor;
			EXCEPTION
        	WHEN OTHERS THEN
        	ROLLBACK;
        	RAISE_APPLICATION_ERROR(-20010, 'Ocurrio un error en la consulta de 
            reservas, datos restablecidos');
        END leer_reservas;
    
    
	-- UPDATE --
	PROCEDURE actualizar_reserva(
        p_reservaId IN VARCHAR2,
        p_estado    IN CHAR
    ) IS BEGIN
        UPDATE RESERVAS
        SET estado = p_estado
        WHERE idReserva = p_reservaId;
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20011, 'Ocurrio un error en la actualizacion de 
        reserva, datos restablecidos, verifique sus parametros');
        END actualizar_reserva;
    

	-- DELETE --
    PROCEDURE eliminar_reserva(
        p_reservaId IN VARCHAR2
    ) IS BEGIN 
        DELETE FROM RESERVAS WHERE idReserva =p_reservaId; 
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20012, 'Ocurrio un error en la eliminacion de 
        reserva, datos restablecidos, verifique sus parametros');
        END eliminar_reserva;
END PC_RESERVAS;
/

CREATE OR REPLACE PACKAGE BODY PC_PROVEEDORES AS
    -- CREATE --
    PROCEDURE crear_proveedor(
        p_nombreP IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_correo_electronico IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO PROVEEDORES(nombreP,clienteI,clienteT,catalogo,correoElectronico)
		VALUES(p_nombreP,p_clienteI,p_clienteT,p_catalogo,p_correo_electronico);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20013, 'Ocurrio un error en la crecion del
            proveedor, datos restablecidos, verifique sus parametros');
    END crear_proveedor;

    -- READ --
    FUNCTION leer_proveedores RETURN SYS_REFCURSOR IS 
        v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PROVEEDORES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20014, 'Ocurrio un error en la lectura de 
                los proveedores, datos restablecidos');
        	END leer_proveedores;
    
    FUNCTION leer_proveedor_id(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2) 
    RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PROVEEDORES WHERE clienteI =p_id_proveedor 
            AND clienteT = p_tid_proveedor;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20015, 'Ocurrio un error en la lectura de 
                los proveedores, datos restablecidos');
	        END leer_proveedor_id;
    
    -- UPDATE --
    PROCEDURE actualizar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2,
        p_correo_electronico IN VARCHAR2,
        p_catalogo IN VARCHAR2,
        p_nombre IN VARCHAR2
    ) IS BEGIN
        	UPDATE PROVEEDORES 
        	SET correoElectronico =p_correo_electronico,
        	catalogo = p_catalogo,
        	nombreP = p_nombre
        	WHERE clienteI =p_id_proveedor AND clienteT = p_tid_proveedor;
        	COMMIT;
			EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20016, 'Ocurrio un error en la eliminacion de 
                los proveedor, datos restablecidos');
		END actualizar_proveedor;
    
	-- DELETE --
    PROCEDURE eliminar_proveedor(
        p_id_proveedor IN VARCHAR2, 
        p_tid_proveedor IN VARCHAR2
    ) IS BEGIN 
    	DELETE FROM PROVEEDORES WHERE clienteI =p_id_proveedor AND clienteT = p_tid_proveedor;
    END eliminar_proveedor;
END PC_PROVEEDORES;
/

CREATE OR REPLACE PACKAGE BODY PC_VENTAS AS
    -- CREATE --
    PROCEDURE crear_ventas(
        p_articuloI IN VARCHAR2,
        p_clienteI IN VARCHAR2,
        p_clienteT IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE
    ) IS BEGIN
    	INSERT INTO VENTAS(articuloI, clienteI,clienteT, metodoPago,total,fechaCompra)
		VALUES(p_articuloI,p_clienteI,p_clienteT,p_metodoPago,p_total,p_fechaCompra);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20017, 'Ocurrio un error en la crecion del
            venta, datos restablecidos, verifique sus parametros');
    END crear_ventas;

    -- READ --
    FUNCTION leer_ventas RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM VENTAS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20018, 'Ocurrio un error en la lectura de 
                los ventas, datos restablecidos');
        	END leer_ventas;

    	FUNCTION leer_venta(p_idCompra IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM VENTAS WHERE idCompra =p_idCompra;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20019, 'Ocurrio un error en la lectura de 
                los ventas, datos restablecidos, verifique parametros');
	        END leer_venta;

    -- UPDATE --
    PROCEDURE actualizar_venta(
        p_idCompra IN VARCHAR2,
        p_articuloI IN VARCHAR2,
        p_metodoPago IN VARCHAR2,
        p_total IN NUMBER,
        p_fechaCompra IN DATE
	
    ) IS BEGIN
        UPDATE	VENTAS
        SET		articuloI = p_articuloI,
        		metodoPago = p_metodoPago,
        		total = p_total,
        		fechaCompra = p_fechaCompra
        WHERE	idCompra = p_idCompra;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020, 'Ocurrio un error en la actualizacion de 
        los ventas, datos restablecidos, verifique parametros');

        END actualizar_venta;

    -- DELETE --
    PROCEDURE eliminar_venta(
        p_idCompra IN VARCHAR2
    ) IS BEGIN
        DELETE FROM VENTAS WHERE idCompra = p_idCompra;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20021, 'Ocurrio un error en la eliminacion de 
        los ventas, datos restablecidos, verifique parametros');
        END eliminar_venta;
END PC_VENTAS;
/

CREATE OR REPLACE PACKAGE BODY PC_ARTICULOS AS
    -- CREATE
    PROCEDURE crear_articulo(
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaPublicacion IN DATE,
    p_nombreArticulo IN VARCHAR2
    )IS BEGIN
    	INSERT INTO ARTICULOS(prestamoI,genero,descripcion,fechaPublicacion,nombreArticulo)
        VALUES (p_prestamoI,p_genero,p_descripcion,p_fechaPublicacion,p_nombreArticulo);
        COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20023, 'Ocurrio un error en la crecion del
            venta, datos restablecidos, verifique sus parametros');
    END crear_articulo;

    -- READ
    FUNCTION leer_articulos RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM ARTICULOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20024, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos');
        	END leer_articulos;
    	FUNCTION leer_articulo(p_idArticulo IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM ARTICULOS WHERE idArticulo =p_idArticulo;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20025, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos, verifique parametros');
	        END leer_articulo;

    -- UPDATE
    PROCEDURE actualizar_articulo(
    p_idArticulo IN VARCHAR2,
    p_prestamoI IN VARCHAR2,
    p_genero IN VARCHAR2,
    p_descripcion IN VARCHAR2
    )IS BEGIN
        UPDATE	ARTICULOS
        SET		prestamoI = p_prestamoI,
        		genero = p_genero,
        		descripcion = p_descripcion
        WHERE	idArticulo = p_idArticulo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20026, 'Ocurrio un error en la actualizacion de 
        los articulos, datos restablecidos, verifique parametros');

        END actualizar_articulo;

    -- DELETE
    PROCEDURE eliminar_articulo(p_idArticulo IN VARCHAR2)
        IS BEGIN
        DELETE FROM ARTICULOS WHERE	idArticulo = p_idArticulo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20028, 'Ocurrio un error en la eliminacion de 
        los articulos, datos restablecidos, verifique parametros');
		 
        END eliminar_articulo;
END PC_ARTICULOS;
/
CREATE OR REPLACE PACKAGE BODY PC_FACTURAS AS
    --CREATE
    PROCEDURE crear_Factura(
    p_prestamoI IN VARCHAR2,
    p_metodoPago IN VARCHAR2,
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    ) IS BEGIN
    	INSERT INTO FACTURAS(prestamoI,metodoPago, fecha,total,estado)
    	VALUES(p_prestamoI,p_metodoPago, p_fecha,p_total,p_estado);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20029, 'Ocurrio un error en la crecion de la
            factura, datos restablecidos, verifique sus parametros');
    END crear_factura;
    --UPDATE
    PROCEDURE actualizar_factura(
        p_idFactura IN VARCHAR2, 
    p_fecha IN DATE,
    p_total IN NUMBER,
    p_estado IN CHAR
    )IS BEGIN
        UPDATE	FACTURAS
        SET		fecha = p_fecha,
                total=p_total,
                estado=p_estado
        WHERE	idFactura = p_idFactura;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la actualizacion de 
        la factura, datos restablecidos, verifique parametros');

    END actualizar_factura;
    PROCEDURE eliminar_factura(p_idFactura IN VARCHAR2)
        IS BEGIN
        DELETE FROM FACTURAS WHERE idFactura = p_idFactura;
        END eliminar_factura;
END PC_FACTURAS;
/
CREATE OR REPLACE PACKAGE BODY PC_AUTORES AS
    -- CREATE
    PROCEDURE crear_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    )IS BEGIN
    	INSERT INTO AUTORES(articuloI,autor)
    	VALUES(p_articuloI, p_autor);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20029, 'Ocurrio un error en la crecion del
            autor, datos restablecidos, verifique sus parametros');
    END crear_autor;

    -- READ
    FUNCTION leer_autores RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM AUTORES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20030, 'Ocurrio un error en la lectura de 
                los autores, datos restablecidos');
        	END leer_autores;
    	
		FUNCTION leer_autor(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM AUTORES WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20031, 'Ocurrio un error en la lectura de 
                los articulos, datos restablecidos, verifique parametros');
	        END leer_autor;

    -- UPDATE
    PROCEDURE actualizar_autor(
    p_articuloI IN VARCHAR2,
    p_autor IN VARCHAR2
    ) IS BEGIN
        UPDATE	AUTORES
        SET		autor = p_autor
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la actualizacion de 
        los autores, datos restablecidos, verifique parametros');

        END actualizar_autor;

    -- DELETE
    PROCEDURE eliminar_autor(p_articuloI IN VARCHAR2,p_autor IN VARCHAR2)
        IS BEGIN
        DELETE FROM AUTORES WHERE autor = p_autor AND	articuloI = p_articuloI;
        END eliminar_autor;
END PC_AUTORES;
/

CREATE OR REPLACE PACKAGE BODY PC_FISICOS AS
    -- CREATE
    PROCEDURE crear_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO FISICOS(articuloI,estado,disponible)
		VALUES(p_articuloI,p_estado,'Y');
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20032, 'Ocurrio un error en la crecion del
            Fisico, datos restablecidos, verifique sus parametros');
    END crear_fisico;

    -- READ
    FUNCTION leer_fisicos RETURN SYS_REFCURSOR IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM FISICOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20033, 'Ocurrio un error en la lectura de 
                los fisicos, datos restablecidos');
        	END leer_fisicos;

    	FUNCTION leer_fisico(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM FISICOS WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20034, 'Ocurrio un error en la lectura de 
                los articulos fisicos, datos restablecidos, verifique parametros');
	        END leer_fisico;

    -- UPDATE
    PROCEDURE actualizar_fisico(
    p_articuloI IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_disponible IN CHAR
    ) IS BEGIN
        UPDATE	FISICOS
        SET		estado = p_estado,
         	disponible = p_disponible
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20035, 'Ocurrio un error en la actualizacion de 
        los articulos fisicos, datos restablecidos, verifique parametros');
        END actualizar_fisico;

    -- DELETE
    PROCEDURE eliminar_fisico(p_articuloI IN VARCHAR2) IS BEGIN
        	DELETE FROM FISICOS WHERE articuloI = p_articuloI;
        END eliminar_fisico;
END PC_FISICOS;
/

CREATE OR REPLACE PACKAGE BODY PC_DIGITALES AS
    -- CREATE
    PROCEDURE crear_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    ) IS BEGIN
    	INSERT INTO DIGITALES(articuloI,formato)
		VALUES(p_articuloI,p_formato);
		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20036, 'Ocurrio un error en la crecion del
            digital, datos restablecidos, verifique sus parametros');
    END crear_digital;

    -- READ
    FUNCTION leer_digitales RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DIGITALES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20037, 'Ocurrio un error en la lectura de 
                los digitales, datos restablecidos');
        	END leer_digitales;

    FUNCTION leer_digital(p_articuloI IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DIGITALES WHERE articuloI =p_articuloI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20038, 'Ocurrio un error en la lectura de 
                los articulos digitales, datos restablecidos, verifique parametros');
	        END leer_digital;

    -- UPDATE
    PROCEDURE actualizar_digital(
    p_articuloI IN VARCHAR2,
    p_formato IN VARCHAR2
    ) IS BEGIN
        UPDATE	DIGITALES
        SET		formato = p_formato
        WHERE	articuloI = p_articuloI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20039, 'Ocurrio un error en la actualizacion de 
        los articulos fisicos, datos restablecidos, verifique parametros');
        END actualizar_digital;

    -- DELETE
    PROCEDURE eliminar_digital(p_articuloI IN VARCHAR2) IS BEGIN
        	DELETE FROM DIGITALES WHERE articuloI = p_articuloI;
        END eliminar_digital;
END PC_DIGITALES;
/


CREATE OR REPLACE PACKAGE BODY PC_PRESTAMOS AS
    -- CREATE
    PROCEDURE crear_prestamo(
    p_clienteI IN VARCHAR2,
    p_clienteT IN VARCHAR2,
    p_reservaI IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS BEGIN
    	INSERT INTO PRESTAMOS(clienteI,clienteT,reservaI,FechaDevolucionEstimada)
		VALUES (p_clienteI, p_clienteT, p_reservaI,p_fechaDevolucionEstimada);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20039, 'Ocurrio un error en la crecion del
            prestamo, datos restablecidos, verifique sus parametros');
    END crear_prestamo;

    -- READ
    FUNCTION leer_prestamos RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PRESTAMOS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20040, 'Ocurrio un error en la lectura de 
                los prestamos, datos restablecidos');
        	END leer_prestamos;

    FUNCTION leer_prestamo(p_idPrestamo IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM PRESTAMOS WHERE idPrestamo =p_idPrestamo;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20041, 'Ocurrio un error en la lectura de 
                los prestamos, datos restablecidos, verifique parametros');
	        END leer_prestamo;

    -- UPDATE
    PROCEDURE actualizar_prestamo(
    p_idPrestamo IN VARCHAR2,
    p_fechaDevolucionEstimada IN DATE
    ) IS BEGIN
        UPDATE	PRESTAMOS
        SET		FechaDevolucionEstimada = p_fechaDevolucionEstimada
        WHERE	idPrestamo = p_idPrestamo;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20042, 'Ocurrio un error en la actualizacion de 
        la fehca de prestamos, datos restablecidos, verifique parametros');
        END actualizar_prestamo;


    -- DELETE
    PROCEDURE eliminar_prestamo(p_idPrestamo IN VARCHAR2) IS BEGIN
        DELETE FROM PRESTAMOS WHERE idPrestamo = p_idPrestamo;
	COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20043, 'Ocurrio un error en la eliminacion de 
        prestamos, datos restablecidos, verifique parametros');
        END eliminar_prestamo;
END PC_PRESTAMOS;
/

CREATE OR REPLACE PACKAGE BODY PC_DEVOLUCIONES AS
    -- CREATE
    PROCEDURE crear_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    ) IS BEGIN
        INSERT INTO DEVOLUCIONES(prestamoI, estado,fechaDevolucion)
        VALUES (p_prestamoI, p_estado, p_fechaDevolucion);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20044, 'Ocurrio un error en la crecion del
            devolucion, datos restablecidos, verifique sus parametros');
    END crear_devolucion;

    -- READ
    FUNCTION leer_devoluciones RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DEVOLUCIONES;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20045, 'Ocurrio un error en la lectura de 
                las devoluciones, datos restablecidos');
        	END leer_devoluciones;
    FUNCTION leer_devolucion(p_prestamoI IN VARCHAR2) RETURN SYS_REFCURSOR
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM DEVOLUCIONES WHERE prestamoI =p_prestamoI;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20046, 'Ocurrio un error en la lectura de 
                las devoluciones, datos restablecidos, verifique parametros');
	        END leer_devolucion;

    -- UPDATE
    PROCEDURE actualizar_devolucion(
    p_prestamoI IN VARCHAR2,
    p_estado IN CHAR,
    p_fechaDevolucion IN DATE
    )
        IS BEGIN
        UPDATE	DEVOLUCIONES
        SET		fechaDevolucion = p_fechaDevolucion,
        		estado = p_estado
        WHERE	prestamoI = p_prestamoI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20047, 'Ocurrio un error en la actualizacion de 
        la devolucion, datos restablecidos, verifique parametros');
        END actualizar_devolucion;

    -- DELETE
    PROCEDURE eliminar_devolucion(p_prestamoI IN VARCHAR2)
        IS BEGIN DELETE FROM DEVOLUCIONES WHERE prestamoI = p_prestamoI;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20048, 'Ocurrio un error en la eliminacion de 
        devoluciones, datos restablecidos, verifique parametros');
        END eliminar_devolucion;
END PC_DEVOLUCIONES;
/

CREATE OR REPLACE PACKAGE BODY PC_MULTAS AS
    -- CREATE
    PROCEDURE crear_multa(
    p_facturaI IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
		INSERT INTO MULTAS(facturaI,monto,descripcion)
		VALUES (p_facturaI, p_monto,p_descripcion);

		COMMIT;
		EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20049, 'Ocurrio un error en la crecion del
            multa, datos restablecidos, verifique sus parametros');
    END crear_multa;

    -- READ
    FUNCTION leer_multas RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM MULTAS;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20050, 'Ocurrio un error en la lectura de 
                las multas, datos restablecidos');
        	END leer_multas;

    FUNCTION leer_multa(p_idMulta IN VARCHAR2) RETURN SYS_REFCURSOR 
        IS v_cursor SYS_REFCURSOR;
        BEGIN
        	OPEN v_cursor FOR
        	SELECT * FROM MULTAS WHERE idMulta =p_idMulta;
			RETURN v_cursor;
    		EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20051, 'Ocurrio un error en la lectura de 
                la Multa, datos restablecidos, verifique parametros');
	        END leer_multa;

    -- UPDATE
    PROCEDURE actualizar_multa(
    p_idMulta IN VARCHAR2,
    p_monto IN NUMBER,
    p_descripcion IN VARCHAR2
    ) IS BEGIN
        UPDATE	MULTAS
        SET		monto = p_monto,
        		descripcion = p_descripcion
        WHERE	idMulta = p_idMulta;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20052, 'Ocurrio un error en la actualizacion de 
        la multa, datos restablecidos, verifique parametros');
        END actualizar_multa;

    -- DELETE
    -- DELETE
    PROCEDURE eliminar_multa(p_idMulta IN VARCHAR2)
        IS BEGIN DELETE FROM MULTAS WHERE idMulta = p_idMulta;
		COMMIT;
        EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20053, 'Ocurrio un error en la eliminacion de 
        devoluciones, datos restablecidos, verifique parametros');
        END eliminar_multa;
END PC_MULTAS;
/

--------------------------- CRUDOK ---------------------------
--------------------------- CRUDOK ---------------------------
------------------CREAR------------------
------CLIENTES------
DECLARE 
    id_cliente VARCHAR(20);
BEGIN
    PC_CLIENTES.crear_cliente('CC',id_cliente);
END;
/
------SUSCRITOS------
BEGIN
    PC_SUSCRITOS.crear_suscrito('C1','CC','T','Luke','Ross');
END;
/
------RESERVAS------
BEGIN
    PC_RESERVAS.crear_reserva('C1','CC');
END;
/
------PRESTAMOS------
BEGIN
    PC_PRESTAMOS.crear_prestamo('C1','CC','R1',TO_DATE('2024-05-25', 'YYYY-MM-DD'));
END;
/
------DEVOLUCIONES------
BEGIN
    PC_DEVOLUCIONES.crear_devolucion('P1','D',TO_DATE('2024-05-27', 'YYYY-MM-DD'));
END;
/
------FACTURAS------
BEGIN
    PC_FACTURAS.crear_factura('P1','C',TO_DATE('2024-04-03', 'YYYY-MM-DD'),5000,'D');
END;
/
------MULTAS------
BEGIN
    PC_MULTAS.crear_multa('F1',10,'descripcion');
END;
/
------ARTICULOS------
BEGIN
    PC_ARTICULOS.crear_articulo('P1','gen1','des1',TO_DATE('1999-05-27', 'YYYY-MM-DD'),'art1');
END;
/
------AUTORES------
BEGIN
    PC_AUTORES.crear_autor('A1','autor1');
END;
/
------FISICOS------
BEGIN
    PC_FISICOS.crear_fisico('A1','A');
END;
/
------DIGITALES------
BEGIN
    PC_DIGITALES.crear_digital('A1','PDF');
END;
/
------PROVEEDORES------
BEGIN
    PC_PROVEEDORES.crear_PROVEEDOR('NOMP','C1','CC','CAT1','correo@.com');
END;
/
------VENTAS------
BEGIN
    PC_VENTAS.crear_VENTAS('A1','C1','CC','T',1,TO_DATE('2024-10-15', 'YYYY-MM-DD'));
END;
/
------------------ACTUALIZAR------------------
------SUSCRITOS------
BEGIN
    PC_SUSCRITOS.actualizar_suscrito('C1','CC','E','Luke');
END;
/
------RESERVAS------
BEGIN
    PC_RESERVAS.actualizar_reserva('R1','A');
END;
/
------PRESTAMOS------
BEGIN
    PC_PRESTAMOS.actualizar_prestamo('P1',TO_DATE('2024-05-24', 'YYYY-MM-DD'));
END;
/
------DEVOLUCIONES------
BEGIN
    PC_DEVOLUCIONES.actualizar_devolucion('P1','A',TO_DATE('2024-05-27', 'YYYY-MM-DD'));
END;
/
------FACTURAS------
BEGIN
    PC_FACTURAS.actualizar_factura('F1',TO_DATE('2024-04-03', 'YYYY-MM-DD'),5000,'D');
END;
/
------MULTAS------
BEGIN
    PC_MULTAS.actualizar_multa('F1',10,'descripcion2');
END;
/
------ARTICULOS------
BEGIN
    PC_ARTICULOS.actualizar_articulo('A1','P1','gen1','des2');
END;
/
------AUTORES------
BEGIN
    PC_AUTORES.actualizar_autor('A1','autor12');
END;
/
------FISICOS------
BEGIN
    PC_FISICOS.actualizar_fisico('A1','D','N');
END;
/
------DIGITALES------
BEGIN
    PC_DIGITALES.actualizar_digital('A1','EPUB');
END;
/
BEGIN
    PC_PROVEEDORES.actualizar_PROVEEDOR('P1','CC','correo@.com','CAT1','NOMP');
END;
/
------VENTAS------
BEGIN
    PC_VENTAS.actualizar_venta('V1','A1','T',5,TO_DATE('2024-10-15', 'YYYY-MM-DD'));
END;
/
------------------ELIMINAR------------------
------SUSCRITOS------
BEGIN
    PC_SUSCRITOS.eliminar_suscrito('C1','CC');
END;
/
------RESERVAS------
BEGIN
    PC_RESERVAS.eliminar_reserva('R1');
END;
/
------PRESTAMOS------
BEGIN
    PC_PRESTAMOS.eliminar_prestamo('P1');
END;
/
------DEVOLUCIONES------
BEGIN
    PC_DEVOLUCIONES.eliminar_devolucion('P1');
END;
/
------MULTAS------
BEGIN
    PC_MULTAS.eliminar_multa('M1');
END;
/
------ARTICULOS------
BEGIN
    PC_ARTICULOS.eliminar_articulo('A1');
END;
/
------AUTORES------
BEGIN
    PC_AUTORES.eliminar_autor('A1','autor12');
END;
/
------FISICOS------
BEGIN
    PC_FISICOS.eliminar_fisico('A1');
END;
/
------DIGITALES------
BEGIN
    PC_DIGITALES.eliminar_digital('A1');
END;
/
------PROVEEDOR------
BEGIN
    PC_PROVEEDORES.eliminar_PROVEEDOR('P1','CC');
END;
/
------VENTAS------
BEGIN
    PC_VENTAS.eliminar_venta('V1');
END;
/
------FACTURAS------
BEGIN
    PC_FACTURAS.eliminar_factura('F1');
END;
/
-------------------------- CRUDEnOK --------------------------


--------------------------- XCRUDE ---------------------------
DROP PACKAGE PC_CLIENTES;
DROP PACKAGE PC_SUSCRITOS;
DROP PACKAGE PC_RESERVAS;
DROP PACKAGE PC_PROVEEDORES;
DROP PACKAGE PC_VENTAS;
DROP PACKAGE PC_ARTICULOS;
DROP PACKAGE PC_AUTORES;
DROP PACKAGE PC_FISICOS;
DROP PACKAGE PC_DIGITALES;
DROP PACKAGE PC_PRESTAMOS;
DROP PACKAGE PC_DEVOLUCIONES;
DROP PACKAGE PC_MULTAS;

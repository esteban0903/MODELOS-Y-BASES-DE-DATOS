---------------------------- VISTAS ----------------------------
-- Solo consultar los clientes --
CREATE VIEW CLIENTES_SUSCRITOS AS SELECT nombre, apellido, clienteI, clienteT FROM SUSCRITOS;

-- Solo consultar las ventas --
CREATE VIEW COMPRAS AS 
SELECT PROVEEDORES.nombreP AS "PROVEEDORES",VENTAS.clienteI AS "ID PROVEEDOR", ARTICULOS.nombreArticulo AS "ARTICULO", VENTAS.articuloI AS "ID ARTICULO", VENTAS.total AS "TOTAL", VENTAS.fechaCompra 
FROM VENTAS 
JOIN ARTICULOS ON VENTAS.articuloI = ARTICULOS.idArticulo
JOIN PROVEEDORES ON PROVEEDORES.clienteI = VENTAS.clienteI AND PROVEEDORES.clienteT = VENTAS.clienteT;

-- Consultar las facturas de los clientes con multa --
CREATE VIEW FACTURAS_CON_MULTA AS 
SELECT SUSCRITOS.nombre, SUSCRITOS.apellido, FACTURAS.total AS "Total a Pagar", MULTAS.monto AS "Total de multa", MULTAS.idMulta
FROM FACTURAS 
JOIN PRESTAMOS ON FACTURAS.prestamoI = PRESTAMOS.idPrestamo 
JOIN SUSCRITOS ON SUSCRITOS.clienteI = PRESTAMOS.clienteI AND SUSCRITOS.clienteT = PRESTAMOS.clienteT 
JOIN MULTAS ON MULTAS.facturaI = FACTURAS.idFactura;
-- Articulos fisicos --
CREATE VIEW ARTICULOS_FISICOS AS SELECT * FROM ARTICULOS a JOIN FISICOS b ON a.idArticulo=b.articuloI;

-- Nombre del articulo, nombre de quien lo reservo, fecha de entrega, fecha estimada de devolucion --
CREATE VIEW ARTICULOS_EN_RESERVA AS
SELECT ARTICULOS.nombreArticulo AS "ARTICULO", SUSCRITOS.nombre, SUSCRITOS.apellido, PRESTAMOS.fechaEntrega, PRESTAMOS.fechaDevolucionEstimada AS "FECHA DEVOLUCION"
FROM RESERVAS
JOIN PRESTAMOS ON PRESTAMOS.reservaI = RESERVAS.idReserva
JOIN SUSCRITOS ON SUSCRITOS.clienteI = PRESTAMOS.clienteI AND SUSCRITOS.clienteT = PRESTAMOS.clienteT
JOIN ARTICULOS ON ARTICULOS.prestamoI = PRESTAMOS.idPrestamo;
---------------------------- XVISTAS ----------------------------
DROP VIEW CLIENTES_SUSCRITOS;
DROP VIEW COMPRAS;
DROP VIEW FACTURAS_CON_MULTA;
DROP VIEW ARTICULOS_FISICOS;
DROP VIEW ARTICULOS_EN_RESERVA;

---------------------------- INDICES ----------------------------
/*
    Solo hacemos dos de los que creemos que seran 
    los mas importantes y que ya contamos con 15 indices
*/
CREATE UNIQUE INDEX I_NOMBRES_USUARIO
ON SUSCRITOS(clienteI, nombre);

CREATE UNIQUE INDEX I_NOMBRES_ARTICULOS
ON ARTICULOS(idArticulo, nombreArticulo);

---------------------------- INDICES ----------------------------
DROP INDEX I_NOMBRES_ARTICULOS;
DROP INDEX I_NOMBRES_USUARIO;

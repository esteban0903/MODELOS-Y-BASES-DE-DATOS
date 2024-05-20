---------------------------PRUEBAS-------------------------
---Ana es una usuaria que quiere hacer parte de LibroTech. Recientemente ha encontrado un libro muy interesante en la plataforma y desea adquirirlo. --

---1. Ana le dice al biblioteario que quiere hacer parte de librotech como un cliente suscrito.
BEGIN
    PC_CLIENTE.suscritoCrear('CC','T','Ana','Maria');
    END;
/

---2 Ana quiere ver que esta en la plataforma, por lo que ingresa al sistema y revisa su id:
SELECT PC_CLIENTE.suscritoLeer_id_tid('C1','CC') FROM DUAL;

---3.. Ana desea generar una reserva de un libro que le gusto
BEGIN
    PC_CLIENTE.reservaCrear( 'C1','CC');
    END;
/
---4. Ana decide ir al otro dia a reclamar su libro reservado.  El bibliotecario al ver que Ana genero una reserva, le genera un prestamo.
BEGIN
    PC_BIBLIOTECARIO.prestamosCrear( 'C1','CC','R1',SYSDATE);
    END;
/
---5. Ana mira que el bibliotecario haya generado la reserva, por lo que revisa en su plataforma si esta creada.
SELECT PC_CLIENTE.reservaLeer_id('C1') FROM DUAL;


---6. Pasan 2 meses y Ana vuelve a la bilioteca a  entregar el libro. El bibliotecario genera una devolución de libro
BEGIN
    PC_BIBLIOTECARIO.crear_devolucion('P1','A',SYSDATE);
END;
/

---7. Al generasela devolución se genera una factura
BEGIN
    PC_BIBLIOTECARIO.facturaCrear( 'P1','T',TO_DATE('2024-07-20', 'YYYY-MM-DD'),0,'D');
    END;
/

---8. El bibliotecario se da cuenta que Ana entrego el libro tarde por lo que le genera una multa
BEGIN
   PC_BIBLIOTECARIO.multaCrear('F1', '100', 'Entrega tarde');
    END;
/
---9 Le muestra la multa a Ana para que sepa el valor que tiene que pagar
SELECT PC_BIBLIOTECARIO.facturaLeer('F1') FROM dual;

---10 Ana paga la multa y le pide al bibliotecario que elimine la factura
BEGIN
   PC_BIBLIOTECARIO.facturaEliminar('F1');
    END;
/
---2 parte de historia ---
---11 Luego de unos dias se conoce al administrador, el esta haciendo inventario de los libros
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
BEGIN
PC_ADMINISTRADOR.articuloCrear(null, 'Romance', 'La historia de Luke Howland',TO_DATE('2004-12-05', 'YYYY-MM-DD'),'Boulevard');
END;
/
BEGIN
PC_ADMINISTRADOR.articuloCrear(null, 'Suspenso', 'La historia de mi muerte',TO_DATE('1974-12-05', 'YYYY-MM-DD'),'Ala de muerte');
END;
/

---12 Luego de eso consulta los articulos que hay
SELECT PC_ADMINISTRADOR.articulosLeer FROM DUAL;


---13 De esos articulos va a crear los articulos fisicos
BEGIN
PC_ADMINISTRADOR.fisicoCrear('A1','Nuevo');
END;
/

BEGIN
PC_ADMINISTRADOR.fisicoCrear('A2','Descuidado');
END;
/

BEGIN
PC_ADMINISTRADOR.fisicoCrear('A4','Nuevo');
END;
/
---14 Cometio un error agregando un articulo demas asi que lo va a eliminar
BEGIN
PC_ADMINISTRADOR.articuloEliminar('A2');
END;
/

---15 Cometio un error agregando un articulo demas asi que lo va a eliminar
BEGIN
PC_ADMINISTRADOR.articuloEliminar('A2');
END;
/

---17 Ahora Maria se interesa saber los articulos nuevos y los consulta
SELECT PC_ARTICULOS.leer_articulos FROM DUAL;

---18 Ella ve Boulvard, y le encanta, asi que lo va a pedir en prestamo pidiendole al bibliotecario, para eso el consulta los suscritos
SELECT PC_BIBLIOTECARIO.suscritosLeer FROM DUAL;

---19 Ahora que el bibliotecario confirma su id, le crea el prestamo y se lo da a Maria

BEGIN
    PC_BIBLIOTECARIO.prestamosCrear('C1','CC',null, SYSDATE);
END;
/

---20 Ahora Maria tiene el prestamo y antes de irse le pregunta al bibliotecario cual es el plazo maximo para entregarlo:
-- El lo actualiza para que tenga 10 dias
BEGIN
    PC_BIBLIOTECARIO.prestamoActualizar('P2', SYSDATE + INTERVAL '10' DAY);
END;
/
-- Confirma el cambio
SELECT PC_BIBLIOTECARIO.prestamoLeer('P2') FROM DUAL;
-- y le dice que tiene 10 dias para devolverlo
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Ficcion', 'Un viaje al corazon de la oscuridad en la jungla africana.', TO_DATE('1899-12-16', 'YYYY-MM-DD'), 'El corazon de las tinieblas'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Poesia', 'Versos que exploran el amor y la naturaleza de una manera lirica.', TO_DATE('1819-06-23', 'YYYY-MM-DD'), 'Cumbres borrascosas'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Misterio', 'Un asesinato sin resolver mantiene al lector en vilo hasta el final.', TO_DATE('1934-10-01', 'YYYY-MM-DD'), 'El halcon maltes'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Ciencia ficcion', 'Una distopia futurista que desafia la nocion de libertad individual.', TO_DATE('1949-06-08', 'YYYY-MM-DD'), 'Un mundo feliz'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Autobiografia', 'Las memorias de una vida extraordinaria en tiempos de guerra.', TO_DATE('1995-06-01', 'YYYY-MM-DD'), 'Una vida en el siglo XX'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Fantasia', 'Un mundo magico donde humanos y criaturas mitologicas coexisten.', TO_DATE('1954-07-29', 'YYYY-MM-DD'), 'El Senor de los Anillos'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Drama', 'Una exploracion profunda de las complejidades de la condicion humana.', TO_DATE('1904-12-17', 'YYYY-MM-DD'), 'La gaviota'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Aventura', 'Una odisea emocionante a traves de mares desconocidos y tierras exoticas.', TO_DATE('1719-04-28', 'YYYY-MM-DD'), 'Las aventuras de Robinson Crusoe'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Historico', 'Un relato cautivador de eventos que dieron forma a nuestra civilizacion.', TO_DATE('1862-11-26', 'YYYY-MM-DD'), 'La guerra y la paz'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Romance', 'Una historia de amor apasionada y tragica que desafia las convenciones.', TO_DATE('1847-01-01', 'YYYY-MM-DD'), 'Cumbres borrascosas'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Filosofia', 'Un tratado visionario que cuestiona la naturaleza de la realidad.', TO_DATE('1781-06-04', 'YYYY-MM-DD'), 'Critica de la razon pura'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Biografia', 'La vida fascinante de un lider que cambio el curso de la historia.', TO_DATE('1998-10-27', 'YYYY-MM-DD'), 'Nelson Mandela: Un largo camino hacia la libertad'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Suspenso', 'Un thriller psicologico que te mantendra al borde del asiento.', TO_DATE('1959-09-15', 'YYYY-MM-DD'), 'Con la muerte en los talones'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Humor', 'Una coleccion hilarante de cuentos satiricos que ponen de relieve lo absurdo.', TO_DATE('1919-05-01', 'YYYY-MM-DD'), 'Cuentos de la montana'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'No ficcion', 'Un relato cautivador y bien investigado de un evento historico crucial.', TO_DATE('2011-10-24', 'YYYY-MM-DD'), 'Sin tregua: La batalla de Bastogne'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Realismo magico', 'Una narrativa unica que combina elementos realistas y fantasticos.', TO_DATE('1967-06-05', 'YYYY-MM-DD'), 'Cien anos de soledad'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Policiaco', 'Un misterio intrincado que desafia la logica y mantiene la intriga.', TO_DATE('1930-02-04', 'YYYY-MM-DD'), 'El asesinato de Roger Ackroyd'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Clasico', 'Una obra maestra atemporal que ha resistido la prueba del tiempo.', TO_DATE('1605-01-01', 'YYYY-MM-DD'), 'Don Quijote de la Mancha'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Distopia', 'Una vision sombria del futuro que advierte sobre los peligros de la opresion.', TO_DATE('1949-06-08', 'YYYY-MM-DD'), '1984'); 
END; 
/
BEGIN 
    PC_ADMINISTRADOR.articuloCrear(null, 'Ensayo', 'Una coleccion de reflexiones profundas sobre temas filosoficos y culturales.', TO_DATE('1919-10-04', 'YYYY-MM-DD'), 'El concepto de angustia'); 
END; 
/
-- Asignando Autores --
BEGIN
    PC_ADMINISTRADOR.autorCrear('A1', XMLType('<autor><nombre>John</nombre><apellido>Doe</apellido><fecha_nacimiento>1990-05-19</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A3', XMLType('<autor><nombre>Dashiell</nombre><apellido>Hammett</apellido><fecha_nacimiento>1894-05-27</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A4', XMLType('<autor><nombre>Aldous</nombre><apellido>Huxley</apellido><fecha_nacimiento>1894-07-26</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A5', XMLType('<autor><nombre>Doris</nombre><apellido>Kearns Goodwin</apellido><fecha_nacimiento>1943-01-04</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A6', XMLType('<autor><nombre>J.R.R.</nombre><apellido>Tolkien</apellido><fecha_nacimiento>1892-01-03</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A7', XMLType('<autor><nombre>Ant�n</nombre><apellido>Ch�jov</apellido><fecha_nacimiento>1860-01-29</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A8', XMLType('<autor><nombre>Daniel</nombre><apellido>Defoe</apellido><fecha_nacimiento>1660</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A9', XMLType('<autor><nombre>Le�n</nombre><apellido>Tolst�i</apellido><fecha_nacimiento>1828-09-09</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A10', XMLType('<autor><nombre>Emily</nombre><apellido>Bront�</apellido><fecha_nacimiento>1818-07-30</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A11', XMLType('<autor><nombre>Immanuel</nombre><apellido>Kant</apellido><fecha_nacimiento>1724-04-22</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A12', XMLType('<autor><nombre>Nelson</nombre><apellido>Mandela</apellido><fecha_nacimiento>1918-07-18</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A13', XMLType('<autor><nombre>Alfred</nombre><apellido>Hitchcock</apellido><fecha_nacimiento>1899-08-13</fecha_nacimiento></autor>'));
END;
/
BEGIN
    PC_ADMINISTRADOR.autorCrear('A14', XMLType('<autor><nombre>Mikhail</nombre><apellido>Bulgakov</apellido><fecha_nacimiento>1891-05-15</fecha_nacimiento></autor>'));
END;
/
-- Asignar fisicos y digitales --
BEGIN
    PC_ADMINISTRADOR.fisicoCrear('A5','Descuidado');
END;
/
BEGIN
    PC_ADMINISTRADOR.fisicoCrear('A3','Nuevo');
END;
/
BEGIN
    PC_ADMINISTRADOR.fisicoCrear('A6','Viejo');
END;
/
BEGIN
    PC_ADMINISTRADOR.digitalCrear('A6','EPUB');
END;
/
BEGIN
    PC_ADMINISTRADOR.digitalCrear('A1','PDF');
END;
/
BEGIN
    PC_ADMINISTRADOR.digitalCrear('A7','PDF');
END;
/
BEGIN
    PC_ADMINISTRADOR.digitalCrear('A8','MOBI');
END;
/

BEGIN
    PC_ADMINISTRADOR.proveedorCrear('Sophia Bernal','CC','Historias: Amor no correspondido','sophiebernal@gmail.com');
    END;
/
BEGIN
    PC_ADMINISTRADOR.proveedorCrear('Diego Leon','CC','Libros de Ciencia ficcion','dieguito@gmail.com');
    END;
/
BEGIN
    PC_ADMINISTRADOR.ventasCrear('A4','C2','CC','T',29000,TO_DATE('2024-05-31', 'YYYY-MM-DD'));
    END;
/
BEGIN
    PC_ADMINISTRADOR.ventasCrear('A5','C2','CC','T',29000,TO_DATE('2024-05-31', 'YYYY-MM-DD'));
    END;
/

SELECT * FROM COMPRAS;
SELECT * FROM ARTICULOS_FISICOS;
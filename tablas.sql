CREATE TABLE GENERO (
id_genero INT PRIMARY KEY AUTO_INCREMENT,
nombre_genero VARCHAR(50) NOT NULL
);

CREATE TABLE DETALLE_PRESTAMO (
  id_detalle INT PRIMARY KEY AUTO_INCREMENT,
  prestamo_id INT,
  videojuego_id INT,
  FOREIGN KEY (prestamo_id) REFERENCES PRESTAMO(id_prestamo),
  FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego),
  );
  
  
  

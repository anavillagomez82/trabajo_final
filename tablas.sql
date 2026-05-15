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

CREATE TABLE ROL (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    fecha_registro DATE NOT NULL,
    id_rol INT,

    FOREIGN KEY (id_rol)
        REFERENCES ROL(id_rol)
);

CREATE TABLE PLATAFORMA (
    id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plataforma VARCHAR(50) NOT NULL
);

CREATE TABLE DESARROLLADOR (
    id_desarrollador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_desarrollador VARCHAR(100) NOT NULL
);


CREATE TABLE ESTADO (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    tipo_estado VARCHAR(30) NOT NULL
);
  
CREATE TABLE LOGRO_USUARIO (
id_logro_usuario INT PRIMARY KEY AUTO_INCREMENT,
fecha_desbloqueo DATE NOT NULL,
usuario_id INT,
logro_id INT,

FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario),
FOREIGN KEY (logro_id) REFERENCES LOGRO(id_logro)
);  

CREATE TABLE MULTA (
id_multa INT PRIMARY KEY AUTO_INCREMENT,
monto DECIMAL(10,2) NOT NULL,
estado_pago VARCHAR(20) NOT NULL,
prestamo_id INT,

FOREIGN KEY (prestamo_id) REFERENCES PRESTAMO(id_prestamo)
);



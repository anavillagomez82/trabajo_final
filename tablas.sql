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

CREATE TABLE PROGRESO_USUARIO (
id_progreso INT PRIMARY KEY AUTO_INCREMENT,
porcentaje DECIMAL(5,2) NOT NULL,
fecha_actualizacion DATE NOT NULL,
usuario_id INT,
videojuego_id INT,

FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario),
FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego)
);


CREATE TABLE logro (
id_logro SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(255) NOT NULL,
videojuego_id INT,
);

CREATE TABLE sesion_juego (
id_sesion SERIAL PRIMARY KEY,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL,
horas_jugadas DECIMAL(10,2) NOT NULL,
usuario_id INT,
videojuego_id INT,
);

CREATE TABLE videojuego (
id_videojuego SERIAL PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
anio_lanzamiento INT NOT NULL,
stock INT NOT NULL,
genero_id INT,
plataforma_id INT,
desarrollador_id INT,
estado_id INT,
);

CREATE TABLE comentario (
id_comentario SERIAL PRIMARY KEY,
texto TEXT NOT NULL,
calificacion INT NOT NULL,
fecha_comentario DATE NOT NULL,
usuario_id INT,
videojuego_id INT,
);

CREATE TABLE estadistica (
id_estadistica SERIAL PRIMARY KEY,
total_horas_jugadas DECIMAL(10,2) NOT NULL,
juegos_completados INT NOT NULL,
fecha_actualizacion DATE NOT NULL,
usuario_id INT,
);

CREATE TABLE prestamo (
id_prestamo SERIAL PRIMARY KEY,
fecha_prestamo DATE NOT NULL,
fecha_limite DATE NOT NULL,
fecha_devolucion DATE NOT NULL,
estado_prestamo VARCHAR(30) NOT NULL,
usuario_id INT,
);

DROP DATABASE IF EXISTS biblioteca_videojuegos;
CREATE DATABASE biblioteca_videojuegos;
USE biblioteca_videojuegos;

CREATE TABLE ROL (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE GENERO (
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre_genero VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE PLATAFORMA (
    id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plataforma VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE DESARROLLADOR (
    id_desarrollador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_desarrollador VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ESTADO (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    tipo_estado VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL UNIQUE,
    fecha_registro DATE NOT NULL,
    id_rol INT NOT NULL,

    FOREIGN KEY (id_rol)
        REFERENCES ROL(id_rol)
        ON UPDATE CASCADE
);

CREATE TABLE VIDEOJUEGO (
    id_videojuego INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    anio_lanzamiento INT NOT NULL
        CHECK (anio_lanzamiento >= 1950),
    stock INT NOT NULL
        CHECK (stock >= 0),

    genero_id INT NOT NULL,
    plataforma_id INT NOT NULL,

    desarrollador_id INT,
    estado_id INT NOT NULL,

    FOREIGN KEY (genero_id)
        REFERENCES GENERO(id_genero)
        ON UPDATE CASCADE,

    FOREIGN KEY (plataforma_id)
        REFERENCES PLATAFORMA(id_plataforma)
        ON UPDATE CASCADE,

    FOREIGN KEY (desarrollador_id)
        REFERENCES DESARROLLADOR(id_desarrollador)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (estado_id)
        REFERENCES ESTADO(id_estado)
        ON UPDATE CASCADE
);

CREATE TABLE PRESTAMO (
    id_prestamo INT PRIMARY KEY AUTO_INCREMENT,
    fecha_prestamo DATE NOT NULL,
    fecha_limite DATE NOT NULL,
    estado_prestamo VARCHAR(30) NOT NULL,

    usuario_id INT NOT NULL,

    CHECK (fecha_limite >= fecha_prestamo),

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE DEVOLUCION (
    id_devolucion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_devolucion DATE NOT NULL,

    prestamo_id INT UNIQUE NOT NULL,

    FOREIGN KEY (prestamo_id)
        REFERENCES PRESTAMO(id_prestamo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE DETALLE_PRESTAMO (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,

    prestamo_id INT NOT NULL,
    videojuego_id INT NOT NULL,

    FOREIGN KEY (prestamo_id)
        REFERENCES PRESTAMO(id_prestamo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (videojuego_id)
        REFERENCES VIDEOJUEGO(id_videojuego)
        ON UPDATE CASCADE
);

CREATE TABLE MULTA (
    id_multa INT PRIMARY KEY AUTO_INCREMENT,
    monto DECIMAL(10,2) NOT NULL
        CHECK (monto >= 0),

    estado_pago VARCHAR(20) NOT NULL,

    prestamo_id INT UNIQUE NOT NULL,

    FOREIGN KEY (prestamo_id)
        REFERENCES PRESTAMO(id_prestamo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE PROGRESO_USUARIO (
    id_progreso INT PRIMARY KEY AUTO_INCREMENT,

    porcentaje DECIMAL(5,2) NOT NULL
        CHECK (porcentaje BETWEEN 0 AND 100),

    fecha_actualizacion DATE NOT NULL,

    usuario_id INT NOT NULL,
    videojuego_id INT NOT NULL,

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (videojuego_id)
        REFERENCES VIDEOJUEGO(id_videojuego)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE SESION_JUEGO (
    id_sesion INT PRIMARY KEY AUTO_INCREMENT,

    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,

    horas_jugadas DECIMAL(10,2) NOT NULL
        CHECK (horas_jugadas >= 0),

    usuario_id INT NOT NULL,
    videojuego_id INT NOT NULL,

    CHECK (fecha_fin >= fecha_inicio),

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (videojuego_id)
        REFERENCES VIDEOJUEGO(id_videojuego)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE COMENTARIO (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,

    texto TEXT NOT NULL,

    calificacion INT NOT NULL
        CHECK (calificacion BETWEEN 1 AND 5),

    fecha_comentario DATE NOT NULL,

    usuario_id INT NOT NULL,
    videojuego_id INT NOT NULL,

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (videojuego_id)
        REFERENCES VIDEOJUEGO(id_videojuego)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE LOGRO (
    id_logro INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,

    videojuego_id INT NOT NULL,

    FOREIGN KEY (videojuego_id)
        REFERENCES VIDEOJUEGO(id_videojuego)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE LOGRO_USUARIO (
    id_logro_usuario INT PRIMARY KEY AUTO_INCREMENT,

    fecha_desbloqueo DATE NOT NULL,

    usuario_id INT NOT NULL,
    logro_id INT NOT NULL,

    UNIQUE(usuario_id, logro_id),

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (logro_id)
        REFERENCES LOGRO(id_logro)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE ESTADISTICA (
    id_estadistica INT PRIMARY KEY AUTO_INCREMENT,

    total_horas_jugadas DECIMAL(10,2) NOT NULL
        CHECK (total_horas_jugadas >= 0),

    juegos_completados INT NOT NULL
        CHECK (juegos_completados >= 0),

    fecha_actualizacion DATE NOT NULL,

    usuario_id INT UNIQUE NOT NULL,

    FOREIGN KEY (usuario_id)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- API BACKEND DE GESTIÓN DE DATOS Y OPTIMIZACIÓN
-- SCRIPT DE CREACIÓN, INSERCIÓN Y PROCEDIMIENTOS CRÍTICOS (.SQL)

CREATE DATABASE IF NOT EXISTS biblioteca_videojuegos;
USE biblioteca_videojuegos;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS ESTADISTICA;
DROP TABLE IF EXISTS LOGRO_USUARIO;
DROP TABLE IF EXISTS COMENTARIO;
DROP TABLE IF EXISTS SESION_JUEGO;
DROP TABLE IF EXISTS PROGRESO_USUARIO;
DROP TABLE IF EXISTS MULTA;
DROP TABLE IF EXISTS DETALLE_PRESTAMO;
DROP TABLE IF EXISTS DEVOLUCION;
DROP TABLE IF EXISTS PRESTAMO;
DROP TABLE IF EXISTS LOGRO;
DROP TABLE IF EXISTS VIDEOJUEGO;
DROP TABLE IF EXISTS ESTADO;
DROP TABLE IF EXISTS DESARROLLADOR;
DROP TABLE IF EXISTS PLATAFORMA;
DROP TABLE IF EXISTS GENERO;
DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS ROL;
SET FOREIGN_KEY_CHECKS = 1;

-- CREACIÓN DE TABLAS 

CREATE TABLE ROL (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATE NOT NULL,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol) ON DELETE SET NULL
);

CREATE TABLE GENERO (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nombre_genero VARCHAR(50) NOT NULL
);

CREATE TABLE PLATAFORMA (
    id_plataforma INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plataforma VARCHAR(50) NOT NULL
);

CREATE TABLE DESARROLLADOR (
    id_desarrollador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_desarrollador VARCHAR(100) NOT NULL
);

CREATE TABLE ESTADO (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    tipo_estado VARCHAR(50) NOT NULL
);

CREATE TABLE VIDEOJUEGO (
    id_videojuego INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    anio_lanzamiento INT NOT NULL,
    stock INT DEFAULT 0,
    genero_id INT,
    plataforma_id INT,
    desarrollador_id INT,
    estado_id INT,
    FOREIGN KEY (genero_id) REFERENCES GENERO(id_genero) ON DELETE SET NULL,
    FOREIGN KEY (plataforma_id) REFERENCES PLATAFORMA(id_plataforma) ON DELETE SET NULL,
    FOREIGN KEY (desarrollador_id) REFERENCES DESARROLLADOR(id_desarrollador) ON DELETE SET NULL,
    FOREIGN KEY (estado_id) REFERENCES ESTADO(id_estado) ON DELETE SET NULL
);

CREATE TABLE LOGRO (
    id_logro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    videojuego_id INT,
    FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego) ON DELETE CASCADE
);

CREATE TABLE PRESTAMO (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_limite DATE NOT NULL,
    estado_prestamo VARCHAR(50) NOT NULL,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

CREATE TABLE DEVOLUCION (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_devolucion DATE NOT NULL,
    prestamo_id INT,
    FOREIGN KEY (prestamo_id) REFERENCES PRESTAMO(id_prestamo) ON DELETE CASCADE
);

CREATE TABLE DETALLE_PRESTAMO (
    prestamo_id INT,
    videojuego_id INT,
    PRIMARY KEY (prestamo_id, videojuego_id),
    FOREIGN KEY (prestamo_id) REFERENCES PRESTAMO(id_prestamo) ON DELETE CASCADE,
    FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego) ON DELETE CASCADE
);

CREATE TABLE MULTA (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    monto DECIMAL(10,2) NOT NULL,
    estado_pago VARCHAR(50) NOT NULL,
    prestamo_id INT,
    FOREIGN KEY (prestamo_id) REFERENCES PRESTAMO(id_prestamo) ON DELETE CASCADE
);

CREATE TABLE PROGRESO_USUARIO (
    id_progreso INT AUTO_INCREMENT PRIMARY KEY,
    porcentaje DECIMAL(5,2) NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    usuario_id INT,
    videojuego_id INT,
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego) ON DELETE CASCADE
);

CREATE TABLE SESION_JUEGO (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    horas_jugadas DECIMAL(5,2) NOT NULL,
    usuario_id INT,
    videojuego_id INT,
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego) ON DELETE CASCADE
);

CREATE TABLE COMENTARIO (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT NOT NULL,
    calificacion INT NOT NULL,
    fecha_comentario DATE NOT NULL,
    usuario_id INT,
    videojuego_id INT,
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (videojuego_id) REFERENCES VIDEOJUEGO(id_videojuego) ON DELETE CASCADE
);

CREATE TABLE LOGRO_USUARIO (
    fecha_desbloqueo DATE NOT NULL,
    usuario_id INT,
    logro_id INT,
    PRIMARY KEY (usuario_id, logro_id),
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (logro_id) REFERENCES LOGRO(id_logro) ON DELETE CASCADE
);

CREATE TABLE ESTADISTICA (
    id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
    total_horas_jugadas DECIMAL(10,2) DEFAULT 0,
    juegos_completados INT DEFAULT 0,
    fecha_actualizacion DATE NOT NULL,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES USUARIO(id_usuario) ON DELETE CASCADE
);

-- INSERCIÓN DE DATOS SEMILLA (DATA SEEDING)

INSERT INTO ROL (nombre_rol, descripcion) VALUES
('Administrador', 'Control total del sistema'),
('Cliente', 'Usuario normal del sistema'),
('Moderador', 'Gestiona comentarios y usuarios'),
('Invitado', 'Acceso limitado al sistema'),
('Tester', 'Prueba funcionalidades del sistema');

INSERT INTO USUARIO (nombre, correo, telefono, fecha_registro, id_rol) VALUES
('Juan Perez', 'juan@gmail.com', '999111222', '2025-01-10', 2),
('Maria Lopez', 'maria@gmail.com', '988777666', '2025-02-15', 1),
('Carlos Ruiz', 'carlos@gmail.com', '977888555', '2025-03-05', 3),
('Lucia Torres', 'lucia@gmail.com', '966444333', '2025-03-20', 2),
('Pedro Gomez', 'pedro@gmail.com', '955222111', '2025-04-01', 5);

INSERT INTO GENERO (nombre_genero) VALUES
('Accion'),
('RPG'),
('Terror'),
('Aventura'),
('Deportes');

INSERT INTO PLATAFORMA (nombre_plataforma) VALUES
('PC'),
('PlayStation 5'),
('Xbox Series X'),
('Nintendo Switch'),
('Mobile');

INSERT INTO DESARROLLADOR (nombre_desarrollador) VALUES
('FromSoftware'),
('Nintendo'),
('Rockstar Games'),
('Valve'),
('Capcom');

INSERT INTO ESTADO (tipo_estado) VALUES
('Disponible'),
('Prestado'),
('Mantenimiento'),
('Reservado'),
('Fuera de stock');

INSERT INTO VIDEOJUEGO (titulo, anio_lanzamiento, stock, genero_id, plataforma_id, desarrollador_id, estado_id) VALUES
('Elden Ring', 2022, 5, 2, 2, 1, 1),
('GTA V', 2013, 8, 1, 1, 3, 1),
('Resident Evil 4', 2023, 4, 3, 3, 5, 1),
('Zelda Tears of the Kingdom', 2023, 6, 4, 4, 2, 1),
('Half Life 2', 2004, 3, 1, 1, 4, 2);

INSERT INTO LOGRO (nombre, descripcion, videojuego_id) VALUES
('Juego Completado', 'Se obtiene al completar el juego', 1),
('Inicio', 'Se obtiene al entrar por primera vez', 1),
('Tutorial Completado', 'Se obtiene al completar el tutorial', 2),
('Modo Facil', 'Se obtiene al completar el modo facil', 3),
('Modo Intermedio', 'Se obtiene al completar el modo intermedio', 4);

INSERT INTO PRESTAMO (fecha_prestamo, fecha_limite, estado_prestamo, usuario_id) VALUES
('2026-05-01', '2026-05-10', 'Devuelto', 1),
('2026-05-05', '2026-05-15', 'Activo', 2),
('2026-05-07', '2026-05-17', 'Devuelto', 3),
('2026-05-09', '2026-05-19', 'Activo', 4),
('2026-05-11', '2026-05-21', 'Devuelto', 5);

INSERT INTO DEVOLUCION (fecha_devolucion, prestamo_id) VALUES
('2026-05-09', 1),
('2026-05-16', 3),
('2026-05-20', 5),
('2026-05-25', 2),
('2026-05-28', 4);

INSERT INTO DETALLE_PRESTAMO (prestamo_id, videojuego_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO MULTA (monto, estado_pago, prestamo_id) VALUES
(15.50, 'Pagado', 1),
(20.00, 'Pendiente', 2),
(10.00, 'Pagado', 3),
(25.75, 'Pendiente', 4),
(5.00, 'Pagado', 5);

INSERT INTO PROGRESO_USUARIO (porcentaje, fecha_actualizacion, usuario_id, videojuego_id) VALUES
(25.50, '2026-05-10', 1, 1),
(40.00, '2026-05-11', 2, 2),
(75.25, '2026-05-12', 3, 3),
(90.00, '2026-05-13', 4, 4),
(100.00, '2026-05-14', 5, 5);

INSERT INTO SESION_JUEGO (fecha_inicio, fecha_fin, horas_jugadas, usuario_id, videojuego_id) VALUES
('2026-05-01', '2026-05-01', 2.5, 1, 1),
('2026-05-02', '2026-05-02', 4.0, 2, 2),
('2026-05-03', '2026-05-03', 3.2, 3, 3),
('2026-05-04', '2026-05-04', 5.7, 4, 4),
('2026-05-05', '2026-05-05', 6.1, 5, 5);

INSERT INTO COMENTARIO (texto, calificacion, fecha_comentario, usuario_id, videojuego_id) VALUES
('Excelente juego y muy entretenido', 5, '2026-05-06', 1, 1),
('La historia es increible', 4, '2026-05-07', 2, 2),
('Muy buenos graficos', 5, '2026-05-08', 3, 3),
('Gameplay bastante divertido', 4, '2026-05-09', 4, 4),
('Un clasico que nunca envejece', 5, '2026-05-10', 5, 5),
('Obra maestra absoluta', 5, '2026-05-20', 2, 1),
('Muy dificil pero excelente', 4, '2026-05-21', 3, 1),
('Gran historia', 5, '2026-05-22', 4, 2);

INSERT INTO LOGRO_USUARIO (fecha_desbloqueo, usuario_id, logro_id) VALUES
('2026-05-11', 1, 1),
('2026-05-12', 2, 2),
('2026-05-13', 3, 3),
('2026-05-14', 4, 4),
('2026-05-15', 5, 5);

INSERT INTO ESTADISTICA (total_horas_jugadas, juegos_completados, fecha_actualizacion, usuario_id) VALUES
(20.5, 1, '2026-05-16', 1),
(35.0, 2, '2026-05-16', 2),
(50.7, 3, '2026-05-16', 3),
(75.3, 4, '2026-05-16', 4),
(100.0, 5, '2026-05-16', 5);

-- ACTUALIZACIONES DE NEGOCIO (UPDATES)

UPDATE LOGRO SET nombre = 'Juego completado al 100%', descripcion = 'Se obtiene al completar todas las misiones del juego' WHERE id_logro = 1;
UPDATE SESION_JUEGO SET horas_jugadas = 35.2 WHERE id_sesion = 3;
UPDATE SESION_JUEGO SET fecha_fin = '2026-07-20' WHERE id_sesion = 4;
UPDATE LOGRO SET videojuego_id = 2 WHERE id_logro = 2;
UPDATE LOGRO 
SET nombre = 'Modo dificil desbloqueado', descripcion = 'Se obtiene al terminar el modo intermedio' WHERE id_logro = 5;

-- OPTIMIZACIÓN (ÍNDICES)
-- Plan de ejecución ANTES de la optimización (Muestra 'ALL' escaneando todas las filas)

CREATE INDEX idx_videojuego_anio 
ON VIDEOJUEGO(anio_lanzamiento);

-- (GESTIÓN DE TRANSACCIONES (ACID))Simulación de proceso crítico coordinado: Registrar préstamo y actualizar stock
BEGIN;

INSERT INTO PRESTAMO (fecha_prestamo, fecha_limite, estado_prestamo, usuario_id) 
VALUES (CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Activo', 1);

INSERT INTO DETALLE_PRESTAMO (prestamo_id, videojuego_id) 
VALUES (LAST_INSERT_ID(), 2);

UPDATE VIDEOJUEGO 
SET stock = stock - 1 
WHERE id_videojuego = 2;

--Índices para la consulta de Historial de Préstamos)
CREATE INDEX idx_prestamo_usuario 
ON PRESTAMO(usuario_id);

CREATE INDEX idx_detalle_prestamo 
ON DETALLE_PRESTAMO(prestamo_id);

CREATE INDEX idx_detalle_videojuego 
ON DETALLE_PRESTAMO(videojuego_id);

-- Índices para el Reporte Avanzado de 3 tablas (Group By / Having)
CREATE INDEX idx_videojuego_categoria 
ON VIDEOJUEGO(categoria_id);
CREATE INDEX idx_comentario_videojuego 
ON COMENTARIO(videojuego_id);

COMMIT;

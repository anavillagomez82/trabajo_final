INSERT INTO ROL (nombre_rol, descripcion)
VALUES
('Administrador', 'Control total del sistema'),
('Cliente', 'Usuario normal del sistema'),
('Moderador', 'Gestiona comentarios y usuarios'),
('Invitado', 'Acceso limitado al sistema'),
('Tester', 'Prueba funcionalidades del sistema');

INSERT INTO USUARIO (nombre, correo, telefono, fecha_registro, id_rol)
VALUES
('Juan Perez', 'juan@gmail.com', '999111222', '2025-01-10', 2),
('Maria Lopez', 'maria@gmail.com', '988777666', '2025-02-15', 1),
('Carlos Ruiz', 'carlos@gmail.com', '977888555', '2025-03-05', 3),
('Lucia Torres', 'lucia@gmail.com', '966444333', '2025-03-20', 2),
('Pedro Gomez', 'pedro@gmail.com', '955222111', '2025-04-01', 5);

INSERT INTO GENERO (nombre_genero)
VALUES
('Accion'),
('RPG'),
('Terror'),
('Aventura'),
('Deportes');

INSERT INTO PLATAFORMA (nombre_plataforma)
VALUES
('PC'),
('PlayStation 5'),
('Xbox Series X'),
('Nintendo Switch'),
('Mobile');

INSERT INTO DESARROLLADOR (nombre_desarrollador)
VALUES
('FromSoftware'),
('Nintendo'),
('Rockstar Games'),
('Valve'),
('Capcom');

INSERT INTO ESTADO (tipo_estado)
VALUES
('Disponible'),
('Prestado'),
('Mantenimiento'),
('Reservado'),
('Fuera de stock');

INSERT INTO VIDEOJUEGO 
(titulo, anio_lanzamiento, stock, genero_id, plataforma_id, desarrollador_id, estado_id)
VALUES
('Elden Ring', 2022, 5, 2, 2, 1, 1),
('GTA V', 2013, 8, 1, 1, 3, 1),
('Resident Evil 4', 2023, 4, 3, 2, 5, 1),
('Zelda Tears of the Kingdom', 2023, 6, 4, 4, 2, 1),
('Half Life 2', 2004, 3, 1, 1, 4, 2);

INSERT INTO LOGRO (nombre, descripcion, videojuego_id)
VALUES
('Juego Completado', 'Se obtiene al completar el juego', 1),
('Inicio', 'Se obtiene al entrar por primera vez', 1),
('Tutorial Completado', 'Se obtiene al completar el tutorial', 2),
('Modo Facil', 'Se obtiene al completar el modo facil', 3),
('Modo Intermedio', 'Se obtiene al completar el modo intermedio', 4);

INSERT INTO PRESTAMO (fecha_prestamo, fecha_limite, estado_prestamo, usuario_id)
VALUES
('2026-05-01', '2026-05-10', 'Devuelto', 1),
('2026-05-05', '2026-05-15', 'Activo', 2),
('2026-05-07', '2026-05-17', 'Devuelto', 3),
('2026-05-09', '2026-05-19', 'Activo', 4),
('2026-05-11', '2026-05-21', 'Devuelto', 5);

INSERT INTO DEVOLUCION (fecha_devolucion, prestamo_id)
VALUES
('2026-05-09', 1),
('2026-05-16', 3),
('2026-05-20', 5),
('2026-05-25', 2),
('2026-05-28', 4);

INSERT INTO DETALLE_PRESTAMO (prestamo_id, videojuego_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO MULTA (monto, estado_pago, prestamo_id)
VALUES
(15.50, 'Pagado', 1),
(20.00, 'Pendiente', 2),
(10.00, 'Pagado', 3),
(25.75, 'Pendiente', 4),
(5.00, 'Pagado', 5);

INSERT INTO PROGRESO_USUARIO 
(porcentaje, fecha_actualizacion, usuario_id, videojuego_id)
VALUES
(25.50, '2026-05-10', 1, 1),
(40.00, '2026-05-11', 2, 2),
(75.25, '2026-05-12', 3, 3),
(90.00, '2026-05-13', 4, 4),
(100.00, '2026-05-14', 5, 5);

INSERT INTO SESION_JUEGO
(fecha_inicio, fecha_fin, horas_jugadas, usuario_id, videojuego_id)
VALUES
('2026-05-01', '2026-05-01', 2.5, 1, 1),
('2026-05-02', '2026-05-02', 4.0, 2, 2),
('2026-05-03', '2026-05-03', 3.2, 3, 3),
('2026-05-04', '2026-05-04', 5.7, 4, 4),
('2026-05-05', '2026-05-05', 6.1, 5, 5);

INSERT INTO COMENTARIO
(texto, calificacion, fecha_comentario, usuario_id, videojuego_id)
VALUES
('Excelente juego y muy entretenido', 5, '2026-05-06', 1, 1),
('La historia es increible', 4, '2026-05-07', 2, 2),
('Muy buenos graficos', 5, '2026-05-08', 3, 3),
('Gameplay bastante divertido', 4, '2026-05-09', 4, 4),
('Un clasico que nunca envejece', 5, '2026-05-10', 5, 5);

INSERT INTO LOGRO_USUARIO
(fecha_desbloqueo, usuario_id, logro_id)
VALUES
('2026-05-11', 1, 1),
('2026-05-12', 2, 2),
('2026-05-13', 3, 3),
('2026-05-14', 4, 4),
('2026-05-15', 5, 5);

INSERT INTO ESTADISTICA
(total_horas_jugadas, juegos_completados, fecha_actualizacion, usuario_id)
VALUES
(20.5, 1, '2026-05-16', 1),
(35.0, 2, '2026-05-16', 2),
(50.7, 3, '2026-05-16', 3),
(75.3, 4, '2026-05-16', 4),
(100.0, 5, '2026-05-16', 5);

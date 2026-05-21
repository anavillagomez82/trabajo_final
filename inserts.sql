INSERT INTO ROL (nombre_rol, descripcion)
VALUES
('Administrador', 'Control total del sistema'),
('Cliente', 'Usuario normal del sistema');
('Moderador', 'Gestiona comentarios y usuarios'),
('Invitado', 'Acceso limitado al sistema'),
('Tester', 'Prueba funcionalidades del sistema');

INSERT INTO USUARIO (nombre, correo, telefono, fecha_registro, id_rol)
VALUES
('Juan Perez', 'juan@gmail.com', '999111222', '2025-01-10', 2),
('Maria Lopez', 'maria@gmail.com', '988777666', '2025-02-15', 1);
('Carlos Ruiz', 'carlos@gmail.com', '977888555', '2025-03-05', 3),
('Lucia Torres', 'lucia@gmail.com', '966444333', '2025-03-20', 2),
('Pedro Gomez', 'pedro@gmail.com', '955222111', '2025-04-01', 5);

INSERT INTO GENERO (nombre_genero)
VALUES
('Acción'),
('RPG'),
('Terror'),
('Aventura')
('Deportes');

INSERT INTO PLATAFORMA (nombre_plataforma)
VALUES
('PC'),
('PlayStation 5'),
('Xbox Series X'),
('Nintendo Switch');

INSERT INTO DESARROLLADOR (nombre_desarrollador)
VALUES
('FromSoftware'),
('Nintendo'),
('Rockstar Games'),
('Valve');

INSERT INTO ESTADO (tipo_estado)
VALUES
('Disponible'),
('Prestado'),
('Mantenimiento');

INSERT INTO logro (id_logro, nombre, descripción, videojuego_id)
VALUES
(100,'juego completado', 'se obtiene al completar el juego',10),
(1, 'inicio', 'se obtiene cuando entras por primera vez al juego',10),
(5, 'tutorial completado', 'se obtiene cuando completas el tutorial con exito', 10'),
(10, 'modo facil completado', 'se obtiene cuando pasas al modo intermedio', 10),
(25, 'modo intermedio completado', 'se obtiene cuando pasas al modo dificil', 10);


INSERT INTO PRESTAMO (fecha_prestamo, fecha_limite, fecha_devolucion, estado_prestamo, usuario_id)
VALUES
('2026-05-01', '2026-05-10', '2026-05-09', 'Devuelto', 1),
('2026-05-05', '2026-05-15', NULL, 'Activo', 2),
('2026-05-07', '2026-05-17', '2026-05-16', 'Devuelto', 1),
('2026-05-09', '2026-05-19', NULL, 'Activo', 2),
('2026-05-11', '2026-05-21', '2026-05-20', 'Devuelto', 1);

INSERT INTO VIDEOJUEGO (titulo, año_lanzamiento, stock, genero_id, plataforma_id, desarrollador_id, estado_id)
VALUES
('Elden Ring', 2022, 5, 2, 2, 1, 1),
('GTA V', 2013, 8, 1, 1, 3, 1),
('Resident Evil 4', 2023, 4, 3, 2, 4, 1),
('Zelda Tears of the Kingdom', 2023, 6, 4, 4, 2, 1),
('Half Life 2', 2004, 3, 1, 1, 4, 2);

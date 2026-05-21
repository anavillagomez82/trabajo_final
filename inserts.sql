INSERT INTO ROL (nombre_rol, descripcion)
VALUES
('Administrador', 'Control total del sistema'),
('Cliente', 'Usuario normal del sistema');

INSERT INTO USUARIO (nombre, correo, telefono, fecha_registro, id_rol)
VALUES
('Juan Perez', 'juan@gmail.com', '999111222', '2025-01-10', 2),
('Maria Lopez', 'maria@gmail.com', '988777666', '2025-02-15', 1);

INSERT INTO GENERO (nombre_genero)
VALUES
('Acción'),
('RPG'),
('Terror'),
('Aventura');

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
(100,'juego completado', 'se obtiene al completar el juego',10);


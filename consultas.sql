SELECT * FROM USUARIO;

SELECT * FROM VIDEOJUEGO;

SELECT * FROM PRESTAMO;

SELECT * FROM COMENTARIO;

SELECT * FROM LOGRO;


SELECT *
FROM VIDEOJUEGO
WHERE stock > 5;

SELECT *
FROM USUARIO
WHERE fecha_registro >= '2025-03-01';

SELECT *
FROM PRESTAMO
WHERE estado_prestamo = 'Activo';

SELECT *
FROM MULTA
WHERE estado_pago = 'Pendiente';

SELECT *
FROM COMENTARIO
WHERE calificacion = 5;



SELECT *
FROM VIDEOJUEGO
ORDER BY anio_lanzamiento DESC;

SELECT *
FROM USUARIO
ORDER BY nombre ASC;

SELECT *
FROM ESTADISTICA
ORDER BY total_horas_jugadas DESC;



SELECT U.nombre, R.nombre_rol
FROM USUARIO U
JOIN ROL R
ON U.id_rol = R.id_rol;

SELECT V.titulo, G.nombre_genero
FROM VIDEOJUEGO V
JOIN GENERO G
ON V.genero_id = G.id_genero;

SELECT V.titulo, P.nombre_plataforma
FROM VIDEOJUEGO V
JOIN PLATAFORMA P
ON V.plataforma_id = P.id_plataforma;

SELECT V.titulo, D.nombre_desarrollador
FROM VIDEOJUEGO V
JOIN DESARROLLADOR D
ON V.desarrollador_id = D.id_desarrollador;

SELECT U.nombre, V.titulo, PR.estado_prestamo
FROM PRESTAMO PR
JOIN USUARIO U
ON PR.usuario_id = U.id_usuario
JOIN DETALLE_PRESTAMO DP
ON PR.id_prestamo = DP.prestamo_id
JOIN VIDEOJUEGO V
ON DP.videojuego_id = V.id_videojuego;

SELECT U.nombre, C.texto, V.titulo
FROM COMENTARIO C
JOIN USUARIO U
ON C.usuario_id = U.id_usuario
JOIN VIDEOJUEGO V
ON C.videojuego_id = V.id_videojuego;

SELECT U.nombre, L.nombre
FROM LOGRO_USUARIO LU
JOIN USUARIO U
ON LU.usuario_id = U.id_usuario
JOIN LOGRO L
ON LU.logro_id = L.id_logro;



SELECT estado_prestamo, COUNT(*) AS cantidad
FROM PRESTAMO
GROUP BY estado_prestamo;

SELECT videojuego_id, AVG(calificacion) AS promedio_calificacion
FROM COMENTARIO
GROUP BY videojuego_id;

SELECT usuario_id, SUM(horas_jugadas) AS total_horas
FROM SESION_JUEGO
GROUP BY usuario_id;

SELECT genero_id, COUNT(*) AS cantidad_juegos
FROM VIDEOJUEGO
GROUP BY genero_id;



SELECT MAX(stock) AS mayor_stock
FROM VIDEOJUEGO;

SELECT MIN(stock) AS menor_stock
FROM VIDEOJUEGO;

SELECT AVG(stock) AS promedio_stock
FROM VIDEOJUEGO;

SELECT SUM(monto) AS total_multas
FROM MULTA;

SELECT COUNT(*) AS total_usuarios
FROM USUARIO;



SELECT titulo
FROM VIDEOJUEGO
WHERE stock = (
    SELECT MAX(stock)
    FROM VIDEOJUEGO
);

SELECT nombre
FROM USUARIO
WHERE id_usuario IN (
    SELECT usuario_id
    FROM PRESTAMO
);

SELECT titulo
FROM VIDEOJUEGO
WHERE id_videojuego IN (
    SELECT videojuego_id
    FROM COMENTARIO
    WHERE calificacion = 5
);



SELECT
U.nombre,
V.titulo,
PU.porcentaje
FROM PROGRESO_USUARIO PU
JOIN USUARIO U
ON PU.usuario_id = U.id_usuario
JOIN VIDEOJUEGO V
ON PU.videojuego_id = V.id_videojuego;

SELECT
U.nombre,
E.total_horas_jugadas,
E.juegos_completados
FROM ESTADISTICA E
JOIN USUARIO U
ON E.usuario_id = U.id_usuario;

SELECT
V.titulo,
COUNT(L.id_logro) AS cantidad_logros
FROM LOGRO L
JOIN VIDEOJUEGO V
ON L.videojuego_id = V.id_videojuego
GROUP BY V.titulo;

SELECT
U.nombre,
SUM(SJ.horas_jugadas) AS horas_totales
FROM SESION_JUEGO SJ
JOIN USUARIO U
ON SJ.usuario_id = U.id_usuario
GROUP BY U.nombre;

SELECT
V.titulo,
AVG(C.calificacion) AS promedio
FROM COMENTARIO C
JOIN VIDEOJUEGO V
ON C.videojuego_id = V.id_videojuego
GROUP BY V.titulo
HAVING promedio >= 4;

SELECT
U.nombre,
COUNT(PR.id_prestamo) AS prestamos_realizados
FROM PRESTAMO PR
JOIN USUARIO U
ON PR.usuario_id = U.id_usuario
GROUP BY U.nombre;

SELECT
V.titulo,
SUM(SJ.horas_jugadas) AS horas_jugadas
FROM SESION_JUEGO SJ
JOIN VIDEOJUEGO V
ON SJ.videojuego_id = V.id_videojuego
GROUP BY V.titulo
ORDER BY horas_jugadas DESC;

SELECT
U.nombre,
M.monto,
M.estado_pago
FROM MULTA M
JOIN PRESTAMO P
ON M.prestamo_id = P.id_prestamo
JOIN USUARIO U
ON P.usuario_id = U.id_usuario;



SELECT
V.titulo,
SUM(SJ.horas_jugadas) AS horas_totales
FROM SESION_JUEGO SJ
JOIN VIDEOJUEGO V
ON SJ.videojuego_id = V.id_videojuego
GROUP BY V.titulo
ORDER BY horas_totales DESC
LIMIT 1;

SELECT
U.nombre,
SUM(SJ.horas_jugadas) AS horas_totales
FROM SESION_JUEGO SJ
JOIN USUARIO U
ON SJ.usuario_id = U.id_usuario
GROUP BY U.nombre
ORDER BY horas_totales DESC
LIMIT 1;

SELECT titulo
FROM VIDEOJUEGO
WHERE id_videojuego NOT IN (
    SELECT videojuego_id
    FROM COMENTARIO
);

SELECT
U.nombre,
M.monto
FROM MULTA M
JOIN PRESTAMO P
ON M.prestamo_id = P.id_prestamo
JOIN USUARIO U
ON P.usuario_id = U.id_usuario
WHERE M.estado_pago = 'Pendiente';

SELECT
AVG(horas_jugadas) AS promedio_horas
FROM SESION_JUEGO;

SELECT
U.nombre,
V.titulo,
PU.porcentaje,
E.total_horas_jugadas
FROM USUARIO U
JOIN PROGRESO_USUARIO PU
ON U.id_usuario = PU.usuario_id
JOIN VIDEOJUEGO V
ON PU.videojuego_id = V.id_videojuego
JOIN ESTADISTICA E
ON U.id_usuario = E.usuario_id
WHERE PU.porcentaje >= 50
ORDER BY E.total_horas_jugadas DESC;



UPDATE USUARIO
SET telefono = '999888777'
WHERE id_usuario = 1;

UPDATE VIDEOJUEGO
SET stock = stock + 2
WHERE id_videojuego = 1;



DELETE FROM COMENTARIO
WHERE id_comentario = 8;

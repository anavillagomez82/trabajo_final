# BIBLIOTECA DE VIDEOJUEGOS - TRABAJO FINAL

## Descripción

Este proyecto consiste en el diseño e implementación de una base de datos relacional para la gestión de una biblioteca de videojuegos.

El sistema permite administrar usuarios, videojuegos, préstamos, devoluciones, multas, comentarios, logros, sesiones de juego, estadísticas y progreso de los usuarios.

La base de datos fue desarrollada utilizando SQL puro, aplicando principios de integridad referencial, restricciones y consultas relacionales.

## Integrantes

* Purguaya Dennis (dennispurguaya)
* Cateriano Juan Pablo (Juan-Pablo-Cateriano-Justo)
* Villagomez Ana (anavillagomez82)

## Tecnologías Utilizadas

* MySQL 8.0
* SQL

## ESTRUCTURA

### tablas.sql

Contiene la creación de la base de datos y las tablas del sistema:

* ROL
* USUARIO
* GENERO
* PLATAFORMA
* DESARROLLADOR
* ESTADO
* VIDEOJUEGO
* PRESTAMO
* DEVOLUCION
* DETALLE_PRESTAMO
* MULTA
* PROGRESO_USUARIO
* SESION_JUEGO
* COMENTARIO
* LOGRO
* LOGRO_USUARIO
* ESTADISTICA

### inserts.sql

Contiene datos de prueba para todas las tablas principales del sistema.

### consultas.sql

Contiene consultas SQL de diferentes tipos:

* Consultas básicas
* Filtros con WHERE
* Ordenamiento con ORDER BY
* JOIN entre tablas
* Funciones de agregación
* GROUP BY
* HAVING
* Subconsultas
* UPDATE
* DELETE

## CARACTERÍSTICAS

### -RESTRICCIONES

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* CHECK

### -INTEGRIDAD REFERENCIAL

* ON DELETE CASCADE
* ON UPDATE CASCADE
* ON DELETE SET NULL
* 
## -INSTRUCCIONES DE EJECUCION

1. Ejecutar el archivo `tablas.sql`.
2. Ejecutar el archivo `inserts.sql`.
3. Ejecutar las consultas del archivo `consultas.sql`.

## OBJETIVO DEL PROYECTO:

Desarrollar una base de datos relacional que permita gestionar la información de una biblioteca de videojuegos aplicando conceptos de modelado de datos, integridad referencial y consultas SQL.

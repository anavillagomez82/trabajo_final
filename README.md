# BIBLIOTECA DE VIDEOJUEGOS - TRABAJO FINAL

## Descripción
Este proyecto consiste en el diseño e implementación de una base de datos relacional e híbrida para la gestión de una biblioteca de videojuegos. El sistema permite administrar usuarios, videojuegos, préstamos, devoluciones, multas, comentarios, logros, sesiones de juego, estadísticas y progreso de los usuarios de manera integrada.

La solución cuenta con una arquitectura sin ORM basada en **SQL puro** y un backend desarrollado en **Node.js/Express**, aplicando principios de integridad referencial, transacciones ACID distribuidas y optimización de rendimiento a través de índices.

## Integrantes
* Purguaya Dennis (dennispurguaya)
* Cateriano Juan Pablo (Juan-Pablo-Cateriano-Justo)
* Villagomez Ana (anavillagomez82)

## Tecnologías Utilizadas
* **Base de Datos:** MySQL 8.0 (Modelo Relacional + Atributos Semiestructurados JSON)
* **Backend:** Node.js (v18+) & Express
* **Librerías Clave:** `mysql2/promise` (Gestión nativa de conexiones y transacciones), `cors`


## Estructura del Proyecto

### Archivos de Base de Datos (SQL)
* **`tablas.sql`:** Contiene la inicialización de la base de datos y la creación física de las 17 entidades del sistema (`ROL`, `USUARIO`, `GENERO`, `PLATAFORMA`, `DESARROLLADOR`, `ESTADO`, `VIDEOJUEGO`, `PRESTAMO`, `DEVOLUCION`, `DETALLE_PRESTAMO`, `MULTA`, `PROGRESO_USUARIO`, `SESION_JUEGO`, `COMENTARIO`, `LOGRO`, `LOGRO_USUARIO`, `ESTADISTICA`).
* **`inserts.sql`:** Carga de datos de prueba coherentes para todas las tablas principales.
* **`consultas.sql`:** Set de consultas avanzadas de control (Filtros, Joins, Subconsultas, Agregaciones).

### API Backend
* **`backend/server.js`:** Servidor Express que interactúa mediante SQL puro con la base de datos. Implementa lógicas CRUD de la entidad central, gestión de transacciones críticas y reportes avanzados.
* **`backend/package.json`:** Definición de dependencias necesarias del entorno Node.js.


## Características Avanzadas (Criterios de Rúbrica)

### 1. Gestión de Transacciones (ACID)
En el endpoint crítico de **Registro de Préstamos** (`POST /api/prestamos`), se implementa una lógica transaccional unificada mediante el driver nativo utilizando explicitamente:
* `connection.beginTransaction()`
* `connection.commit()`
* `connection.rollback()`

Esto garantiza que la inserción de la cabecera del préstamo, los detalles asociados y el descuento físico en el stock del videojuego (`CHECK stock >= 0`) ocurran de forma atómica o no se aplique ningún cambio ante fallos concurrentes.

### 2. Módulo Híbrido (Caso de Uso NoSQL / JSON)
Se incorporó el soporte para datos semiestructurados usando el tipo de dato **JSON** en la columna `caracteristicas_extra` de la tabla `VIDEOJUEGO`.

* **Justificación:** Las especificaciones técnicas de hardware (idiomas, almacenamiento base en GB, modos cooperativos o soporte VR) cambian drásticamente entre plataformas y generaciones. Almacenarlas en una columna JSON flexibiliza el esquema evitando alterar físicamente el DDL o crear tablas relacionales artificiales vacías, manteniendo el rendimiento del motor.

### 3. Reportes y Exportación Compleja
El endpoint `/api/reportes/juegos-populares?format=csv` realiza consultas de agregación complejas (`GROUP BY`, `HAVING promedio >= 4`) combinando múltiples tablas, permitiendo la generación dinámica y descarga en formato **CSV** directo para su lectura en Excel.

### 4. Optimización mediante Índices (EXPLAIN)
La base de datos cuenta con índices secundarios estratégicos (como `idx_prestamo_usuario` y `idx_detalle_prestamo`) diseñados tras analizar cuellos de botella. 
* *Nota: La documentación detallada de la optimización y las evidencias del plan de ejecución antes y después del uso de `EXPLAIN` se encuentran registradas detalladamente en el archivo adjunto en este repositorio:* **`Informe_Optimizacion_Indices.pdf`**.

## Instrucciones de Ejecución

### Paso 1: Base de Datos
1. Abre tu terminal de MySQL o herramienta administrativa (MySQL Workbench / phpMyAdmin).
2. Ejecuta el script de estructura: `tablas.sql`.
3. Ejecuta el script de datos iniciales: `inserts.sql`.

### Paso 2: Servidor Backend
1. Navega desde la terminal a la carpeta del servidor:
Bash  cd backend
2. Instala las dependencias necesarias:
Bash  npm install
3. Inicia el servidor de desarrollo:
Bash  node server.js
4. El servidor estará disponible escuchando peticiones en http://localhost:3306 (o el puerto configurado).

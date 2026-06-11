const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// 1. Conexión a la Base de Datos
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      
    password: '',      
    database: 'biblioteca_videojuegos'
});

db.connect((err) => {
    if (err) {
        console.error('Error al conectar a MySQL:', err);
        return;
    }
    console.log('¡Conectado exitosamente a la base de datos biblioteca_videojuegos!');
});

// CRUD COMPLEJO (3 a más tablas conectadas)

app.get('/api/prestamos-detallados', (req, res) => {
    const query = `
        SELECT 
            p.id_prestamo, 
            u.nombre AS nombre_usuario, 
            v.titulo AS titulo_videojuego, 
            p.fecha_prestamo, 
            p.estado_prestamo
        FROM PRESTAMO p
        INNER JOIN USUARIO u ON p.usuario_id = u.id_usuario
        INNER JOIN DETALLE_PRESTAMO dp ON p.id_prestamo = dp.prestamo_id
        INNER JOIN VIDEOJUEGO v ON dp.videojuego_id = v.id_videojuego
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Error en la consulta compleja', detalles: err });
        }
        res.json(results);
    });
});

// REPORTE AVANZADO CON GROUP BY / HAVING Y EXPORTACIÓN A CSV (EXCEL)

app.get('/api/reporte-videojuegos/csv', (req, res) => {
    const query = `
        SELECT 
            v.titulo AS Videojuego, 
            COUNT(c.id_comentario) AS Total_Comentarios, 
            AVG(c.calificacion) AS Promedio_Calificacion
        FROM VIDEOJUEGO v
        LEFT JOIN COMENTARIO c ON v.id_videojuego = c.videojuego_id
        GROUP BY v.id_videojuego, v.titulo
        HAVING Total_Comentarios > 0
    `;

    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).send('Error generando el reporte');
        }

        // Creamos la estructura del archivo CSV manualmente (compatible con Excel)
        let csvContent = "\uFEFFVideojuego,Total Comentarios,Promedio Calificacion\n"; 
        
        results.forEach(row => {
            csvContent += `"${row.Videojuego}",${row.Total_Comentarios},${Number(row.Promedio_Calificacion).toFixed(2)}\n`;
        });

        // Configuramos los encabezados para que el navegador lo descargue como archivo
        res.setHeader('Content-Type', 'text/csv; charset=utf-8');
        res.setHeader('Content-Disposition', 'attachment; filename=reporte_videojuegos.csv');
        
        res.status(200).send(csvContent);
    });
});

// 2. Encender Servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'biblioteca_videojuegos',
    port: 3306
};

app.post('/api/prestamos', async (req, res) => {
    const { usuario_id, videojuego_id, fecha_prestamo, fecha_limite, estado_prestamo } = req.body;
    const connection = await mysql.createConnection(dbConfig);
    
    try {
        await connection.beginTransaction(); 
        
        // 1. Validar stock
        const [juegos] = await connection.execute('SELECT stock FROM VIDEOJUEGO WHERE id_videojuego = ?', [videojuego_id]);
        if (juegos[0].stock <= 0) throw new Error('Sin stock');

        // 2. Insertar Préstamo
        const [prestamo] = await connection.execute(
            'INSERT INTO PRESTAMO (fecha_prestamo, fecha_limite, estado_prestamo, usuario_id) VALUES (?, ?, ?, ?)',
            [fecha_prestamo, fecha_limite, estado_prestamo, usuario_id]
        );

        // 3. Insertar Detalle 
        await connection.execute(
            'INSERT INTO DETALLE_PRESTAMO (prestamo_id, videojuego_id) VALUES (?, ?)',
            [prestamo.insertId, videojuego_id]
        );

        // 4. Actualizar Stock
        await connection.execute('UPDATE VIDEOJUEGO SET stock = stock - 1 WHERE id_videojuego = ?', [videojuego_id]);

        await connection.commit(); 
        res.status(201).json({ success: true, message: 'Préstamo registrado y stock actualizado.' });
    } catch (error) {
        await connection.rollback(); 
        res.status(500).json({ error: error.message });
    } finally {
        await connection.end();
    }
});

//Reportes y Exportación CSV
app.get('/api/reportes/juegos-populares', async (req, res) => {
    const { format } = req.query;
    const connection = await mysql.createConnection(dbConfig);
    
    try {
        // (GROUP BY, HAVING)
        const query = `
            SELECT V.titulo, AVG(C.calificacion) AS promedio 
            FROM COMENTARIO C JOIN VIDEOJUEGO V ON C.videojuego_id = V.id_videojuego 
            GROUP BY V.titulo HAVING promedio >= 4
        `;
        const [rows] = await connection.execute(query);

        if (format === 'csv') {
            res.setHeader('Content-Type', 'text/csv');
            res.setHeader('Content-Disposition', 'attachment; filename=reporte.csv');
            let csv = 'Titulo,Promedio\n';
            rows.forEach(r => csv += `"${r.titulo}",${r.promedio}\n`);
            return res.send(csv);
        }
        res.json({ data: rows });
    } finally {
        await connection.end();
    }
});

app.listen(3000, () => console.log('Servidor listo en http://localhost:3000'));

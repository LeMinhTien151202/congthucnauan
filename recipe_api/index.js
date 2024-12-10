const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Kết nối tới MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'recipe_manager',
});

db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL');
});

// Lấy danh sách công thức
app.get('/recipes', (req, res) => {
    const sql = 'SELECT * FROM recipes';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Thêm công thức
app.post('/recipes', (req, res) => {
    const { name, description, ingredients, instructions } = req.body;
    const sql = 'INSERT INTO recipes (name, description, ingredients, instructions) VALUES (?, ?, ?, ?)';
    db.query(sql, [name, description, ingredients, instructions], (err, result) => {
        if (err) throw err;
        res.json({ id: result.insertId, name, description, ingredients, instructions });
    });
});

// Xóa công thức
app.delete('/recipes/:id', (req, res) => {
    const sql = 'DELETE FROM recipes WHERE id = ?';
    db.query(sql, [req.params.id], (err, result) => {
        if (err) throw err;
        res.json({ message: 'Recipe deleted' });
    });
});

// Cập nhật công thức
app.put('/recipes/:id', (req, res) => {
    const { name, description, ingredients, instructions } = req.body;
    const sql = 'UPDATE recipes SET name = ?, description = ?, ingredients = ?, instructions = ? WHERE id = ?';
    db.query(sql, [name, description, ingredients, instructions, req.params.id], (err, result) => {
        if (err) throw err;
        res.json({ message: 'Recipe updated' });
    });
});

// Khởi động server
app.listen(3000, () => {
    console.log('Server running on port 3000');
});

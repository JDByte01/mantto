var mysql = require('mysql');

// var pool = mysql.createPool({
//     connectionLimit: 15,
//     host: '198.136.62.47',
//     user: 'bkhonzfz_esaban',
//     password: 'Seguridad65',
//     database: 'bkhonzfz_db'
// });

var pool = mysql.createPool({
    connectionLimit: 15,
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'manttodb'
});


pool.query('SELECT 1 + 1 AS solution', function(error, results, fields) {
    if (error) throw error;
    console.log('La solucion es: ', results[0].solution);
});

module.exports = pool;
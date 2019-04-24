var pool = require('../db/conexion');
let marcaVehiculoModel = {};

marcaVehiculoModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `SELECT * FROM marca_vehiculo`;
                connection.query(sql, (err, results) => {
                    if (err) {
                        return reject(err);
                    } else {
                        return resolve(results);
                    }
                });
            }
            connection.release();
        });
    })
}

module.exports = marcaVehiculoModel
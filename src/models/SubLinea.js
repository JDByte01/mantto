var pool = require('../db/conexion');
let subLineaModel = {};

subLineaModel.getById = (idLineaVehiculo) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerSubLineaVehiculo(${connection.escape(idLineaVehiculo)})`;
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
    });
}

module.exports = subLineaModel
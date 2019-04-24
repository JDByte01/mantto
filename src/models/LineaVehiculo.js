var pool = require('../db/conexion');
let lineaVehiculoModel = {};

lineaVehiculoModel.getById = (idMarcaVehiculo) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerLineaVehiculo(${connection.escape(idMarcaVehiculo)})`;
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

module.exports = lineaVehiculoModel
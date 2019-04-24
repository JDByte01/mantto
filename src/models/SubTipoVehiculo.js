var pool = require('../db/conexion');
let subTipoVehiculoModel = {};

subTipoVehiculoModel.getById = (idTipoVehiculo) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerSubTipoVehiculo(${connection.escape(idTipoVehiculo)})`;
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

module.exports = subTipoVehiculoModel
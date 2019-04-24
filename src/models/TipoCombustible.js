var pool = require('../db/conexion');
let tipoCombustibleModel = {};

tipoCombustibleModel.getById = (idVehiculo) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerTipoCombustibleVehiculo(${connection.escape(idVehiculo)})`;
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

module.exports = tipoCombustibleModel
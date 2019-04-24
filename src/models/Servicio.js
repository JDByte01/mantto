var pool = require('../db/conexion');
let servicioModel = {};

servicioModel.obtenerServiciosNoAtendidos = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM VIEW_ServiciosSinAtender',
                    (err, results) => {
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

module.exports = servicioModel;
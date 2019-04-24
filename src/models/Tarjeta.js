var pool = require('../db/conexion');
let tarjetaModel = {};

tarjetaModel.create = (tarjetaData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_InsertarTarjeta(?,?,?,?,?,?)";
                connection.query(sql, [tarjetaData.tipoTarjeta,tarjetaData.numTarjeta,tarjetaData.fechaVencimiento,tarjetaData.idPais,tarjetaData.idBanco,tarjetaData.idMoneda],
                    (err, results) => {
                        if (err) {
                            return reject(err);
                        } else {
                            return resolve(results);
                        }
                    });
            }
            connection.release();
        })
    })
}

tarjetaModel.getById = (idTarjeta) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_ObtenerTarjeta(?)";
                connection.query(sql, idTarjeta,
                    (err, results) => {
                        if (err) {
                            return reject(err);
                        } else {
                            return resolve(results);
                        }
                    });
            }
            connection.release();
        })
    })
}

module.exports = tarjetaModel
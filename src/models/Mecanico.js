var pool = require('../db/conexion');
let mecanicoModel = {};

mecanicoModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM mecanico',
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
    })
}


mecanicoModel.getById = (idMecanico) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerDatosMecanico(${connection.escape(idMecanico)})`;
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

mecanicoModel.create = (mecanicoData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_InsertarCliente(?,?,?,?,?,?,?,?,?,?,?,?)";
                connection.query(sql, [mecanicoData.email, mecanicoData.contraseña, mecanicoData.nombre, mecanicoData.apellido, mecanicoData.telefono,
                mecanicoData.identificacion, mecanicoData.direccion, mecanicoData.marcaVehiculo, mecanicoData.noPlaca, mecanicoData.tipoTarjeta, mecanicoData.fechaVencimiento],
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
module.exports = mecanicoModel
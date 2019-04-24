var pool = require('../db/conexion');
let clienteModel = {};

clienteModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM cliente',
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

clienteModel.getById = (idCliente) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_ObtenerDatosCliente(${connection.escape(idCliente)})`;
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

clienteModel.create = (clienteData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_InsertarCliente(?,?,?,?,?,?,?,?)";
                connection.query(sql, [clienteData.email, clienteData.password, clienteData.nombres, clienteData.apellidos, clienteData.telefono, clienteData.identificacion, clienteData.direccion, clienteData.pais],
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

clienteModel.update = (clientData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = 'CALL SP_ModificarPerfilCliente(?, ?, ?, ?, ?)';
                connection.query(sql, [clientData.nombres, clientData.email, clientData.telefono, clientData.direccion, clientData.idPersona],
                    (err, results) => {
                        if (err) {
                            return reject(err);
                        } else {
                            return resolve(results);
                        }
                    }
                )
            }
            connection.release();
        })
    });
}

clienteModel.uploadPicture = (clientData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = 'update persona set foto = ? where idPersona = ?';
                connection.query(sql, [clientData.foto, clientData.idPersona],
                    (err, results) => {
                        if (err) {
                            return reject(err);
                        } else {
                            return resolve(results);
                        }
                    }
                )
            }
            connection.release();
        })
    });
}

module.exports = clienteModel
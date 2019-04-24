var pool = require('../db/conexion');
let personaModel = {};

personaModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM persona',
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

personaModel.getById = (idPersona) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM persona WHERE idPersona = ?', idPersona,
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

personaModel.create = (personaData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_InsertarPersona(?,?,?,?,?,?,?,?,?)";
                connection.query(sql, [personaData.nombres, personaData.apellidos, personaData.telefono, personaData.nit, personaData.direccion, personaData.identificacion, personaData.foto, personaData.idPais, personaData.resetCode],
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

personaModel.generarCodigo = (personaData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_GenerarCodigo(?,?)";
                connection.query(sql, [personaData.email, personaData.resetCode],
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

personaModel.nuevaPassword = (personaData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_NuevaPassword(?,?)";
                connection.query(sql, [personaData.password, personaData.resetCode],
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

personaModel.update = (personaData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_ModificarPersona(?,?,?,?,?,?,?,?,?,?)";
                connection.query(sql, [personaData.idPersona, personaData.nombres, personaData.apellidos, personaData.telefono, personaData.nit, personaData.direccion, personaData.identificacion, personaData.foto, personaData.idPais, personaData.resetCode],
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

personaModel.delete = (idPersona) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_BuscarPersona(${connection.escape(idPersona)})`;
                connection.query(sql, (err, results) => {
                    if (results) {
                        let sql = `CALL SP_EliminarPersona(${idPersona})`;
                        connection.query(sql, (err, results) => {
                            if (err) {
                                return reject(err);
                            } else {
                                return resolve(results);
                            }
                        })
                    } else {
                        reject(err);
                    }
                });
            }
            connection.release();
        });
    });
}

module.exports = personaModel
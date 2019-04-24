var pool = require('../db/conexion');
let usuarioModel = {};

usuarioModel.login = (usuarioData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = 'CALL SP_AutenticarUsuario(?,?)';
                connection.query(sql, [usuarioData.email, usuarioData.password],
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

usuarioModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM usuario',
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

usuarioModel.getById = (idUsuario) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM usuario WHERE idUsuario = ?', idUsuario,
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

usuarioModel.create = (usuarioData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_InsertarUsuario(?,?,?,?,?,?,?)";
                connection.query(sql, [usuarioData.idPersona, usuarioData.email, usuarioData.password, usuarioData.tipoUsuario, usuarioData.numReintento, usuarioData.resetPassword, usuarioData.tipoLogin],
                    (err, results) => {
                        if (err) {
                            return reject(err);
                        } else {
                            return resolve({ message: "Usuario creado con éxito" });
                        }
                    });
            }
            connection.release();
        })
    })
}

usuarioModel.update = (usuarioData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_ModificarUsuario(?,?,?,?,?,?,?,?)";
                connection.query(sql, [usuarioData.idUsuario,usuarioData.idPersona, usuarioData.email, usuarioData.password, usuarioData.tipoUsuario, usuarioData.numReintento, usuarioData.resetPassword, usuarioData.tipoLogin],
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

usuarioModel.delete = (idUsuario) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_BuscarUsuario(${connection.escape(idUsuario)})`;
                connection.query(sql, (err, results) => {
                    if (results) {
                        let sql = `CALL SP_EliminarUsuario(${idUsuario})`;
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
    })
}
module.exports = usuarioModel

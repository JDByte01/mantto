var pool = require('../db/conexion');
let tipoMaterialModel = {};

tipoMaterialModel.getAll = () => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM tipo_material',
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

tipoMaterialModel.getById = (idTipoMaterial) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                connection.query('SELECT * FROM tipo_material WHERE idTipoMaterial = ?', idTipoMaterial,
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

tipoMaterialModel.create = (tipoMaterialData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if(err){
                console.log(err);
            }else{
                const sql = "CALL SP_InsertarTipoMaterial(?)";
                connection.query(sql, [tipoMaterialData.tipoMaterial],
                (err, results) => {
                    if(err) {
                        return reject(err);
                    }else{
                        return resolve({message: "Registrado con éxito"});
                    }
                });
            }
            connection.release();
        })
    })
}

tipoMaterialModel.update = (tipoMaterialData) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = "CALL SP_ModificarTipoMaterial(?,?)";
                connection.query(sql, [tipoMaterialData.idTipoMaterial, tipoMaterialData.tipoMaterial],
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

tipoMaterialModel.delete = (idTipoMaterial) => {
    return new Promise((resolve, reject) => {
        pool.getConnection((err, connection) => {
            if (err) {
                console.log(err);
            } else {
                const sql = `CALL SP_BuscarTipoMaterial(${connection.escape(idTipoMaterial)})`;
                connection.query(sql, (err, results) => {
                    if(results){
                        let sql = `CALL SP_EliminarTipoMaterial(${idTipoMaterial})`;
                        connection.query(sql, (err,results) => {
                            if (err) {
                                return reject(err);
                            } else {
                                return resolve(results);
                            }
                        })
                    }else{
                        reject(err);
                    }
                });
            }
            connection.release();
        });
    })
}

module.exports = tipoMaterialModel
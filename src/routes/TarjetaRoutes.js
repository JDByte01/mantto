const Tarjeta = require('../models/Tarjeta');
const bcrypt = require('bcrypt');
const saltRounds = 10;

module.exports = function(app) {
    app.post('/tarjeta', (req, res) => {
        let encriptada;
        bcrypt.hash(req.body.numTarjeta, saltRounds).then(hash => {
            encriptada = hash;
            const tarjetaData = {
                idTarjeta: null,
                tipoTarjeta: req.body.tipoTarjeta,
                numTarjeta: encriptada,
                fechaVencimiento: req.body.fechaVencimiento,
                idPais: req.body.idPais,
                idBanco: req.body.idBanco,
                idMoneda: req.body.idMoneda
            }
            Tarjeta.create(tarjetaData).then(results => {
                if (typeof results !== 'undefined' && results.length > 0) {
                    res.status(200).json(results);
                } else {
                    res.status(200).json({message: "Tarjeta creada con éxito"});
                }
            },(err) => {
                console.log(err)
                res.status(500).json(err);
            });
        },(err) => {
            res.status(500).json({message: "Error No. de tarjeta necesario"});
        });
    });

    app.get('/tarjeta/:idTarjeta', (req,res) => {
        Tarjeta.getById(req.params.idTarjeta).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results[0]);
            } else {
                res.status(204).json({message: 'Not Content'});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });
}
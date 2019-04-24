const TipoVehiculo = require('../models/TipoVehiculo');

module.exports = function(app) {
    app.get('/tipo-vehiculo', (req,res) => {
        TipoVehiculo.getAll().then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results[0]);
            } else {
                res.status(204).json({message: 'Not Content'});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        })
    });

    app.get('/tipo-vehiculo/:idTipoVehiculo', (req,res) => {
        TipoVehiculo.getById(req.params.idTipoVehiculo).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results[0]);
            } else {
                res.status(204).json({message: 'Not Content'});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        })
    });
}
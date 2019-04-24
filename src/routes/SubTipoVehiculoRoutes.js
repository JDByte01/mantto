const SubTipoVehiculo = require('../models/SubTipoVehiculo');

module.exports = function(app) {
    app.get('/sub-tipo-vehiculo/:idSubTipoVehiculo', (req,res) => {
        SubTipoVehiculo.getById(req.params.idSubTipoVehiculo).then(results => {
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
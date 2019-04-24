const LineaVehiculo = require('../models/LineaVehiculo');

module.exports = function(app) {
    app.get('/linea/:idMarcaVehiculo', (req,res) => {
        LineaVehiculo.getById(req.params.idMarcaVehiculo).then(results => {
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
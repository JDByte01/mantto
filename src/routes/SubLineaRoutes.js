const SubLinea = require('../models/SubLinea');

module.exports = function(app) {
    app.get('/sub-linea/:idLineaVehiculo', (req,res) => {
        SubLinea.getById(req.params.idLineaVehiculo).then(results => {
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
const Marca = require('../models/MarcaVehiculo');

module.exports = function(app) {
    app.get('/marca', (req,res) => {
        Marca.getAll().then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(204).json({message: 'Not Content'});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        })
    });
}
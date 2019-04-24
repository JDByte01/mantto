const Mecanico = require('../models/Mecanico');

module.exports = function(app) {
    app.get('/mecanico', (req,res) => {
        Mecanico.getAll().then(results => {
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

    app.get('/mecanico/:idMecanico', (req,res) => {
        Mecanico.getById(req.params.idMecanico).then(results => {
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
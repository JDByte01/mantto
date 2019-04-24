const Usuario = require('../models/Usuario');

module.exports = function(app) {
    app.get('/usuario', (req,res) => {
        Usuario.getAll().then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(204).json({message: 'Not Content'});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });
}
const Servicio = require('../models/Servicio');

module.exports = function (app) {
    app.get('/servicio', (req, res) => {
        if (typeof results !== 'undefined' && results.length > 0) {
            res.status(200).json(results);
        } else {
            res.status(204).json({ message: 'Not Content' });
        }
    }, (err) => {
        res.status(500).json(err);
    })
}
const TipoMaterial = require('../models/TipoMaterial');

module.exports = function(app) {
    app.get('/tipo-material', (req,res) => {
        TipoMaterial.getAll().then(results => {
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

    app.get('/tipo-material/:idTipoMaterial', (req,res) => {
        TipoMaterial.getById(req.params.idTipoMaterial).then(results => {
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

    app.post('/tipo-material', (req, res) => {
        const tipoMaterialData = {
            idTipoMaterial: null,
            tipoMaterial: req.body.tipoMaterial
        }
        TipoMaterial.create(tipoMaterialData).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json(results);
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });

    app.put('/tipo-material/:idTipoMaterial', (req, res) => {
        const tipoMaterialData = {
            idTipoMaterial: req.params.idTipoMaterial,
            tipoMaterial: req.body.tipoMaterial
        }
        TipoMaterial.update(tipoMaterialData).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json({message: "Tipo Material modificado con éxito"});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        }); 
    });

    app.delete('/tipo-material/:idTipoMaterial', (req, res) => {
        TipoMaterial.delete(req.params.idTipoMaterial).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json({message: "Tipo Material modificado con éxito"});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        }); 
    })
}
const Persona = require('../models/Persona');

module.exports = function(app) {
    app.get('/persona', (req,res) => {
        Persona.getAll().then(results => {
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

    app.post('/reset-password', (req, res) => {
        let resetCode = Math.floor(Math.random() * (9999 - 1000)) + 1000;
        const personaData = {
            email: req.body.email,
            resetCode: resetCode
        }  
        console.log(personaData);    
        Persona.generarCodigo(personaData).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json({resetCode: resetCode});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });
    
    app.post('/new-password', (req, res) => {
        const personaData = {
            password: req.body.password,
            resetCode: req.body.resetCode
        }    
        Persona.nuevaPassword(personaData).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json({message: "success"});
            }
        },(err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });
}
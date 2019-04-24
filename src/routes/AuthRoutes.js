var jwt = require('jsonwebtoken');
var usuario = require('../models/usuario');

module.exports = function (app) {
    app.post('/login', function (req, res) {
        var usuarioData = {
            idUsuario: null,
            email: req.body.email,
            password: req.body.password
        }
        usuario.login(usuarioData).then(results => {
            if (typeof results[0] !== 'undefined' && results[0].length > 0) {
                var temp = {
                    idUsuario: results[0].idUsuario,
                    idPersona: results[0].idPersona,
                    email: results[0].email,
                    password: results[0].password,
                    tipoUsuario: results[0].tipoUsuario
                }

                var token = 'Bearer ' + jwt.sign(temp, 'mantto', { expiresIn: "365 days" });
                var resultado = {
                    idUsuario: results[0][0].idUsuario,
                    token: token
                }
                res.json(resultado);
            } else {
                res.json({
                    mensaje: "Email o Contraseña Incorrectos"
                });
            }
        })
    });
}
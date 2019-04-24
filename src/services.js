var jwt = require('jsonwebtoken');
var services = {};

services.verificar = function(req, res, next) {
	var token = services.getToken(req, res);
	jwt.verify(token, 'mantto', function(err, decoded) {
		if(err) {
			res.json({
				success: false,
				mensaje: "Error en el token",
				error: err
			});
		}else {
			console.log("Token valido");
			req.token = token;
			req.usuario = decoded;
			next();
		}
	});
}
services.getToken = function(req, res) {
	var header = req.headers.authorization;
	console.log(header);
	if (typeof header != 'undefined') {
		var headerArray = header.split(" ");
		//var token = headerArray[1];
        var token = headerArray.pop();
        
		if(token) {
			return token;
		} else {
			console.log("No Existe el token");
			res.json({
				estado: false,
				mensaje: "No existen el token"
			});
		}
	} else {
		console.log("No Existe la cabecera Authorization");
		res.json({
			estado: false,
			mensaje: "No Existe la cabecera Authorization"
		});
		return ;
	}
}

module.exports = services;

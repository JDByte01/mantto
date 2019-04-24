const Cliente = require('../models/Cliente');
const Persona = require('../models/Persona');
const uuidv1 = require('uuid/v1');
const fs = require('fs');

module.exports = function(app) {
    app.get('/cliente', (req, res) => {
        Cliente.getAll().then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(204).json({ message: 'Not Content' });
            }
        }, (err) => {
            console.log(err)
            res.status(500).json(err);
        })
    });

    app.post('/cliente/:idPersona', (req, res) => {
        let clienteData = {
            idPersona: req.params.idPersona
        }

        if (!req.files) {
            return res.status(400).json('No files were uploaded.');
        } else {
            let archivo = req.files.archivo;
            let nombreCortado = archivo.name.split('.');
            let extension = nombreCortado[nombreCortado.length - 1];

            // Extensiones permitidas
            let extensionesValidas = ['png', 'jpg', 'gif', 'jpeg'];

            if (extensionesValidas.indexOf(extension) < 0) {
                return res.status(400).json({
                    ok: false,
                    err: {
                        message: 'Las extensiones permitidas son ' + extensionesValidas.join(', '),
                        ext: extension
                    }
                });
            }

            // Cambiar nombre al archivo
            let nombreArchivo = `${uuidv1()}.${extension}`;

            archivo.mv(`src/public/uploads/${nombreArchivo}`, function(err) {
                if (err)
                    return res.status(500).send(err);
                // Aqui imagen cargada
                Object.defineProperty(clienteData, 'foto', {
                    value: nombreArchivo,
                    enumerable: true
                });

                Cliente.uploadPicture(clienteData).then(() => {
                    res.status(200).json({ message: "Foto actualizada correctamente" });
                }, (err) => {
                    res.status(500).json(err);
                });
            });
        }

    });

    app.put('/cliente/:idPersona', (req, res) => {
        const clienteData = {
            nombres: req.body.nombres,
            email: req.body.email,
            telefono: req.body.telefono,
            direccion: req.body.direccion,
            idPersona: req.params.idPersona
        }
        Cliente.update(clienteData).then(() => {
            res.status(200).json({ message: "Cliente actualizado correctamente" });
        }, (err) => {
            res.status(500).json(err);
        });
    });

    app.post('/registro-cliente', (req, res) => {
        const clienteData = {
            idCliente: null,
            email: req.body.email,
            password: req.body.password,
            nombres: req.body.nombres,
            apellidos: req.body.apellidos,
            telefono: req.body.telefono,
            identificacion: req.body.identificacion,
            direccion: req.body.direccion,
            pais: req.body.pais
        }
        Cliente.create(clienteData).then(results => {
            if (typeof results !== 'undefined' && results.length > 0) {
                res.status(200).json(results);
            } else {
                res.status(200).json({ message: "Cliente creado con éxito" });
            }
        }, (err) => {
            console.log(err)
            res.status(500).json(err);
        });
    });
}
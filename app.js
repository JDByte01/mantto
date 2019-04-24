const express = require('express');
const fileUpload = require('express-fileupload');
var path = require('path');
const cors = require('cors');
const app = express();
app.use(express.static(__dirname + 'public'));
const morgan = require('morgan');
const bodyParser = require('body-parser');

//SETTINGS
app.set('port', process.env.PORT || 3000);

//MIDDLEWARES
app.use(fileUpload());
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

//CORS
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

//RUTAS
require('./src/routes/TipoMaterialRoutes')(app);
require('./src/routes/AuthRoutes')(app);
require('./src/routes/UsuarioRoutes')(app);
require('./src/routes/ClienteRoutes')(app);
require('./src/routes/PersonaRoutes')(app);
require('./src/routes/TipoVehiculoRoutes')(app);
require('./src/routes/SubTipoVehiculoRoutes')(app);
require('./src/routes/MarcaVehiculoRoutes')(app);
require('./src/routes/LineaVehiculoRoutes')(app);
require('./src/routes/SubLineaRoutes')(app);
require('./src/routes/TipoCombustibleRoutes')(app);
require('./src/routes/TarjetaRoutes')(app);
require('./src/routes/ServicioRoute')(app);

app.listen(app.get('port'), () => {
    console.log(`Servidor Corriendo en el Puerto ${app.get('port')}`);
});
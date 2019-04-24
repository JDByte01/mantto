/*CREACION DE LA BASE DE DATOS*/
CREATE DATABASE ManttoDB;

USE ManttoDB;

/*CREACION DE LAS TABLAS*/
CREATE TABLE tipo_material(
	idTipoMaterial INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipoMaterial VARCHAR(64)
);

CREATE TABLE banco(
	idBanco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    banco VARCHAR(128) NOT NULL
);

CREATE TABLE marca(
	idMarca INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(64)
);

CREATE TABLE tipo_proveedor(
	idTipoProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	tipoProveedor VARCHAR(64)
);

CREATE TABLE pais(
	idPais INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    pais VARCHAR(64)
);

CREATE TABLE uso_vehiculo(
	idUsoVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usoVehiculo VARCHAR(64),
    abreviacion VARCHAR(64)
);

CREATE TABLE tipo_combustible(
	idTipoCombustible INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipoCombustible VARCHAR(64)
);

CREATE TABLE transmision(
	idTransmision INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    transmision VARCHAR(64)
);

CREATE TABLE tipo_servicio(
	idTipoServicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipoServicio VARCHAR(64)
);

CREATE TABLE tipo_pago(
	idTipoPago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	tipoPago VARCHAR(64)
);

CREATE TABLE usuario(
	idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idPersona INT NOT NULL,
    email VARCHAR(128),
    password VARCHAR(50),
    tipoUsuario CHAR,
    numReintento INT,
    resetPassword BOOLEAN,
    tipoLogin CHAR
);

CREATE TABLE moneda(
	idMoneda INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    moneda VARCHAR(64)
);

CREATE TABLE tipo_promocion(
	idTipoPromocion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipoPromocion VARCHAR(64)
);

CREATE TABLE tamanio_motor(
	idTamanioMotor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tamanioMotor INT
);

CREATE TABLE tipo_vehiculo(
	idTipoVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	tipoVehiculo VARCHAR(64)
);

CREATE TABLE linea_vehiculo(
	idLineaVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    linea VARCHAR(64)
);

CREATE TABLE sub_linea(
	idSubLinea INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    subLinea VARCHAR(64),
    idLineaVehiculo INT NOT NULL,
	FOREIGN KEY (idLineaVehiculo) REFERENCES linea_vehiculo(idLineaVehiculo) ON DELETE CASCADE
);

CREATE TABLE sub_tipo_vehiculo(
	idSubTipoVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTipoVehiculo INT NOT NULL,
    subTipoVehiculo VARCHAR(64),
	FOREIGN KEY (idTipoVehiculo) REFERENCES tipo_vehiculo(idTipoVehiculo) ON DELETE CASCADE
);

CREATE TABLE mano_obra(
	idManoObra INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	idServicio INT NOT NULL,
    idUsuario INT NOT NULL,
    fechaServicio DATETIME,
	idTipoServicio INT NOT NULL,
    FOREIGN KEY (idTipoServicio) REFERENCES tipo_servicio(idTipoServicio) ON DELETE CASCADE
);

CREATE TABLE material(
	idMaterial INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTipoMaterial INT NOT NULL,
    costo DECIMAL(22,7),
    costoProduccion DECIMAL(22,7),
    unidadDisponible INT,
    precioVentaMaterial DECIMAL(22,7),
    precioConIva DECIMAL(22,7),
    precioSinIva DECIMAL(22,7),
    FOREIGN KEY (idTipoMaterial) REFERENCES tipo_material (idTipoMaterial) ON DELETE CASCADE
);

CREATE TABLE persona(
	idPersona INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(128),
    apellidos VARCHAR(128),
	telefono VARCHAR(64),
    nit VARCHAR(64),
    direccion VARCHAR(64),
    identificacion VARCHAR(64),
    foto VARCHAR(256),
    idPais INT NOT NULL,
    resetCode INT,
    FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE
);

CREATE TABLE marca_vehiculo(
	idMarcaVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    marcaVehiculo VARCHAR(64),
    idLineaVehiculo INT NOT NULL,
	FOREIGN KEY (idLineaVehiculo) REFERENCES linea_vehiculo(idLineaVehiculo) ON DELETE CASCADE
);

CREATE TABLE servicio(
	idServicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTipoServicio INT NOT NULL,
    precioVentaMaterial DECIMAL(22,7),
    costoManoObra DECIMAL(22,7),
    isr DECIMAL(22,7),
    boniMantto DECIMAL(22,7),
    precioTotal DECIMAL(22,7),
    FOREIGN KEY (idTipoServicio) REFERENCES tipo_servicio(idTipoServicio) ON DELETE CASCADE
);

CREATE TABLE vehiculo(
	idVehiculo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMarcaVehiculo INT NOT NULL,
    idLineaVehiculo INT NOT NULL,
    idTipoVehiculo INT NOT NULL,
    idUsoVehiculo INT NOT NULL,
    idTipoCombustible INT NOT NULL,
    idTransmision INT NOT NULL,
    color VARCHAR(64),
	cantPuertas INT,
    modelo INT,
    placa VARCHAR(64),
    idTamanioMotor INT NOT NULL,
    FOREIGN KEY (idMarcaVehiculo) REFERENCES marca_vehiculo(idMarcaVehiculo) ON DELETE CASCADE,
    FOREIGN KEY (idLineaVehiculo) REFERENCES linea_vehiculo(idLineaVehiculo) ON DELETE CASCADE,
    FOREIGN KEY (idTipoVehiculo) REFERENCES tipo_vehiculo(idTipoVehiculo) ON DELETE CASCADE,
    FOREIGN KEY (idUsoVehiculo) REFERENCES uso_vehiculo(idUsoVehiculo) ON DELETE CASCADE,
    FOREIGN KEY (idTipoCombustible) REFERENCES tipo_combustible(idTipoCombustible) ON DELETE CASCADE,
    FOREIGN KEY (idTransmision) REFERENCES transmision(idTransmision) ON DELETE CASCADE,
    FOREIGN KEY (idTamanioMotor) REFERENCES tamanio_motor(idTamanioMotor) ON DELETE CASCADE
); 

CREATE TABLE tarjeta(
	idTarjeta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tipoTarjeta CHAR,
    numTarjeta VARCHAR(128),
    fechaVencimiento DATETIME,
    idPais INT NOT NULL,
    idBanco INT NOT NULL,
    idMoneda INT NOT NULL,
    FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE,
    FOREIGN KEY (idBanco) REFERENCES banco(idBanco) ON DELETE CASCADE,
    FOREIGN KEY (idMoneda) REFERENCES moneda(idMoneda) ON DELETE CASCADE
);

CREATE TABLE mecanico(
	idMecanico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	idPersona INT NOT NULL,
    idVehiculo INT NOT NULL,
    idTarjeta INT NOT NULL,
    idUsuario INT NOT NULL,
    FOREIGN KEY (idPersona) REFERENCES persona(idPersona) ON DELETE CASCADE,
    FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo) ON DELETE CASCADE,
    FOREIGN KEY (idTarjeta) REFERENCES tarjeta(idTarjeta) ON DELETE CASCADE,
     FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario) ON DELETE CASCADE
);

CREATE TABLE cliente(
	idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idPersona INT NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario) ON DELETE CASCADE,
    FOREIGN KEY (idPersona) REFERENCES persona(idPersona) ON DELETE CASCADE
);

CREATE TABLE datos_adicionales(	
	idDatosAdicionales INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    idMecanico INT,
    cantServOfrecido INT,
    cantAutoTrabajado INT,
    cantClienteAtendido INT,
    cantDiaSinBrindarServ INT,
    cantServRecibido INT,
    cantAutoServRecibido INT,
    cantMecHanAtendido INT,
    cantDiaSinRecibirServ INT,
    calificacionMedia INT,
	FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE,
	FOREIGN KEY (idMecanico) REFERENCES mecanico(idMecanico) ON DELETE CASCADE
);

CREATE TABLE solicitud_servicio(
	idSolicitudServicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	idServicio INT NOT NULL,
    idCliente INT NOT NULL,
    idMecanico INT NOT NULL,
    idTipoPago INT NOT NULL,
    horaSolicitud DATETIME,
    horaAtencion DATETIME,
    horaFinalizacion DATETIME,
    calificacionCliente DECIMAL(10,2),
    calificacionMecanico DECIMAL(10,2),
    estado VARCHAR(64),
    latitud DECIMAL(12,4),
    longitud DECIMAL(12,4),
    FOREIGN KEY (idServicio) REFERENCES servicio(idServicio) ON DELETE CASCADE,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE,
    FOREIGN KEY (idMecanico) REFERENCES mecanico(idMecanico) ON DELETE CASCADE,
    FOREIGN KEY (idTipoPago) REFERENCES tipo_pago(idTipoPago) ON DELETE CASCADE
);

CREATE TABLE comentario(
	idComentario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSolicitudServicio INT NOT NULL,
    comentario VARCHAR(512),
    FOREIGN KEY (idSolicitudServicio) REFERENCES solicitud_servicio(idSolicitudServicio) ON DELETE CASCADE
);

CREATE TABLE reg_tracking(
	idRegTracking INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSolicitudServicio INT NOT NULL,
    horaLlegada DATETIME,
    horaInicioOrden DATETIME,
    horaFinalizacionOrden DATETIME,
    horaCobroOrden DATETIME,
    horaCierreOrden DATETIME,
    FOREIGN KEY (idSolicitudServicio) REFERENCES solicitud_servicio(idSolicitudServicio) ON DELETE CASCADE
);

CREATE TABLE preferencia_cliente(
	idPreferenciaCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    frecuenciaServicio INT,
    programarServicio BOOLEAN,
    fechaProximoServicio DATETIME,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

CREATE TABLE tasa_cambio(
	idTasaCambio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMoneda INT NOT NULL,
    fecha DATETIME,
    tasaCambio DECIMAL(22,7),
    FOREIGN KEY (idMoneda) REFERENCES moneda(idMoneda) ON DELETE CASCADE
);

CREATE TABLE promocion(
	idPromocion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTipoPromocion INT NOT NULL,
    promocion VARCHAR(256),
    descuento INT,
    fechaCreacion DATETIME,
    fechaInicio DATETIME,
    fechaFin DATETIME,
    FOREIGN KEY (idTipoPromocion) REFERENCES tipo_promocion(idTipoPromocion) ON DELETE CASCADE
);

CREATE TABLE material_marca(
	idMaterialMarca INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMaterial INT NOT NULL,
	idMarca INT NOT NULL,
    FOREIGN KEY (idMaterial) REFERENCES material(idMaterial) ON DELETE CASCADE,
    FOREIGN KEY (idMarca) REFERENCES marca(idMarca) ON DELETE CASCADE
);

CREATE TABLE proveedor(
	idProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idTipoProveedor INT NOT NULL,
    idPersona INT NOT NULL,
    nombre VARCHAR(128),
    nombreComercial VARCHAR(128),
    representante VARCHAR(128),
    direccion VARCHAR(128),
    idPais INT NOT NULL,
    codigoPostal VARCHAR(10),
    telefono VARCHAR(64),
	nitProveedor VARCHAR(64),
    FOREIGN KEY (idTipoProveedor) REFERENCES tipo_proveedor(idTipoProveedor) ON DELETE CASCADE,
    FOREIGN KEY (idPersona) REFERENCES persona(idPersona) ON DELETE CASCADE,
    FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE
);

CREATE TABLE material_proveedor(
	idMaterialProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMaterial INT NOT NULL,
    idProveedor INT NOT NULL,
    FOREIGN KEY (idMaterial) REFERENCES material(idMaterial) ON DELETE CASCADE,
    FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor) ON DELETE CASCADE
);

CREATE TABLE marca_proveedor(
	idMarcaProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idProveedor INT NOT NULL,
    idMarca INT NOT NULL,
    FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor) ON DELETE CASCADE,
    FOREIGN KEY (idMarca) REFERENCES marca(idMarca) ON DELETE CASCADE
);

CREATE TABLE material_servicio(
	idMaterialServicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idServicio INT NOT NULL,
    idMaterial INT NOT NULL,
    FOREIGN KEY (idServicio) REFERENCES servicio(idServicio) ON DELETE CASCADE,
    FOREIGN KEY (idMaterial) REFERENCES material(idMaterial) ON DELETE CASCADE
);

CREATE TABLE precio(
	idPrecio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMaterialServicio INT NOT NULL,
    idServicio INT NOT NULL,
    costoMaterial DECIMAL(22,7),
    costoServicio DECIMAL(22,7),
    costoManoDeObra DECIMAL(22,7),
    precioVentaMaterial DECIMAL(22,7),
    precioVentaServicio DECIMAL(22,7),
    boniMantto DECIMAL(22,7),
	isr DECIMAL(22,7),
    precioTotalSinIva DECIMAL(22,7),
	FOREIGN KEY (idMaterialServicio) REFERENCES material_servicio(idMaterialServicio) ON DELETE CASCADE,
	FOREIGN KEY (idServicio) REFERENCES servicio(idServicio) ON DELETE CASCADE
);

CREATE TABLE vehiculo_cliente(
	idVehiculoCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idVehiculo INT NOT NULL,
    idCliente INT NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE marca_cliente(
	idMarcaCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idMarca INT NOT NULL,
    idCliente INT NOT NULL,
	FOREIGN KEY (idMarca) REFERENCES marca(idMarca),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE promocion_usuario(
	idPromocionUsuario INT NOT NULL PRIMARY KEY,
    idPromocion INT NOT NULL,
    idUsuario INT NOT NULL,
    FOREIGN KEY (idPromocion) REFERENCES promocion(idPromocion) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario) ON DELETE CASCADE
);

CREATE TABLE moneda_pais(
	idMonedaPais INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idPais INT NOT NULL,
    idMoneda INT NOT NULL,
    FOREIGN KEY (idPais) REFERENCES pais(idPais) ON DELETE CASCADE,
    FOREIGN KEY (idMoneda) REFERENCES moneda(idMoneda) ON DELETE CASCADE
);

CREATE TABLE promocion_tipo_pago(
	idPromocionTipoPago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idPromocion INT NOT NULL,
    idTipoPago INT NOT NULL,
    FOREIGN KEY (idPromocion) REFERENCES promocion(idPromocion) ON DELETE CASCADE,
    FOREIGN KEY (idTipoPago) REFERENCES tipo_pago(idTipoPago) ON DELETE CASCADE
);

CREATE TABLE cliente_tarjeta(
	idClienteTarjeta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    idTarjeta INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE,
    FOREIGN KEY (idTarjeta) REFERENCES tarjeta(idTarjeta) ON DELETE CASCADE
);


/*-----------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TIPO MATERIAL*/
/*---------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTipoMaterial(_tipoMaterial VARCHAR(128))
BEGIN
	INSERT INTO tipo_material(tipoMaterial) VALUES (_tipoMaterial);
END //
DELIMITER ;

/*--------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA PAIS*/
/*------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarPais(
    _pais VARCHAR(64)
)
BEGIN
	INSERT INTO pais(pais) VALUES (_pais);
END //
DELIMITER ;

/*-----------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA USUARIO*/
/*---------------------------------------*/

/*GENERAR CODIGO RESET PASSWORD*/
DELIMITER //
CREATE PROCEDURE SP_GenerarCodigo(
	_email VARCHAR(64),
    _resetCode INT
)
BEGIN
	SET @idPersona = (SELECT idPersona FROM usuario WHERE email = _email);
    UPDATE persona SET resetCode = _resetCode WHERE idPersona = @idPersona;
    UPDATE usuario SET resetPassword = TRUE WHERE idPersona = @idPersona;
END //
DELIMITER ;

/*RESETEAR PASSWORD*/
DELIMITER //
CREATE PROCEDURE SP_NuevaPassword(
	_password VARCHAR(64),
    _resetCode INT
)
BEGIN
	SET @idPersona = (SELECT idPersona FROM persona WHERE resetCode = _resetCode);
    UPDATE usuario SET password = _password, resetPassword = FALSE WHERE idPersona = @idPersona;
    UPDATE persona SET resetCode = NULL WHERE idPersona = @idPersona;
END //
DELIMITER ;

/*AUTENTICAR USUARIO*/
DELIMITER //
CREATE PROCEDURE SP_AutenticarUsuario(IN _email VARCHAR(128), IN _password VARCHAR(50))
	BEGIN
		SELECT * FROM usuario WHERE email = _email AND password = _password;
    END //
DELIMITER ;

/*-----------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA CLIENTE*/
/*---------------------------------------*/

/*OBTENER DATOS CLIENTE*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerDatosCliente(
    _idCliente INT
)
BEGIN
	SELECT cantServRecibido,cantAutoServRecibido,cantMecHanAtendido,cantDiaSinRecibirServ FROM datos_adicionales WHERE idCliente = _idCliente; 
END //
DELIMITER ;

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarCliente(
    _email VARCHAR(128),
    _password VARCHAR(50),
	_nombres VARCHAR(128),
    _apellidos VARCHAR(128),
	_telefono VARCHAR(64),
	_identificacion VARCHAR(64),
    _direccion VARCHAR(64),
    _pais VARCHAR(64)
)
BEGIN
	SET @idPais = (SELECT idPais FROM pais WHERE pais = _pais);
    INSERT INTO persona(nombres,apellidos,telefono,identificacion,direccion,idPais) VALUES(_nombres,_apellidos,_telefono,_identificacion,_direccion,@idPais);
    SET @idPersona = LAST_INSERT_ID();
	INSERT INTO usuario(idPersona,email,password) VALUES(@idPersona,_email,_password);
    SET @idUsuario = LAST_INSERT_ID();
	INSERT INTO cliente(idUsuario,idPersona) VALUES (@idUsuario,@idPersona);
END //
DELIMITER ;

/*------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA MECANICO*/
/*----------------------------------------*/

/*OBTENER DATOS MECANICO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerDatosMecanico(
    _idMecanico INT
)
BEGIN
	SELECT cantServOfrecido,cantAutoTrabajado,cantClienteAtendido,cantDiaSinBrindarServ FROM datos_adicionales WHERE idMecanico = _idMecanico; 
END //
DELIMITER ;

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarMecanico(
    _email VARCHAR(128),
    _password VARCHAR(50),
	_nombres VARCHAR(128),
    _apellidos VARCHAR(128),
	_telefono VARCHAR(64),
	_identificacion VARCHAR(64),
    _direccion VARCHAR(64),
    _marcaVehiculo VARCHAR(64),
    _placa VARCHAR(64),
    _tipoTarjeta CHAR,
    _numTarjeta VARCHAR(25),
    _fechaVencimiento DATETIME,
	_pais VARCHAR(64)
)
BEGIN
	SET @idPais = (SELECT idPais FROM pais WHERE pais = _pais);
    INSERT INTO persona(nombres,apellidos,telefono,identificacion,direccion,idPais) VALUES(_nombres,_apellidos,_telefono,_identificacion,_direccion,@idPais);
    SET @idPersona = LAST_INSERT_ID();
	INSERT INTO usuario(idPersona,email,password) VALUES(@idPersona,_email,_password);
    SET @idUsuario = LAST_INSERT_ID();
    INSERT INTO marca_vehiculo(marcaVehiculo) VALUES(_marcaVehiculo);
	INSERT INTO mecanico(idPersona,idVehiculo,idTarjeta,idUsuario) VALUES (_idPersona,_idVehiculo,_idTarjeta,_idUsuario);
END //
DELIMITER ;


/*---------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS DATOS ADICIONALES*/
/*-------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarDatosAdicionales(
    _idCliente INT,
    _idMecanico INT,
    _cantServOfrecido INT,
    _cantAutoTrabajado INT,
    _cantClienteAtendido INT,
    _cantDiaSinBrindarServ INT,
    _cantServRecibido INT,
    _cantAutoServRecibido INT,
    _cantMecHanAtendido INT,
    _cantDiaSinRecibirServ INT,
    _calificacionMedia INT
)
BEGIN
	INSERT INTO datos_adicionales(idCliente,idMecanico,cantServOfrecido,cantAutoTrabajado,cantClienteAtendido,cantDiaSinBrindarServ,cantServRecibido,cantAutoServRecibido,cantMecHanAtendido,cantDiaSinRecibirServ,calificacionMedia)
    VALUES(_idCliente,_idMecanico,_cantServOfrecido,_cantAutoTrabajado,_cantClienteAtendido,_cantDiaSinBrindarServ,_cantServRecibido,_cantAutoServRecibido,_cantMecHanAtendido,_cantDiaSinRecibirServ,_calificacionMedia);
END //
DELIMITER ;

/*-----------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TIPO VEHICULO*/
/*---------------------------------------------*/

/*OBTENER TIPOS VEHICULO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerTipoVehiculo()
BEGIN
	SELECT t.idTipoVehiculo,t.tipoVehiculo,st.idSubTipoVehiculo,st.subTipoVehiculo FROM tipo_vehiculo t
    INNER JOIN sub_tipo_vehiculo st ON t.idTipoVehiculo = st.idTipoVehiculo; 
END //
DELIMITER ;

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTipoVehiculo(
	_tipoVehiculo VARCHAR(64)
)
BEGIN
	INSERT INTO tipo_vehiculo(tipoVehiculo) VALUES(_tipoVehiculo);
END //
DELIMITER ;

/*---------------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA SUB TIPO VEHICULO*/
/*-------------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarSubTipoVehiculo(
	_idTipoVehiculo INT,
	_subTipoVehiculo VARCHAR(64)
)
BEGIN
	INSERT INTO sub_tipo_vehiculo(idTipoVehiculo,subTipoVehiculo) VALUES(_idTipoVehiculo,_subTipoVehiculo);
END //
DELIMITER ;

/*OBTENER SUB TIPO VEHICULO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerSubTipoVehiculo(
	_idTipoVehiculo INT
)
BEGIN
	SELECT t.idTipoVehiculo,t.tipoVehiculo,st.idSubTipoVehiculo,st.subTipoVehiculo FROM tipo_vehiculo t
    INNER JOIN sub_tipo_vehiculo st ON t.idTipoVehiculo = st.idTipoVehiculo
	WHERE st.idTipoVehiculo = _idTipoVehiculo; 
END //
DELIMITER ;

/*------------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA MARCA VEHICULO*/
/*----------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarMarcaVehiculo(
    _marcaVehiculo VARCHAR(64),
    _idLineaVehiculo INT
)
BEGIN
	INSERT INTO marca_vehiculo(marcaVehiculo,idLineaVehiculo) VALUES(_marcaVehiculo,_idLineaVehiculo);
END //
DELIMITER ;

/*------------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA LINEA VEHICULO*/
/*----------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarLineaVehiculo(
    _linea VARCHAR(64)
)
BEGIN
	INSERT INTO linea_vehiculo(linea) VALUES(_linea);
END //
DELIMITER ;

/*OBTENER LINEA VEHICULO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerLineaVehiculo(
	_idMarcaVehiculo INT
)
BEGIN
	SELECT m.idMarcaVehiculo,m.marcaVehiculo,l.idLineaVehiculo,l.linea, s.idSubLinea, s.subLinea FROM marca_vehiculo m
    INNER JOIN linea_vehiculo l ON m.idLineaVehiculo = l.idLineaVehiculo
    INNER JOIN sub_linea s ON l.idLineaVehiculo = s.idLineaVehiculo
	WHERE m.idMarcaVehiculo = _idMarcaVehiculo; 
END //
DELIMITER ;

/*-------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA SUB LINEA*/
/*-----------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarSubLinea(
    _subLinea VARCHAR(64),
    _idLineaVehiculo INT
)
BEGIN
	INSERT INTO sub_linea(subLinea,idLineaVehiculo) VALUES(_subLinea,_idLineaVehiculo);
END //
DELIMITER ;

/*OBTENER SUB LINEA VEHICULO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerSubLineaVehiculo(
	_idLineaVehiculo INT
)
BEGIN
	SELECT l.idLineaVehiculo,l.linea, s.idSubLinea, s.subLinea FROM linea_vehiculo l
    INNER JOIN sub_linea s ON l.idLineaVehiculo = s.idLineaVehiculo
	WHERE l.idLineaVehiculo = _idLineaVehiculo; 
END //
DELIMITER ;


/*------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA VEHICULO*/
/*----------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarVehiculo(
    _idMarcaVehiculo INT,
    _idLineaVehiculo INT,
    _idTipoVehiculo INT,
    _idUsoVehiculo INT,
    _idTipoCombustible INT,
    _idTransmision INT,
    _color VARCHAR(64),
	_cantPuertas INT,
    _modelo INT,
    _placa VARCHAR(64),
    _idTamanioMotor INT
)
BEGIN
	INSERT INTO vehiculo(idMarcaVehiculo,idLineaVehiculo,idTipoVehiculo,idUsoVehiculo,idTipoCombustible,idTransmision,color,cantPuertas,modelo,placa,idTamanioMotor)
    VALUES(_idMarcaVehiculo,_idLineaVehiculo,_idTipoVehiculo,_idUsoVehiculo,_idTipoCombustible,_idTransmision,_color,_cantPuertas,_modelo,_placa,_idTamanioMotor);
END //
DELIMITER ;

/*--------------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TIPO COMBUSTIBLE*/
/*------------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTipoCombustible(
	_tipoCombustible VARCHAR(64)
)
BEGIN
	INSERT INTO tipo_combustible(tipoCombustible)
    VALUES(_tipoCombustible);
END //
DELIMITER ;

/*OBTENER TIPO COMBUSTIBLE VEHICULO*/
DELIMITER //
CREATE PROCEDURE SP_ObtenerTipoCombustibleVehiculo(
	_idVehiculo INT
)
BEGIN
	SELECT tipoCombustible FROM vehiculo v
    INNER JOIN tipo_combustible t ON v.idTipoCombustible = t.idTipoCombustible
    WHERE v.idVehiculo = _idVehiculo;
END //
DELIMITER ;

/*----------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA USO VEHICULO*/
/*--------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarUsoVehiculo(
    _usoVehiculo VARCHAR(64),
    _abreviacion VARCHAR(64)
)
BEGIN
	INSERT INTO uso_vehiculo(usoVehiculo,abreviacion)
    VALUES(_usoVehiculo,_abreviacion);
END //
DELIMITER ;

/*---------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TRANSMISION*/
/*-------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTransmision(
    _transmision VARCHAR(64)
)
BEGIN
	INSERT INTO transmision(transmision)
    VALUES(_transmision);
END //
DELIMITER ;

/*-----------------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TAMANIO MOTOR*/
/*---------------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTamanioMotor(
     _tamanioMotor INT
)
BEGIN
	INSERT INTO tamanio_motor(tamanioMotor)
    VALUES(_tamanioMotor);
END //
DELIMITER ;

/*-----------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA TARJETA*/
/*---------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarTarjeta(
    _tipoTarjeta CHAR,
    _numTarjeta VARCHAR(128),
    _fechaVencimiento DATETIME,
    _idPais INT,
    _idBanco INT,
    _idMoneda INT
)
BEGIN
	INSERT INTO tarjeta(tipoTarjeta,numTarjeta,fechaVencimiento,idPais,idBanco,idMoneda)
    VALUES(_tipoTarjeta,_numTarjeta,_fechaVencimiento,_idPais,_idBanco,_idMoneda);
END //
DELIMITER ;

/*---------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA BANCO*/
/*-------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarBanco(
    _banco VARCHAR(128)
)
BEGIN
	INSERT INTO banco(banco)
    VALUES(_banco);
END //
DELIMITER ;

/*----------------------------------------*/
/*PROCEDIMIENTOS ALMACENADOS TABLA MONEDA*/
/*--------------------------------------*/

/*INSERTAR*/
DELIMITER //
CREATE PROCEDURE SP_InsertarMoneda(
    _moneda VARCHAR(64)
)
BEGIN
	INSERT INTO moneda(moneda)
    VALUES(_moneda);
END //
DELIMITER ;


/*LLAMAR A TODOS LOS PROCEDIMIENTOS PARA DATOS DE PRUEBA*/
CALL SP_InsertarTipoMaterial ('Plastico');
CALL SP_InsertarPais ('Guatemala');
CALL SP_InsertarCliente ('Estuardo1314@gmail.com','Operaciones@es18','Erick Estuardo','Saban Avila','5522-0011','3076741690603','3av 9-32 Zona 8','Guatemala');
CALL SP_InsertarDatosAdicionales(1,null,null,null,null,null,5,2,7,15,9);
CALL SP_InsertarTipoVehiculo('TIPO VEHICULO 1');
CALL SP_InsertarTipoVehiculo('TIPO VEHICULO 2');
CALL SP_InsertarSubTipoVehiculo(1,'SUB TIPO 1');
CALL SP_InsertarSubTipoVehiculo(2,'SUB TIPO 2');
CALL SP_InsertarLineaVehiculo('LINEA 3');
CALL SP_InsertarLineaVehiculo('LINEA 2');
CALL SP_InsertarSubLinea('SUB LINEA 1',1);
CALL SP_InsertarSubLinea('SUB LINEA 2',1);
CALL SP_InsertarMarcaVehiculo('MARCA 1', 1);
CALL SP_InsertarMarcaVehiculo('MARCA 2', 2);
CALL SP_ObtenerTipoVehiculo();
CALL SP_ObtenerSubTipoVehiculo(2);
CALL SP_ObtenerLineaVehiculo(1);
CALL SP_ObtenerSubLineaVehiculo(1);
CALL SP_InsertarUsoVehiculo('USO VEHICULO 1','ABREVIACION');
CALL SP_InsertarTransmision('TRANSMISION 1');
CALL SP_InsertarTamanioMotor(2000);
CALL SP_InsertarTipoCombustible('Gasolina');
CALL SP_InsertarVehiculo(1,1,1,1,1,1,'AZUL',4,2018,'P99GWK',1);
CALL SP_ObtenerTipoCombustibleVehiculo(1);
CALL SP_InsertarBanco('BANCO 1');
CALL SP_InsertarMoneda('MONEDA 1');
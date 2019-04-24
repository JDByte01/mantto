/*Información de Prueba*/
insert into persona (nombres, apellidos, telefono, nit, direccion, identificacion, idPais) values ('Fredy', 'García', '1234-5678', '3602978-5', 'L.1 S.2 Col.XD Zona 18', '2320556340103', 1);
insert into usuario (idPersona, email, password) values (2, 'manttotest@gmail.com', 'helloWorld');
insert into cliente (idUsuario, idPersona) values (2, 2);
insert into tarjeta (tipoTarjeta, numTarjeta, fechaVencimiento, idPais, idBanco, idMoneda) values ('D', '1234567890123456', '2019-12-01', 1, 1, 1);
insert into cliente_tarjeta (idCliente, idTarjeta) values (2, 1);

/*Procedimientos Almacenados*/
-- OBTENER PERFIL CLIENTE
DELIMITER //
CREATE PROCEDURE SP_ObtenerPerfilCliente
	(IN _idPersona int)
BEGIN
	select b.idPersona, b.nombres, a.email, b.telefono, b.direccion, b.foto from usuario as a
	inner join persona as b on a.idPersona = b.idPersona
	where a.idPersona = _idPersona;
END //
DELIMITER ;

-- MODIFICAR PERFIL CLIENTE
DELIMITER //
CREATE PROCEDURE SP_ModificarPerfilCliente
	(
		in _nombres varchar(128),
        in _email varchar(128),
        in _telefono varchar(64),
        in _direccion varchar(64),
        in _idPersona int
    )
BEGIN
	update persona as a 
	inner join usuario as b on a.idPersona = b.idPersona
	set a.nombres = _nombres, b.email = _email, a.telefono = _telefono, a.direccion = _direccion
	where a.idPersona = _idPersona;  
END //
DELIMITER ;

-- LISTAR TARJETA
DELIMITER //
CREATE PROCEDURE SP_ObtenerTarjeta
	(IN _idTarjeta int)
BEGIN
	select b.idTarjeta, b.tipoTarjeta, b.numTarjeta, b.fechaVencimiento, c.pais, d.banco, e.moneda from cliente_tarjeta as a
	inner join tarjeta as b on a.idTarjeta = b.idTarjeta
	inner join pais as c on b.idPais = c.idPais
	inner join banco as d on b.idBanco = d.idBanco
	inner join moneda as e on b.idMoneda = e.idMoneda
	where b.idTarjeta = _idTarjeta;
END //
DELIMITER ;

-- LISTAR SERVICIOS
CREATE VIEW VIEW_ServiciosSinAtender
	AS
		select a.idSolicitudServicio, g.email, f.nombres, f.apellidos, h.tipoServicio, e.tipoPago, a.horaSolicitud, a.horaAtencion, a.horaFinalizacion, i.nombres as nombre_mecanico, i.apellidos as apellidos_mecanico, a.calificacionCliente, a.calificacionMecanico, a.estado, a.latitud, a.longitud from solicitud_servicio as a
		inner join cliente as b on a.idCliente = b.idCliente
		inner join servicio as c on a.idServicio = c.idServicio
		inner join mecanico as d on a.idMecanico = d.idMecanico
		inner join tipo_pago as e on a.idTipoPago = e.idTipoPago
		inner join persona as f on b.idPersona = f.idPersona
		inner join usuario as g on f.idPersona = g.idPersona
		inner join tipo_servicio as h on c.idTipoServicio = h.idTipoServicio
		inner join persona as i on d.idPersona = i.idPersona
		where a.horaAtencion is null;
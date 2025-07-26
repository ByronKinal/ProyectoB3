drop database if exists tiendaWebDB;
create database tiendaWebDB;
use tiendaWebDB;



create table Usuarios(
	idUsuario int auto_increment,
    nombreUsuario varchar(64),
    apellidoUsuario varchar(64),
    fechaNacimiento timestamp,
    generoUsuario enum('MASCULINO','FEMENINO'),
    telefonoUsuario varchar(32),
    correoUsuario varchar(256) unique,
    contrasenaUsuario varchar(256),
    rolUsuario ENUM('Empleado','Cliente') default 'Cliente',
    constraint pk_usuarios primary key (idUsuario)
);

create table DetalleUsuarios(
	idDetalleUsuario int auto_increment,
    direccionUsuario varchar(256) not null,
    puestoUsuario varchar(32) not null,
    salarioUsuario double not null,
    idUsuario int,
    constraint pk_detalle_usuarios primary key (idDetalleUsuario),
    constraint fk_detalle_usuarios_usuarios foreign key (idUsuario)
		references Usuarios(idUsuario) on delete cascade
);

create table Compras(
	idCompra int auto_increment,
    estadoCompra enum('Pendiente','Completada','Cancelada') default 'Pendiente',
    estadoPago enum('Pendiente', 'Pagado')default'Pendiente',
    fechaCompra timestamp,
    idUsuario int,
    constraint pk_compras primary key (idCompra),
    constraint fk_compras_usuarios foreign key (idUsuario)
		references Usuarios(idUsuario) on delete cascade
); 

create table Proveedores(
	idProveedor int auto_increment,
    nombreProveedor varchar(128) not null,
    correoProveedor varchar(256) not null unique,
    telefonoProveedor varchar(16) not null,
    direccionProveedor varchar(256) not null,
    constraint pk_proveedores primary key (idProveedor)
);

create table Categorias(
	idCategoria int auto_increment,
    nombreCategoria varchar(64) not null,
    descripcionCategoria varchar(256) not null,
    constraint pk_categorias primary key (idCategoria)
);

create table Productos(
	idProducto int auto_increment,
	nombreProducto varchar(128) not null,
	descripcionProducto varchar(256) not null,
    tallaProducto varchar(8),
    marcaProducto varchar(64) not null,
	precioProducto double not null,
	stockProducto int not null,
    fechaIngresoProducto timestamp,
    fechaSalidaProducto timestamp,
    idCategoria int,
	idProveedor int,
    constraint pk_productos primary key (idProducto),
    constraint fk_productos_categorias foreign key (idCategoria)
		references Categorias(idCategoria) on delete cascade,
    constraint fk_productos_proveedores foreign key (idProveedor)
		references Proveedores(idProveedor) on delete cascade
);


create table Pagos(
	idPago int auto_increment,
    fechaPago timestamp,
	metodoPago enum('Tarjeta'),
	cantidadPago double not null,
    idCompra int not null,
    constraint pk_pagos primary key (idPago),
    constraint fk_pagos_compras foreign key (idCompra) 
		references Compras (idCompra) on delete cascade
);

create table Carritos( -- DetalleCompra 
	idCompra int not null,
    idProducto int not null,
    cantidadProducto int not null,
    subtotal double not null,
    constraint pk_detallecompras primary key (idCompra, idProducto),
    constraint fk_detalle_compras_compras foreign key (idCompra)
		references Compras(idCompra) on delete cascade,
    constraint fk_detalle_compras_productos foreign key (idProducto)
		references Productos(idProducto) on delete cascade
);

create table Facturas(
	idFactura int auto_increment,
    fechaFactura timestamp,
    total double not null,
    metodoPago enum('Tarjeta'),
    idCompra int not null,
    constraint pk_facturas primary key (idFactura),
	constraint fk_facturas_compras foreign key (idCompra)
		references Compras(idCompra) on delete cascade
);





-- CRUD Usuarios ---------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarUsuarios()
		begin
			select 
			idUsuario as ID,
			nombreUsuario  as USUARIO,
			apellidoUsuario as APELLIDO,
			fechaNacimiento  as NACIMIENTO,
			generoUsuario as GENERO,
            telefonoUsuario as TELEFONO,
			correoUsuario as CORREO,
			contrasenaUsuario as CONTRASEÑA,
			rolUsuario as ROL
			from Usuarios;
		end$$
	
DELIMITER ;
call sp_ListarUsuarios();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarUsuario(
			in p_nombreUsuario varchar(64),
			in p_apellidoUsuario varchar(64),
			in p_fechaNacimiento timestamp,
			in p_generoUsuario enum('MASCULINO','FEMENINO'),
			in p_telefonoUsuario varchar(32),
			in p_correoUsuario varchar(256) ,
			in p_contrasenaUsuario varchar(256),
			in p_rolUsuario ENUM('Empleado','Cliente'))
		begin
			insert into Usuarios(nombreUsuario , apellidoUsuario , fechaNacimiento,  generoUsuario , telefonoUsuario, correoUsuario, contrasenaUsuario, rolUsuario)
				values(p_nombreUsuario , p_apellidoUsuario , p_fechaNacimiento, p_generoUsuario, p_telefonoUsuario, p_correoUsuario, p_contrasenaUsuario, p_rolUsuario);
		end$$
	
DELIMITER ;
call sp_AgregarUsuario('Lucía','Ramírez','2000-04-10 00:00:00','FEMENINO',  '3214567890','lucia.ramirez@gmail.com','luciaSegura2025','Cliente');
call sp_ListarUsuarios();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarUsuario(
			in p_idUsuario int,
			in p_nombreUsuario varchar(64),
			in p_apellidoUsuario varchar(64),
			in p_fechaNacimiento timestamp,
			in p_generoUsuario enum('MASCULINO','FEMENINO'),
			in p_telefonoUsuario varchar(32),
			in p_correoUsuario varchar(256) ,
			in p_contrasenaUsuario varchar(256),
			in p_rolUsuario ENUM('Empleado','Cliente'))
		begin
			update Usuarios
				set
					nombreUsuario = p_nombreUsuario,
					apellidoUsuario = p_apellidoUsuario ,
					fechaNacimiento = p_fechaNacimiento,
					generoUsuario = p_generoUsuario,
                    telefonoUsuario = p_telefonoUsuario,
                    correoUsuario = p_correoUsuario,
                    contrasenaUsuario = p_contrasenaUsuario,
                    rolUsuario = p_rolUsuario
				where 
					p_idUsuario = idUsuario ;
			
		end$$
	
DELIMITER ;
call sp_ActualizarUsuario(1,'Carlos', 'Méndez', '1995-05-20 00:00:00', 'MASCULINO', '45678912', 'carlos.mendez@gmail.com', 'claveSegura123', 'Empleado');
call sp_ListarUsuarios();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarUsuario(in p_idUsuario int)
		begin
			delete 
			from Usuarios
				where idUsuario  = p_idUsuario ;
		end$$
DELIMITER ;



-- CRUD DetalleUsuarios ---------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarDetalleUsuarios()
		begin
			select 
			idDetalleUsuario as ID,
			direccionUsuario as DIRECCION,
			puestoUsuario as PUESTO,
			salarioUsuario as SALARIO,
			idUsuario as USUARIO
			from DetalleUsuarios;
		end$$
DELIMITER ;
call sp_ListarDetalleUsuarios();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarDetalleUsuario(
			in p_direccionUsuario varchar(256),
			in p_puestoUsuario varchar(32),
			in p_salarioUsuario double ,
			in p_idUsuario int)
		begin
			insert into DetalleUsuarios(direccionUsuario, puestoUsuario, salarioUsuario, idUsuario)
				values(p_direccionUsuario, p_puestoUsuario, p_salarioUsuario,p_idUsuario);
		end$$
	
DELIMITER ;
call sp_AgregarDetalleUsuario('Zona 7 de capital', 'Administador',4200.00, 1);
call sp_ListarDetalleUsuarios();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarDetalleUsuario(
			in p_idDetalleUsuario int,
			in p_direccionUsuario varchar(256),
			in p_puestoUsuario varchar(32),
			in p_salarioUsuario double ,
			in p_idUsuario int)
		begin
			update DetalleUsuarios
				set
					direccionUsuario  = p_direccionUsuario,
					puestoUsuario = p_puestoUsuario ,
					salarioUsuario = p_salarioUsuario,
                    idUsuario = p_idUsuario
				where 
					p_idDetalleUsuario = idDetalleUsuario;
			
		end$$
	
DELIMITER ;
call sp_ActualizarDetalleUsuario(1,'Zona 8 de capital', 'Administador',4200.00, 1);
call sp_ListarDetalleUsuarios();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarDetalleUsuario(in p_idDetalleUsuario int)
		begin
			delete 
			from Usuarios
				where idDetalleUsuario = p_idDetalleUsuario;
		end$$
	
DELIMITER ;



-- CRUD COMPRAS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarCompras()
		begin
			select 
			idCompra   as ID,
			estadoCompra as ESTADO_COMPRA,
			estadoPago as ESTADO_PAGO,
            fechaCompra  as FECHA,
            idUsuario as USUARIO
			from Compras;
		end$$
	
DELIMITER ;
call sp_ListarCompras();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCompra(
			in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
			in p_estadoPago enum('Pendiente', 'Pagado'),
			in p_fechaCompra timestamp,
            in p_idUsuario int)
		begin
			insert into Compras(estadoCompra , estadoPago, fechaCompra, idUsuario)
				values(p_estadoCompra , p_estadoPago, p_fechaCompra , p_idUsuario);
		end$$
DELIMITER ;
call sp_AgregarCompra('Pendiente', 'Pendiente', current_timestamp(), 1);
call sp_ListarCompras();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCompra(
				in p_idCompra int,
				in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
				in p_estadoPago enum('Pendiente', 'Pagado'),
				in p_fechaCompra timestamp ,
				in p_idUsuario int)
		begin
			update Compras
				set
					estadoCompra = p_estadoCompra ,
					estadoPago = p_estadoPago,
                    fechaCompra = p_fechaCompra,
                    idUsuario = p_idUsuario
				where 
					p_idCompra = idCompra;
			
		end$$
DELIMITER ;
call sp_ActualizarCompra(1,'Pendiente', 'Pendiente', current_timestamp(), 1);
call sp_ListarCompras();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarCompra (in p_idCompra int)
		begin
			delete 
			from Compras
				where idCompra = p_idCompra;
		end$$
DELIMITER ;




-- CRUD PROVEEDORES -------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarProveedores()
		begin
			select 
			idProveedor  as ID,
			nombreProveedor  as PROVEEDOR,
			correoProveedor as CORREO,
			telefonoProveedor  as TELEFONO,
			direccionProveedor  as DIRECCION
			from Proveedores;
		end$$
	
DELIMITER ;
call sp_ListarProveedores();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarProveedor(
			in p_nombreProveedor varchar(128),
			in p_correoProveedor varchar(256), 
			in p_telefonoProveedor varchar(16),
			in p_direccionProveedor varchar(256))
		begin
			insert into Proveedores(nombreProveedor, correoProveedor , telefonoProveedor, direccionProveedor)
				values(p_nombreProveedor, p_correoProveedor, p_telefonoProveedor, p_direccionProveedor);
		end$$
        
DELIMITER ;
call sp_AgregarProveedor('Colgate','colgate@gmail.com', '12456789','Zona 7 Villa Nueva');
call sp_ListarProveedores();


-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarProveedor(
				in p_idProveedor int,
				in p_nombreProveedor varchar(128),
				in p_correoProveedor varchar(256), 
				in p_telefonoProveedor varchar(16),
				in p_direccionProveedor varchar(256))
		begin
			update Proveedores
				set
					nombreProveedor = p_nombreProveedor,
					correoProveedor = p_correoProveedor,
					telefonoProveedor = p_telefonoProveedor,
					direccionProveedor = p_direccionProveedor
				where 
					p_idProveedor = idProveedor;
			
		end$$
DELIMITER ;
call sp_ActualizarProveedor(1,'Colgate','colgate@gmail.com', '12456789','Zona 8 Villa Nueva');
call sp_ListarProveedores();


-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarProveedor(in p_idProveedor int)
		begin
			delete 
			from Proveedores
				where idProveedor = p_idProveedor;
		end$$
DELIMITER ;





-- CRUD CATEGORIAS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarCategorias()
		begin
			select 
			idCategoria as ID,
			nombreCategoria  as CATEGORIA,
			descripcionCategoria as DESCRIPCION
			from Categorias;
		end$$
	
DELIMITER ;
call sp_ListarCategorias();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCategoria(
			in p_nombreCategoria varchar(64),
			in p_descripcionCategoria varchar(256))
		begin
			insert into Categorias(nombreCategoria, descripcionCategoria)
				values(p_nombreCategoria, p_descripcionCategoria);
		end$$
DELIMITER ;
call sp_AgregarCategoria('Limpieza','Dedicado a la limpieza de los animalitos de tu hogar');
call sp_ListarCategorias();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCategoria(
				in p_idCategoria  int,
				in p_nombreCategoria varchar(64),
				in p_descripcionCategoria  varchar(256))
		begin
			update Categorias
				set
					nombreCategoria  = p_nombreCategoria ,
					descripcionCategoria = p_descripcionCategoria
				where 
					p_idCategoria = idCategoria ;
			
		end$$
DELIMITER ;
call sp_ActualizarCategoria(1,'Limpieza','Dedicado a la higiendo de tus animalitos');
call sp_ListarCategorias();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarCategoria(in p_idCategoria int)
		begin
			delete 
			from Categorias
				where idCategoria = p_idCategoria;
		end$$
DELIMITER ;






-- CRUD PRODUCTOS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarProductos()
		begin
			select 
			idProducto  as ID,
			nombreProducto as PRODUCTO,
			descripcionProducto  as DESCRIPCION,
            tallaProducto as TALLA,
            marcaProducto as MARCA,
            precioProducto as PRECIO,
            stockProducto as STOCK,
            fechaIngresoProducto as FECHA_INGRESO,
            fechaSalidaProducto as FECHA_SALIDA,
            idCategoria as CATEGORIA,
            idProveedor as PROVEEDOR
			from Productos;
		end$$
	
DELIMITER ;
call sp_ListarProductos();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarProducto(
			in p_nombreProducto varchar(128),
			in p_descripcionProducto varchar(256),
			in p_tallaProducto varchar(8),
			in p_marcaProducto varchar(64),
			in p_precioProducto double,
			in p_stockProducto int,
            in p_fechaIngresoProducto datetime,
			in p_fechaSalidaProducto date,
			in p_idCategoria int,
			in p_idProveedor int)
		begin
			insert into Productos(nombreProducto, descripcionProducto, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, fechaSalidaProducto,idCategoria, idProveedor )
				values(p_nombreProducto, p_descripcionProducto, p_tallaProducto, p_marcaProducto, p_precioProducto, p_stockProducto, p_fechaIngresoProducto, p_fechaSalidaProducto, p_idCategoria, p_idProveedor);
		end$$
DELIMITER ;
call sp_AgregarProducto('Zapatos', 'Calzado para su pie', '32', 'NIKE', 850, 40, '2006-12-08 12:00:00', '2006-12-07', 1, 1);
call sp_ListarProductos();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarProducto(
				in p_idProducto int,
				in p_nombreProducto varchar(128),
				in p_descripcionProducto varchar(256),
				in p_tallaProducto varchar(8),
				in p_marcaProducto varchar(64),
				in p_precioProducto double,
				in p_stockProducto int,
				in p_idCategoria int,
				in p_idProveedor int)
		begin
			update Productos
				set
					nombreProducto= p_nombreProducto  ,
					descripcionProducto  = p_descripcionProducto,
                    tallaProducto = p_tallaProducto,
                    marcaProducto =p_marcaProducto,
                    precioProducto = p_precioProducto,
                    stockProducto = p_stockProducto ,
                    idCategoria = p_idCategoria,
                    idProveedor= p_idProveedor
				where 
					p_idProducto = idProducto;
			
		end$$
DELIMITER ;
call sp_ActualizarProducto(1,'Zapatos', 'Calzado para su pie', '42', 'ADIDAS', 850, 40, 1, 1);
call sp_ListarProductos();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarProducto (in p_idProducto int)
		begin
			delete 
			from Productos
				where idProducto  = p_idProducto ;
		end$$
DELIMITER ;










-- CRUD PAGOS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarPagos()
		begin
			select 
			idPago    as ID,
			fechaPago  as FECHA,
			metodoPago  as METODO_PAGO,
            cantidadPago  as CANTIDAD,
            idCompra as COMPRA
			from Pagos;
		end$$
	
DELIMITER ;
call sp_ListarPagos();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarPago(
			in p_fechaPago datetime ,
			in p_metodoPago enum('Tarjeta'),
			in p_cantidadPago double ,
			in p_idCompra int )
		begin
			insert into Pagos(fechaPago, metodoPago, cantidadPago, idCompra)
				values(p_fechaPago, p_metodoPago, p_cantidadPago, p_idCompra);
		end$$
DELIMITER ;
call sp_AgregarPago('2025-09-21 20:30:00', 'Tarjeta', 500.00, 1);
call sp_ListarPagos();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarPago(
				in p_idPago int,
				in p_fechaPago datetime ,
				in p_metodoPago enum('Tarjeta'),
				in p_cantidadPago double ,
				in p_idCompra int )
		begin
			update Pagos
				set
					fechaPago  = p_fechaPago ,
					metodoPago = p_metodoPago,
                    cantidadPago = p_cantidadPago,
                    idCompra = p_idCompra
				where 
					p_idPago = idPago ;
			
		end$$
DELIMITER ;
call sp_ActualizarPago(1,'2025-10-21 20:30:00', 'Tarjeta', 500.00, 1);
call sp_ListarPagos();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarPago (in p_idPago int)
		begin
			delete 
			from Pagos
				where idPago = p_idPago ;
		end$$
DELIMITER ;





-- CRUD CARRITOS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarCarritos()
		begin
			select 
			idCompra as COMPRA,
			idProducto as PRODUCTO,
			cantidadProducto as CANTIDAD_PRODUCTO,
            subtotal as SUBTOTAL
			from Carritos;
		end$$
	
DELIMITER ;
call sp_ListarCarritos();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCarrito(
			in p_idCompra int,
			in p_idProducto int,
			in p_cantidadProducto int ,
			in p_subtotal double)
		begin
			insert into Carritos(idCompra, idProducto, cantidadProducto, subtotal)
				values(p_idCompra, p_idProducto, p_cantidadProducto, p_subtotal);
		end$$
DELIMITER ;
call sp_AgregarCarrito(1,1,35,999);
call sp_ListarCarritos();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCarrito(
				in p_idCompra int,
				in p_idProducto int,
				in p_cantidadProducto int ,
				in p_subtotal double)
		begin
			update Carritos
				set
					idCompra = p_idCompra ,
					idProducto = p_idProducto,
                    cantidadProducto = p_cantidadProducto,
                    subtotal = p_subtotal 
				where 
					p_idCompra = idCompra ;
			
		end$$
DELIMITER ;
call sp_ActualizarCarrito(1,1,35,654);
call sp_ListarCarritos();


-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarCarrito(in p_idCompra int)
		begin
			delete 
			from Carritos
				where idCompra = p_idCompra;
		end$$
DELIMITER ;





-- CRUD FACTURAS-------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarFacturas()
		begin
			select 
			idFactura as ID,
			fechaFactura as FECHA,
			total as TOTAL,
            metodoPago as METODO_PAGO,
            idCompra as COMPRA
			from Facturas;
		end$$
	
DELIMITER ;
call sp_ListarFacturas();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarFactura(
			in p_fechaFactura datetime ,
			in p_total double,
			in p_metodoPago enum('Tarjeta'),
            in p_idCompra int)
		begin
			insert into Facturas(fechaFactura, total, metodoPago, idCompra )
				values(p_fechaFactura, p_total, p_metodoPago, p_idCompra );
		end$$
DELIMITER ;
call sp_AgregarFactura('2025-09-21 20:30:00',2306,'Tarjeta',1);
call sp_ListarFacturas();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarFactura(
				in p_idFactura int,
				in p_fechaFactura datetime ,
				in p_total double,
				in p_metodoPago enum('Tarjeta'),
				in p_idCompra int)
		begin
			update Facturas
				set
					fechaFactura = p_fechaFactura,
					total = p_total,
                    metodoPago = p_metodoPago,
                    idCompra= p_idCompra
				where 
					p_idFactura = idFactura;
			
		end$$
DELIMITER ;
call sp_ActualizarFactura(1,'2025-09-21 20:30:00',210,'Tarjeta',1);
call sp_ListarFacturas();


-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarFactura(in p_idFactura int)
		begin
			delete 
			from Facturas
				where idFactura = p_idFactura;
		end$$
DELIMITER ;
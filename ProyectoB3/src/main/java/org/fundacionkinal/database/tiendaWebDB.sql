drop database if exists tiendaWebDB;
create database tiendaWebDB;
use tiendaWebDB;

create table Clientes(
	idCliente int auto_increment,
    correoCliente varchar(256) not null,
    contrasenaCliente varchar(256) not null,
    telefonoCliente varchar(32) not null,
    constraint pk_clientes primary key (idCliente)
);


create table Empleados(
	idEmpleado int auto_increment,
    nombreEmpleado varchar(128) not null,
    correoEmpleado varchar(256) not null,
    contrasenaEmpleado varchar(256) not null,
    tipoEmpleado ENUM('Administrador') default 'Administrador',
    constraint pk_empleados primary key (idEmpleado)
);

create table Proveedores(
	idProveedor int auto_increment,
    nombreProveedor varchar(128) not null,
    correoProveedor varchar(256) not null,
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
    idCategoria int,
	idProveedor int,
    constraint pk_productos primary key (idProducto),
    constraint fk_productos_categorias foreign key (idCategoria)
		references Categorias(idCategoria) on delete cascade,
    constraint fk_productos_proveedores foreign key (idProveedor)
		references Proveedores(idProveedor) on delete cascade
);

create table Compras(
	idCompra int auto_increment,
    estadoCompra enum('Pendiente','Completada','Cancelada') default 'Pendiente',
    estadoPago enum('Pendiente', 'Pagado')default'Pendiente',
    fechaCompra datetime default now(),
    idCliente int,
    constraint pk_compras primary key (idCompra),
    constraint fk_compras_clientes foreign key (idCliente) 
		references Clientes(idCliente) on delete cascade
);

create table Pagos(
	idPago int auto_increment,
    fechaPago datetime default now(),
	metodoPago enum('Tarjeta'),
	cantidadPago double not null,
    idCompra int not null,
    constraint pk_pagos primary key (idPago),
    constraint fk_pagos_compras foreign key (idCompra) 
		references Compras (idCompra) on delete cascade
);

create table Carrito( -- DetalleCompra 
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
    fechaFactura datetime default now(),
    total double not null,
    metodoPago enum('Tarjeta'),
    idCliente int not null,
    idCompra int not null,
    idPago int not null,
    constraint pk_facturas primary key (idFactura),

	constraint fk_facturas_clientes foreign key (idCliente)
		references Clientes(idCliente) on delete cascade,
	constraint fk_facturas_compras foreign key (idCompra)
		references Compras(idCompra) on delete cascade,
	constraint fk_facturas_pagos foreign key (idPago)
		references Pagos(idPago) on delete cascade
);


-- CRUD CLIENTES ---------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarClientes()
		begin
			select 
			idCliente as ID,
			correoCliente as CORREO_CLIENTE,
			contrasenaCliente as CONTRASEÑA,
			telefonoCliente as TELEFONO
			from Clientes;
		end$$
	
DELIMITER ;
call sp_ListarClientes();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCliente(
			in p_correoCliente varchar(256),
			in p_contrasenaCliente varchar(256), 
			in p_telefonoCliente varchar(32))
		begin
			insert into Clientes (correoCliente, contrasenaCliente, telefonoCliente)
				values(p_correoCliente, p_contrasenaCliente, p_telefonoCliente);
		end$$
	
DELIMITER ;
call sp_AgregarCliente('iossg8@gmail.com', '12345','30071148');
call sp_ListarClientes();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCliente(
			in p_idCliente int,
			in p_correoCliente varchar(256),
			in p_contrasenaCliente varchar(256), 
			in p_telefonoCliente varchar(32))
		begin
			update Clientes
				set
					correoCliente  = p_correoCliente,
					contrasenaCliente = p_contrasenaCliente ,
					telefonoCliente = p_telefonoCliente
				where 
					p_idCliente = idCliente;
			
		end$$
	
DELIMITER ;
call sp_ActualizarCliente(1,'iossg8@gmail.com', 'Mlgdi3301','30071148');
call sp_ListarClientes();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarCliente(in p_idCliente int)
		begin
			delete 
			from Clientes
				where idCliente = p_idClientes;
		end$$
	
DELIMITER ;






-- CRUD EMPLEADOS ---------------------------------------------------------------
-- LISTAR
DELIMITER $$
	create procedure sp_ListarEmpleados()
		begin
			select 
			idEmpleado as ID,
			nombreEmpleado  as EMPLEADO,
			correoEmpleado as CORREO,
			contrasenaEmpleado  as CONTRASEÑA,
			tipoEmpleado  as TIPO
			from Empleados;
		end$$
	
DELIMITER ;
call sp_ListarEmpleados();

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarEmpleado(
			in p_nombreEmpleado varchar(128),
			in p_correoEmpleado varchar(256), 
			in p_contrasenaEmpleado varchar(256),
			in p_tipoEmpleado ENUM('Administrador'))
		begin
			insert into Empleados(nombreEmpleado , correoEmpleado , contrasenaEmpleado, tipoEmpleado  )
				values(p_nombreEmpleado , p_correoEmpleado , p_contrasenaEmpleado, p_tipoEmpleado);
		end$$
	
DELIMITER ;
call sp_AgregarEmpleado('is','is', '1234','Administrador');
call sp_ListarEmpleados();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarEmpleado(
			in p_idEmpleado int,
			in p_nombreEmpleado varchar(128),
			in p_correoEmpleado varchar(256), 
			in p_contrasenaEmpleado varchar(256),
			in p_tipoEmpleado ENUM('Administrador'))
		begin
			update Empleados
				set
					nombreEmpleado = p_nombreEmpleado,
					correoEmpleado = p_correoEmpleado ,
					contrasenaEmpleado = p_contrasenaEmpleado,
					tipoEmpleado = p_tipoEmpleado 
				where 
					p_idEmpleado = idEmpleado ;
			
		end$$
	
DELIMITER ;
call sp_ActualizarEmpleado(1,'is','is', '124','Administrador');
call sp_ListarEmpleados();

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarEmpleado(in p_idEmpleado int)
		begin
			delete 
			from Empleados
				where idEmpleado  = p_idEmpleado ;
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
			in p_idCategoria int,
			in p_idProveedor int)
		begin
			insert into Productos(nombreProducto, descripcionProducto, tallaProducto, marcaProducto, precioProducto, stockProducto, idCategoria, idProveedor)
				values(p_nombreProducto, p_descripcionProducto, p_tallaProducto, p_marcaProducto, p_precioProducto, p_stockProducto, p_idCategoria, p_idProveedor);
		end$$
DELIMITER ;
call sp_AgregarProducto('Zapatos', 'Calzado para su pie', '32', 'NIKE', 850, 40, 1, 1);
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
call sp_ActualizarProducto(1,'Zapatos', 'Calzado para su pie', '32', 'ADIDAS', 850, 40, 1, 1);
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
            idCliente as CLIENTE
			from Compras;
		end$$
	
DELIMITER ;
call sp_ListarCompras();


-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCompra(
			in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
			in p_estadoPago enum('Pendiente', 'Pagado'),
			in p_fechaCompra datetime ,
			in p_idCliente int)
		begin
			insert into Compras(estadoCompra , estadoPago, fechaCompra, idCliente)
				values(p_estadoCompra , p_estadoPago, p_fechaCompra , p_idCliente);
		end$$
DELIMITER ;
call sp_AgregarCompra('Pendiente', 'Pendiente', '2025-07-21 20:30:00', 1);
call sp_ListarCompras();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCompra(
				in p_idCompra int,
				in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
				in p_estadoPago enum('Pendiente', 'Pagado'),
				in p_fechaCompra datetime ,
				in p_idCliente int)
		begin
			update Compras
				set
					estadoCompra = p_estadoCompra ,
					estadoPago = p_estadoPago,
                    fechaCompra = p_fechaCompra,
                    idCliente = p_idCliente
				where 
					p_idCompra = idCompra;
			
		end$$
DELIMITER ;
call sp_ActualizarCompra(1,'Pendiente', 'Pendiente', '2025-09-21 20:30:00', 1);
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
			from Carrito;
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
			insert into Carrito(idCompra, idProducto, cantidadProducto, subtotal)
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
			update Carrito
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
			from Carrito
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
            idCliente as CLIENTE,
            idCompra as COMPRA,
            idPago as PAGO
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
			in p_idCliente int,
            in p_idCompra int,
            in p_idPago int)
		begin
			insert into Facturas(fechaFactura, total, metodoPago, idCliente, idCompra, idPago)
				values(p_fechaFactura, p_total, p_metodoPago, p_idCliente, p_idCompra, p_idPago );
		end$$
DELIMITER ;
call sp_AgregarFactura('2025-09-21 20:30:00',2306,'Tarjeta',1,1,1);
call sp_ListarFacturas();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarFactura(
				in p_idFactura int,
				in p_fechaFactura datetime ,
				in p_total double,
				in p_metodoPago enum('Tarjeta'),
				in p_idCliente int,
				in p_idCompra int,
				in p_idPago int)
		begin
			update Facturas
				set
					fechaFactura = p_fechaFactura,
					total = p_total,
                    metodoPago = p_metodoPago,
                    idCliente = p_idCliente,
                    idCompra= p_idCompra,
                    idPago= p_idPago
				where 
					p_idFactura = idFactura;
			
		end$$
DELIMITER ;
call sp_ActualizarFactura(1,'2025-09-21 20:30:00',210,'Tarjeta',1,1,1);
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
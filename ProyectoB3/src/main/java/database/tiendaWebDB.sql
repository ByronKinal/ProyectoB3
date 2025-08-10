drop database if exists tiendaWebDB;
create database tiendaWebDB;
use tiendaWebDB;

create table Usuarios(
	idUsuario int auto_increment,
    nombreUsuario varchar(64),
    apellidoUsuario varchar(64),
    fechaNacimiento date,
    generoUsuario enum('MASCULINO','FEMENINO'),
    telefonoUsuario varchar(32),
    correoUsuario varchar(256) unique,
    contrasenaUsuario varchar(256),
    rolUsuario ENUM('Empleado','Cliente') default 'Cliente',
	estadoUsuario enum('ACTIVO','SUSPENDIDO') default 'ACTIVO',
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
    estadoProveedor enum('ACTIVO','SUSPENDIDO') default 'ACTIVO',
    constraint pk_proveedores primary key (idProveedor)
);

create table Categorias(
	idCategoria int auto_increment,
    nombreCategoriaTipo varchar(64) not null,
    nombreCategoriaGenero varchar(64) not null,
    descripcionCategoria varchar(256) not null,
    constraint pk_categorias primary key (idCategoria)
);

create table Productos(
	idProducto int auto_increment,
	nombreProducto varchar(128) not null,
	descripcionProducto varchar(256) not null,
    url_imagen varchar(255) not null,
    tallaProducto varchar(8),
    marcaProducto varchar(64) not null,
	precioProducto double not null,
	stockProducto int not null,
    fechaIngresoProducto timestamp,
    fechaSalidaProducto timestamp,
	estadoProdducto enum('ACTIVO','SUSPENDIDO') default 'ACTIVO',
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
    estadoPago enum('Pendiente', 'Pagado')default'Pendiente',
	metodoPago enum('Tarjeta'),
    idCompra int not null,
    constraint pk_pagos primary key (idPago),
    constraint fk_pagos_compras foreign key (idCompra) 
		references Compras (idCompra) on delete cascade
);

create table Carritos( -- DetalleCompra 
	idCompra int not null,
    idProducto int not null,
    cantidadProducto int not null,
    subtotal double,
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
			rolUsuario as ROL,
			estadoUsuario as ESTADO
			from Usuarios;
		end$$
	
DELIMITER ;

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarUsuario(
			in p_nombreUsuario varchar(64),
			in p_apellidoUsuario varchar(64),
			in p_fechaNacimiento date,
			in p_generoUsuario enum('MASCULINO','FEMENINO'),
			in p_telefonoUsuario varchar(32),
			in p_correoUsuario varchar(256) ,
			in p_contrasenaUsuario varchar(256),
			in p_rolUsuario ENUM('Empleado','Cliente'),
			in p_estadoUsuario enum('ACTIVO','SUSPENDIDO') )
		begin
			insert into Usuarios(nombreUsuario , apellidoUsuario , fechaNacimiento,  generoUsuario , telefonoUsuario, correoUsuario, contrasenaUsuario, rolUsuario, estadoUsuario)
				values(p_nombreUsuario , p_apellidoUsuario , p_fechaNacimiento, p_generoUsuario, p_telefonoUsuario, p_correoUsuario, p_contrasenaUsuario, p_rolUsuario, p_estadoUsuario);
		end$$
DELIMITER ;
call sp_AgregarUsuario('Lucía','Ramírez','2000-04-10','FEMENINO',  '3214567890','a','a','Cliente','ACTIVO');
call sp_AgregarUsuario('Jose','Alvarez','1990-09-12','MASCULINO',  '1234567891','s','s','Empleado','ACTIVO');

-- call sp_ListarUsuarios();

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarUsuario(
			in p_idUsuario int,
			in p_nombreUsuario varchar(64),
			in p_apellidoUsuario varchar(64),
			in p_fechaNacimiento date,
			in p_generoUsuario enum('MASCULINO','FEMENINO'),
			in p_telefonoUsuario varchar(32),
			in p_correoUsuario varchar(256) ,
			in p_contrasenaUsuario varchar(256),
			in p_rolUsuario ENUM('Empleado','Cliente'),
            in p_estadoUsuario enum('ACTIVO','SUSPENDIDO'))
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
                    rolUsuario = p_rolUsuario,
                    estadoUsuario = p_estadoUsuario
				where 
					p_idUsuario = idUsuario ;
			
		end$$
DELIMITER ;

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
            fechaCompra  as FECHA,
            idUsuario as USUARIO
			from Compras;
		end$$
DELIMITER ;

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCompra(
			in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
			in p_fechaCompra timestamp,
            in p_idUsuario int)
		begin
			insert into Compras(estadoCompra , fechaCompra, idUsuario)
				values(p_estadoCompra , p_fechaCompra , p_idUsuario);
		end$$
DELIMITER ;

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCompra(
				in p_idCompra int,
				in p_estadoCompra enum('Pendiente','Completada','Cancelada'),
				in p_fechaCompra timestamp ,
				in p_idUsuario int)
		begin
			update Compras
				set
					estadoCompra = p_estadoCompra ,
                    fechaCompra = p_fechaCompra,
                    idUsuario = p_idUsuario
				where 
					p_idCompra = idCompra;
			
		end$$
DELIMITER ;

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
			direccionProveedor  as DIRECCION,
            estadoProveedor as ESTADO
			from Proveedores;
		end$$
DELIMITER ;

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

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarProveedor(
				in p_idProveedor int,
				in p_nombreProveedor varchar(128),
				in p_correoProveedor varchar(256), 
				in p_telefonoProveedor varchar(16),
				in p_direccionProveedor varchar(256),
                in p_estadoProveedor varchar (32))
		begin
			update Proveedores
				set
					nombreProveedor = p_nombreProveedor,
					correoProveedor = p_correoProveedor,
					telefonoProveedor = p_telefonoProveedor,
					direccionProveedor = p_direccionProveedor,
                    estadoProveedor = p_estadoProveedor
				where 
					p_idProveedor = idProveedor;
			
		end$$
DELIMITER ;

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
			nombreCategoriaTipo  as CATEGORIATIPO,
			nombreCategoriaGenero  as CATEGORIAG,
			descripcionCategoria as DESCRIPCION
			from Categorias;
		end$$
	
DELIMITER ;

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCategoria(
            in p_nombreCategoriaTipo varchar(64),
			in p_nombreCategoriaGenero varchar(256),
			in p_descripcionCategoria varchar(256))
		begin
			insert into Categorias( nombreCategoriaTipo,nombreCategoriaGenero,descripcionCategoria)
			
				values(p_nombreCategoriaTipo,p_nombreCategoriaGenero, p_descripcionCategoria);
		end$$
DELIMITER ;

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarCategoria(
				in p_idCategoria  int,
            in p_nombreCategoriaTipo varchar(64),
			in p_nombreCategoriaGenero varchar(256),
			in p_descripcionCategoria varchar(256))
		begin
			update Categorias
				set
					nombreCategoriaGenero	=	p_nombreCategoriaGenero,
					descripcionCategoria = p_descripcionCategoria
				where 
					p_idCategoria = idCategoria ;
			
		end$$
DELIMITER ;

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
			url_imagen as IMAGEN,
            tallaProducto as TALLA,
            marcaProducto as MARCA,
            precioProducto as PRECIO,
            stockProducto as STOCK,
            fechaIngresoProducto as FECHA_INGRESO,
            fechaSalidaProducto as FECHA_SALIDA,
            estadoProducto as ESTADO,
            idCategoria as CATEGORIA,
            idProveedor as PROVEEDOR
			from Productos;
		end$$
	
DELIMITER ;

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarProducto(
			in p_nombreProducto varchar(128),
			in p_descripcionProducto varchar(256),
            in p_url_imagen varchar(255),
			in p_tallaProducto varchar(8),
			in p_marcaProducto varchar(64),
			in p_precioProducto double,
			in p_stockProducto int,
            in p_fechaIngresoProducto datetime,
			in p_fechaSalidaProducto date,
            in p_estadoProducto enum('ACTIVO','SUSPENDIDO'),
			in p_idCategoria int,
			in p_idProveedor int)
		begin
			insert into Productos(nombreProducto, descripcionProducto,url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, fechaSalidaProducto, estadoProducto, idCategoria, idProveedor )
				values(p_nombreProducto, p_descripcionProducto ,p_url_imagen, p_tallaProducto, p_marcaProducto, p_precioProducto, p_stockProducto, p_fechaIngresoProducto, p_fechaSalidaProducto, p_estadoProducto, p_idCategoria, p_idProveedor);
		end$$
DELIMITER ;

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarProducto(
				in p_idProducto int,
				in p_nombreProducto varchar(128),
				in p_descripcionProducto varchar(256),
				in p_url_imagen varchar(255),
				in p_tallaProducto varchar(8),
				in p_marcaProducto varchar(64),
				in p_precioProducto double,
				in p_stockProducto int,
				in p_estadoProducto enum('ACTIVO','SUSPENDIDO'),
				in p_idCategoria int,
				in p_idProveedor int)
		begin
			update Productos
				set
					nombreProducto= p_nombreProducto  ,
					descripcionProducto  = p_descripcionProducto,
                    url_imagen = p_url_imagen,
                    tallaProducto = p_tallaProducto,
                    marcaProducto =p_marcaProducto,
                    precioProducto = p_precioProducto,
                    stockProducto = p_stockProducto ,
                    estadoProducto =p_estadoProducto,
                    idCategoria = p_idCategoria,
                    idProveedor= p_idProveedor
				where 
					p_idProducto = idProducto;
		end$$
DELIMITER ;

-- ACTUALIZAR SALIDA PRODUCTO
DELIMITER $$
	create procedure sp_ActualizarProductoSalida(
				in p_id int,
				in p_salida timestamp,
                in p_estado varchar(16))
		begin
			update Productos
				set
					fechaSalidaProducto = p_Salida,
                    estadoProdducto =  p_estado
				where 
					p_id = idProducto;
		end$$
DELIMITER ;

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
            estadoPago as ESTADO_PAGO,
			metodoPago  as METODO_PAGO,
            idCompra as COMPRA
			from Pagos;
		end$$
	
DELIMITER ;

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarPago(
			in p_fechaPago datetime ,
			in p_metodoPago enum('Tarjeta'),
			in p_idCompra int )
		begin
			insert into Pagos(fechaPago, metodoPago, idCompra)
				values(p_fechaPago, p_metodoPago, p_idCompra);
		end$$
DELIMITER ;

-- ACTUALIZAR
DELIMITER $$
	create procedure sp_ActualizarPago(
				in p_idPago int,
				in p_fechaPago datetime ,
                in p_estadoPago enum('Pendiente', 'Pagado'),
				in p_metodoPago enum('Tarjeta'),
				in p_idCompra int )
		begin
			update Pagos
				set
					fechaPago  = p_fechaPago ,
                    estadoPago = p_estadoPago,
					metodoPago = p_metodoPago,
                    idCompra = p_idCompra
				where 
					p_idPago = idPago ;
			
		end$$
DELIMITER ;

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

-- AGREGAR
DELIMITER $$
	create procedure sp_AgregarCarrito(
			in p_idCompra int,
			in p_idProducto int,
			in p_cantidadProducto int)
		begin
			insert into Carritos(idCompra, idProducto, cantidadProducto)
				values(p_idCompra, p_idProducto, p_cantidadProducto);
		end$$
DELIMITER ;

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

-- ELIMINAR
DELIMITER $$
	create procedure sp_EliminarFactura(in p_idFactura int)
		begin
			delete 
			from Facturas
				where idFactura = p_idFactura;
		end$$
DELIMITER ;

-- ------------------------------------------------

-- Insertar categorías
DELIMITER $$
CREATE PROCEDURE sp_InsertarCategoriasIniciales()
BEGIN
    -- Categorías para Hombre
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('casual', 'Hombre', 'Calzado casual para hombre');
    
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('deportivo', 'Hombre', 'Calzado deportivo para hombre');
    
    -- Categorías para Mujer
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('casual', 'Mujer', 'Calzado casual para mujer');
    
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('deportivo', 'Mujer', 'Calzado deportivo para mujer');
    
    -- Categorías Unisex
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('casual', 'Unisex', 'Calzado casual unisex');
    
    INSERT INTO Categorias(nombreCategoriaTipo, nombreCategoriaGenero, descripcionCategoria) 
    VALUES ('deportivo', 'Unisex', 'Calzado deportivo unisex');
END$$
DELIMITER ;

-- Insertar proveedores
DELIMITER $$
CREATE PROCEDURE sp_InsertarProveedoresIniciales()
BEGIN
    -- Proveedores globales más famosos
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Nike', 'contacto@nike.com', '+15054123456', 'One Bowerman Drive, Beaverton, OR 97005, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Adidas', 'contacto@adidas.com', '+498132840', 'Adi-Dassler-Straße 1, 91074 Herzogenaurach, Germany');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Puma', 'contacto@puma.com', '+499132810', 'Puma Way 1, 91074 Herzogenaurach, Germany');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('New Balance', 'contacto@newbalance.com', '+18002532200', '100 Guest Street, Boston, MA 02135, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Reebok', 'contacto@reebok.com', '+18009322326', '25 Drydock Avenue, Boston, MA 02210, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Under Armour', 'contacto@underarmour.com', '+18777872768', '1020 Hull Street, Baltimore, MD 21230, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Skechers', 'contacto@skechers.com', '+18007534374', '228 Manhattan Beach Blvd, Manhattan Beach, CA 90266, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Vans', 'contacto@vans.com', '+18558382678', '555 Broadway, Costa Mesa, CA 92627, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Converse', 'contacto@converse.com', '+18004212126', '160 North Washington Street, Boston, MA 02114, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Timberland', 'contacto@timberland.com', '+18004455866', '200 Domain Drive, Stratham, NH 03885, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Dr. Martens', 'contacto@drmartens.com', '+442033601000', '28 Jamestown Road, Camden, London NW1 7BY, UK');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Clarks', 'contacto@clarks.com', '+441225447700', '40 High Street, Street, Somerset BA16 0EQ, UK');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Crocs', 'contacto@crocs.com', '+13036552767', '7477 East Dry Creek Parkway, Niwot, CO 80503, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('ASICS', 'contacto@asics.com', '+18002274271', '1720 Regal Row, Dallas, TX 75235, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Salomon', 'contacto@salomon.com', '+33450504050', '74996 Annecy Cedex 9, France');
END$$
DELIMITER ;

-- Insertar productos iniciales
DELIMITER $$
CREATE PROCEDURE sp_InsertarProductosIniciales()
BEGIN
    -- Obtener IDs de categorías
    DECLARE cat_hombre_casual INT;
    DECLARE cat_hombre_deportivo INT;
    DECLARE cat_mujer_casual INT;
    DECLARE cat_mujer_deportivo INT;
    DECLARE cat_unisex_casual INT;
    DECLARE cat_unisex_deportivo INT;
    
    -- Obtener IDs de proveedores
    DECLARE prov_nike INT;
    DECLARE prov_adidas INT;
    DECLARE prov_puma INT;
    DECLARE prov_newbalance INT;
    DECLARE prov_reebok INT;
    DECLARE prov_underarmour INT;
    DECLARE prov_skechers INT;
    DECLARE prov_vans INT;
    DECLARE prov_converse INT;
    DECLARE prov_timberland INT;
    DECLARE prov_drmartens INT;
    DECLARE prov_clarks INT;
    DECLARE prov_crocs INT;
    DECLARE prov_asics INT;
    DECLARE prov_salomon INT;
    
    -- Obtener categorías
    SELECT idCategoria INTO cat_hombre_casual FROM Categorias 
    WHERE nombreCategoriaTipo = 'casual' AND nombreCategoriaGenero = 'Hombre' LIMIT 1;
    
    SELECT idCategoria INTO cat_hombre_deportivo FROM Categorias 
    WHERE nombreCategoriaTipo = 'deportivo' AND nombreCategoriaGenero = 'Hombre' LIMIT 1;
    
    SELECT idCategoria INTO cat_mujer_casual FROM Categorias 
    WHERE nombreCategoriaTipo = 'casual' AND nombreCategoriaGenero = 'Mujer' LIMIT 1;
    
    SELECT idCategoria INTO cat_mujer_deportivo FROM Categorias 
    WHERE nombreCategoriaTipo = 'deportivo' AND nombreCategoriaGenero = 'Mujer' LIMIT 1;
    
    SELECT idCategoria INTO cat_unisex_casual FROM Categorias 
    WHERE nombreCategoriaTipo = 'casual' AND nombreCategoriaGenero = 'Unisex' LIMIT 1;
    
    SELECT idCategoria INTO cat_unisex_deportivo FROM Categorias 
    WHERE nombreCategoriaTipo = 'deportivo' AND nombreCategoriaGenero = 'Unisex' LIMIT 1;
    
    -- Obtener proveedores
    SELECT idProveedor INTO prov_nike FROM Proveedores WHERE nombreProveedor = 'Nike' LIMIT 1;
    SELECT idProveedor INTO prov_adidas FROM Proveedores WHERE nombreProveedor = 'Adidas' LIMIT 1;
    SELECT idProveedor INTO prov_puma FROM Proveedores WHERE nombreProveedor = 'Puma' LIMIT 1;
    SELECT idProveedor INTO prov_newbalance FROM Proveedores WHERE nombreProveedor = 'New Balance' LIMIT 1;
    SELECT idProveedor INTO prov_reebok FROM Proveedores WHERE nombreProveedor = 'Reebok' LIMIT 1;
    SELECT idProveedor INTO prov_underarmour FROM Proveedores WHERE nombreProveedor = 'Under Armour' LIMIT 1;
    SELECT idProveedor INTO prov_skechers FROM Proveedores WHERE nombreProveedor = 'Skechers' LIMIT 1;
    SELECT idProveedor INTO prov_vans FROM Proveedores WHERE nombreProveedor = 'Vans' LIMIT 1;
    SELECT idProveedor INTO prov_converse FROM Proveedores WHERE nombreProveedor = 'Converse' LIMIT 1;
    SELECT idProveedor INTO prov_timberland FROM Proveedores WHERE nombreProveedor = 'Timberland' LIMIT 1;
    SELECT idProveedor INTO prov_drmartens FROM Proveedores WHERE nombreProveedor = 'Dr. Martens' LIMIT 1;
    SELECT idProveedor INTO prov_clarks FROM Proveedores WHERE nombreProveedor = 'Clarks' LIMIT 1;
    SELECT idProveedor INTO prov_crocs FROM Proveedores WHERE nombreProveedor = 'Crocs' LIMIT 1;
    SELECT idProveedor INTO prov_asics FROM Proveedores WHERE nombreProveedor = 'ASICS' LIMIT 1;
    SELECT idProveedor INTO prov_salomon FROM Proveedores WHERE nombreProveedor = 'Salomon' LIMIT 1;
    
        -- Insertar productos Nike (10 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES 
    ('Air Jordan 1 Retro High OG', 'Zapatillas clásicas de baloncesto', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/5e7687f1-c13e-4bac-8ffa-a6f863ae9157/NIKE+DUNK+HI+RETRO.png', '42', 'Nike', 1400.00, 20, NOW(), cat_hombre_casual, prov_nike),
    ('Nike Air Force 1 ''07', 'Zapatillas urbanas icónicas', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/AIR+FORCE+1+%2707.png', '41', 'Nike', 850.00, 20, NOW(), cat_hombre_casual, prov_nike),
    ('Nike Dunk Low Retro', 'Zapatillas skate clásicas', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9ce2cbad-9509-4c80-ade5-89228743a459/dunk-low-retro-shoes-l5qCQT.png', '40', 'Nike', 930.00, 20, NOW(), cat_hombre_casual, prov_nike),
    ('Nike Air Max 90', 'Zapatillas con tecnología Air Max', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/319a45b8-cd48-4457-a109-6d8bd11067b2/air-max-90-gtx-shoes-zq6Lwr.png', '43', 'Nike', 1010.00, 20, NOW(), cat_hombre_deportivo, prov_nike),
    ('Nike React Infinity Run Flyknit', 'Zapatillas running para larga distancia', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/45544e10-1e4c-437d-8340-dc4e9a9fbead/react-infinity-run-flyknit-3-road-running-shoes-sqDvTF.png', '44', 'Nike', 1240.00, 20, NOW(), cat_hombre_deportivo, prov_nike),
    ('Nike Air Zoom Pegasus 39', 'Zapatillas running versátiles', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/74babf4d-2a86-482f-b72d-c24108738c52/NIKE+DOWNSHIFTER+13+WIDE.png', '42', 'Nike', 970.00, 20, NOW(), cat_hombre_deportivo, prov_nike),
    ('Nike Air Max 270', 'Zapatillas con máxima amortiguación', 'https://th.bing.com/th/id/R.fcb40717db7b8c6d3e2f3dcb70c3c212?rik=AkILmWUHVuOetA&pid=ImgRaw&r=0', '41', 'Nike', 1240.00, 20, NOW(), cat_hombre_deportivo, prov_nike),
    ('Nike Blazer Mid ''77 Vintage', 'Zapatillas retro de baloncesto', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/cff8f233-33f6-4836-a0ed-0baf153701a5/blazer-mid-77-vintage-zapatillas-4LTRzh.jpg', '39', 'Nike', 780.00, 20, NOW(), cat_mujer_casual, prov_nike),
    ('Nike Air VaporMax 2023 Flyknit', 'Zapatillas con tecnología VaporMax', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/877d30e7-4880-46f8-aa71-6704eb7d944d/AIR+MAX+PLUS.png', '38', 'Nike', 1550.00, 20, NOW(), cat_mujer_deportivo, prov_nike),
    ('Nike Free RN 5.0', 'Zapatillas para entrenamiento natural', 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/3b27eb2b-da90-4a12-bb43-a093ca26b4a3/NIKE+FREE+RN+5.0+NEXT+NATURE.png', '37', 'Nike', 850.00, 20, NOW(), cat_mujer_deportivo, prov_nike);

    -- Insertar productos Adidas (10 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Adidas Ultraboost 22', 'Zapatillas running con Boost', 'https://adidasgt.vtexassets.com/arquivos/ids/170079-800-800?v=638670386719330000&width=800&height=800&aspect=true', '42', 'Adidas', 1350.00, 20, NOW(), cat_hombre_deportivo, prov_adidas),
    ('Adidas NMD_R1', 'Zapatillas urbanas con Boost', 'https://adidasgt.vtexassets.com/arquivos/ids/170095-800-800?v=638670386755370000&width=800&height=800&aspect=true', '41', 'Adidas', 1100.00, 20, NOW(), cat_hombre_casual, prov_adidas),
    ('Adidas Superstar', 'Zapatillas clásicas con puntera de goma', 'https://adidasgt.vtexassets.com/arquivos/ids/260447-800-800?v=638784575612000000&width=800&height=800&aspect=true', '40', 'Adidas', 750.00, 20, NOW(), cat_hombre_casual, prov_adidas),
    ('Adidas Stan Smith', 'Zapatillas clásicas de cuero', 'https://adidasgt.vtexassets.com/arquivos/ids/191038-800-800?v=638736291577170000&width=800&height=800&aspect=true', '39', 'Adidas', 680.00, 20, NOW(), cat_mujer_casual, prov_adidas),
    ('Adidas Gazelle', 'Zapatillas retro de los 90s', 'https://adidasgt.vtexassets.com/arquivos/ids/420091-800-800?v=638888817030130000&width=800&height=800&aspect=true', '38', 'Adidas', 720.00, 20, NOW(), cat_mujer_casual, prov_adidas),
    ('Adidas Solarboost 4', 'Zapatillas running de alto rendimiento', 'https://adidasgt.vtexassets.com/arquivos/ids/170669-800-800?v=638670388178200000&width=800&height=800&aspect=true', '43', 'Adidas', 1250.00, 20, NOW(), cat_hombre_deportivo, prov_adidas),
    ('Adidas Forum Low', 'Zapatillas retro de baloncesto', 'https://adidasgt.vtexassets.com/arquivos/ids/256315-800-800?v=638781076522770000&width=800&height=800&aspect=true', '42', 'Adidas', 850.00, 20, NOW(), cat_hombre_casual, prov_adidas),
    ('Adidas Dropset 3', 'Zapatillas con estilo futurista', 'https://adidasgt.vtexassets.com/arquivos/ids/189142-800-800?v=638736283630100000&width=800&height=800&aspect=true', '41', 'Adidas', 950.00, 20, NOW(), cat_hombre_casual, prov_adidas),
    ('Adidas Adizero Adios Pro 3', 'Zapatillas para competición', 'https://adidasgt.vtexassets.com/arquivos/ids/436594-800-800?v=638896658010830000&width=800&height=800&aspect=true', '44', 'Adidas', 1800.00, 20, NOW(), cat_hombre_deportivo, prov_adidas),
    ('Adidas Duramo SL', 'Zapatillas running para entrenamiento', 'https://adidasgt.vtexassets.com/arquivos/ids/411485-800-800?v=638887369087170000&width=800&height=800&aspect=true', '42', 'Adidas', 650.00, 20, NOW(), cat_hombre_deportivo, prov_adidas);

    -- Insertar productos Puma (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Puma RS-X', 'Zapatillas con estilo retro-futurista', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/402373/01/sv01/fnd/PNA/fmt/png/Tenis-PUMA-x-TORTUGAS-NINJA-RS-X', '42', 'Puma', 850.00, 20, NOW(), cat_hombre_casual, prov_puma),
    ('Puma Suede Classic', 'Zapatillas clásicas de skate', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/399781/03/sv01/fnd/PNA/fmt/png/Tenis-Suede-Classic', '41', 'Puma', 600.00, 20, NOW(), cat_hombre_casual, prov_puma),
    ('Puma Deviate Nitro', 'Zapatillas running con tecnología Nitro', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/309809/08/sv01/fnd/PNA/fmt/png/Tenis-de-running-para-hombre-Deviate-NITRO-Elite-3', '43', 'Puma', 1100.00, 20, NOW(), cat_hombre_deportivo, prov_puma),
    ('Puma Cali Sport', 'Zapatillas deportivas para mujer', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/394384/01/sv01/fnd/PNA/fmt/png/Tenis-para-j%C3%B3venes-PUMA-Cali-Court-de-cuero', '38', 'Puma', 750.00, 20, NOW(), cat_mujer_deportivo, prov_puma),
    ('Puma Future Rider', 'Zapatillas con estilo retro', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/405728/01/sv01/fnd/PNA/fmt/png/Style-Rider-Lumi-Women', '40', 'Puma', 700.00, 20, NOW(), cat_mujer_casual, prov_puma);

    -- Insertar productos New Balance (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('New Balance 574', 'Zapatillas clásicas de running', 'https://newbalance.com.gt/cdn/shop/files/WL574YA1-1_p9hsib.jpg?v=1730435193&width=713', '42', 'New Balance', 750.00, 20, NOW(), cat_hombre_casual, prov_newbalance),
    ('New Balance 990v5', 'Zapatillas premium made in USA', 'https://newbalance.com.gt/cdn/shop/files/U990NC6-1_wl0381.jpg?v=1724350107&width=713', '43', 'New Balance', 1500.00, 20, NOW(), cat_hombre_casual, prov_newbalance),
    ('New Balance FuelCell Rebel v3', 'Zapatillas running ligeras', 'https://newbalance.com.gt/cdn/shop/files/MRCXLB4-1_ycncux.jpg?v=1731690279&width=713', '44', 'New Balance', 1200.00, 20, NOW(), cat_hombre_deportivo, prov_newbalance),
    ('New Balance 327', 'Zapatillas con estilo retro', 'https://newbalance.com.gt/cdn/shop/files/WS327GD-1_voneby.jpg?v=1721160485&width=713', '39', 'New Balance', 850.00, 20, NOW(), cat_mujer_casual, prov_newbalance),
    ('New Balance Fresh Foam X 1080v12', 'Zapatillas running con máxima amortiguación', 'https://newbalance.com.gt/cdn/shop/files/M1080B13-1_9lr0in_961b5fbf-4dda-4a92-b575-fca39c26c22d.jpg?v=1721250989&width=713', '42', 'New Balance', 1300.00, 20, NOW(), cat_hombre_deportivo, prov_newbalance);

   /* -- Insertar productos Reebok (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Reebok Classic Leather', 'Zapatillas clásicas de cuero', '', '42', 'Reebok', 650.00, 20, NOW(), cat_hombre_casual, prov_reebok),
    ('Reebok Nano X2', 'Zapatillas para cross training', '', '43', 'Reebok', 1100.00, 20, NOW(), cat_hombre_deportivo, prov_reebok),
    ('Reebok Club C 85', 'Zapatillas retro de tenis', '', '41', 'Reebok', 700.00, 20, NOW(), cat_hombre_casual, prov_reebok),
    ('Reebok Floatride Energy 4', 'Zapatillas running ligeras', '', '44', 'Reebok', 950.00, 20, NOW(), cat_hombre_deportivo, prov_reebok),
    ('Reebok Princess', 'Zapatillas clásicas para mujer', '', '37', 'Reebok', 550.00, 20, NOW(), cat_mujer_casual, prov_reebok);

    -- Insertar productos Under Armour (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Under Armour HOVR Phantom 3', 'Zapatillas running con tecnología HOVR', '', '42', 'Under Armour', 1200.00, 20, NOW(), cat_hombre_deportivo, prov_underarmour),
    ('Under Armour Charged Assert 9', 'Zapatillas running de entrada', '', '43', 'Under Armour', 750.00, 20, NOW(), cat_hombre_deportivo, prov_underarmour),
    ('Under Armour Project Rock 5', 'Zapatillas para entrenamiento', '', '44', 'Under Armour', 1400.00, 20, NOW(), cat_hombre_deportivo, prov_underarmour),
    ('Under Armour Curry Flow 10', 'Zapatillas de baloncesto signature', '', '45', 'Under Armour', 1600.00, 20, NOW(), cat_hombre_deportivo, prov_underarmour),
    ('Under Armour Slingflex', 'Zapatillas running para mujer', '', '38', 'Under Armour', 900.00, 20, NOW(), cat_mujer_deportivo, prov_underarmour);

    -- Insertar productos Vans (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Vans Old Skool', 'Zapatillas skate clásicas', '', '42', 'Vans', 550.00, 20, NOW(), cat_unisex_casual, prov_vans),
    ('Vans Sk8-Hi', 'Zapatillas skate tobilleras', '', '41', 'Vans', 600.00, 20, NOW(), cat_unisex_casual, prov_vans),
    ('Vans Authentic', 'Zapatillas skate minimalistas', '', '40', 'Vans', 500.00, 20, NOW(), cat_unisex_casual, prov_vans),
    ('Vans Ultrarange', 'Zapatillas para skate y running', '', '43', 'Vans', 850.00, 20, NOW(), cat_unisex_deportivo, prov_vans),
    ('Vans Slip-On', 'Zapatillas sin cordones', '', '39', 'Vans', 520.00, 20, NOW(), cat_unisex_casual, prov_vans);

    -- Insertar productos Converse (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Converse Chuck Taylor All Star', 'Zapatillas clásicas de lona', '', '42', 'Converse', 450.00, 20, NOW(), cat_unisex_casual, prov_converse),
    ('Converse Chuck 70', 'Versión premium de las All Star', '', '41', 'Converse', 600.00, 20, NOW(), cat_unisex_casual, prov_converse),
    ('Converse One Star', 'Zapatillas con estilo vintage', '', '40', 'Converse', 650.00, 20, NOW(), cat_hombre_casual, prov_converse),
    ('Converse Run Star Motion', 'Zapatillas con plataforma', '', '38', 'Converse', 750.00, 20, NOW(), cat_mujer_casual, prov_converse),
    ('Converse Jack Purcell', 'Zapatillas con puntera sonriente', '', '39', 'Converse', 550.00, 20, NOW(), cat_unisex_casual, prov_converse);

    -- Insertar productos Timberland (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Timberland Premium 6" Boot', 'Botas clásicas de trabajo', '', '42', 'Timberland', 1200.00, 20, NOW(), cat_hombre_casual, prov_timberland),
    ('Timberland Euro Hiker', 'Botas de senderismo', '', '43', 'Timberland', 1100.00, 20, NOW(), cat_hombre_deportivo, prov_timberland),
    ('Timberland Killington Chukka', 'Botines casuales', '', '41', 'Timberland', 950.00, 20, NOW(), cat_hombre_casual, prov_timberland),
    ('Timberland Nellie Double', 'Botas para mujer', '', '37', 'Timberland', 1000.00, 20, NOW(), cat_mujer_casual, prov_timberland),
    ('Timberland White Ledge', 'Botas de senderismo ligeras', '', '44', 'Timberland', 900.00, 20, NOW(), cat_hombre_deportivo, prov_timberland);

    -- Insertar productos Dr. Martens (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Dr. Martens 1460', 'Botas clásicas de 8 ojales', '', '42', 'Dr. Martens', 1300.00, 20, NOW(), cat_hombre_casual, prov_drmartens),
    ('Dr. Martens 2976 Chelsea', 'Botas tipo Chelsea', '', '41', 'Dr. Martens', 1250.00, 20, NOW(), cat_hombre_casual, prov_drmartens),
    ('Dr. Martens Jadon', 'Botas con plataforma', '', '39', 'Dr. Martens', 1400.00, 20, NOW(), cat_mujer_casual, prov_drmartens),
    ('Dr. Martens 1461', 'Zapatos Oxford de 3 ojales', '', '43', 'Dr. Martens', 1200.00, 20, NOW(), cat_hombre_casual, prov_drmartens),
    ('Dr. Martens Sinclair', 'Botas con cremallera lateral', '', '38', 'Dr. Martens', 1500.00, 20, NOW(), cat_mujer_casual, prov_drmartens);

    -- Insertar productos Crocs (5 productos) - Precios en GTQ
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES
    ('Crocs Classic Clog', 'Zuecos clásicos de material Croslite', '', '42', 'Crocs', 350.00, 20, NOW(), cat_unisex_casual, prov_crocs),
    ('Crocs LiteRide 360', 'Zapatillas cómodas y ligeras', '', '43', 'Crocs', 450.00, 20, NOW(), cat_unisex_deportivo, prov_crocs),
    ('Crocs Bistro Pro', 'Zuecos para trabajo con suela antideslizante', '', '44', 'Crocs', 400.00, 20, NOW(), cat_hombre_casual, prov_crocs),
    ('Crocs Swiftwater', 'Sandalias para agua', '', '41', 'Crocs', 380.00, 20, NOW(), cat_unisex_casual, prov_crocs),
    ('Crocs Brooklyn', 'Zapatillas estilo sneaker', '', '42', 'Crocs', 500.00, 20, NOW(), cat_hombre_casual, prov_crocs);*/
END$$
DELIMITER ;

-- Ejecutar los procedimientos para insertar datos iniciales
CALL sp_InsertarCategoriasIniciales();
CALL sp_InsertarProveedoresIniciales();
CALL sp_InsertarProductosIniciales();


-- Obtener todos los productos para menú principal
DELIMITER $$
CREATE PROCEDURE sp_ObtenerProductosParaMenuPrincipal()
BEGIN
    SELECT 
        p.idProducto,
        p.nombreProducto,
        p.descripcionProducto,
        p.url_imagen,
        p.precioProducto,
        c.nombreCategoriaGenero AS genero
    FROM Productos p
    JOIN Categorias c ON p.idCategoria = c.idCategoria
    ORDER BY p.nombreProducto;
END$$
DELIMITER ;

-- Obtener productos para menú administrativo
DELIMITER $$
CREATE PROCEDURE sp_ObtenerProductosParaMenuAdministrativo()
BEGIN
    SELECT 
        p.idProducto,
        p.nombreProducto,
        p.descripcionProducto,
        p.url_imagen,
        p.precioProducto,
        p.stockProducto,
        c.nombreCategoriaGenero AS genero,
        c.nombreCategoriaTipo AS tipo,
        pr.nombreProveedor
    FROM Productos p
    JOIN Categorias c ON p.idCategoria = c.idCategoria
    JOIN Proveedores pr ON p.idProveedor = pr.idProveedor
    ORDER BY p.nombreProducto;
END$$
DELIMITER ;



-- ------------------------------------- TRIGGERS -----------------------------------------
-- ROGER VALLADARES

-- Agregar Subtotal
delimiter $$
	create trigger tr_CalcularSubtotal_Before_Insert
	before insert
	on carritos
	for each row
	begin
		declare v_precio double;
		select precioProducto into v_precio
		from productos
		where idProducto = new.idProducto;
		set new.subtotal = new.cantidadProducto * v_precio;
	end $$
delimiter ;

-- Actualización Stock
delimiter $$
	create trigger tr_RestarStock_After_Insert
    after insert
    on carritos
    for each row
		begin
			declare stock int;
            select P.stockProducto into stock
            from Productos P where P.idProducto = new.idProducto;
			if (new.cantidadProducto > stock) then
				signal sqlstate '45000'
                set message_text = 'No hay suficientes productos';
            else
				update Productos P
					set P.stockProducto = stock - new.cantidadProducto
					where P.idProducto = new.idProducto;
			end if;
        end $$
delimiter ;

-- Devolver Stock 
delimiter $$
	create trigger tr_sumarstock_after_update
	after update on compras
	for each row
		begin
			declare done int default false;
			declare v_idproducto int;
			declare v_cantidadproducto int;
			declare cur cursor for
				select idproducto, cantidadproducto
				from carritos
				where idcompra = new.idcompra;
			declare continue handler for not found set done = true;
            
			if new.estadocompra = 'Cancelada' then
				open cur;
				read_loop: loop
					fetch cur into v_idproducto, v_cantidadproducto;
					if done then
						leave read_loop;
					end if;
					update productos
					set stockproducto = stockproducto + v_cantidadproducto
					where idproducto = v_idproducto;
				end loop;
				close cur;
			end if;
		end$$
delimiter ;

-- Cambiar Fecha de Ingreso
delimiter $$
	create trigger tr_CambioFechaIngreso_Before_Update
	before update
	on productos
	for each row
		begin
			if old.stockProducto != new.stockProducto then
				set new.fechaIngresoProducto = now();
			end if;
		end $$
delimiter ;

-- Cuando se complete un pago Completar una compra
delimiter $$
	create trigger tr_actualizarEstadoCompra_After_Insert
	after insert 
	on pagos
	for each row
	begin
		if new.estadoPago = 'Pagado' then
			update compras
			set estadoCompra = 'Completada'
			where idCompra = new.idCompra;
		end if;
	end $$
delimiter ;

-- Actualizar la fecha de salida
delimiter $$
	create trigger tr_actualizarFechaSalida_Before_Update
	before update on productos
	for each row
	begin
		if new.stockProducto = 0 and old.fechaSalidaProducto is null then
			set new.fechaSalidaProducto = now();
		end if;
	end $$
delimiter ;

-- Generacion de Factura
delimiter $$
	create trigger tr_crear_factura_after_pago
	after insert on pagos
	for each row
	begin
		declare v_total double;
		if (new.estadoPago = 'Pagado') then
			select sum(subtotal) into v_total
			from carritos
			where idCompra = new.idCompra;
			call sp_AgregarFactura(now(), v_total, new.metodoPago, new.idCompra);
		end if;
	end $$
delimiter ;
/*
call sp_ListarCompras();
call sp_ListarCarritos();
call sp_ListarUsuarios();
*/
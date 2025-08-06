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
call sp_ListarUsuarios();

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
call sp_AgregarCompra('Pendiente', current_timestamp(), 1);

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
 call sp_AgregarPago('2025-09-21 20:30:00', 'Tarjeta', 1);

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
call sp_AgregarFactura('2025-09-21 20:30:00',2306,'Tarjeta',1);

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
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Nike', 'contacto@nike.com', '1234567890', 'Oregon, USA');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Adidas', 'contacto@adidas.com', '0987654321', 'Herzogenaurach, Alemania');
    
    INSERT INTO Proveedores(nombreProveedor, correoProveedor, telefonoProveedor, direccionProveedor)
    VALUES ('Puma', 'contacto@puma.com', '1122334455', 'Herzogenaurach, Alemania');
END$$
DELIMITER ;

-- Insertar productos iniciales
DELIMITER $$
CREATE PROCEDURE sp_InsertarProductosIniciales()
BEGIN
    -- Obtener IDs de categorías y proveedores
    DECLARE cat_hombre_casual INT;
    DECLARE cat_hombre_deportivo INT;
    DECLARE cat_mujer_casual INT;
    DECLARE cat_mujer_deportivo INT;
    DECLARE cat_unisex_casual INT;
    DECLARE cat_unisex_deportivo INT;
    
    DECLARE prov_nike INT;
    DECLARE prov_adidas INT;
    DECLARE prov_puma INT;
    
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
    
    SELECT idProveedor INTO prov_nike FROM Proveedores WHERE nombreProveedor = 'Nike' LIMIT 1;
    SELECT idProveedor INTO prov_adidas FROM Proveedores WHERE nombreProveedor = 'Adidas' LIMIT 1;
    SELECT idProveedor INTO prov_puma FROM Proveedores WHERE nombreProveedor = 'Puma' LIMIT 1;
    
    -- Insertar productos
    -- Producto 1
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Handball Spezial', 'Tenis de running Supernova Rise 2', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/1fa18f47b66e4f4980ba74d48de04ecc_9366/Handball_Spezial_Shoes_Blue_IF7087_01_standard.jpg', '42', 'Adidas', 1325.00, 50, NOW(), cat_hombre_deportivo, prov_adidas);
    
    -- Producto 2
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Campus 00s', 'Tenis Supernova Rise 2 Running', 'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/4659ee058ba34bd2a5d0af500104c17d_9366/Campus_00s_Shoes_Black_HQ8708_01_standard.jpg', '40', 'Adidas', 1340.00, 45, NOW(), cat_hombre_casual, prov_adidas);
    
    -- Producto 3
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Air Jordan 4 Retro', 'Tenis Supernova Ease', 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/540653a2-a2aa-4e3a-8c33-6451f258946c/AIR+JORDAN+4+RETRO.png', '41', 'Nike', 960.00, 60, NOW(), cat_hombre_casual, prov_nike);
    
    -- Continuar con los demás productos...
    -- Producto 4
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Air Force 1', 'Tenis Supernova Ease', 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/4f37fca8-6bce-43e7-ad07-f57ae3c13142/AIR+FORCE+1+%2707.png', '39', 'Nike', 960.00, 55, NOW(), cat_hombre_casual, prov_nike);
    
    -- Producto 5
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Nike Dunk Low Retro', 'Supernova Rise 2 W', 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0f76f73e-2578-4d62-abab-c5563ea4f78c/NIKE+DUNK+LOW+RETRO.png', '38', 'Nike', 1340.00, 40, NOW(), cat_mujer_casual, prov_nike);
    
    -- Producto 6
    INSERT INTO Productos(nombreProducto, descripcionProducto, url_imagen, tallaProducto, marcaProducto, precioProducto, stockProducto, fechaIngresoProducto, idCategoria, idProveedor)
    VALUES ('Nike Ava Rover', 'Tenis Supernova Surge', 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/fe01cb61-0753-4143-accd-b7c654600021/NIKE+AVA+ROVER.png', '37', 'Nike', 1055.00, 65, NOW(), cat_mujer_deportivo, prov_nike);
    
    -- Continuar con el resto de productos...
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


CALL sp_AgregarProveedor('Nike', '@nike.com', '+50212345678', 'Av. Reforma 123, Ciudad de Guatemala');
CALL sp_AgregarProveedor('Timberland', 'info@timberland.com', '+50223456789', 'Calle Principal 456, Zona 10');
CALL sp_AgregarProveedor('Crocs', 'ventas@crocs.com', '+50234567890', 'Boulevard Los Próceres 789, Zona 14');
CALL sp_AgregarProveedor('Clarks', 'soporte@clarks.com', '+50245678901', '5ta Avenida 101, Mixco');



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

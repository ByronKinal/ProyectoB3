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
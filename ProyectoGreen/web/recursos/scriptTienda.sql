create database tienda;
use tienda;
//tenerlo disponible cuando lo necesitemos 

create table persona(
    identificacion varchar(12) not null primary key unique,
    nombres varchar(50) not null,
    apellidos varchar(50) not null,
    genero char not null,
    telefono varchar(12),
    email varchar(80),
    tipo char not null,
    clave varchar(32)
);

create table categoria(
    id int not null primary key auto_increment,
    nombre varchar (50) not null,
    descripcion text 
);

create table medioDePago(
    id int not null primary key auto_increment,
    nombre varchar(50) not null,
    descripcion text 
);

create table producto(
    id int not null primary key auto_increment,
    codigoDeBarras varchar(14),
    nombre varchar(50)  uniqe not null,
    stock int not null default 0,
    stockMinimo int,
    stockMaximo int,
    valorUnitario int not null default 0,
    descripcion text,
    foto varchar(100),
    idCategoria int,
    foreign key (idCategoria) references categoria(id) on update cascade on delete restrict
);
create table factura(
    numero varchar(10) not null primary key,
    identificacionCliente varchar(12) not null,
    fecha datetime not null default now(),
    foreign key (identificacionCliente) references persona(identificacion) on update cascade on delete restrict
);

create table medioDePagoFactura(
    id int not null primary key auto_increment,
    idMedioDePago int not null,
    numeroFactura varchar(12) not null,
    foreign key (idMedioDePago) references medioDePago(id) on update cascade on delete restrict,
    foreign key (numeroFactura) references factura(numero) on update cascade on delete restrict
);

create table facturaDetalle(
    id int not null primary key auto_increment,
    idProducto int not null,
    numeroFactura varchar(10) not null,
    cantidad int not null default 1,
    valorUnitario int not null, -- valor actual del producto
    foreign key (idProducto) references producto(id) on update cascade on delete restrict,
    foreign key (numeroFactura) references factura(numero) on update cascade on delete restrict
);

 show tables;
 drop table categoria;








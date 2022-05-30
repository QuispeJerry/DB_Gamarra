-- Base de datos: dbGamarra
CREATE DATABASE dbGamarra

-- Tabla: categoria
CREATE TABLE categoria (
    id INT NOT NULL CONSTRAINT categoria_pk PRIMARY KEY,
    nombre VARCHAR(300) NOT NULL
);

-- Tabla: direccion
CREATE TABLE direccion (
    id INT NOT NULL CONSTRAINT direccion_pk PRIMARY KEY,
    departamento VARCHAR(500) NOT NULL,
    provincia VARCHAR(500) NOT NULL,
    distrito VARCHAR(500) NOT NULL,
    avenida VARCHAR(500),
    urbanizacion VARCHAR(200),
    numero INT,
    referencia VARCHAR(500) NOT NULL
);

-- Tabla: galeria
CREATE TABLE galeria (
    id INT NOT NULL CONSTRAINT galeria_pk PRIMARY KEY,
    nombre VARCHAR(500) NOT NULL,
    direccion_id INT NOT NULL,
    CONSTRAINT galeria_direccion FOREIGN KEY (direccion_id)
    REFERENCES direccion (id)
);


-- Tabla: imagen
CREATE TABLE imagen (
    id INT NOT NULL CONSTRAINT imagen_pk PRIMARY KEY,
    url VARCHAR(500) NOT NULL
);

-- Tabla: piso
CREATE TABLE piso (
    id INT NOT NULL,
    numero_piso INT NOT NULL,
    cantidad_tiendas_por_piso INT NOT NULL,
    galeria_id INT NOT NULL,
    CONSTRAINT piso_pk PRIMARY KEY (galeria_id,id),
    CONSTRAINT piso_galeria FOREIGN KEY (galeria_id)
    REFERENCES galeria (id)
);

-- Tabla: rol_usuario
CREATE TABLE rol_usuario (
    id INT NOT NULL CONSTRAINT rol_usuario_pk PRIMARY KEY,
    descripcion VARCHAR(300) NOT NULL
);

-- Tabla: usuario
CREATE TABLE usuario (
    id INT NOT NULL CONSTRAINT usuario_pk PRIMARY KEY,
    nombre VARCHAR(1000) NOT NULL,
    apellido VARCHAR(1000) NOT NULL,
    correo VARCHAR(1000) NOT NULL,
    direccion_id INT,
    rol_usuario_id INT NOT NULL,
    CONSTRAINT usuario_direccion FOREIGN KEY (direccion_id)
    REFERENCES direccion (id),
    CONSTRAINT usuario_rol_usuario FOREIGN KEY (rol_usuario_id)
    REFERENCES rol_usuario (id)
);


-- Tabla: venta
CREATE TABLE venta (
    id INT NOT NULL CONSTRAINT venta_pk PRIMARY KEY,
    fecha_envio DATE NOT NULL,
    nombre_agencia VARCHAR(500) NOT NULL,
    usuario_id INT NOT NULL,
    CONSTRAINT venta_usuario FOREIGN KEY (usuario_id)
    REFERENCES usuario (id)
);


-- Tabla: tienda
CREATE TABLE tienda (
    id INT NOT NULL CONSTRAINT tienda_pk PRIMARY KEY,
    ruc VARCHAR(50) NULL,
    nombre VARCHAR(100) NOT NULL,
    usuario_id INT NOT NULL,
    piso_galeria_id INT NOT NULL,
    piso_id INT NOT NULL,
    CONSTRAINT tienda_usuario FOREIGN KEY (usuario_id)
    REFERENCES usuario (id),
    CONSTRAINT tienda_piso FOREIGN KEY (piso_galeria_id,piso_id)
    REFERENCES piso (galeria_id,id)
);


-- Tabla: producto
CREATE TABLE producto (
    id INT NOT NULL CONSTRAINT producto_pk PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    color INT NOT NULL,
    talla INT NOT NULL,
    precio_minorista INT NOT NULL,
    precio_mayorista INT NOT NULL,
    tienda_id INT NOT NULL,
    categoria_id INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT producto_tienda FOREIGN KEY (tienda_id)
    REFERENCES tienda(id),
    CONSTRAINT producto_categoria FOREIGN KEY (categoria_id)
    REFERENCES categoria (id)
);


-- Tabla: detalle_venta
CREATE TABLE detalle_venta (
    id INT NOT NULL CONSTRAINT detalle_venta_pk PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_total INT NOT NULL,
    producto_id INT NOT NULL,
    fecha_compra DATE NOT NULL,
    venta_id INT NOT NULL,
    CONSTRAINT detalle_venta_Producto FOREIGN KEY (producto_id)
    REFERENCES producto(id),
    CONSTRAINT detalle_venta_venta FOREIGN KEY (venta_id)
    REFERENCES venta(id)
);

-- Tabla: mensaje
CREATE TABLE mensaje (
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,
    texto VARCHAR(500) NOT NULL,
    mensaje_usuario_id INT NOT NULL,
    mensaje_producto_id INT NOT NULL,
    CONSTRAINT mensaje_pk PRIMARY KEY (usuario_id,producto_id),
    CONSTRAINT mensaje_usuario FOREIGN KEY (usuario_id)
    REFERENCES usuario (id),
    CONSTRAINT mensaje_producto FOREIGN KEY (producto_id)
    REFERENCES producto (id),
    CONSTRAINT mensaje_mensaje FOREIGN KEY (mensaje_usuario_id,mensaje_producto_id)
    REFERENCES mensaje (usuario_id,producto_id)
);


-- Tabla: producto_imagen
CREATE TABLE producto_imagen (
    producto_id INT NOT NULL,
    imagen_id INT NOT NULL,
    CONSTRAINT producto_imagen_pk PRIMARY KEY (producto_id,imagen_id),
    CONSTRAINT producto_imagen_producto FOREIGN KEY (producto_id)
    REFERENCES producto (id),
    CONSTRAINT producto_imagen_imagen FOREIGN KEY (imagen_id)
    REFERENCES imagen (id)
);

CREATE DATABASE telovendo5;

CREATE USER admin_tlv WITH PASSWORD 123;
GRANT ALL PRIVILEGES ON DATABASE telovendo5 to admin;

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    id_proveedor INTEGER,
    nombre VARCHAR(100),
    precio INTEGER CHECK (precio >= 0),
    color VARCHAR(15),
    categoria VARCHAR(30),
    stock INTEGER CHECK (stock >= 0)
);

CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_comercial VARCHAR(30),
    representante_legal VARCHAR(30),
    nombre_contacto VARCHAR(30),
    correo VARCHAR(30),
    contacto1 VARCHAR(10),
    contacto2 VARCHAR(10),
    id_producto INTEGER
);

CREATE TABLE cliente( 
    id_cliente SERIAL PRIMARY KEY, 
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    direccion VARCHAR(50)
);

-- CLAVES FORANEAS
ALTER TABLE producto ADD FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor);
ALTER TABLE proveedor ADD FOREIGN KEY (id_producto) REFERENCES producto (id_producto);

INSERT INTO cliente (nombre, apellido, direccion)
VALUES
    ('Juan', 'López', 'Calle Principal, 123'),
    ('María', 'García', 'Avenida Central, 456'),
    ('Carlos', 'Rodríguez', 'Calle Secundaria, 789'),
    ('Ana', 'Martínez', 'Avenida Norte, 321'),
    ('Pedro', 'Sánchez', 'Calle Sur, 654');

INSERT INTO proveedor (nombre_comercial, representante_legal, nombre_contacto, correo, contacto1, contacto2)
VALUES
    ('Proveedor1', 'Representante1', 'Contacto1', 'proveedor1@example.com', 1234567890, 9876543210),
    ('Proveedor2', 'Representante2', 'Contacto2', 'proveedor2@example.com', 1111111111, 2222222222),
    ('Proveedor3', 'Representante3', 'Contacto3', 'proveedor3@example.com', 3333333333, 4444444444),
    ('Proveedor4', 'Representante4', 'Contacto4', 'proveedor4@example.com', 5555555555, 6666666666),
    ('Proveedor5', 'Representante5', 'Contacto5', 'proveedor5@example.com', 7777777777, 8888888888);

-- Insertar productos tecnológicos (6 registros)
INSERT INTO producto (id_proveedor, nombre, precio, color, categoria, stock)
VALUES
    (1, 'Smartphone', 500, 'Negro', 'Tecnología', 10),
    (1, 'Laptop', 1200, 'Plata', 'Tecnología', 8),
    (1, 'Tablet', 300, 'Blanco', 'Tecnología', 15),
    (2, 'Televisor', 800, 'Gris', 'Tecnología', 5),
    (2, 'Cámara digital', 400, 'Negro', 'Tecnología', 12),
    (2, 'Auriculares inalámbricos', 100, 'Negro', 'Tecnología', 20);

-- Insertar productos de ropa (2 registros)
INSERT INTO producto (id_proveedor, nombre, precio, color, categoria, stock)
VALUES
    (3, 'Chaqueta', 60, 'Azul', 'Ropa', 20),
    (3, 'Pantalón vaquero', 40, 'Negro', 'Ropa', 30);

-- Insertar productos de accesorios (2 registros)
INSERT INTO producto (id_proveedor, nombre, precio, color, categoria, stock)
VALUES
    (4, 'Reloj', 120, 'Plateado', 'Accesorios', 10),
    (4, 'Gafas de sol', 40, 'Negro', 'Accesorios', 15);

SELECT categoria, COUNT(categoria) as CUENTA FROM producto GROUP BY categoria ORDER BY CUENTA DESC  LIMIT 1;
SELECT nombre, stock FROM producto WHERE stock = (SELECT MAX(stock) FROM producto);
SELECT color, COUNT(color) as CUENTA FROM producto GROUP BY color ORDER BY CUENTA DESC  LIMIT 1;
SELECT nombre_comercial FROM proveedor JOIN producto ON ( proveedor.id_proveedor = producto.id_proveedor) WHERE producto.stock = 
(SELECT MIN(stock) FROM producto);


UPDATE producto COLUMN categoria = 'Electrónica y computación' WHERE categoria = 'Tecnología';
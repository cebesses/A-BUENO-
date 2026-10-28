-- ============================================================================
--  Datos de ejemplo para probar los endpoints de la API.
--
--  Se puede ejecutar varias veces: usa INSERT IGNORE.
--  Ejecutar después de crear las tablas (01) y, si aplica, de la migración (02).
-- ============================================================================

USE tienda;

-- Categorías
INSERT IGNORE INTO categoria (nombre) VALUES
    ('Computadores'),
    ('Periféricos'),
    ('Audio'),
    ('Accesorios'),
    ('Oficina');

-- Clientes (correo es UNIQUE)
INSERT IGNORE INTO cliente (nombre, correo, ciudad) VALUES
    ('Ana María Gómez', 'ana.gomez@correo.com',       'Medellín'),
    ('Carlos Pérez',    'carlos.perez@correo.com',    'Bogotá'),
    ('Laura Rodríguez', 'laura.rodriguez@correo.com', 'Cali');

-- Productos. Se usan ids fijos para que el script sea idempotente;
-- la categoría se busca por nombre para no depender de sus ids.
INSERT IGNORE INTO producto (id_producto, nombre, id_categoria, precio, stock)
SELECT 1, 'Portátil HP 15', id_categoria, 2450000.00, 10
FROM categoria WHERE nombre = 'Computadores';

INSERT IGNORE INTO producto (id_producto, nombre, id_categoria, precio, stock)
SELECT 2, 'Mouse inalámbrico Logitech', id_categoria, 85000.00, 40
FROM categoria WHERE nombre = 'Periféricos';

INSERT IGNORE INTO producto (id_producto, nombre, id_categoria, precio, stock)
SELECT 3, 'Diadema Sony WH-CH520', id_categoria, 320000.00, 15
FROM categoria WHERE nombre = 'Audio';

INSERT IGNORE INTO producto (id_producto, nombre, id_categoria, precio, stock)
SELECT 4, 'Teclado mecánico Redragon', id_categoria, 210000.00, 25
FROM categoria WHERE nombre = 'Periféricos';

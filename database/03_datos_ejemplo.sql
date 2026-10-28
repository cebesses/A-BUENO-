-- ============================================================================
--  Datos de ejemplo para probar los endpoints de la API.
--  Se puede ejecutar varias veces: usa INSERT IGNORE / NOT EXISTS.
-- ============================================================================

USE tienda;

-- Categorías
INSERT IGNORE INTO categoria (nombre) VALUES
    ('Computadores'),
    ('Periféricos'),
    ('Audio'),
    ('Accesorios'),
    ('Oficina');

-- Clientes
INSERT IGNORE INTO cliente (nombre, correo, ciudad) VALUES
    ('Ana María Gómez',  'ana.gomez@correo.com',    'Medellín'),
    ('Carlos Pérez',     'carlos.perez@correo.com', 'Bogotá'),
    ('Laura Rodríguez',  'laura.rodriguez@correo.com', 'Cali');

-- Productos (la categoría se busca por nombre para no depender de los ids)
INSERT INTO producto (nombre, id_categoria, precio, stock)
SELECT 'Portátil HP 15', id_categoria, 2450000.00, 10
FROM categoria WHERE nombre = 'Computadores'
  AND NOT EXISTS (SELECT 1 FROM producto WHERE nombre = 'Portátil HP 15');

INSERT INTO producto (nombre, id_categoria, precio, stock)
SELECT 'Mouse inalámbrico Logitech', id_categoria, 85000.00, 40
FROM categoria WHERE nombre = 'Periféricos'
  AND NOT EXISTS (SELECT 1 FROM producto WHERE nombre = 'Mouse inalámbrico Logitech');

INSERT INTO producto (nombre, id_categoria, precio, stock)
SELECT 'Diadema Sony WH-CH520', id_categoria, 320000.00, 15
FROM categoria WHERE nombre = 'Audio'
  AND NOT EXISTS (SELECT 1 FROM producto WHERE nombre = 'Diadema Sony WH-CH520');

INSERT INTO producto (nombre, id_categoria, precio, stock)
SELECT 'Teclado mecánico Redragon', id_categoria, 210000.00, 25
FROM categoria WHERE nombre = 'Periféricos'
  AND NOT EXISTS (SELECT 1 FROM producto WHERE nombre = 'Teclado mecánico Redragon');

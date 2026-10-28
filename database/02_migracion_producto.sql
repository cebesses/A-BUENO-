-- ============================================================================
--  Ajuste de una tabla "producto" que YA EXISTE (migración) - MySQL 8+
--
--  Ejecutar solamente si en tu base de datos la tabla producto fue creada con
--  la estructura anterior en inglés: id, name, price, quantity.
--  Si la tabla ya tiene las columnas del diagrama (id_producto, nombre,
--  id_categoria, precio, stock), NO ejecutes este script.
--
--  Orden recomendado:
--    1) database/01_crear_base_datos.sql  (crea categoria y cliente; producto
--       se deja igual si ya existe)
--    2) database/02_migracion_producto.sql (este archivo)
--    3) database/03_datos_ejemplo.sql
--
--  Si tu tabla se llama "productos" (en plural), cambia el nombre en cada
--  sentencia ALTER TABLE.
-- ============================================================================

USE tienda;

-- 1) Renombrar/ajustar las columnas al español.
ALTER TABLE producto
    CHANGE COLUMN id       id_producto INT           NOT NULL AUTO_INCREMENT,
    CHANGE COLUMN name     nombre      VARCHAR(150)  NOT NULL,
    CHANGE COLUMN price    precio      DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CHANGE COLUMN quantity stock       INT           NOT NULL DEFAULT 0;

-- 2) Agregar la llave foránea hacia categoria.
--    Primero se agrega como NULL para poder llenar las filas existentes.
ALTER TABLE producto
    ADD COLUMN id_categoria INT NULL AFTER nombre;

-- 2.1) Categoría por defecto para los productos que ya existían.
--      INSERT IGNORE no falla si la categoría 'General' ya existe
--      (nombre es UNIQUE). Puedes cambiar el nombre por una categoría real.
INSERT IGNORE INTO categoria (nombre) VALUES ('General');

-- 2.2) Asignar esa categoría a los productos huérfanos.
UPDATE producto
SET id_categoria = (SELECT MIN(id_categoria) FROM categoria)
WHERE id_categoria IS NULL;

-- 2.3) Dejar la columna como NOT NULL, tal como se ve en el diagrama.
ALTER TABLE producto
    MODIFY COLUMN id_categoria INT NOT NULL;

-- 2.4) Crear el índice y la llave foránea.
ALTER TABLE producto
    ADD KEY ix_producto_categoria (id_categoria),
    ADD CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;

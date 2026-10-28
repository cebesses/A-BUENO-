-- ============================================================================
--  Ajuste de una tabla "producto" que YA EXISTE (migración).
--
--  Ejecutar solamente si en tu base de datos la tabla producto fue creada con
--  la estructura anterior en inglés: id, name, price, quantity.
--  Si la tabla ya tiene las columnas del diagrama (id_producto, nombre,
--  id_categoria, precio, stock), NO ejecutes este script.
--
--  Requisito: la tabla categoria debe existir antes de crear la llave foránea;
--  ejecuta primero database/01_crear_base_datos.sql (o solo la sección de
--  categoria).
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
ALTER TABLE producto
    ADD COLUMN id_categoria INT NOT NULL AFTER nombre,
    ADD KEY ix_producto_categoria (id_categoria),
    ADD CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;

-- 3) Si la tabla ya tenía filas y la categoría 1 existe, se puede asignar una
--    categoría por defecto a los productos huérfanos (opcional):
-- UPDATE producto SET id_categoria = 1 WHERE id_categoria IS NULL OR id_categoria = 0;

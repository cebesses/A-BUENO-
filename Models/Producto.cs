namespace ApiEjemplo.Models;

/// <summary>
/// Representa un registro de la tabla <c>producto</c> (estructura ajustada al diagrama).
/// </summary>
public class Producto
{
    public int IdProducto { get; set; }

    public string Nombre { get; set; } = string.Empty;

    /// <summary>Llave foránea hacia <c>categoria.id_categoria</c>.</summary>
    public int IdCategoria { get; set; }

    public decimal Precio { get; set; }

    public int Stock { get; set; }

    /// <summary>Nombre de la categoría; solo se llena en las consultas de lectura (JOIN).</summary>
    public string? NombreCategoria { get; set; }
}

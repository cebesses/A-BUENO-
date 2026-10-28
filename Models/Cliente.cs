namespace ApiEjemplo.Models;

/// <summary>
/// Representa un registro de la tabla <c>cliente</c>.
/// </summary>
public class Cliente
{
    public int IdCliente { get; set; }

    public string Nombre { get; set; } = string.Empty;

    public string Correo { get; set; } = string.Empty;

    public string? Ciudad { get; set; }

    /// <summary>Si se envía en el POST/PUT se respeta; si no, MySQL usa la fecha actual.</summary>
    public DateTime? FechaRegistro { get; set; }
}

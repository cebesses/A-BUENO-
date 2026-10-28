using MySqlConnector;

var builder = WebApplication.CreateBuilder(args);

// Cadena de conexión a MySQL definida en appsettings.json (ConnectionStrings:Tienda).
var cadenaConexion = builder.Configuration.GetConnectionString("Tienda")
    ?? throw new InvalidOperationException(
        "No se encontró la cadena de conexión 'Tienda' en appsettings.json.");

// Un único MySqlDataSource (pool de conexiones) para toda la aplicación.
builder.Services.AddSingleton(_ => new MySqlDataSource(cadenaConexion));

builder.Services.AddControllers();
builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseAuthorization();

app.MapControllers();

app.Run();

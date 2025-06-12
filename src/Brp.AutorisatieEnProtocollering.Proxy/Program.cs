using Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;
using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.AutorisatieEnProtocollering.Proxy.Protocollering;
using Brp.Shared.Validatie;
using Brp.Shared.Infrastructure.Autorisatie;
using Brp.Shared.Infrastructure.HealthCheck;
using Brp.Shared.Infrastructure.Logging;
using Brp.Shared.Infrastructure.Utils;
using Microsoft.EntityFrameworkCore;
using Microsoft.FeatureManagement;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Serilog;
using Brp.AutorisatieEnProtocollering.Proxy.Middleware;

Log.Logger = SerilogHelpers.SetupSerilogBootstrapLogger();

try
{
    Log.Information("Starting {AppName} v{AppVersion}. TimeZone: {TimeZone}. Now: {TimeNow}",
                    AssemblyHelpers.Name, AssemblyHelpers.Version, TimeZoneInfo.Local.StandardName, DateTime.Now);

    var builder = WebApplication.CreateBuilder(args);

    builder.Services.AddHttpContextAccessor();

    builder.SetupSerilog(Log.Logger);

    builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"))
                         .AddJsonFile(Path.Combine("configuration", $"ocelot.{builder.Environment.EnvironmentName}.json"), true)
                         .AddEnvironmentVariables();

    builder.Services.AddFeatureManagement();

    builder.SetupAuthentication(Log.Logger);
    builder.SetupAuthorisation();
    builder.SetupProtocollering();
    builder.SetupRequestValidation();

    var dbSection = builder.Configuration.GetSection("Db");
    var connectionString = $"Host={dbSection["Host"]};Username={dbSection["Username"]};Password={dbSection["Password"]};Database={dbSection["Database"]}";

    builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql(connectionString));

    builder.Services.AddOcelot();

    builder.Services.AddHealthChecks()
                    .AddNpgSql(connectionString, name: "Database")
                    .AddOcelotDownstreamEndpointCheck(builder.Configuration)
                    .AddOpenIdConnectServer(new Uri(builder.Configuration["OAuth:Authority"]), discoverConfigurationSegment: "nam/.well-known/openid-configuration", name: "IDP");

    var app = builder.Build();

    app.SetupSerilogRequestLogging();

    app.UseAuthentication();

    app.UseRouting();

    app.UseAuthorization();

    app.SetupHealthCheckEndpoints(builder.Configuration, Log.Logger);

    app.UseEndpoints(e => e.MapControllers());

    app.UseMiddleware<AutorisatieEnProtocolleringMiddleware>();

    app.UseOcelot().Wait();

    await app.RunAsync();
}
catch(Exception ex)
{
    Log.Fatal(ex, "{AppName} terminated unexpectedly", AssemblyHelpers.Name);
}
finally
{
    await Log.CloseAndFlushAsync();
}

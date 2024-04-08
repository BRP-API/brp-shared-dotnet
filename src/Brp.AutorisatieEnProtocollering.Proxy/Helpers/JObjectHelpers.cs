using Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Helpers;

public static class JObjectHelpers
{

    public static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanZoekParameters(this JObject input)
    {
        return from property in input.Properties()
               where !new[] { "type", "fields", "inclusiefOverledenPersonen" }.Contains(property.Name)
               select (property.Name, Value: Constanten.FieldElementNrDictionary[property.Name].Split(' '));
    }
}
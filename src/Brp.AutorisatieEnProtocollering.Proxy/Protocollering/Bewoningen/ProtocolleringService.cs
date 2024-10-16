using Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Bewoningen;
using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Newtonsoft.Json.Linq;

namespace Brp.AutorisatieEnProtocollering.Proxy.Protocollering.Bewoningen;

public class ProtocolleringService : AbstractProtocolleringService
{
    public ProtocolleringService(IServiceProvider serviceProvider)
        : base(serviceProvider, Constanten.FieldElementNrDictionary)
    {
    }

    private static string BepaalKeyVoor(string gevraagdField, string zoekType) => gevraagdField;

    protected override IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFieldsVoorProtocollering(JObject input)
    {
        var zoekType = input.WaardeTypeParameter();
        var gevraagdeFields = new string[] { "bewoning" };

        return gevraagdeFields.ToKeyStringArray(Constanten.FieldElementNrDictionary, zoekType!, BepaalKeyVoor);
    }
}

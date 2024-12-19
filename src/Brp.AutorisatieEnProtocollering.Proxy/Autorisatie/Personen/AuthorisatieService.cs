using Brp.AutorisatieEnProtocollering.Proxy.Helpers;
using Brp.Shared.Infrastructure.Autorisatie;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Personen;

public class AuthorisatieService : AbstractAutorisatieService
{
    public AuthorisatieService(IServiceProvider serviceProvider, IHttpContextAccessor httpContextAccessor)
        : base(serviceProvider, httpContextAccessor)
    {
    }

    public override AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        if (AfnemerIsGemeente(afnemerCode, gemeenteCode))
        {
            return Authorized();
        }

        var autorisatie = GetActueleAutorisatieFor(afnemerCode);

        if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
        {
            return NietGeautoriseerdVoorAdhocGegevensverstrekking(autorisatie, afnemerCode);
        }

        var input = JObject.Parse(requestBody);

        var zoekElementNrs = input.BepaalElementNrVanZoekParameters(Constanten.FieldElementNrDictionary);

        var geautoriseerdeElementNrs = autorisatie!.RubrieknummerAdHoc!.Split(' ');

        var nietGeautoriseerdQueryElementNrs = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, zoekElementNrs);
        if (nietGeautoriseerdQueryElementNrs.Any())
        {
            return NietGeautoriseerdVoorParameters(nietGeautoriseerdQueryElementNrs);
        }

        var fieldElementNrs = BepaalElementNrVanFields(input);

        var nietGeautoriseerdFieldNames = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, fieldElementNrs);
        if (nietGeautoriseerdFieldNames.Any())
        {
            return NietGeautoriseerdVoorFields(nietGeautoriseerdFieldNames, afnemerCode);
        }

        return Authorized();
    }

    private static string BepaalKeyVoor(string gevraagdField, string zoekType)
    {
        return zoekType != "RaadpleegMetBurgerservicenummer"
                ? $"{gevraagdField}-beperkt"
                : gevraagdField;
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFields(JObject input)
    {
        var zoekType = input.WaardeTypeParameter();
        var gevraagdeFields = input.WaardeFieldsParameter();

        return gevraagdeFields.ToKeyStringArray(Constanten.FieldElementNrDictionary, zoekType!, BepaalKeyVoor);
    }

    protected override IEnumerable<string> BepaalNietGeautoriseerdeElementNamen(IEnumerable<string> geautoriseerdeElementen,
                                                                                IEnumerable<(string Name, string[] Value)> gevraagdeElementen)
    {
        var retval = new List<string>();

        foreach (var (Name, Value) in gevraagdeElementen)
        {
            if (Value.Length == 0 && Name == "ouders.ouderAanduiding" &&
                !IsGeautoriseerdVoorOuderAanduidingVraag(geautoriseerdeElementen))
            {
                retval.Add(Name);
            }
            else if (Name.StartsWith("adressering"))
            {
                if (!IsGeautoriseerdVoorAdresseringAanvraag(geautoriseerdeElementen, Value))
                {
                    retval.Add(Name);
                }
            }
            else
            {
                foreach (var gevraagdElementNr in Value)
                {
                    if (!geautoriseerdeElementen.Any(x => gevraagdElementNr == x.PrefixWithZero()))
                    {
                        retval.Add(Name);
                    }
                }
            }
        }

        return retval.Distinct();
    }

    private static bool IsGeautoriseerdVoorAdresseringAanvraag(IEnumerable<string> geautoriseerdeElementen, IEnumerable<string> gevraagdeElementen)
    {
        if (geautoriseerdeElementen.Contains(Constanten.ElementNrAdressering) ||
            geautoriseerdeElementen.Contains(Constanten.ElementNrElektronischeAdressering))
        {
            return AdresseringAutorisatieMetNieuweElementNummers(geautoriseerdeElementen, gevraagdeElementen);
        }

        return AdresseringAutorisatieMetOudeElementNummers(geautoriseerdeElementen, gevraagdeElementen);
    }

    private static bool IsGeautoriseerdVoorOuderAanduidingVraag(IEnumerable<string> geautoriseerdeElementen)
    {
        var ouder1Regex = new Regex(@"^(02(01|02|03|04|62)\d{2}|PAOU01)$", RegexOptions.None, TimeSpan.FromMilliseconds(100));
        var ouder2Regex = new Regex(@"^(03(01|02|03|04|62)\d{2}|PAOU01)$", RegexOptions.None, TimeSpan.FromMilliseconds(100));

        var isGeautoriseerdVoorOuder1 = false;
        var isGeautoriseerdVoorOuder2 = false;

        foreach (var elementNr in geautoriseerdeElementen)
        {
            var prefixedElementNr = elementNr.PrefixWithZero();
            if (ouder1Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder1 = true;
            }
            if (ouder2Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder2 = true;
            }
        }

        return isGeautoriseerdVoorOuder1 && isGeautoriseerdVoorOuder2;
    }

    private static bool AdresseringAutorisatieMetNieuweElementNummers(IEnumerable<string> geautoriseerdeElementen, IEnumerable<string> gevraagdeElementen)
    {
        var values = gevraagdeElementen.Where(x => x == Constanten.ElementNrAdressering ||
                                                   x == Constanten.ElementNrElektronischeAdressering).ToArray();
        if (values.Length == 0)
        {
            return false;
        }
        foreach (var gevraagdElementNr in values)
        {
            if (gevraagdElementNr == Constanten.ElementNrElektronischeAdressering &&
                !geautoriseerdeElementen.Any(x => x == Constanten.ElementNrElektronischeAdressering ||
                                                  x == Constanten.ElementNrAdressering))
            {
                return false;
            }
            else if (gevraagdElementNr == Constanten.ElementNrAdressering &&
                     !geautoriseerdeElementen.Any(x => x == Constanten.ElementNrAdressering))
            {
                return false;
            }
        }

        return true;
    }

    private static bool AdresseringAutorisatieMetOudeElementNummers(IEnumerable<string> geautoriseerdeElementen, IEnumerable<string> gevraagdeElementen)
    {
        var values = gevraagdeElementen.Where(x => x != Constanten.ElementNrAdressering && x != Constanten.ElementNrElektronischeAdressering).ToArray();
        if (values.Length == 0)
        {
            return false;
        }
        foreach (var gevraagdElementNr in values)
        {
            if (!geautoriseerdeElementen.Any(x => gevraagdElementNr == x.PrefixWithZero()))
            {
                return false;
            }
        }

        return true;
    }
}

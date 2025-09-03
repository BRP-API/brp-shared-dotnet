namespace Brp.AutorisatieEnProtocollering.Proxy.Helpers;

public static class RewriteDatumEnTabelwaardeFieldwaardenHelper
{
    public static IEnumerable<string> RewriteDatumEnTabelwaardeFieldWaarden(this IEnumerable<string> fieldWaarden)
    {
        var retval = new List<string>();

        foreach(var fieldwaarde in fieldWaarden)
        {
            retval.Add(fieldwaarde.RewriteDatumEnTabelwaardeFieldwaarden());
        }

        return retval;
    }

	private static readonly List<string> DatumEnTabelwaardeVeldnamen =
	[
		"aanduiding",
		"aanduidingBijHuisnummer",
		"aanduidingNaamgebruik",
		"adellijkeTitelPredicaat",
		"datum",
		"datumEersteInschrijvingGBA",
		"datumEinde",
		"datumIngangFamilierechtelijkeBetrekking",
		"datumIngang",
		"datumIngangGeldigheid",
		"datumInschrijvingInGemeente",
		"datumVan",
		"datumVestigingInNederland",
		"einddatum",
		"einddatumUitsluiting",
		"functieAdres",
		"gemeenteVanInschrijving",
		"geslacht",
		"indicatieGezagMinderjarige",
		"land",
		"landVanwaarIngeschreven",
		"nationaliteit",
		"plaats",
		"redenOpname",
		"soortVerbintenis"
	];

	/// <summary>
	/// rewrite veldwaarden die verwijzen naar een (niet-bestaand) sub-velden van datum of tabelwaarde velden
	/// naar een verwijzing van het datum of tabelwaarde veld
	/// voorbeeld: geboorte.datum.jaar of geboorte.datum.nietBestaand wordt gewijzigd naar geboorte.datum 
	/// </summary>
	/// <param name="veld"></param>
	/// <returns></returns>
	private static string RewriteDatumEnTabelwaardeFieldwaarden(this string veld)
	{
		var subvelden = veld.Split('.');
		if (subvelden.Length == 1)
		{
			return veld;
		}

		return DatumEnTabelwaardeVeldnamen.Contains(subvelden[^2])
			? string.Join('.', subvelden.Take(subvelden.Length - 1))
			: veld;
	}
}

using System.Collections.ObjectModel;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie.Personen;

public static class Constanten
{
    static Constanten()
    {
        FieldElementNrDictionary = new(_fieldElementNrDictionary);
    }

    public static ReadOnlyDictionary<string, string> FieldElementNrDictionary { get; }

    public const string ElementNrAdressering = "PAAD01";
    public const string ElementNrElektronischeAdressering = "PAAD02";
    private const string ElementNrAanhef = "PANM03";
    private const string ElementNrAanspreekvorm = "PANM04";
    private const string ElementNrAanschrijfwijzeNaam = "PANM05";
    private const string ElementNrGebruikInLopendeTekst = "PANM06";
    private const string ElementNrAdresregel1 = "PAVP03";
    private const string ElementNrAdresregel2 = "PAVP04";
    private const string ElementNrVerblijfplaatsLand = "081310";

    private const string ElementNrBurgerservicenummer = "010120";
    private const string ElementNrVoornamen = "010210";
    private const string ElementNrAdellijkeTitelPredicaat = "010220";
    private const string ElementNrVoorvoegsel = "010230";
    private const string ElementNrGeslachtsnaam = "010240";
    private const string ElementNrGeboortedatum = "010310";
    private const string ElementNrGeboorteplaats = "010320";
    private const string ElementNrGeboorteland = "010330";
    private const string ElementNrGeslacht = "010410";
    private const string ElementNrAanduidingNaamgebruik = "016110";
    private const string ElementNrVoorletters = "PANM01";
    private const string ElementNrVolledigeNaam = "PANM02";

    private const string ElementNrBurgerserviceNummerouder = "020120 030120";
    private const string ElementNrVoornamenOuder = "020210 030210";
    private const string ElementNrAdellijkeTitelPredicaatOuder = "020220 030220";
    private const string ElementNrVoorvoegselOuder = "020230 030230";
    private const string ElementNrGeslachtsnaamOuder = "020240 030240";
    private const string ElementNrGeboortedatumOuder = "020310 030310";
    private const string ElementNrGeboorteplaatsOuder = "020320 030320";
    private const string ElementNrGeboortelandOuder = "020330 030330";
    private const string ElementNrGeslachtOuder = "020410 030410";
    private const string ElementNrDatumIngangFamilierechtelijkeBetrekking = "026210 036210";
    private const string ElementNrVoorlettersOuder = "PAOU01";

    private const string ElementNrNationaliteit = "040510";
    private const string ElementNrRedenOpnameNationaliteit = "046310";
    private const string ElementNrDatumIngangGeldigheidNationaliteit = "048510";
    private const string ElementNrNationaliteitType = "PANT01";

    private const string ElementNrBurgerservicenummerPartner = "050120";
    private const string ElementNrVoornamenPartner = "050210";
    private const string ElementNrAdellijkeTitelPredicaatPartner = "050220";
    private const string ElementNrVoorvoegselPartner = "050230";
    private const string ElementNrGeslachtsnaamPartner = "050240";
    private const string ElementNrGeboortedatumPartner = "050310";
    private const string ElementNrGeboorteplaatsPartner = "050320";
    private const string ElementNrGeboortelandPartner = "050330";
    private const string ElementNrGeslachtPartner = "050410";
    private const string ElementNrDatumAangaanHuwelijkPartnerschap = "050610";
    private const string ElementNrPlaatsAangaanHuwelijkPartnerschap = "050620";
    private const string ElementNrLandAangaanHuwelijkPartnerschap = "050630";
    private const string ElementNrDatumOntbindingHuwelijkPartnerschap = "050710";
    private const string ElementNrSoortVerbintenis = "051510";
    private const string ElementNrVoorlettersPartner = "PAHP01";

    private const string ElementNrOverlijdendatum = "060810";
    private const string ElementNrOverlijdenLand = "060830";
    private const string ElementNrOverlijdenPlaats = "060820";

    private const string ElementNrDatumEersteInschrijvingGba = "076810";

    private const string ElementNrGemeenteVanInschrijving = "080910";
    private const string ElementNrDatumInschrijvingInGemeente = "080920";
    private const string ElementNrFunctieAdres = "081010";
    private const string ElementNrStraatnaam = "081110";
    private const string ElementNrNaamOpenbareRuimte = "081115";
    private const string ElementNrHuisnummer = "081120";
    private const string ElementNrHuisletter = "081130";
    private const string ElementNrHuisnummertoevoeging = "081140";
    private const string ElementNrAanduidingBijHuisnummer = "081150";
    private const string ElementNrPostcode = "081160";
    private const string ElementNrWoonplaats = "081170";
    private const string ElementNrLocatiebeschrijving = "081210";
    private const string ElementNrAdresseerbaarObjectIdentificatie = "081180";
    private const string ElementNrNummeraanduidingIdentificatie = "081190";
    private const string ElementNrVerblijfplaatsRegel1 = "081330";
    private const string ElementNrVerblijfplaatsRegel2 = "081340";
    private const string ElementNrVerblijfplaatsRegel3 = "081350";
    private const string ElementNrLandVanwaarIngeschreven = "081410";
    private const string ElementNrDatumVestigingInNederland = "081420";
    private const string ElementNrDatumIngangGeldigheidVerblijfplaats = "088510";
    private const string ElementNrDatumVanVerblijfplaats = "PAVP01";
    private const string ElementNrDatumAanvangAdreshouding = "081030";
    private const string ElementNrDatumAanvangAdresBuitenland = "081320";
    private const string ElementNrVerblijfplaatsType = "PAVP02";

    private const string ElementNrIndicatieVestigingVanuitBuitenland = "PAVP05";
    private const string ElementNrVanuitVerblijfplaatsOnbekend = "PAVP06";

    private const string ElementNrVoornamenKind = "090210";
    private const string ElementNrAdellijkeTitelPredicaatKind = "090220";
    private const string ElementNrVoorvoegselKind = "090230";
    private const string ElementNrGeslachtsnaamKind = "090240";
    private const string ElementNrGeboortedatumKind = "090310";
    private const string ElementNrGeboorteplaatsKind = "090320";
    private const string ElementNrGeboortelandKind = "090330";
    private const string ElementNrVoorlettersKind = "PAKD01";

    private const string ElementNrAanduidingVerblijfstitel = "103910";
    private const string ElementNrDatumEindeVerblijfstitel = "103920";
    private const string ElementNrDatumIngangVerblijfstitel = "103930";

    private const string ElementNrIndicatieGezagMinderjarige = "113210";
    private const string ElementNrGezag = "PAGZ01";

    private const string ElementNrAanduidingEuropeesKiesrecht = "133110";
    private const string ElementNrEinddatumUitsluitingEuropeesKiesrecht = "133130";

    private const string ElementNrUitgeslotenVanKiesrecht = "133810";
    private const string ElementNrEinddatumUitsluitingKiesrecht = "133820";


    private const string AdresseringBinnenlandBeperktElementen = $"{ElementNrAdresregel1} {ElementNrAdresregel2}";
    private const string AdresseringBinnenlandElementen = $"{ElementNrAanhef} {ElementNrAanspreekvorm} {ElementNrAanschrijfwijzeNaam} {ElementNrGebruikInLopendeTekst} {AdresseringBinnenlandBeperktElementen}";
    private const string AdresseringElementen = $"{ElementNrVerblijfplaatsLand} {ElementNrVerblijfplaatsRegel3} {AdresseringBinnenlandElementen}";
    private const string AdresseringBeperktElementen = $"{ElementNrVerblijfplaatsLand} {ElementNrVerblijfplaatsRegel3} {AdresseringBinnenlandBeperktElementen}";
    private const string AanhefAutorisatieElementen = $"{ElementNrAanhef} {ElementNrElektronischeAdressering}";
    private const string AanschrijfwijzeElementen = $"{ElementNrAanspreekvorm} {ElementNrAanschrijfwijzeNaam}";
    private const string AanschrijfwijzeAutorisatieElementen = $"{AanschrijfwijzeElementen} {ElementNrElektronischeAdressering}";
    private const string AanschrijfwijzeNaamAutorisatieElementen = $"{ElementNrAanschrijfwijzeNaam} {ElementNrElektronischeAdressering}";
    private const string AanspreekvormAutorisatieElementen = $"{ElementNrAanspreekvorm} {ElementNrElektronischeAdressering}";
    private const string GebruikInLopendeTekstAutorisatieElementen = $"{ElementNrGebruikInLopendeTekst} {ElementNrElektronischeAdressering}";
    private const string AdresseringAdresregel1AutorisatieElementen = $"{ElementNrAdresregel1} {ElementNrAdressering}";
    private const string AdresseringAdresregel2AutorisatieElementen = $"{ElementNrAdresregel2} {ElementNrAdressering}";
    private const string AdresseringLandAutorisatieElementen = $"{ElementNrVerblijfplaatsLand} {ElementNrAdressering}";

    private const string NaamBeperktElementen = $"{ElementNrVoornamen} {ElementNrAdellijkeTitelPredicaat} {ElementNrVoorvoegsel} {ElementNrGeslachtsnaam} {ElementNrVoorletters} {ElementNrVolledigeNaam}";

    private const string VerblijfplaatsBinnenlandVerblijfadresElementen = $"{ElementNrStraatnaam} {ElementNrNaamOpenbareRuimte} {ElementNrHuisnummer} {ElementNrHuisletter} {ElementNrHuisnummertoevoeging} {ElementNrAanduidingBijHuisnummer} {ElementNrPostcode} {ElementNrWoonplaats} {ElementNrLocatiebeschrijving}";
    private const string VerblijfplaatsBinnenlandElementen = $"{ElementNrFunctieAdres} {VerblijfplaatsBinnenlandVerblijfadresElementen} {ElementNrAdresseerbaarObjectIdentificatie} {ElementNrNummeraanduidingIdentificatie} {ElementNrDatumIngangGeldigheidVerblijfplaats}";
    private const string VerblijfplaatsVerblijfadresElementen = $"{VerblijfplaatsBinnenlandVerblijfadresElementen} {ElementNrVerblijfplaatsLand} {ElementNrVerblijfplaatsRegel1} {ElementNrVerblijfplaatsRegel2} {ElementNrVerblijfplaatsRegel3}";
    private const string VerblijfplaatsElementen = $"{ElementNrFunctieAdres} {VerblijfplaatsVerblijfadresElementen} {ElementNrAdresseerbaarObjectIdentificatie} {ElementNrNummeraanduidingIdentificatie} {ElementNrDatumIngangGeldigheidVerblijfplaats}";

    private const string OuderGeboorteElementen = $"{ElementNrGeboortedatumOuder} {ElementNrGeboorteplaatsOuder} {ElementNrGeboortelandOuder}";
    private const string OuderNaamElementen = $"{ElementNrVoornamenOuder} {ElementNrAdellijkeTitelPredicaatOuder} {ElementNrVoorvoegselOuder} {ElementNrGeslachtsnaamOuder} {ElementNrVoorlettersOuder}";

    private const string PartnerGeboorteElementen = $"{ElementNrGeboortedatumPartner} {ElementNrGeboorteplaatsPartner} {ElementNrGeboortelandPartner}";
    private const string PartnerNaamElementen = $"{ElementNrVoornamenPartner} {ElementNrAdellijkeTitelPredicaatPartner} {ElementNrVoorvoegselPartner} {ElementNrGeslachtsnaamPartner} {ElementNrVoorlettersPartner}";
    private const string PartnerHuwelijkPartnerschapElementen = $"{ElementNrDatumAangaanHuwelijkPartnerschap} {ElementNrPlaatsAangaanHuwelijkPartnerschap} {ElementNrLandAangaanHuwelijkPartnerschap}";

    private static readonly Dictionary<string, string> _fieldElementNrDictionary = new()
    {
        #region zoek parameters
        { "adresseerbaarObjectIdentificatie", ElementNrAdresseerbaarObjectIdentificatie },
        { "nummeraanduidingIdentificatie", ElementNrNummeraanduidingIdentificatie },
        { "postcode", ElementNrPostcode },
        { "straat", ElementNrStraatnaam },
        { "huisnummer", ElementNrHuisnummer },
        { "huisletter", ElementNrHuisletter },
        { "huisnummertoevoeging", ElementNrHuisnummertoevoeging },

        { "geboortedatum", ElementNrGeboortedatum },
        { "geslachtsnaam", ElementNrGeslachtsnaam },
        { "voornamen", ElementNrVoornamen },
        { "voorvoegsel", ElementNrVoorvoegsel },
        #endregion

        #region adressering
        { "adressering", $"{AdresseringElementen} {ElementNrAdressering}" },
        { "adressering-protocollering", AdresseringElementen },
        { "adressering-beperkt", $"{AdresseringBeperktElementen} {ElementNrAdressering}" },
        { "adressering-beperkt-protocollering", AdresseringBeperktElementen },
        { "adressering.aanhef", AanhefAutorisatieElementen },
        { "adressering.aanhef-protocollering", ElementNrAanhef },
        { "adressering.aanschrijfwijze", AanschrijfwijzeAutorisatieElementen },
        { "adressering.aanschrijfwijze-protocollering", AanschrijfwijzeElementen },
        { "adressering.aanschrijfwijze.aanspreekvorm", AanspreekvormAutorisatieElementen },
        { "adressering.aanschrijfwijze.aanspreekvorm-protocollering", ElementNrAanspreekvorm },
        { "adressering.aanschrijfwijze.naam", AanschrijfwijzeNaamAutorisatieElementen },
        { "adressering.aanschrijfwijze.naam-protocollering", ElementNrAanschrijfwijzeNaam },
        { "adressering.gebruikInLopendeTekst", GebruikInLopendeTekstAutorisatieElementen },
        { "adressering.gebruikInLopendeTekst-protocollering", ElementNrGebruikInLopendeTekst },
        { "adressering.adresregel1", AdresseringAdresregel1AutorisatieElementen },
        { "adressering.adresregel1-protocollering", ElementNrAdresregel1 },
        { "adressering.adresregel2", AdresseringAdresregel2AutorisatieElementen },
        { "adressering.adresregel2-protocollering", ElementNrAdresregel2 },
        { "adressering.adresregel3", $"{ElementNrVerblijfplaatsRegel3} {ElementNrAdressering}" },
        { "adressering.adresregel3-protocollering", ElementNrVerblijfplaatsRegel3 },
        { "adressering.land", AdresseringLandAutorisatieElementen },
        { "adressering.land-protocollering", ElementNrVerblijfplaatsLand },
        { "adressering.land.code-protocollering", ElementNrVerblijfplaatsLand },
        { "adressering.land.omschrijving-protocollering", ElementNrVerblijfplaatsLand },

        { "adresseringBinnenland", $"{AdresseringBinnenlandElementen} {ElementNrAdressering}" },
        { "adresseringBinnenland-protocollering",  AdresseringBinnenlandElementen },
        { "adresseringBinnenland-beperkt", $"{AdresseringBinnenlandBeperktElementen} {ElementNrAdressering}" },
        { "adresseringBinnenland-beperkt-protocollering", AdresseringBinnenlandBeperktElementen },
        { "adresseringBinnenland.aanhef", AanhefAutorisatieElementen },
        { "adresseringBinnenland.aanhef-protocollering", ElementNrAanhef },
        { "adresseringBinnenland.aanschrijfwijze", AanschrijfwijzeAutorisatieElementen },
        { "adresseringBinnenland.aanschrijfwijze-protocollering", AanschrijfwijzeElementen },
        { "adresseringBinnenland.aanschrijfwijze.aanspreekvorm", AanspreekvormAutorisatieElementen },
        { "adresseringBinnenland.aanschrijfwijze.aanspreekvorm-protocollering", ElementNrAanspreekvorm },
        { "adresseringBinnenland.aanschrijfwijze.naam", AanschrijfwijzeNaamAutorisatieElementen },
        { "adresseringBinnenland.aanschrijfwijze.naam-protocollering", ElementNrAanschrijfwijzeNaam },
        { "adresseringBinnenland.gebruikInLopendeTekst", GebruikInLopendeTekstAutorisatieElementen },
        { "adresseringBinnenland.gebruikInLopendeTekst-protocollering", ElementNrGebruikInLopendeTekst },
        { "adresseringBinnenland.adresregel1", AdresseringAdresregel1AutorisatieElementen },
        { "adresseringBinnenland.adresregel1-protocollering", ElementNrAdresregel1 },
        { "adresseringBinnenland.adresregel2", AdresseringAdresregel2AutorisatieElementen },
        { "adresseringBinnenland.adresregel2-protocollering", ElementNrAdresregel2 },
        #endregion

        { "aNummer", "010110" },
        { "burgerservicenummer", ElementNrBurgerservicenummer },
        { "datumEersteInschrijvingGBA", ElementNrDatumEersteInschrijvingGba },

        #region geslacht
        { "geslacht", ElementNrGeslacht },
        #endregion

        #region europees kiesrecht
        { "europeesKiesrecht", $"{ElementNrAanduidingEuropeesKiesrecht} {ElementNrEinddatumUitsluitingEuropeesKiesrecht}" },
        { "europeesKiesrecht.aanduiding", ElementNrAanduidingEuropeesKiesrecht },
        { "europeesKiesrecht.einddatumUitsluiting", ElementNrEinddatumUitsluitingEuropeesKiesrecht },
        #endregion

        #region geboorte
        { "geboorte", $"{ElementNrGeboortedatum} {ElementNrGeboorteplaats} {ElementNrGeboorteland}" },
        { "geboorte-beperkt", ElementNrGeboortedatum },
        { "geboorte-beperkt-protocollering", ElementNrGeboortedatum },
        { "geboorte.datum", ElementNrGeboortedatum },
        { "geboorte.plaats", ElementNrGeboorteplaats },
        { "geboorte.land", ElementNrGeboorteland },
        #endregion

        #region gemeente van inschrijving
        { "gemeenteVanInschrijving", ElementNrGemeenteVanInschrijving },
        { "datumInschrijvingInGemeente", ElementNrDatumInschrijvingInGemeente },
        #endregion

        #region gezag
        { "gezag", ElementNrGezag },
        { "gezag.type", ElementNrGezag },
        { "gezag.minderjarige", ElementNrGezag },
        { "gezag.ouders", ElementNrGezag },
        { "gezag.ouder", ElementNrGezag },
        { "gezag.derde", ElementNrGezag },
        { "gezag.derden", ElementNrGezag },
        { "gezag.minderjarige.burgerservicenummer", ElementNrGezag },
        { "gezag.ouders.burgerservicenummer", ElementNrGezag },
        { "gezag.ouder.burgerservicenummer", ElementNrGezag },
        { "gezag.derde.burgerservicenummer", ElementNrGezag },
        { "gezag.derden.burgerservicenummer", ElementNrGezag },
        { "gezag.toelichting", ElementNrGezag },
        #endregion

        #region indicatie gezag minderjarige
        { "indicatieGezagMinderjarige", ElementNrIndicatieGezagMinderjarige },
        { "indicatieCurateleRegister", "113310" },
        #endregion

        #region immigratie
        { "immigratie", $"{ElementNrLandVanwaarIngeschreven} {ElementNrDatumVestigingInNederland} {ElementNrIndicatieVestigingVanuitBuitenland} {ElementNrVanuitVerblijfplaatsOnbekend}" },
        { "immigratie.datumVestigingInNederland", ElementNrDatumVestigingInNederland },
        { "immigratie.indicatieVestigingVanuitBuitenland", ElementNrIndicatieVestigingVanuitBuitenland },
        { "immigratie.landVanwaarIngeschreven", ElementNrLandVanwaarIngeschreven },
        { "immigratie.vanuitVerblijfplaatsOnbekend", ElementNrVanuitVerblijfplaatsOnbekend },
        #endregion

        #region kind
        { "kinderen", $"090120 {ElementNrVoornamenKind} {ElementNrAdellijkeTitelPredicaatKind} {ElementNrVoorvoegselKind} {ElementNrGeslachtsnaamKind} {ElementNrGeboortedatumKind} {ElementNrGeboorteplaatsKind} {ElementNrGeboortelandKind} {ElementNrVoorlettersKind}" },
        { "kinderen.burgerservicenummer", "090120" },
        { "kinderen.geboorte", $"{ElementNrGeboortedatumKind} {ElementNrGeboorteplaatsKind} {ElementNrGeboortelandKind}" },
        { "kinderen.geboorte.datum", ElementNrGeboortedatumKind },
        { "kinderen.geboorte.land", ElementNrGeboortelandKind },
        { "kinderen.geboorte.plaats", ElementNrGeboorteplaatsKind },
        { "kinderen.naam", $"{ElementNrVoornamenKind} {ElementNrAdellijkeTitelPredicaatKind} {ElementNrVoorvoegselKind} {ElementNrGeslachtsnaamKind} {ElementNrVoorlettersKind}" },
        { "kinderen.naam.adellijkeTitelPredicaat", ElementNrAdellijkeTitelPredicaatKind },
        { "kinderen.naam.geslachtsnaam", ElementNrGeslachtsnaamKind },
        { "kinderen.naam.voorletters", ElementNrVoorlettersKind },
        { "kinderen.naam.voornamen", ElementNrVoornamenKind },
        { "kinderen.naam.voorvoegsel", ElementNrVoorvoegselKind },
        #endregion

        { "leeftijd", "PAGL01" },

        #region naam
        { "naam", $"{NaamBeperktElementen} {ElementNrAanduidingNaamgebruik}" },
        { "naam-beperkt", NaamBeperktElementen },
        { "naam-beperkt-protocollering", NaamBeperktElementen },
        { "naam.voornamen", ElementNrVoornamen },
        { "naam.adellijkeTitelPredicaat", ElementNrAdellijkeTitelPredicaat },
        { "naam.voorvoegsel", ElementNrVoorvoegsel },
        { "naam.geslachtsnaam", ElementNrGeslachtsnaam },
        { "naam.aanduidingNaamgebruik", ElementNrAanduidingNaamgebruik },
        { "naam.voorletters", ElementNrVoorletters },
        { "naam.volledigeNaam", ElementNrVolledigeNaam },
        #endregion

        #region nationaliteit
        { "nationaliteiten", $"{ElementNrNationaliteit} {ElementNrRedenOpnameNationaliteit} {ElementNrDatumIngangGeldigheidNationaliteit}" },
        { "nationaliteiten-protocollering", $"{ElementNrNationaliteit} {ElementNrRedenOpnameNationaliteit} {ElementNrDatumIngangGeldigheidNationaliteit} {ElementNrNationaliteitType}" },
        { "nationaliteiten.type", ElementNrNationaliteit },
        { "nationaliteiten.type-protocollering", ElementNrNationaliteitType },
        { "nationaliteiten.nationaliteit", ElementNrNationaliteit },
        { "nationaliteiten.redenOpname", ElementNrRedenOpnameNationaliteit },
        { "nationaliteiten.datumIngangGeldigheid", ElementNrDatumIngangGeldigheidNationaliteit },
        #endregion

        #region ouder
        { "ouders", $"{ElementNrBurgerserviceNummerouder} {OuderNaamElementen} {OuderGeboorteElementen} {ElementNrGeslachtOuder} {ElementNrDatumIngangFamilierechtelijkeBetrekking}" },
        { "ouders.ouderAanduiding", "" },
        { "ouders.burgerservicenummer", ElementNrBurgerserviceNummerouder },
        { "ouders.naam", OuderNaamElementen },
        { "ouders.naam.voornamen", ElementNrVoornamenOuder },
        { "ouders.naam.adellijkeTitelPredicaat", ElementNrAdellijkeTitelPredicaatOuder },
        { "ouders.naam.voorvoegsel", ElementNrVoorvoegselOuder },
        { "ouders.naam.geslachtsnaam", ElementNrGeslachtsnaamOuder },
        { "ouders.naam.voorletters", ElementNrVoorlettersOuder },
        { "ouders.geboorte", OuderGeboorteElementen },
        { "ouders.geboorte.datum", ElementNrGeboortedatumOuder },
        { "ouders.geboorte.plaats", ElementNrGeboorteplaatsOuder },
        { "ouders.geboorte.land", ElementNrGeboortelandOuder },
        { "ouders.geslacht", ElementNrGeslachtOuder },
        { "ouders.datumIngangFamilierechtelijkeBetrekking", ElementNrDatumIngangFamilierechtelijkeBetrekking },
        #endregion

        #region overlijden
        { "overlijden", $"{ElementNrOverlijdendatum} {ElementNrOverlijdenPlaats} {ElementNrOverlijdenLand}" },
        { "overlijden.datum", ElementNrOverlijdendatum },
        { "overlijden.land", ElementNrOverlijdenLand },
        { "overlijden.plaats", ElementNrOverlijdenPlaats },
        #endregion

        #region partner
        { "partners", $"{ElementNrBurgerservicenummerPartner} {PartnerNaamElementen} {PartnerGeboorteElementen} {ElementNrGeslachtPartner} {PartnerHuwelijkPartnerschapElementen} {ElementNrDatumOntbindingHuwelijkPartnerschap} {ElementNrSoortVerbintenis}" },
        { "partners.burgerservicenummer", ElementNrBurgerservicenummerPartner },
        { "partners.naam", PartnerNaamElementen },
        { "partners.naam.voornamen", ElementNrVoornamenPartner },
        { "partners.naam.adellijkeTitelPredicaat", ElementNrAdellijkeTitelPredicaatPartner },
        { "partners.naam.voorvoegsel", ElementNrVoorvoegselPartner },
        { "partners.naam.geslachtsnaam", ElementNrGeslachtsnaamPartner },
        { "partners.naam.voorletters", ElementNrVoorlettersPartner },
        { "partners.geboorte", PartnerGeboorteElementen },
        { "partners.geboorte.datum", ElementNrGeboortedatumPartner },
        { "partners.geboorte.plaats", ElementNrGeboorteplaatsPartner },
        { "partners.geboorte.land", ElementNrGeboortelandPartner },
        { "partners.geslacht", ElementNrGeslachtPartner },
        { "partners.aangaanHuwelijkPartnerschap", PartnerHuwelijkPartnerschapElementen },
        { "partners.aangaanHuwelijkPartnerschap.datum", ElementNrDatumAangaanHuwelijkPartnerschap },
        { "partners.aangaanHuwelijkPartnerschap.plaats", ElementNrPlaatsAangaanHuwelijkPartnerschap },
        { "partners.aangaanHuwelijkPartnerschap.land", ElementNrLandAangaanHuwelijkPartnerschap },
        { "partners.ontbindingHuwelijkPartnerschap", ElementNrDatumOntbindingHuwelijkPartnerschap },
        { "partners.ontbindingHuwelijkPartnerschap.datum", ElementNrDatumOntbindingHuwelijkPartnerschap },
        { "partners.soortVerbintenis", ElementNrSoortVerbintenis },
        #endregion

        #region uitsluiting kiesrecht
        { "uitsluitingKiesrecht", $"{ElementNrUitgeslotenVanKiesrecht} {ElementNrEinddatumUitsluitingKiesrecht}" },
        { "uitsluitingKiesrecht.uitgeslotenVanKiesrecht", ElementNrUitgeslotenVanKiesrecht },
        { "uitsluitingKiesrecht.einddatum", ElementNrEinddatumUitsluitingKiesrecht },
        #endregion

        #region verblijfplaats
        { "verblijfplaats.type", $"{ElementNrStraatnaam} {ElementNrLocatiebeschrijving} {ElementNrVerblijfplaatsLand}" },
        { "verblijfplaats.type-protocollering", ElementNrVerblijfplaatsType },
        { "verblijfplaats.functieAdres", ElementNrFunctieAdres },
        { "verblijfplaats.datumVan", $"{ElementNrDatumAanvangAdreshouding} {ElementNrDatumAanvangAdresBuitenland}" },
        { "verblijfplaats.datumVan-protocollering", ElementNrDatumVanVerblijfplaats },
        { "verblijfplaats.verblijfadres.korteStraatnaam", ElementNrStraatnaam },
        { "verblijfplaats.verblijfadres.officieleStraatnaam", ElementNrNaamOpenbareRuimte },
        { "verblijfplaats.verblijfadres.huisnummer", ElementNrHuisnummer },
        { "verblijfplaats.verblijfadres.huisletter", ElementNrHuisletter },
        { "verblijfplaats.verblijfadres.huisnummertoevoeging", ElementNrHuisnummertoevoeging },
        { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer", ElementNrAanduidingBijHuisnummer },
        { "verblijfplaats.verblijfadres.postcode", ElementNrPostcode },
        { "verblijfplaats.verblijfadres.woonplaats", ElementNrWoonplaats },
        { "verblijfplaats.verblijfadres.locatiebeschrijving", ElementNrLocatiebeschrijving },
        { "verblijfplaats.verblijfadres.land", ElementNrVerblijfplaatsLand },
        { "verblijfplaats.verblijfadres.regel1", ElementNrVerblijfplaatsRegel1 },
        { "verblijfplaats.verblijfadres.regel2", ElementNrVerblijfplaatsRegel2 },
        { "verblijfplaats.verblijfadres.regel3", ElementNrVerblijfplaatsRegel3 },
        { "verblijfplaats.adresseerbaarObjectIdentificatie", ElementNrAdresseerbaarObjectIdentificatie },
        { "verblijfplaats.nummeraanduidingIdentificatie", ElementNrNummeraanduidingIdentificatie },
        { "verblijfplaats.datumIngangGeldigheid", ElementNrDatumIngangGeldigheidVerblijfplaats },
        { "verblijfplaats.verblijfadres", VerblijfplaatsVerblijfadresElementen },
        { "verblijfplaats", $"{VerblijfplaatsElementen} {ElementNrDatumAanvangAdreshouding} {ElementNrDatumAanvangAdresBuitenland}" },
        { "verblijfplaats-protocollering", $"{VerblijfplaatsElementen} {ElementNrVerblijfplaatsType} {ElementNrDatumVanVerblijfplaats}" },

        { "verblijfplaatsBinnenland.type", $"{ElementNrStraatnaam} {ElementNrLocatiebeschrijving}" },
        { "verblijfplaatsBinnenland.type-protocollering", ElementNrVerblijfplaatsType },
        { "verblijfplaatsBinnenland.functieAdres", ElementNrFunctieAdres },
        { "verblijfplaatsBinnenland.datumVan", ElementNrDatumAanvangAdreshouding },
        { "verblijfplaatsBinnenland.datumVan-protocollering", ElementNrDatumVanVerblijfplaats },
        { "verblijfplaatsBinnenland.verblijfadres.korteStraatnaam", ElementNrStraatnaam },
        { "verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam", ElementNrNaamOpenbareRuimte },
        { "verblijfplaatsBinnenland.verblijfadres.huisnummer", ElementNrHuisnummer },
        { "verblijfplaatsBinnenland.verblijfadres.huisletter", ElementNrHuisletter },
        { "verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging", ElementNrHuisnummertoevoeging },
        { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer", ElementNrAanduidingBijHuisnummer },
        { "verblijfplaatsBinnenland.verblijfadres.postcode", ElementNrPostcode },
        { "verblijfplaatsBinnenland.verblijfadres.woonplaats", ElementNrWoonplaats },
        { "verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving", ElementNrLocatiebeschrijving },
        { "verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie", ElementNrAdresseerbaarObjectIdentificatie },
        { "verblijfplaatsBinnenland.nummeraanduidingIdentificatie", ElementNrNummeraanduidingIdentificatie },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid", ElementNrDatumIngangGeldigheidVerblijfplaats },
        { "verblijfplaatsBinnenland.verblijfadres", VerblijfplaatsBinnenlandVerblijfadresElementen },
        { "verblijfplaatsBinnenland", $"{VerblijfplaatsBinnenlandElementen} {ElementNrDatumAanvangAdreshouding}" },
        { "verblijfplaatsBinnenland-protocollering", $"{VerblijfplaatsBinnenlandElementen} {ElementNrVerblijfplaatsType} {ElementNrDatumVanVerblijfplaats}" },
        #endregion

        #region verblijfstitel
        { "verblijfstitel", $"{ElementNrAanduidingVerblijfstitel} {ElementNrDatumEindeVerblijfstitel} {ElementNrDatumIngangVerblijfstitel}" },
        { "verblijfstitel.aanduiding", ElementNrAanduidingVerblijfstitel },
        { "verblijfstitel.datumEinde", ElementNrDatumEindeVerblijfstitel },
        { "verblijfstitel.datumIngang", ElementNrDatumIngangVerblijfstitel },
        #endregion

    };
}

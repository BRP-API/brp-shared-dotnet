using Brp.Shared.DtoMappers.Interfaces;

namespace Brp.Shared.DtoMappers.Mappers;

public static class AdellijkeTitelPredicaatHelpers
{
    private const string BARONES = "barones";
    private const string BARON = "baron";
    private const string GRAVIN = "gravin";
    private const string GRAAF = "graaf";
    private const string HERTOGIN = "hertogin";
    private const string HERTOG = "hertog";
    private const string MARKIEZIN = "markiezin";
    private const string MARKIES = "markies";
    private const string PRINSES = "prinses";
    private const string PRINS = "prins";
    private const string RIDDER = "ridder";

    private const string JONKVROUW = "jonkvrouw";
    private const string JONKHEER = "jonkheer";

    private static string MapNaarBaronOfBarones(this IWaardetabel? geslacht) => geslacht.IsVrouw() ? BARONES : BARON;
    private static string MapNaarGraafOfGravin(this IWaardetabel? geslacht) => geslacht.IsVrouw() ? GRAVIN : GRAAF;
    private static string MapNaarHertogOfHertogin(this IWaardetabel? geslacht) => geslacht.IsVrouw() ? HERTOGIN : HERTOG;
    private static string MapNaarMarkiesOfMarkiezin(this IWaardetabel? geslacht) => geslacht.IsVrouw() ? MARKIEZIN : MARKIES;
    private static string MapNaarPrinsOfPrinses(this IWaardetabel? geslacht) => geslacht.IsVrouw() ? PRINSES : PRINS;

    public static string MapNaarAdellijkeTitel(this IAdellijkeTitelPredicaatType? adellijkeTitel, IWaardetabel? geslacht)
    {
        if (adellijkeTitel == null) return string.Empty;

        return adellijkeTitel.Code switch
        {
            "B" => geslacht.MapNaarBaronOfBarones(),
            "BS" => geslacht.MapNaarBaronOfBarones(),
            "G" => geslacht.MapNaarGraafOfGravin(),
            "GI" => geslacht.MapNaarGraafOfGravin(),
            "H" => geslacht.MapNaarHertogOfHertogin(),
            "HI" => geslacht.MapNaarHertogOfHertogin(),
            "M" => geslacht.MapNaarMarkiesOfMarkiezin(),
            "MI" => geslacht.MapNaarMarkiesOfMarkiezin(),
            "P" => geslacht.MapNaarPrinsOfPrinses(),
            "PS" => geslacht.MapNaarPrinsOfPrinses(),
            "R" => RIDDER,
            _ => string.Empty,
        };
    }
    
    public static string MapNaarPredicaat(this IAdellijkeTitelPredicaatType? predicaat, IWaardetabel? geslacht)
    {
        if (predicaat == null) return string.Empty;

        return predicaat.Code switch
        {
            "JH" => geslacht.IsVrouw() ? JONKVROUW : JONKHEER,
            "JV" => geslacht.IsMan() ? JONKHEER : JONKVROUW,
            _ => string.Empty,
        };
    }
}

using Microsoft.EntityFrameworkCore;

namespace Brp.AutorisatieEnProtocollering.Proxy.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {}

    public DbSet<Autorisatie> Autorisaties => Set<Autorisatie>();
    public DbSet<Protocollering> Protocolleringen => Set<Protocollering>();
    public DbSet<Adres> Adressen => Set<Adres>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Autorisatie>(ba =>
        {
            ba.ToTable("lo3_autorisatie");
            ba.Property(p => p.AutorisatieId).HasColumnName("autorisatie_id");
            ba.Property(p => p.AdHocMedium).HasColumnName("ad_hoc_medium");
            ba.Property(p => p.AfnemerCode).HasColumnName("afnemer_code");
            ba.Property(p => p.TabelRegelStartDatum).HasColumnName("tabel_regel_start_datum");
            ba.Property(p => p.TabelRegelEindDatum).HasColumnName("tabel_regel_eind_datum");
            ba.Property(p => p.RubrieknummerAdHoc).HasColumnName("ad_hoc_rubrieken");

        });

        modelBuilder.Entity<Protocollering>(ba =>
        {
            ba.ToTable("haalcentraal_vraag");
            ba.HasKey(p => p.RequestId);
            ba.Property(p => p.RequestId).HasColumnName("request_id").IsRequired();
            ba.Property(p => p.AfnemerCode).HasColumnName("afnemer_code");
            ba.Property(p => p.PersoonslijstId).HasColumnName("pl_id");
            ba.Property(p => p.RequestZoekRubrieken).HasColumnName("request_zoek_rubrieken");
            ba.Property(p => p.RequestGevraagdeRubrieken).HasColumnName("request_gevraagde_rubrieken");
        });

        modelBuilder.Entity<Adres>(ba =>
        {
            ba.ToTable("lo3_adres");
            ba.HasKey(p => p.AdresId);
            ba.Property(p => p.AdresId).HasColumnName("adres_id");
            ba.Property(p => p.GemeenteCode).HasColumnName("gemeente_code");
            ba.Property(p => p.AdresseerbaarObjectIdentificatie).HasColumnName("verblijf_plaats_ident_code");
        });
    }
}

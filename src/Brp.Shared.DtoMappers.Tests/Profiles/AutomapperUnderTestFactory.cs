using AutoMapper;

namespace Brp.Shared.DtoMappers.Tests.Profiles;

public static class AutomapperUnderTestFactory
{
    public static IMapper CreateSut<T>() where T : Profile, new()
    {
        MapperConfiguration config = new(cfg =>
        {
            cfg.AddProfile<T>();
        });
        return config.CreateMapper();
    }

    public static IMapper CreateSut<T1, T2>()
        where T1 : Profile, new()
        where T2 : Profile, new()
    {
        MapperConfiguration config = new(cfg =>
        {
            cfg.AddProfile<T1>();
            cfg.AddProfile<T2>();
        });
        return config.CreateMapper();
    }
}

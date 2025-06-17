#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS base
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    TZ=Europe/Amsterdam \
    # Disable config change monitoring for better container performance
    # See https://github.com/Contrast-Security-OSS/agent-operator/blob/master/docs/public/08-tips.md
    DOTNET_HOSTBUILDER__RELOADCONFIGONCHANGE=false
# Add ICU libraries for better globalization support
RUN apk add --no-cache icu-libs
WORKDIR /app

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
ARG BUILD_CONFIGURATION=Release
ARG TARGETARCH
WORKDIR /src

COPY ["Brp.AutorisatieEnProtocollering.Proxy/Brp.AutorisatieEnProtocollering.Proxy.csproj", "Brp.AutorisatieEnProtocollering.Proxy/"]
COPY ["Brp.Shared.Infrastructure/Brp.Shared.Infrastructure.csproj", "Brp.Shared.Infrastructure/"]
COPY ["Brp.Shared.Validatie/Brp.Shared.Validatie.csproj", "Brp.Shared.Validatie/"]

RUN dotnet restore "./Brp.AutorisatieEnProtocollering.Proxy/Brp.AutorisatieEnProtocollering.Proxy.csproj"

COPY . .
WORKDIR "/src/Brp.AutorisatieEnProtocollering.Proxy"
RUN dotnet build "./Brp.AutorisatieEnProtocollering.Proxy.csproj" -c "$BUILD_CONFIGURATION" -o /app/build --arch "$TARGETARCH"

FROM --platform=$BUILDPLATFORM build AS publish
ARG BUILD_CONFIGURATION=Release
ARG TARGETARCH
RUN dotnet publish "./Brp.AutorisatieEnProtocollering.Proxy.csproj" -c "$BUILD_CONFIGURATION" -o /app/publish /p:UseAppHost=false --arch "$TARGETARCH"

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Create non-root user and set proper file ownership
RUN addgroup -g 1000 -S brp-api && \
    adduser -u 1000 -S -D -G brp-api brp-api-user && \
    chown -R brp-api-user:brp-api /app

USER brp-api-user

ENTRYPOINT ["dotnet", "Brp.AutorisatieEnProtocollering.Proxy.dll"]
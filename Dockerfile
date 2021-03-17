FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1-focal AS build
WORKDIR /src
COPY ["ShoeStore.ApiGateway.Ocelot/ShoeStore.ApiGateway.Ocelot.csproj", "ShoeStore.ApiGateway.Ocelot/"]
RUN dotnet restore "ShoeStore.ApiGateway.Ocelot/ShoeStore.ApiGateway.Ocelot.csproj"
COPY . .
WORKDIR "/src/ShoeStore.ApiGateway.Ocelot"
RUN dotnet build "ShoeStore.ApiGateway.Ocelot.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ShoeStore.ApiGateway.Ocelot.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ShoeStore.ApiGateway.Ocelot.dll"]
FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1-focal AS build
WORKDIR /src
COPY . .
WORKDIR "/src/ShoeStore.ApiGateway"
RUN dotnet restore "ShoeStore.ApiGateway.csproj"
RUN dotnet build "ShoeStore.ApiGateway.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ShoeStore.ApiGateway.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ShoeStore.ApiGateway.dll"]
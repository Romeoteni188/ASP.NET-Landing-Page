# Usar la imagen base de .NET SDK para construir la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar los archivos del proyecto y restaurar las dependencias
COPY *.sln .
COPY Indotalent.csproj .
RUN dotnet restore

# Copiar todo el contenido del proyecto y compilar la aplicación
COPY . .
RUN dotnet publish -c Release -o /out

# Usar la imagen base de ASP.NET para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .

# Exponer el puerto en el que la aplicación estará escuchando
EXPOSE 90

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "Indotalent.dll"]

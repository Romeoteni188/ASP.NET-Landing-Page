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

# Instalar Wine y otras dependencias necesarias para Dotfuscator
RUN apt-get update && apt-get install -y wine64 wine32 unzip wget

# Descargar Dotfuscator (reemplaza con la URL de descarga válida)
WORKDIR /dotfuscator
RUN wget -O dotfuscator.zip "URL_DE_DESCARGA_DOTFUSCATOR" && \
    unzip dotfuscator.zip

# Ofuscar la aplicación usando Dotfuscator
RUN wine /dotfuscator/Dotfuscator.exe /in:/out/Indotalent.dll /out:/out/Obfuscated.dll


# Usar la imagen base de ASP.NET para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .

# Exponer el puerto en el que la aplicación estará escuchando
EXPOSE 90

# Comando para ejecutar la aplicación
# ENTRYPOINT ["dotnet", "Indotalent.dll"]
# Comando para ejecutar la aplicación ofuscada
ENTRYPOINT ["dotnet", "Obfuscated.dll"]
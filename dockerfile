FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env 
WORKDIR /App

#Copiar todas as informações na pasta
COPY . ./
#Limpar a aplicação
RUN dotnet restore
#Builda e compilar a aplicação e coloca tudo na pasta out /App/out
RUN dotnet publish -c Release -o out
#Nesse momento ficou tudo armazenado dentro da variavel build-ev


#Agora baixa a imagem que irá executar de fato nossa aplicação (play)
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /App
#Copia tudo o que fizemos na etapa inicial, pra conseguir saber o que subir
COPY --from=build-env /App/out .
#ponto de entrada: ponto de execução, primeiro executa o comando dotnet e após qual a dll que eu desejo executar essa aplicação
ENTRYPOINT ["dotnet", "Dotnet.Docker.dll"]

#Com essas instruções(imagem) eu consigo buildar, compilar e executar uma aplicação dentro do meu container.


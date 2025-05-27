FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY secure-shield.exe .

ENTRYPOINT ["./secure-shield.exe"]

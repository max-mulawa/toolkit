---
id: fuh187o5u5mb8iu2o8mhzk2
title: Dotnet
desc: ''
updated: 1696178834700
created: 1676453369885
---

- https://dotnet.microsoft.com/en-us/download/dotnet/6.0
- https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install

```bash
mkdir ~/msdotnet
cd msdotnet
wget https://dot.net/v1/dotnet-install.sh
sudo chmod +x ./dotnet-install.sh
./dotnet-install.sh #installs LTS version of .NET Core runtime SDK (6.0 at the time)
./dotnet-install.sh --channel 7.0

export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools

```

```
dotnet build
dotnet test
cd src\App
dotnet run
```


```bash
# msbuild diagnostics
dotnet build -v d
```

# Decompiler
Download https://github.com/icsharpcode/AvaloniaILSpy 

# install rider on ubuntu
sudo snap install rider --classic

# new project

```bash
dotnet new sln --name "MySolution"
dotnet new classlib -f net6.0 -n "Search"
dotnet sln add "Search"
#Add Packages
dotnet add "MyProject" package TextSearch
```
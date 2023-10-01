---
id: lvbpmtlaiilm2k9onzr5ez1
title: Aks
desc: ''
updated: 1676451085659
created: 1676451064458
---

### install azure cli
```bash
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### login to azure
```bash
az login # or
az login --use-device-code #without browser opening as root
```
### aks context
```bash
az aks get-credentials -g aks -n aks

kubectl config current-context
```
### login to azure container registry
```bash
az acr login --name regname
```

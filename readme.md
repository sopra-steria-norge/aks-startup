# Terraform for å komme i gang med Azure Kubernetes Service #

## Start utviklingsmiljø i container ##

Gå inn i **aks-workspace** og kjør **vscode-remote-workspace-1.bat**

## Kjør terraform mot Azure tenant ##

1. Kjør Terraform kommandoer i container

Terraform er delt opp seperate kataloger slik at det er mulig å kjøre terraform direkte i hver sin katalog.

F.eks. i katalogen **terraform-backend**
```
az login --tenant <tenant_id>
tf init
tf plan
tf apply -auto-approve
```

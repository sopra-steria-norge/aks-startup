# Terraform for å komme i gang med Azure Kubernetes Service #



## Opprett Service Principal i Azure ##

1 - Lag Storage Account via Terraform script

```bash
cd terraform-backend
az login
tf init
tf apply -input=false -auto-approve
```

2 - Lag Service Principal

```bash
az login --tenant <tenant_id>

az ad sp create-for-rbac --name aks_startup_sp

# This will produce an output similar to this:
# {
#   "appId": "6cd93b1e-14d2-417a-abae-6b7c23173b92",
#   "displayName": "aks_startup_app_services",
#   "name": "6cd93b1e-14d2-417a-abae-6b7c23173b92",
#   "password": "myverysecretsecret",
#   "tenant": "94ce5a37-6c1e-4cce-aaeb-3f20b96ab1af"
# }

```

3 - Lagre variabler i bash

```bash
ARM_CLIENT_ID=6cd93b1e-14d2-417a-abae-6b7c23173b92
ARM_CLIENT_SECRET=myverysecretsecret
ARM_SUBSCRIPTION_ID=22481158-8cb8-4597-be0c-4913204b4544
ARM_TENANT_ID=94ce5a37-6c1e-4cce-aaeb-3f20b96ab1af
```

4 - Legg til rolle for ressursen

```bash
az role assignment create --assignee $ARM_CLIENT_ID --role Owner
```

Kan også settes kun til Resource Group.

5 - Legg til rolle for Storage Account

```bash
az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee $ARM_CLIENT_ID \
    --scope "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/aks-startup-rg/providers/Microsoft.Storage/storageAccounts/aksstartupsttfstate"
```



## Start utviklingsmiljø i container ##

- Gå inn i **aks-workspace** og kjør **vscode-remote-workspace-1.bat**

## Konfigurer ENV på lokal maskin ##

```bash
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
```

1. Lag mappe på utsiden av roten til "aks-startup" med navn "aks-startup-config"
2. Kopier "aks-workspace/.env" filen til denne katalogen
3. Start **aks-workspace** med "aks-workspace/docker-compose.up.bat"

[docker-compose.yml](aks-workspace\docker-compose.yml) som starter utviklingsmiljøet bruker disse environment variablene til å koble Terraform til Azure tenanten



## Kjør terraform mot Azure tenant ##

1. Kjør Terraform kommandoer i container

Terraform er delt opp seperate kataloger slik at det er mulig å kjøre terraform direkte i hver sin katalog.

F.eks. i katalogen **terraform-backend**

```bash
az login --tenant <tenant_id>
tf init
terraform plan -input=false
tf apply -input=false -auto-approve
```



## Start Azure Kubernetes Service (AKS) ##

[Start AKS](aks\readme.md)

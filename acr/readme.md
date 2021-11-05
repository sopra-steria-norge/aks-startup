# Terraform for å komme i gang med Azure Container Registry (ACR) #

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

#!/bin/bash


####################################
##### Usage: This is not yet really a script. 
##### Copy and paste each cmd into terminal and run ####
####################################


# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli

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

# ARM_CLIENT_ID=6cd93b1e-14d2-417a-abae-6b7c23173b92
# ARM_CLIENT_SECRET=myverysecretsecret
# ARM_SUBSCRIPTION_ID=22481158-8cb8-4597-be0c-4913204b4544
# ARM_TENANT_ID=94ce5a37-6c1e-4cce-aaeb-3f20b96ab1af

az role assignment create --assignee <client_id> --role Owner
> az role assignment create --assignee 6cd93b1e-14d2-417a-abae-6b7c23173b92 --role Owner

echo $ARM_CLIENT_ID

az login --service-principal --username <client_id> --tenant <tenant_id>  --password PASSWORD
> az login --service-principal --username 6cd93b1e-14d2-417a-abae-6b7c23173b92 --tenant 94ce5a37-6c1e-4cce-aaeb-3f20b96ab1af  --password myverysecretsecret
> az login --service-principal --username $ARM_CLIENT_ID --tenant $ARM_TENANT_ID --password $ARM_CLIENT_SECRET

# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-user-delegation-sas-create-cli

az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee <assignee email or client id> \
    --scope "/subscriptions/<subscription>/resourceGroups/aks-startup-rg/providers/Microsoft.Storage/storageAccounts/aksstartupsttfstate"

> az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee $ARM_CLIENT_ID \
    --scope "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/aks-startup-rg/providers/Microsoft.Storage/storageAccounts/aksstartupsttfstate"

az role assignment list --assignee <tenant_id>

> az role assignment list --assignee 94ce5a37-6c1e-4cce-aaeb-3f20b96ab1af

# Create Service Connection to ACR
# https://docs.microsoft.com/en-us/azure/devops/cli/service-endpoint?view=azure-devops#create-service-endpoint-using-configuration-file
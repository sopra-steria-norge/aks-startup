#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli

az login --tenant <tenant_id>

az ad sp create-for-rbac --name aks_startup_app_services

az role assignment create --assignee <tenant_id> --role Owner

az login --service-principal --username <user_id> --tenant <tenant_id>  --password PASSWORD

# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-user-delegation-sas-create-cli

az role assignment create \
    --role "Storage Blob Data Contributor" \
    --assignee <assignee email or client id> \
    --scope "/subscriptions/<subscription>/resourceGroups/aks-startup-d-rg-aks-infrastructure-shared/providers/Microsoft.Storage/storageAccounts/aksstartupstorage"

az role assignment list --assignee <tenant_id>

# Create Service Connection to ACR
# https://docs.microsoft.com/en-us/azure/devops/cli/service-endpoint?view=azure-devops#create-service-endpoint-using-configuration-file
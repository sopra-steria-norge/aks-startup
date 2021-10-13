#!/bin/bash
cd "$(dirname "$0")"

echo "Create storage account for Terraform backend azurerm"

echo "az login"
az login --service-principal --username ${ARM_CLIENT_ID} --tenant ${ARM_TENANT_ID} --password ${ARM_CLIENT_SECRET}

az account show
az storage account list --query "[?name=='aksstartupsttfstate']" --resource-group aks-startup-rg --subscription  ${ARM_SUBSCRIPTION_ID}

storage_account_exists=$(az storage account list --name aksstartupsttfstate --subscription ${ARM_SUBSCRIPTION_ID})
echo $
az appservice plan list --query "[?name=='aksstartupsttfstate']"

# if [$group_infrastructure_exists == true] ; then
#     echo "** Deleting aks-startup-rg **"
#     az storage account create \
#       --name aksstartupsttfstate \
#       --resource-group aks-startup-rg \
#       --kind StorageV2 \
#       --sku Standard_LRS \
#       --https-only true \
#       --allow-blob-public-access false
# fi

# group_shared_exists=$(az group exists --name aks-startup-rg --subscription ${ARM_SUBSCRIPTION_ID})
# if $group_shared_exists == true ; then
#     echo "** Deleting aks-startup-rg **"
#     az group delete --name aks-startup-rg --subscription ${ARM_SUBSCRIPTION_ID} --yes --verbose
# fi

#### Exit with great success
exit 0


# az storage account create \
#   --name aksstartupsttfstate \
#   --resource-group aks-startup-rg \
#   --kind StorageV2 \
#   --sku Standard_LRS \
#   --https-only true \
#   --allow-blob-public-access false

# terraform init -backend-config=azure.conf

# terraform init \
#   -backend-config="storage_account_name=$TF_STATE_BLOB_ACCOUNT_NAME" \
#   -backend-config="container_name=$TF_STATE_BLOB_CONTAINER_NAME" \
#   -backend-config="key=$TF_STATE_BLOB_FILE" \
#   -backend-config="sas_token=$TF_STATE_BLOB_SAS_TOKEN"
